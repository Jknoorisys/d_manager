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
  const UpdateSellDeal({super.key, required this.sellID});
  @override
  State<UpdateSellDeal> createState() => _UpdateSellDealState();
}

class _UpdateSellDealState extends State<UpdateSellDeal> {
  bool submitted = false;
  String myFirm = 'Danish Textiles';
  String partyName = 'Mahesh Textiles';
  String clothQuality = '5 - Kilo';
  String status = 'On Going';
  bool isLoading = false;

  TextEditingController totalThanController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  SellDealDetails sellDealDetails = SellDealDetails();
  DateTime selectedDate = DateTime.now();

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
  }
  @override
  void initState() {
    super.initState();
    _loadData();
    _loadPartyData();
    _loadClothData();
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          title:S.of(context).manageClothSellDeal,
          content: Padding(
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select Deal Date', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDatePicker(selectedDate: DateTime.parse(selectedDate.toString())),
                            ],
                          ),
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
                                onChanged:(newValue){
                                  setState(() {
                                    selectedFirm = newValue;
                                    if (newValue != null) {
                                      firmID = newValue.firmId.toString();
                                      print("firmIDisselected===== $firmID");
                                    } else {
                                      firmID = null; // Reset firmID if selectedFirm is null
                                    }
                                  });
                                } ,
                                displayTextFunction: (ActiveFirmsList? firm){
                                  return firm!.firmName!;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                onChanged:(newValue){
                                  setState(() {
                                    selectedParty = newValue;
                                    if (newValue != null) {
                                      partyID = newValue.partyId.toString();
                                      print("partyIDselected===== $partyID");
                                    } else {
                                      partyID = null; // Reset firmID if selectedFirm is null
                                    }
                                  });
                                } ,
                                displayTextFunction: (ActivePartiesList? parties){
                                  return parties!.partyName!;
                                },
                              ),
                            ],
                          ),
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
                                onChanged:(newValue){
                                  setState(() {
                                    selectedClothQuality = newValue;
                                    if (newValue != null) {
                                      clothID = newValue.qualityId.toString();
                                      print("ClothIDisselected===== $clothID");
                                    } else {
                                      clothID = null; // Reset firmID if selectedFirm is null
                                    }
                                  });
                                } ,
                                displayTextFunction: (ClothQuality? cloth){
                                  return cloth!.qualityName!;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
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
                          Column(
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
                        ],
                      ),
                      Gap(Dimensions.height20),
                      Column(
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
  Future<void> _handleUpdateSellDeal()async{
    UpdateSellDeal(
      context,
      selectedDate,
      firmID!,
      partyID!,
      clothID!,
      totalThanController.text,
      rateController.text,
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
      ) async {
    try {
      String formattedSellDate = DateFormat('yyyy-MM-dd').format(sellDate);
      UpdateSellDealModel? model = await sellDealDetails.updateSellDealApi(
        widget.sellID.toString(),
        formattedSellDate,
        firmID,
        partyID,
        qualityID,
        totalThan,
        rate,
      );
      if (model?.success == true) {
        Navigator.of(context).pushNamed(AppRoutes.clothSellList);
      }
    } catch (e) {
      print("Error occurred: $e");
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
}
