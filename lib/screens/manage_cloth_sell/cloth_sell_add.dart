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
import '../../api/manage_sell_deals.dart';
import '../../models/sell_models/create_sell_deal_model.dart';
import '../widgets/loader.dart';
import '../widgets/snackbar.dart';

class ClothSellAdd extends StatefulWidget {
  final Map<String, dynamic>? clothSellData;
  const ClothSellAdd({Key? key, this.clothSellData}) : super(key: key);

  @override
  _ClothSellAddState createState() => _ClothSellAddState();
}

class _ClothSellAddState extends State<ClothSellAdd> {
  bool submitted = false;
  String myFirm = 'Danish Textiles';
  String partyName = 'Mahesh Textiles';
  String clothQuality = '5 - Kilo';
  String status = 'On Going';

  TextEditingController totalThanController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  SellDealDetails sellDealDetails = SellDealDetails();
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;



  void handleDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }
  void handleMyFirmChanged(String? newValue) {
    setState(() {
      myFirm = newValue!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return
      CustomDrawer(
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
                              CustomDropdown(
                                dropdownItems: ['Mahesh Textiles', 'Danish Textiles', 'SS Textiles', 'Laxmi Traders'],
                                selectedValue: myFirm,
                                onChanged: handleMyFirmChanged,
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
                              CustomDropdown(
                                dropdownItems: const ['Mahesh Textiles', 'Tulsi Textiles', 'Laxmi Traders', 'Mahalaxmi Textiles', 'Veenapani Textiles'],
                                selectedValue: partyName,
                                onChanged: (newValue) {
                                  setState(() {
                                    partyName = newValue!;
                                  });
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
                              CustomDropdown(
                                dropdownItems: ['5 - Kilo', '6 - Kilo', '5/200'],
                                selectedValue: clothQuality,
                                onChanged: (newValue) {
                                  setState(() {
                                    clothQuality = newValue!;
                                  });
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
                          setState(() {
                            isLoading = !isLoading;
                          });
                          _handleCreateSellDeal();
                          // setState(() {
                          //   submitted = true;
                          // });
                          // if (_isFormValid()) {
                          //   Navigator.of(context).pushReplacementNamed(AppRoutes.clothSellList);
                          // }
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
  Future<void> NewSellDeal(
      BuildContext context,
      String userID,
      DateTime sellDate,
      String firmID,
      String partyID,
      String qualityID,
      String totalThan,
      String rate,
      ) async {

    try {
      String formattedSellDate = DateFormat('yyyy-MM-dd').format(sellDate);
      CreateSellDealModel? model = await sellDealDetails.createNewSellDeal(
        userID,
        formattedSellDate,
        firmID,
        partyID,
        qualityID,
        totalThan,
        rate,
      );
      if (model?.success == true) {
        Navigator.of(context).pop(); // Close the loading dialog
        Navigator.of(context).pushNamed(AppRoutes.clothSellList);
      } else {
        Navigator.of(context).pop(); // Close the loading dialog
        CustomApiSnackbar.show(
          context,
          'Error',
          model!.message!,
          mode: SnackbarMode.error,
        );
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }
  Future<void> _handleCreateSellDeal()async{
    // Validate total than and rate fields
    bool isFormValid = _isFormValid();
    if (isFormValid) {
      NewSellDeal(
        context,
        '1',
        selectedDate,
        '1',
        '1',
        '1',
        totalThanController.text,
        rateController.text,
      );
    }
  }
}
