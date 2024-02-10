
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
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
import '../../models/sell_models/update_sell_deal_model.dart';
class UpdateSellDeal extends StatefulWidget {
  final int sellID;
  const UpdateSellDeal({super.key, required this.sellID});
  @override
  State<UpdateSellDeal> createState() => _UpdateSellDealState();
}

class _UpdateSellDealState extends State<UpdateSellDeal> {
  bool submitted = false;
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  String myFirm = 'Danish Textiles';
  String partyName = 'Mahesh Textiles';
  String clothQuality = '5 - Kilo';
  String status = 'On Going';

  TextEditingController totalThanController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  SellDealDetails sellDealDetails = SellDealDetails();
  DateTime selectedDate = DateTime.now();

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
    return CustomDrawer(
        content: CustomBody(
          title: 'Update Cloth Sell Deal',
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
                              CustomDatePicker(selectedDate: DateTime.parse(selectedDate.toString()), firstDate: firstDate, lastDate: lastDate),
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
                          _handleUpdateSellDeal();

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
        )
    );
  }
  Future<void> _handleUpdateSellDeal()async{
    UpdateSellDeal(
      context,
      selectedDate,
      '1',
      '2',
      '3',
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
      // String userID  =await HelperFunctions.getUserID();
      //print("USerIDInUpdateScreen==== $userID");
      UpdateSellDealModel? model = await sellDealDetails.updateSellDealApi(
        '1',
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
}
