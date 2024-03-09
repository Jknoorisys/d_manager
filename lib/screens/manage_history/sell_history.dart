import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../api/manage_history_services.dart';
import '../../helpers/helper_functions.dart';
import '../../models/history_models/sell_history_model.dart';
import '../manage_cloth_sell/cloth_sell_view.dart';
import '../widgets/new_custom_dropdown.dart';
import '../widgets/snackbar.dart';

//
import '../../models/sell_models/active_parties_model.dart';
import '../../api/dropdown_services.dart';
import '../../api/manage_firm_services.dart';
import '../../api/manage_party_services.dart';
import '../../models/dropdown_models/dropdown_cloth_quality_list_model.dart';
import '../../models/sell_models/active_firms_model.dart';

class SellHistory extends StatefulWidget {
  const SellHistory({super.key});

  @override
  State<SellHistory> createState() => _SellHistoryState();
}

class _SellHistoryState extends State<SellHistory> {
  final searchController = TextEditingController();
  List<SellHistoryModelList> sellHistoryData = [];
  String myFirm = 'Danish Textiles';
  String partyName = 'Mahesh Textiles';
  String clothQuality = '5 - Kilo';
  DateTime selectedDate = DateTime.now();
  DateTime firstDateForSell = DateTime(2000);
  DateTime lastDateForSell = DateTime(2050);

  bool isLoading = false;
  ManageHistoryServices manageHistoryServices = ManageHistoryServices();
  int currentPage = 1;
  final RefreshController _refreshController = RefreshController();

  //
  ManageFirmServices firmServices = ManageFirmServices();
  ManagePartyServices partyServices = ManagePartyServices();
  DropdownServices dropdownServices = DropdownServices();
  List<ActiveFirmsList> firms = [];
  List<ActivePartiesList> parties = [];
  List<ClothQuality> activeClothQuality = [];
  ActiveFirmsList? selectedFirm;
  ActivePartiesList? selectedParty;
  ClothQuality? selectedClothQuality;
  String? firmID;
  String? partyID;
  String? clothID;
  HelperFunctions helperFunctions = HelperFunctions();
  bool isFilterApplied = false;
  @override
  void initState() {
    super.initState();
    if (HelperFunctions.checkInternet() == false) {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No internet connection',
        mode: SnackbarMode.warning,
      );
    } else {
      setState(() {
        isLoading = !isLoading;
      });
      getSellHistory(currentPage, searchController.text.trim());
    }
    _loadData();
    _loadPartyData();
    _loadClothData();
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          isLoading:isLoading,
            title: S.of(context).sellHistory,
            filterButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.print, color: AppTheme.black),
                SizedBox(width: Dimensions.width20),
                GestureDetector(
                  onTap: () {
                    if (isFilterApplied) {
                      clearFilters();
                      setState(() {
                        isFilterApplied = false;
                      });
                    } else {
                      _showBottomSheet(context);
                    }
                  },
                  child: isFilterApplied ? Text(
                    'Clear',
                    style: TextStyle(color: AppTheme.black,fontWeight: FontWeight.bold),
                  ) : const FaIcon(FontAwesomeIcons.sliders, color: AppTheme.black),
                ),
              ],
            ),
            content: Padding(
              padding: EdgeInsets.all(Dimensions.height15),
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextField(
                            isFilled: false,
                            controller: searchController,
                            hintText: S.of(context).searchParty,
                            prefixIcon: Icons.search,
                            suffixIcon: Icons.close,
                            borderRadius: Dimensions.radius10,
                            borderColor: AppTheme.primary,
                            onSuffixTap: () {
                              setState(() {
                                searchController.clear();
                                sellHistoryData.clear();
                                currentPage = 1;
                                getSellHistory(currentPage, searchController.text.trim());
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                sellHistoryData.clear();
                                currentPage = 1;
                                getSellHistory(currentPage, value);
                              });
                            }
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  AppTheme.divider,
                  Expanded(
                    child:
                    SmartRefresher(
                      enablePullUp: true,
                      controller: _refreshController,
                      onRefresh: () async {
                        setState(() {
                          sellHistoryData.clear();
                          currentPage = 1;
                        });
                        getSellHistory(currentPage, searchController.text.trim());
                        _refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        getSellHistory(currentPage, searchController.text.trim());
                        _refreshController.loadComplete();
                      },
                      child:
                      ListView.builder(
                        itemCount: sellHistoryData.length,
                        itemBuilder: (context, index) {
                          return CustomAccordion(
                            titleChild: Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      SizedBox(height: Dimensions.height10),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            SizedBox(width: Dimensions.width10),
                                            CircleAvatar(
                                              backgroundColor: AppTheme.secondary,
                                              radius: Dimensions.height20,
                                              child: BigText(text: sellHistoryData[index].partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                                            ),
                                            SizedBox(width: Dimensions.height10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                BigText(text: sellHistoryData[index].partyName!, color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: AppTheme.black,
                                                      radius: Dimensions.height10,
                                                      child: BigText(text: sellHistoryData[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                                    ),
                                                    SizedBox(width: Dimensions.width10),
                                                    SmallText(text: sellHistoryData[index].firmName!, color: AppTheme.black, size: Dimensions.font12),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            contentChild: Column(
                              children: [
                                SizedBox(height: Dimensions.height10),
                                AppTheme.divider,
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Deal Date', sellHistoryData[index].sellDate!.toString())),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Cloth Quality', sellHistoryData[index].qualityName!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Deal Rate',' ₹ ${sellHistoryData[index].rate!}')),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Total Thans', sellHistoryData[index].totalThan!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Than Delivered', sellHistoryData[index].thanDelivered!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Than Remaining', sellHistoryData[index].thanRemaining!)),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Total Meter', sellHistoryData[index].totalMeter!.toString())),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Difference Amount', ' ₹ ${sellHistoryData[index].totalDifferenceAmount!.toString()}')),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Due Date', sellHistoryData[index].sellDueDate!.toString())),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Total Invoice Amount', ' ₹ ${sellHistoryData[index].totalInvoiceAmount!.toString()}')),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Status', sellHistoryData[index].dealStatus!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('', '')),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width/2.65,
                                        height: Dimensions.height40*2,
                                        padding: EdgeInsets.all(Dimensions.height10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                          border: Border.all(color: AppTheme.primary),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BigText(text: 'Total GST Amount', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: AppTheme.primary,
                                                  fontSize: Dimensions.font18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                children: [
                                                  TextSpan(text: ' ${sellHistoryData[index].totalGstAmount!.toString()}',),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    SizedBox(width: Dimensions.width20),
                                    Container(
                                        width: MediaQuery.of(context).size.width/2.65,
                                        height: Dimensions.height40*2,
                                        padding: EdgeInsets.all(Dimensions.height10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                          border: Border.all(color: AppTheme.primary),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BigText(text: 'Total Received Amount', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                            BigText(text: '${sellHistoryData[index].totalReceivedAmount!.toString()}',color: AppTheme.primary, size: Dimensions.font18)
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomElevatedButton(
                                      onPressed: (){
                                        // Navigator.pushNamed(context, AppRoutes.clothSellView, arguments: {'clothSellData': filteredSellHistoryList[index]});
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ClothSellView(sellID: sellHistoryData[index].sellId!,)));
                                      },
                                      buttonText: 'View Details',
                                      isBackgroundGradient: false,
                                      backgroundColor: AppTheme.primary,
                                      textSize: Dimensions.font14,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                  ),
                ],
              ),
            )
        )
    );
  }
  Widget _buildInfoColumn(String title, String value) {
    String formattedValue = value;
    if (title == 'Deal Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }else if (title == 'Due Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }
    return Container(
      width: MediaQuery.of(context).size.width / 3.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.nearlyBlack, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font12),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppTheme.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius20),
          topRight: Radius.circular(Dimensions.radius20),
        ),
      ),
      elevation: 10,
      context: context,
      builder: (context) =>
       StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return Padding(
                  padding: EdgeInsets.all(Dimensions.height20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select My Firm', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDropdownNew<ActiveFirmsList>(
                                hintText: 'Select Firm',
                                dropdownItems:firms ?? [],
                                selectedValue:selectedFirm,
                                onChanged:(newValue)async{
                                  if (newValue != null) {
                                    firmID = newValue.firmId.toString();
                                    await HelperFunctions.setFirmID(firmID!);
                                    print("firmID==== $firmID");
                                  } else {
                                    await HelperFunctions.setFirmID('');
                                    firmID = null; // Reset firmID if selectedFirm is null
                                  }
                                  setState(()  {
                                    selectedFirm = newValue;
                                  });
                                } ,
                                displayTextFunction: (ActiveFirmsList? firm) {
                                  return firm?.firmName ?? ''; // Ensure you're returning a non-null value
                                },
                              ),
                            ],
                          ),
                          Gap(Dimensions.height10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select Party Name', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDropdownNew<ActivePartiesList>(
                                hintText: 'Select Party',
                                dropdownItems:parties ?? [],
                                selectedValue:selectedParty,
                                onChanged:(newValue)async{
                                  if (newValue != null) {
                                    partyID = newValue.partyId.toString();
                                    await HelperFunctions.setPartyID(partyID!);
                                    print("partyIDselected===== $partyID");
                                  } else {
                                    await HelperFunctions.setPartyID('');
                                    partyID = null; // Reset firmID if selectedFirm is null
                                  }
                                  setState((){
                                    selectedParty = newValue;
                                  });
                                } ,
                                displayTextFunction: (ActivePartiesList? parties){
                                  return parties!.partyName!;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select Cloth Quality', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDropdownNew<ClothQuality>(
                                hintText: 'Cloth Quality',
                                dropdownItems:activeClothQuality ?? [],
                                selectedValue:selectedClothQuality,
                                onChanged:(newValue)async{
                                  if (newValue != null) {
                                    clothID = newValue.qualityId.toString();
                                    await HelperFunctions.setClothID(clothID!);
                                    print("ClothIDisselected===== $clothID");
                                  } else {
                                    await HelperFunctions.setClothID('');
                                    clothID = null; // Reset firmID if selectedFirm is null
                                  }
                                  setState((){
                                    selectedClothQuality = newValue;
                                  });
                                } ,
                                displayTextFunction: (ClothQuality? cloth){
                                  return cloth!.qualityName!;
                                },
                              ),
                            ],
                          ),
                          Gap(Dimensions.height10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Filter by Date', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              GestureDetector(
                                onTap: () async {
                                  DateTimeRange? pickedDateRange = await showDateRangePicker(
                                    initialEntryMode: DatePickerEntryMode.input,
                                    helpText: S.of(context).selectDate,
                                    context: context,
                                    initialDateRange: DateTimeRange(
                                      start: DateTime.now(),
                                      end: DateTime.now().add(const Duration(days: 7)),
                                    ),
                                    firstDate: firstDateForSell,
                                    lastDate: lastDateForSell,
                                  );

                                  if (pickedDateRange != null) {
                                    DateTime startDateForSellHistory = pickedDateRange.start;
                                    DateTime endDateForSellHistory = pickedDateRange.end;
                                    String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDateForSellHistory);
                                    String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDateForSellHistory);
                                    await HelperFunctions.setStartDateForSellHistory(formattedStartDate);
                                    await HelperFunctions.setEndDateForSellHistory(formattedEndDate);
                                    setState(() {
                                      firstDateForSell = startDateForSellHistory;
                                      lastDateForSell = endDateForSellHistory;
                                    });

                                    print("StartDate## $formattedStartDate");
                                    print("EndDate##  $formattedEndDate");
                                  }
                                },
                                child: Container(
                                  height: Dimensions.height50,
                                  width: MediaQuery.of(context).size.width/2.65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                                    color: Colors.white,
                                    border: Border.all(color: AppTheme.black, width: 0.5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(Dimensions.height10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: BigText(
                                        text: '${DateFormat('dd/MM/yyyy').format(firstDateForSell)} to ${DateFormat('dd/MM/yyyy').format(lastDateForSell)}', size: Dimensions.font12,)),
                                        Padding(
                                          padding: EdgeInsets.zero,
                                          child: Icon(
                                            Icons.calendar_month,
                                            color: Colors.black,
                                            size: Dimensions.iconSize20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(Dimensions.height25),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                        child: CustomElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState((){
                              currentPage = 0;
                              getSellHistory(1, searchController.text  );
                              isFilterApplied = true;
                            });
                          },
                          buttonText: 'Submit',
                        ),
                      ),
                    ],
                  ),
                );
          },
       )
    );
  }
  Future<SellHistoryModel?> getSellHistory(
      int pageNo,
      String search,
      ) async {
    setState(() {
      isLoading = true;
    });
    try {
      SellHistoryModel? model = await manageHistoryServices.showSellHistory(
        pageNo.toString(),
        search,
      );
      if (model != null) {
        if (model.success == true) {
          if (model.data!.isNotEmpty) {
            if (pageNo == 1) {
              sellHistoryData.clear();
            }
            setState(() {
              sellHistoryData.addAll(model.data!);
              currentPage++;
            });
          } else {
            _refreshController.loadNoData();
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            model.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again later.',
          mode: SnackbarMode.error,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Filter Dropdown

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      ActiveFirmsModel? activeFirms = await firmServices.activeFirms();
      if (activeFirms != null) {
        if (activeFirms.success == true) {
          if (activeFirms.data!.isNotEmpty) {
            setState(() {
              firms.clear();
              firms.addAll(activeFirms!.data!);
            });
          } else {
            _refreshController.loadNoData();
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            activeFirms.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again later.',
          mode: SnackbarMode.error,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> _loadPartyData() async {
    setState(() {
      isLoading = true;
    });
    try {
      ActivePartiesModel? activePartiesModel = await partyServices.activeParties();
      if (activePartiesModel != null) {
        if (activePartiesModel.success == true) {
          if (activePartiesModel.data!.isNotEmpty) {
            setState(() {
              parties.clear();
              parties.addAll(activePartiesModel.data!);
            });
          } else {
            _refreshController.loadNoData();
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            activePartiesModel.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again later.',
          mode: SnackbarMode.error,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> _loadClothData() async {
    setState(() {
      isLoading = true;
    });
    try {
      DropdownClothQualityListModel? activeClothQualityModel = await dropdownServices.clothQualityList();
      if (activeClothQualityModel != null) {
        if (activeClothQualityModel.success == true) {
          if (activeClothQualityModel.data!.isNotEmpty) {
            setState(() {
              activeClothQuality.clear();
              activeClothQuality.addAll(activeClothQualityModel.data!);
            });
          } else {
            _refreshController.loadNoData();
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            activeClothQualityModel.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again later.',
          mode: SnackbarMode.error,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void clearFilters() async {
    // Clear the preferences
    await HelperFunctions.setFirmID('');
    await HelperFunctions.setPartyID('');
    await HelperFunctions.setClothID('');
    setState(() {
      selectedFirm = null;
      selectedParty = null;
      selectedClothQuality = null;
    });
    if (firstDateForSell != DateTime(2000) || lastDateForSell != DateTime(2050)) {
      setState(() {
        firstDateForSell = DateTime(2000);
        lastDateForSell = DateTime(2050);
      });
    }
    getSellHistory(1, ''); // Assuming you're resetting to the first page and empty search query
  }
}
