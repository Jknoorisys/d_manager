import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_datepicker.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../api/dropdown_services.dart';
import '../../api/manage_firm_services.dart';
import '../../api/manage_party_services.dart';
import '../../api/manage_sell_deals.dart';
import '../../helpers/helper_functions.dart';
import '../../models/dropdown_models/dropdown_cloth_quality_list_model.dart';
import '../../models/sell_models/active_firms_model.dart';
import '../../models/sell_models/active_parties_model.dart';
import '../../models/sell_models/create_sell_deal_model.dart';
import '../widgets/new_custom_dropdown.dart';
import '../widgets/snackbar.dart';

class ClothSellAdd extends StatefulWidget {
  final Map<String, dynamic>? clothSellData;
  const ClothSellAdd({Key? key, this.clothSellData}) : super(key: key);

  @override
  _ClothSellAddState createState() => _ClothSellAddState();
}

class _ClothSellAddState extends State<ClothSellAdd> {
  bool submitted = false;
  String status = 'On Going';

  TextEditingController totalThanController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  SellDealDetails sellDealDetails = SellDealDetails();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDueDate = DateTime.now();
  bool isLoading = false;
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

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadPartyData();
    _loadClothData();
  }
  @override
  Widget build(BuildContext context) {
    var errorTotalThan = submitted == true ? _validateTotalThan(totalThanController.text) : null,
        errorRate = submitted == true ? _validateRate(rateController.text) : null;
    return CustomDrawer(
        content: CustomBody(
          title: widget.clothSellData == null ? 'Create Cloth Sell Deal' : 'Update Cloth Sell Deal',
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
                              //CustomDatePicker(selectedDate: selectedDate, firstDate: firstDate, lastDate: lastDate),
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
                                errorText: selectedFirm == null ? 'Firm is required' : null,
                                onChanged:(newValue){
                                  setState(() {
                                    selectedFirm = newValue;
                                    if (newValue != null) {
                                      firmID = newValue.firmId.toString();
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
                                errorText: selectedParty == null ? 'Party is required' : null,
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
                                errorText: selectedClothQuality == null ? 'Cloth Quality is required' : null,
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
                                errorText: errorTotalThan.toString() != 'null' ? errorTotalThan.toString() : '',
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
                                errorText: errorRate.toString() != 'null' ? errorRate.toString() : '',
                              )
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select Due Date', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              //CustomDatePicker(selectedDate: selectedDate, firstDate: firstDate, lastDate: lastDate),
                              CustomDatePicker(selectedDate: DateTime.parse(selectedDueDate.toString())),
                            ],
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      CustomElevatedButton(
                        onPressed: () {
                          setState(() {
                            submitted = true;
                          });
                          if (_isFormValid()) {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            NewSellDeal(
                                context,
                                selectedDate,
                                firmID!,
                                partyID!, // Assuming partyID is not null
                                clothID!, // Assuming qualityID is fixed
                                totalThanController.text,
                                rateController.text,
                                selectedDueDate
                            );
                          }
                        },
                        buttonText: 'Save',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }

  String? _validateTotalThan(String? value) {
    if (value == null || value.isEmpty) {
      return 'Total Than is required';
    }
    return null;
  }

  String? _validateRate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Rate is required';
    }
    return null;
  }

  bool _isFormValid() {
    String totalThanError = _validateTotalThan(totalThanController.text) ?? '';
    String rateError = _validateRate(rateController.text) ?? '';
    return totalThanError.isEmpty && rateError.isEmpty ? true : false;
  }

  Future<CreateSellDealModel?> NewSellDeal(
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
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        String formattedSellDate = DateFormat('yyyy-MM-dd').format(sellDate);
        String formattedSellDueDate = DateFormat('yyyy-MM-dd').format(sellDueDate);
        CreateSellDealModel? model = await sellDealDetails.createNewSellDeal(
          formattedSellDate,
          firmID,
          partyID,
          qualityID,
          totalThan,
          rate,
          formattedSellDueDate,
        );
        if (model?.success == true) {
          Navigator.of(context).pop(); // Close the loading dialog
          Navigator.of(context).pushNamed(AppRoutes.clothSellList);
          CustomApiSnackbar.show(
            context,
            'Success',
            'Your deal has been created successfully',
            mode: SnackbarMode.success,
          );
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            model!.message!,
            mode: SnackbarMode.error,
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        CustomApiSnackbar.show(
          context,
          'Warning',
          'No Internet Connection',
          mode: SnackbarMode.warning,
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      Navigator.of(context).pop();
      CustomApiSnackbar.show(
        context,
        'Error',
        'Something went wrong, please try again later.',
        mode: SnackbarMode.error,
      );
    }
  }

  // Future<void> _handleCreateSellDeal()async{
  //   print("formValidation==== ${_isFormValid()}");
  //   print("internet==== ${HelperFunctions.checkInternet()}");
  //   if (_isFormValid()) {
  //     if (HelperFunctions.checkInternet() == false) {
  //       CustomApiSnackbar.show(
  //         context,
  //         'Warning',
  //         'No internet connection',
  //         mode: SnackbarMode.warning,
  //       );
  //       print("internetpermission");
  //     } else {
  //       setState(() {
  //         isLoading = !isLoading;
  //       });
  //       NewSellDeal(
  //         context,
  //         selectedDate,
  //         firmID!,
  //         partyID!, // Assuming partyID is not null
  //         clothID!, // Assuming qualityID is fixed
  //         totalThanController.text,
  //         rateController.text,
  //       );
  //     }
  //   }
  // }

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
