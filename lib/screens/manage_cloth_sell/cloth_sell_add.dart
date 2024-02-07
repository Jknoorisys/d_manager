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

class ClothSellAdd extends StatefulWidget {
  final Map<String, dynamic>? clothSellData;
  const ClothSellAdd({Key? key, this.clothSellData}) : super(key: key);

  @override
  _ClothSellAddState createState() => _ClothSellAddState();
}

class _ClothSellAddState extends State<ClothSellAdd> {
  bool submitted = false;
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  String myFirm = 'Danish Textiles';
  String partyName = 'Mahesh Textiles';
  String clothQuality = '5 - Kilo';
  String status = 'On Going';


  TextEditingController totalThanController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.clothSellData != null) {
      selectedDate = DateFormat('dd-MM-yyyy').parse(widget.clothSellData!['dealDate']);
      myFirm = widget.clothSellData!['myFirm'];
      partyName = widget.clothSellData!['partyName'];
      status = widget.clothSellData!['status'];
      totalThanController.text = widget.clothSellData!['totalThan'];
      clothQuality = widget.clothSellData!['clothQuality'];
    }
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
                              CustomDatePicker(selectedDate: selectedDate, firstDate: firstDate, lastDate: lastDate),
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
                                onChanged: (newValue) {
                                  setState(() {
                                    myFirm = newValue!;
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
                            submitted = true;
                          });
                          if (_isFormValid()) {
                            Navigator.of(context).pushReplacementNamed(AppRoutes.clothSellList);
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
        )
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
}
