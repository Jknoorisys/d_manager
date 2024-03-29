import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../api/manage_sell_deals.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_datepicker.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../constants/routes.dart';
import '../../generated/l10n.dart';
import '../../models/sell_models/sell_deal_list_model.dart';
import '../../models/sell_models/update_sell_deal_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../api/dropdown_services.dart';
import '../../api/manage_firm_services.dart';
import '../../api/manage_party_services.dart';
import '../../models/dropdown_models/dropdown_cloth_quality_list_model.dart';
import '../../models/sell_models/active_firms_model.dart';
import '../../models/sell_models/active_parties_model.dart';
import '../widgets/new_custom_dropdown.dart';
import '../widgets/snackbar.dart';
class UpdateSellDeal extends StatefulWidget {
  final int sellID;
  final SellDeal sellListData;
  ActiveFirmsList? selectedFirm;
  ActivePartiesList? selectedParty;
  ClothQuality? selectedClothQuality;
   UpdateSellDeal({
    super.key,
    required this.sellID,
    required this.sellListData,
    this.selectedFirm,
    this.selectedParty,
    this.selectedClothQuality,
  });
  @override
  State<UpdateSellDeal> createState() => _UpdateSellDealState();
}

class _UpdateSellDealState extends State<UpdateSellDeal> {
  TextEditingController firmController = TextEditingController();
  TextEditingController partyController = TextEditingController();
  TextEditingController clothQualityController = TextEditingController();
  late SellDeal _sellListData;
  late TextEditingController totalThanController;
  late TextEditingController rateController;
  bool submitted = false;
  String myFirm = 'Danish Textiles';
  String partyName = 'Mahesh Textiles';
  String clothQuality = '5 - Kilo';
  String status = 'On Going';
  bool isLoading = false;
  SellDealDetails sellDealDetails = SellDealDetails();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDueDate = DateTime.now();

  ManageFirmServices firmServices = ManageFirmServices();
  ManagePartyServices partyServices = ManagePartyServices();
  DropdownServices dropdownServices = DropdownServices();
  List<ActiveFirmsList> firms = [];
  List<ActivePartiesList> parties = [];
  List<ClothQuality> activeClothQuality = [];
  final RefreshController _refreshController = RefreshController();
  ActiveFirmsList? selectedFirm;
  ActivePartiesList? selectedParty;
  ClothQuality? selectedClothQuality;
  String? firmID;
  String? partyID;
  String? clothID;

  void handleDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
    print("selectedDatebefore===== $selectedDate");
  }
  @override
  void initState() {
    super.initState();
    _sellListData = widget.sellListData;
    totalThanController = TextEditingController(text: _sellListData.totalThan);
    rateController = TextEditingController(text: _sellListData.rate);

    if (widget.selectedFirm != null) {
      selectedFirm = widget.selectedFirm!;
      firmID = selectedFirm!.firmId.toString();
    }
    if (widget.selectedParty != null) {
      selectedParty = widget.selectedParty!;
      partyID = selectedParty!.partyId.toString();
    }
    if (widget.selectedClothQuality != null) {
      selectedClothQuality = widget.selectedClothQuality!;
      clothID = selectedClothQuality!.qualityId.toString();
    }

    _loadData();
    _loadPartyData();
    _loadClothData();
  }


  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content:CustomBody(
          isLoading: isLoading,
          title: S.of(context).updateSellDeal,
          content:isLoading ? Container() : Padding(
            padding: EdgeInsets.only(left: Dimensions.height10, right: Dimensions.height10, bottom: Dimensions.height20),
            child: Card(
              elevation: 10,
              color: AppTheme.white,
              shadowColor: AppTheme.nearlyWhite,
              surfaceTintColor: AppTheme.nearlyWhite,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Deal Details
                      Text("Deal Details", style: AppTheme.heading2,),
                      Gap(Dimensions.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Select Deal Date', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomDatePickerForUpdate(
                                  selectedDate: widget.sellListData.sellDate!, // pass selectedDate
                                  onDateChanged: (newDate) {
                                    setState(() {
                                      selectedDate = newDate; // update selectedDate when a new date is selected
                                    });
                                    print("Deal Date==== $selectedDate");
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Select My Firm', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomDropdownNew<ActiveFirmsList>(
                                  hintText: 'Select Firm',
                                  dropdownItems: firms ?? [],
                                  selectedValue: selectedFirm,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedFirm = newValue;
                                      if (newValue != null) {
                                        firmID = newValue.firmId.toString();
                                      } else {
                                        firmID = null; // Reset firmID if selectedFirm is null
                                      }
                                    });
                                  },
                                  displayTextFunction: (ActiveFirmsList? firm) {
                                    return firm!.firmName!;
                                  },
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Select Party Name', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomDropdownNew<ActivePartiesList>(
                                  hintText: 'Select Party',
                                  dropdownItems: parties ?? [],
                                  selectedValue: selectedParty,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedParty = newValue;
                                      if (newValue != null) {
                                        partyID = newValue.partyId.toString();
                                      } else {
                                        partyID = null; // Reset partyID if selectedParty is null
                                      }
                                    });
                                  },
                                  displayTextFunction: (ActivePartiesList? party) {
                                    return party!.partyName!;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Select Cloth Quality', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomDropdownNew<ClothQuality>(
                                  hintText: 'Cloth Quality',
                                  dropdownItems: activeClothQuality ?? [],
                                  selectedValue: selectedClothQuality,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedClothQuality = newValue;
                                      if (newValue != null) {
                                        clothID = newValue.qualityId.toString();
                                      } else {
                                        clothID = null; // Reset clothID if selectedClothQuality is null
                                      }
                                    });
                                  },
                                  displayTextFunction: (ClothQuality? cloth) {
                                    return cloth!.qualityName!;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Total Than', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomTextField(
                                  controller: totalThanController,
                                  hintText: "Enter Total Than",
                                  keyboardType: TextInputType.number,
                                  borderRadius: Dimensions.radius10,
                                  width: MediaQuery.of(context).size.width/2.65,
                                  // errorText: errorTotalThan.toString() != 'null' ? errorTotalThan.toString() : '',
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Rate', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomTextField(
                                  controller: rateController,
                                  hintText: "Enter Rate",
                                  keyboardType: TextInputType.number,
                                  borderRadius: Dimensions.radius10,
                                  width: MediaQuery.of(context).size.width/2.65,
                                  //errorText: errorRate.toString() != 'null' ? errorRate.toString() : '',
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Status', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomDropdown(
                                  dropdownItems: ['On Going', 'Completed'],
                                  selectedValue: status,
                                  onChanged: (newValue) {
                                    setState(() {
                                      status = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Select Due Date', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                               CustomDatePickerForUpdate(
                                 selectedDate: widget.sellListData.sellDueDate!, // pass selectedDate
                                 onDateChanged: (newDate) {
                                   setState(() {
                                     selectedDueDate = newDate; // update selectedDate when a new date is selected
                                   });
                                   print("Due Date=== $selectedDueDate");
                                 },
                               )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      CustomElevatedButton(
                        onPressed: () {
                          _handleUpdateSellDeal();
                        },
                        buttonText: 'Save',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
  Future<void> _handleUpdateSellDeal() async{
    UpdateSellDeal(
      context,
      selectedDate,
      firmID!,
      partyID!,
      clothID!,
      totalThanController.text,
      rateController.text,
        selectedDueDate
    );
  }
  Future<void> UpdateSellDeal(
      BuildContext context,
      DateTime sellDate,
      String firmID,
      String partyID,
      String qualityID,
      String totalThan,
      String rate,
      DateTime sellDueDate
      ) async {
    try {
      String formattedSellDate = DateFormat('yyyy-MM-dd').format(sellDate);
      String formattedSellDueDate = DateFormat('yyyy-MM-dd').format(sellDueDate);
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        UpdateSellDealModel? model = await sellDealDetails.updateSellDealApi(
            widget.sellID.toString(),
            formattedSellDate,
            firmID,
            partyID,
            qualityID,
            totalThan,
            rate,
            formattedSellDueDate
        );
        if (model?.success == true) {
          Navigator.of(context).pushNamed(AppRoutes.clothSellList);
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            model!.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Warning',
          'No Internet Connection!',
          mode: SnackbarMode.warning,
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      CustomApiSnackbar.show(
        context,
        'Error',
        'Something went wrong, please try again later.',
        mode: SnackbarMode.error,
      );
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
              if (widget.selectedFirm != null) {
                selectedFirm = firms.firstWhereOrNull((firm) => firm.firmId.toString() == widget.selectedFirm?.firmId.toString());
              }
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
              if (widget.selectedParty != null) {
                selectedParty = parties.firstWhereOrNull((party) => party.partyId.toString() == widget.selectedParty?.partyId.toString());
              }
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
              if (widget.selectedClothQuality != null) {
                selectedClothQuality = activeClothQuality.firstWhereOrNull((cloth) => cloth.qualityId.toString() == widget.selectedClothQuality?.qualityId.toString());
              }
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
}
