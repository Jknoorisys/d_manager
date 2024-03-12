import 'package:d_manager/api/manage_sell_deals.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/screens/manage_cloth_sell/update_sell_deal.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../models/sell_models/active_parties_model.dart';
import '../../models/sell_models/sell_deal_list_model.dart';
import '../../models/sell_models/status_sell_deal_model.dart';
import '../widgets/new_custom_dropdown.dart';
import '../widgets/snackbar.dart';
import 'cloth_sell_view.dart';
import '../../api/dropdown_services.dart';
import '../../api/manage_firm_services.dart';
import '../../api/manage_party_services.dart';
import '../../models/dropdown_models/dropdown_cloth_quality_list_model.dart';
import '../../models/sell_models/active_firms_model.dart';

class ClothSellList extends StatefulWidget {
  const ClothSellList({Key? key}) : super(key: key);

  @override
  _ClothSellListState createState() => _ClothSellListState();
}

class _ClothSellListState extends State<ClothSellList> {
  SellDealDetails sellDealDetails = SellDealDetails();
  final searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController();
  SellDealListModel? sellDealListModel;
  List<SellDeal> clothSellList = [];

  String status = 'On Going';
  int currentPage = 1;

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
  bool isLoading = false;
  bool isNetworkAvailable = true;
  bool noRecordFound = false;
  HelperFunctions helperFunctions = HelperFunctions();
  bool isFilterApplied = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = !isLoading;
    });
    getSellDealList(currentPage, searchController.text.trim());
    _loadData();
    _loadPartyData();
    _loadClothData();
  }
  @override
  void dispose() {
    searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          isLoading: isLoading,
          noRecordFound: noRecordFound,
          internetNotAvailable: isNetworkAvailable,
          title: S.of(context).clothSellList,
          filterButton: GestureDetector(
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
            ): FaIcon(FontAwesomeIcons.sliders, color: AppTheme.black),
          ),
          content: Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child: Column(
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
                              clothSellList.clear();
                              currentPage = 1;
                              getSellDealList(currentPage, searchController.text.trim());
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              clothSellList.clear();
                              currentPage = 1;
                              getSellDealList(currentPage, value);
                            });
                          }
                      ),
                    ),
                    SizedBox(width: Dimensions.width20),
                    CustomIconButton(
                        radius: Dimensions.radius10,
                        backgroundColor: AppTheme.primary,
                        iconColor: AppTheme.white,
                        iconData: Icons.add,
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.clothSellAdd);
                        }
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                AppTheme.divider,
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: SmartRefresher(
                    enablePullUp: true,
                    controller: _refreshController,
                    onRefresh:() async {
                      setState(() {
                        clothSellList.clear();
                        currentPage = 1;
                      });
                      getSellDealList(currentPage, searchController.text.trim());
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      getSellDealList(currentPage, searchController.text.trim());
                      _refreshController.loadComplete();
                    },
                    child:
                    ListView.builder(
                      itemCount: clothSellList.length,
                      itemBuilder: (context, index) {
                        return CustomAccordion(
                          titleChild: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    children: [
                                      SizedBox(width: Dimensions.width10),
                                      CircleAvatar(
                                        backgroundColor: AppTheme.secondary,
                                        radius: Dimensions.height20,
                                        child: BigText(text: clothSellList[index].partyFirm![0], color: AppTheme.primary, size: Dimensions.font18),
                                      ),
                                      SizedBox(width: Dimensions.height10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: Dimensions.screenWidth * 0.5,
                                              child: BigText(text: clothSellList[index].partyName!, color: AppTheme.primary, size: Dimensions.font16)
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: AppTheme.black,
                                                radius: Dimensions.height10,
                                                child: BigText(text: clothSellList[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                              ),
                                              SizedBox(width: Dimensions.width10),
                                              SizedBox(
                                                  width: Dimensions.screenWidth * 0.5,
                                                  child: SmallText(text: clothSellList[index].firmName!, color: AppTheme.black, size: Dimensions.font12)
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              AppTheme.divider,
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  Expanded(flex:1,child: _buildInfoColumn('Deal Date', clothSellList[index].sellDate!.toString())),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Cloth Quality', clothSellList[index].qualityName!)),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Total Than', clothSellList[index].totalThan!)),
                                ],
                              ),
                            ],
                          ),
                          contentChild: Column(
                            children:[
                              Row(
                                children: [
                                  Expanded(flex:1,child: _buildInfoColumn('Than Delivered', clothSellList[index].thanDelivered!)),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Than Remaining', clothSellList[index].thanRemaining!)),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('Rate', '₹ ${clothSellList[index].rate!}')),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  Expanded(flex:1,child: _buildInfoColumn('Status', clothSellList[index].dealStatus! == 'ongoing' ? 'On Going' : 'Completed')),
                                  SizedBox(width: Dimensions.width20),
                                   Expanded(flex:1,child: _buildInfoColumn('Due Date', clothSellList[index].sellDueDate!.toString())),
                                  SizedBox(width: Dimensions.width20),
                                  Expanded(flex:1,child: _buildInfoColumn('', '')),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRoutes.clothSellView, arguments: {'sellID': clothSellList[index].sellId});
                                      },
                                      icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary)
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        selectedFirm = ActiveFirmsList(firmName: clothSellList[index].firmName,firmId:int.tryParse(clothSellList[index]!.firmId!));
                                        selectedParty = ActivePartiesList(partyName: clothSellList[index].partyFirm,partyId:int.tryParse(clothSellList[index]!.partyId!));
                                        selectedClothQuality = ClothQuality(qualityName: clothSellList[index].qualityName,qualityId:int.tryParse(clothSellList[index]!.qualityId!));

                                        // Navigator.of(context).pushNamed(AppRoutes.clothSellAdd, arguments: {'clothSellData': clothSellList[index]});
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            UpdateSellDeal(
                                                sellID: clothSellList[index].sellId!,
                                              sellListData:clothSellList[index],
                                              selectedFirm: selectedFirm, // Pass the selected firm
                                              selectedParty: selectedParty, // Pass the selected party
                                              selectedClothQuality: selectedClothQuality,
                                            )));

                                      },
                                      icon: const Icon(Icons.edit_outlined, color: AppTheme.primary)
                                  ),
                                  GFCheckbox(
                                    size: Dimensions.height20,
                                    type: GFCheckboxType.custom,
                                    inactiveBgColor: AppTheme.nearlyWhite,
                                    inactiveBorderColor: AppTheme.primary,
                                    customBgColor: AppTheme.primary,
                                    activeBorderColor: AppTheme.primary,
                                    onChanged: (value) {
                                      if (clothSellList[index].dealStatus == 'ongoing') {
                                        updateStatusOfSellDeal(
                                            clothSellList[index].sellId.toString(), 'completed', index);
                                      }
                                    },
                                    value: clothSellList[index].dealStatus == 'completed' ? true : false,
                                    inactiveIcon: null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      return
      Padding(
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
                      BigText(text: 'Status', size: Dimensions.font12,),
                      Gap(Dimensions.height10/2),
                      CustomDropdown(
                        dropdownItems: ['On Going', 'Completed'],
                        selectedValue: status,
                        onChanged: (newValue)async {
                          await HelperFunctions.setDealStatus(status!);
                          setState(() {
                            status = newValue!;
                          });
                        },
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
                      getSellDealList(1, searchController.text  );
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

    Future<SellDealListModel?> getSellDealList(int pageNo, String search,) async {
      setState(() {
        isLoading = true;
      });
      try {
        if (await HelperFunctions.isPossiblyNetworkAvailable()) {
          SellDealListModel? model = await sellDealDetails.sellDealListApi(
            pageNo.toString(),
            search,
          );
          if (model != null) {
            if (model.success == true) {
              if (model.data != null) {
                if (model.data!.isNotEmpty) {
                  if (pageNo == 1) {
                    clothSellList.clear();
                  }
                  print("sellDealList===");
                  setState(() {
                    clothSellList.addAll(model.data!);
                    currentPage++;
                  });
                } else {
                  _refreshController.loadNoData();
                }
              } else{
                setState(() {
                  noRecordFound = true;
                });
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

  Future<UpdateSellDealStatusModel?> updateStatusOfSellDeal(
      String sellID,
      String dealStatus,
      int index
      ) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        UpdateSellDealStatusModel? model = await sellDealDetails.updateSellDealStatus(
          sellID,
          dealStatus,
        );
        if (model != null) {
          if (model.success == true) {
            clothSellList[index].dealStatus = 'completed';
            CustomApiSnackbar.show(
              context,
              'Success',
              model.message!.toString(),
              mode: SnackbarMode.success,
            );
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
        CustomApiSnackbar.show(
          context,
          'Warning',
          'No Internet Connection',
          mode: SnackbarMode.warning,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
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
    await HelperFunctions.setDealStatus('');
    setState(() {
      selectedFirm = null;
      selectedParty = null;
      selectedClothQuality = null;
      status = 'On Going'; // Assuming 'On Going' is the default status
    });

    getSellDealList(1, ''); // Assuming you're resetting to the first page and empty search query
  }
}
