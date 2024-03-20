import 'package:d_manager/api/manage_invoice_services.dart';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/models/dropdown_models/drop_down_party_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_film_list_model.dart';
import 'package:d_manager/models/history_models/export_history_model.dart';
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
import 'package:url_launcher/url_launcher.dart';
import '../../api/manage_history_services.dart';
import '../../helpers/helper_functions.dart';
import '../../models/history_models/sell_history_model.dart';
import '../manage_cloth_sell/cloth_sell_view.dart';
import '../widgets/new_custom_dropdown.dart';
import '../widgets/snackbar.dart';
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
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(2000);
  DateTime lastDate = DateTime(2050);
  DateTime firstDateForSell = DateTime.now();
  DateTime lastDateForSell = DateTime.now().add(const Duration(days: 7));

  bool isLoading = false;
  ManageHistoryServices manageHistoryServices = ManageHistoryServices();
  int currentPage = 1;
  final RefreshController _refreshController = RefreshController();

  //
  ManageFirmServices firmServices = ManageFirmServices();
  ManagePartyServices partyServices = ManagePartyServices();
  DropdownServices dropdownServices = DropdownServices();
  var selectedFirm;
  var selectedParty;
  var selectedClothQuality;
  var selectedStartDate;
  var selectedEndDate;
  List<Firm> firms = [];
  List<Party> parties = [];
  List<ClothQuality> cloths = [];
  bool isFilterApplied = false;
  bool noRecordFound = false;
  bool isNetworkAvailable = true;
  DateTime? firstDateForPurchase = DateTime.now();
  DateTime? lastDateForPurchase = DateTime.now().add(const Duration(days: 7));
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = !isLoading;
    });
    getSellHistory(currentPage, searchController.text.trim());
    _getFirms();
    _getParties();
    _getClothTypes();
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          isLoading:isLoading,
          internetNotAvailable: isNetworkAvailable,
          title: S.of(context).sellHistory,
          filterButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Map<String, dynamic> body = {
                    'user_id': HelperFunctions.getUserID(),
                    // 'page_no': currentPage.toString(),
                    'search' : searchController.text.trim() == '' ? '' : searchController.text.trim(),
                    "firm_id" : selectedFirm != null ? selectedFirm.toString() : "",
                    'party_id' : selectedParty != null ? selectedParty.toString() : "",
                    'quality_id' : selectedClothQuality != null ? selectedClothQuality.toString() : "",
                    'start_date' : selectedStartDate != null ? selectedStartDate.toString() : "",
                    'end_date' : selectedEndDate != null ? selectedEndDate.toString() : "",
                  };
                  _exportSellHistory(body);
                },
                  child: const Icon(Icons.print, color: AppTheme.black)
              ),
              SizedBox(width: Dimensions.width20),
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: const FaIcon(FontAwesomeIcons.sliders, color: AppTheme.black),
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
                          hintText: 'Search here...',
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
                                              SizedBox(
                                                width : Dimensions.screenWidth * 0.5,
                                                  child: BigText(text: sellHistoryData[index].partyName!, color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,)),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: AppTheme.black,
                                                    radius: Dimensions.height10,
                                                    child: BigText(text: sellHistoryData[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                                  ),
                                                  SizedBox(width: Dimensions.width10),
                                                  SizedBox(
                                                      width : Dimensions.screenWidth * 0.5,
                                                      child: SmallText(text: sellHistoryData[index].firmName!, color: AppTheme.black, size: Dimensions.font12)),
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
                              SizedBox(height: Dimensions.height10),
                              AppTheme.divider,
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  Expanded(flex:1,child: _buildInfoColumn('Deal Date', sellHistoryData[index].sellDate!.toString())),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Cloth Quality', sellHistoryData[index].qualityName!)),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Total Thans', sellHistoryData[index].totalThan!)),
                                ],
                              ),
                            ],
                          ),
                          contentChild: Column(
                            children: [
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  Expanded(flex:1,child: _buildInfoColumn('Deal Rate','₹${sellHistoryData[index].rate!}')),
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
                                  Expanded(flex:1,child: _buildInfoColumn('Difference Amount', '₹${sellHistoryData[index].totalDifferenceAmount!.toString()}')),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Due Date', sellHistoryData[index].sellDueDate!.toString())),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  Expanded(flex:1,child: _buildInfoColumn('Total Invoice Amount', '₹${sellHistoryData[index].totalInvoiceAmount!.toString()}')),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Status', sellHistoryData[index].dealStatus! == 'completed' ? 'Completed' : 'On Going')),
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
                                                TextSpan(text: '₹${sellHistoryData[index].totalGstAmount!.toString()}',),
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
                                          BigText(text: '₹${sellHistoryData[index].totalReceivedAmount!.toString()}',color: AppTheme.primary, size: Dimensions.font18)
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
    if (title.contains('Date') && value != 'N/A' && value != '' && value != null) {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yy').format(date);
    }
    return Container(
      width: MediaQuery.of(context).size.width / 3.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.nearlyBlack, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font14),
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
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.all(Dimensions.height20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        tooltip: 'Apply Filters',
                        onPressed: () {
                          isLoading = true;
                          setState(() {
                            searchController.clear();
                            sellHistoryData.clear();
                            currentPage = 1;
                            isFilterApplied = true;
                            getSellHistory(currentPage, '');
                          });
                          Navigator.of(context).pop();
                        },
                        icon: const FaIcon(FontAwesomeIcons.filter, color: AppTheme.black),
                      ),
                      BigText(text: 'Apply Filters', size: Dimensions.font20, color: AppTheme.black),
                      IconButton(
                        tooltip: 'Clear Filters',
                        onPressed: () {
                          setState(() {
                            selectedFirm = null;
                            selectedParty = null;
                            selectedClothQuality = null;
                            selectedStartDate = null;
                            selectedEndDate = null;
                            isFilterApplied = false;
                            sellHistoryData.clear();
                            currentPage = 1;
                            getSellHistory(currentPage, '');
                          });
                          Navigator.of(context).pop();
                        },
                        icon: const FaIcon(FontAwesomeIcons.filterCircleXmark, color: AppTheme.black),
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
                          BigText(text: 'Select My Firm', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomApiDropdown(
                              hintText: 'Select Firm',
                              dropdownItems: firms.map((e) => DropdownMenuItem<dynamic>(value: e.firmId!, child: BigText(text: e.firmName!, size: Dimensions.font14,))).toList(),
                              selectedValue: firms.any((firm) => firm.firmId == selectedFirm) ? selectedFirm : null,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedFirm = newValue!;
                                });
                              }
                          )
                        ],
                      ),
                      Gap(Dimensions.height10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'Select Party Name', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomApiDropdown(
                              hintText: 'Select Party',
                              dropdownItems: parties.map((e) => DropdownMenuItem<dynamic>(value: e.partyId!, child: BigText(text: e.partyName!, size: Dimensions.font14,))).toList(),
                              selectedValue: parties.any((party) => party.partyId == selectedParty) ? selectedParty : null,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedParty = newValue!;
                                });
                              }
                          )
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
                          CustomApiDropdown(
                              hintText: 'Select Cloth Quality',
                              dropdownItems: cloths.map((e) => DropdownMenuItem<dynamic>(value: e.qualityId!, child: BigText(text: e.qualityName!, size: Dimensions.font14,))).toList(),
                              selectedValue: cloths.any((cloth) => cloth.qualityId == selectedClothQuality) ? selectedClothQuality : null,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedClothQuality = newValue!;
                                });
                              }
                          )
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
                                firstDate: firstDate,
                                lastDate: lastDate,
                              );

                              if (pickedDateRange != null) {
                                DateTime startDateForPurchaseHistory = pickedDateRange.start;
                                DateTime endDateForPurchaseHistory = pickedDateRange.end;
                                String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDateForPurchaseHistory);
                                String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDateForPurchaseHistory);
                                setState(() {
                                  firstDateForPurchase = startDateForPurchaseHistory;
                                  lastDateForPurchase = endDateForPurchaseHistory;
                                  selectedStartDate = formattedStartDate;
                                  selectedEndDate = formattedEndDate;
                                });
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
                                    Expanded(child: BigText(text: '${DateFormat('dd/MM/yyyy').format(firstDateForPurchase!)} to ${DateFormat('dd/MM/yyyy').format(lastDateForPurchase!)}', size: Dimensions.font12,)),
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
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _getFirms() async {
    DropdownFirmListModel? response = await dropdownServices.firmList();
    if (response != null) {
      setState(() {
        firms.addAll(response.data!);
        isLoading = false;
      });
    }
  }
  Future<void> _getParties() async {
    DropdownPartyListModel? response = await dropdownServices.partyList();
    if (response != null) {
      setState(() {
        parties.addAll(response.data!);
        isLoading = false;
      });
    }
  }
  Future<void> _getClothTypes() async {
    DropdownClothQualityListModel? response = await dropdownServices.clothQualityList();
    if (response != null) {
      setState(() {
        cloths.addAll(response.data!);
        isLoading = false;
      });
    }
  }
  Future<SellHistoryModel?> getSellHistory(int pageNo, String search) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        SellHistoryModel? model = await manageHistoryServices.showSellHistory(
          pageNo.toString(),
          search,
          selectedFirm,
          selectedParty,
          selectedClothQuality,
          selectedStartDate,
          selectedEndDate,
        );
        if (model != null) {
          if (model.success == true) {
            if (model.data!.isNotEmpty) {

              setState(() {
                if (pageNo == 1) {
                  sellHistoryData.clear();
                }
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
      } else {
        setState(() {
          isNetworkAvailable = false;
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _exportSellHistory(Map<String, dynamic> body) async {
    try {
      setState(() {
        isLoading = true;
      });

      ExportHistoryModel? historyModel = await ManageInvoiceServices().exportSellHistory(body);
      print(historyModel);
      if (historyModel?.message != null) {
        if (historyModel?.success == true) {
          if (historyModel?.filePath != null) {
            _launchUrl(Uri.parse('$baseUrl/${historyModel?.filePath!}'));
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              'Unable to download invoice, please try again...',
              mode: SnackbarMode.error,
            );
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            historyModel!.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again',
          mode: SnackbarMode.error,
        );
      }
    } catch (error) {
      CustomApiSnackbar.show(
        context,
        'Error',
        'An error occurred: $error',
        mode: SnackbarMode.error,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

}
