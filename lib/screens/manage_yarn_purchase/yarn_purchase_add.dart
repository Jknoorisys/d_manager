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

class YarnPurchaseAdd extends StatefulWidget {
  final Map<String, dynamic>? yarnPurchaseData;
  const YarnPurchaseAdd({super.key, this.yarnPurchaseData});

  @override
  State<YarnPurchaseAdd> createState() => _YarnPurchaseAddState();
}

class _YarnPurchaseAddState extends State<YarnPurchaseAdd> {
  bool submitted = false;
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  String paymentType = 'Current';
  String myFirm = 'Danish Textiles';
  String partyName = 'Mehta and Sons Yarn Trades';
  String yarnName = 'Golden';
  String yarnType = 'Roto';
  String status = 'On Going';
  String dharaOption = '15 days';


  TextEditingController lotNumberController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController boxOrderedController = TextEditingController();
  TextEditingController denyarController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController copsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.yarnPurchaseData != null) {
      selectedDate = DateFormat('dd-MM-yyyy').parse(widget.yarnPurchaseData!['dealDate']);
      myFirm = widget.yarnPurchaseData!['myFirm'];
      partyName = widget.yarnPurchaseData!['partyName'];
      status = widget.yarnPurchaseData!['status'];
      lotNumberController.text = widget.yarnPurchaseData!['lotNumber'];
      netWeightController.text = widget.yarnPurchaseData!['totalNetWeight'];
      yarnName = widget.yarnPurchaseData!['yarnName'];
      yarnType = widget.yarnPurchaseData!['yarnType'];
      boxOrderedController.text = widget.yarnPurchaseData!['boxOrdered'];
      denyarController.text = widget.yarnPurchaseData!['Deiner'];
      rateController.text = widget.yarnPurchaseData!['rate'];
      copsController.text = widget.yarnPurchaseData!['cops'];
      paymentType = widget.yarnPurchaseData!['paymentType'];
    }
  }
  @override
  Widget build(BuildContext context) {
    var errorLotNumber = submitted == true ? _validateLotNumber(lotNumberController.text) : null,
        errorNetWeight = submitted == true ? _validateNetWeight(netWeightController.text) : null,
        errorBoxOrdered = submitted == true ? _validateBoxOrdered(boxOrderedController.text) : null,
        errorDenyar = submitted == true ? _validateDenyar(denyarController.text) : null,
        errorRate = submitted == true ? _validateRate(rateController.text) : null,
        errorCops = submitted == true ? _validateCops(copsController.text) : null;
    return CustomDrawer(
        content: CustomBody(
          title: widget.yarnPurchaseData == null ? 'Create Yarn Purchase Deal' : 'Update Yarn Purchase Deal',
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
                                dropdownItems: ['Mahesh Textiles', 'Danish Textiles', 'SS Textiles and Sons', 'Laxmi Traders'],
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
                                dropdownItems: ['SS Textile', 'Nageena Textile', 'Mehta and Sons Yarn Trades', 'Bluesky Cloth Sale', 'Suntex Textiles'],
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
                        ],
                      ),
                      Gap(Dimensions.height30),

                      // Purchase Details
                      Text("Purchase Details", style: AppTheme.heading2,),
                      Gap(Dimensions.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Lot Number', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomTextField(
                                controller: lotNumberController,
                                hintText: "Enter Lot Number",
                                keyboardType: TextInputType.number,
                                borderRadius: Dimensions.radius10,
                                width: MediaQuery.of(context).size.width/2.65,
                                errorText: errorLotNumber.toString() != 'null' ? errorLotNumber.toString() : '',
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Net Weight', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomTextField(
                                controller: netWeightController,
                                hintText: "Enter Net Weight",
                                keyboardType: TextInputType.number,
                                borderRadius: Dimensions.radius10,
                                width: MediaQuery.of(context).size.width/2.65,
                                errorText: errorNetWeight.toString() != 'null' ? errorNetWeight.toString() : '',
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
                              BigText(text: 'Select Yarn Name', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDropdown(
                                dropdownItems: ['Bhilosa', 'Golden', 'Silver'],
                                selectedValue: yarnName,
                                onChanged: (newValue) {
                                  setState(() {
                                    yarnName = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select Yarn Type', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDropdown(
                                dropdownItems: ['Roto', 'Zero', 'dZero'],
                                selectedValue: yarnType,
                                onChanged: (newValue) {
                                  setState(() {
                                    yarnType = newValue!;
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
                              BigText(text: 'Box Ordered', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomTextField(
                                controller: boxOrderedController,
                                hintText: "Enter Box Ordered",
                                keyboardType: TextInputType.number,
                                borderRadius: Dimensions.radius10,
                                width: MediaQuery.of(context).size.width/2.65,
                                errorText: errorBoxOrdered.toString() != 'null' ? errorBoxOrdered.toString() : '',
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Denyar', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomTextField(
                                controller: denyarController,
                                hintText: "Enter Denyar",
                                keyboardType: TextInputType.number,
                                borderRadius: Dimensions.radius10,
                                width: MediaQuery.of(context).size.width/2.65,
                                errorText: errorDenyar.toString() != 'null' ? errorDenyar.toString() : '',
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Cops', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomTextField(
                                controller: copsController,
                                hintText: "Enter Cops",
                                keyboardType: TextInputType.number,
                                borderRadius: Dimensions.radius10,
                                width: MediaQuery.of(context).size.width/2.65,
                                errorText: errorCops.toString() != 'null' ? errorCops.toString() : '',
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
                              BigText(text: 'Select Delivery Type', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDropdown(
                                dropdownItems: ['Current', 'Dhara'],
                                selectedValue: paymentType,
                                onChanged: (newValue) {
                                  setState(() {
                                    paymentType = newValue!;
                                  });
                                },
                              )
                            ],
                          ),
                          if (paymentType == 'Current')
                            _buildCurrentFields()
                          else
                            _buildDharaFields(),
                        ],
                      ),
                      if (paymentType == 'Dhara' && dharaOption == 'Other')
                        _buildOtherDharaField(),
                      Gap(Dimensions.height20),
                      CustomElevatedButton(
                        onPressed: () {
                          setState(() {
                            submitted = true;
                          });
                          if (_isFormValid()) {
                            Navigator.of(context).pushReplacementNamed(AppRoutes.yarnTypeList);
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

  Widget _buildCurrentFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: 'Select Due Date', size: Dimensions.font12,),
        Gap(Dimensions.height10/2),
        CustomDatePicker(
          selectedDate: selectedDate,
          firstDate: firstDate,
          lastDate: lastDate
        )
      ],
    );
  }

  Widget _buildDharaFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: 'Select Dhara Options', size: Dimensions.font12,),
        Gap(Dimensions.height10/2),
        CustomDropdown(
          dropdownItems: ['15 days', '40 days', 'Other'],
          selectedValue: dharaOption,
          onChanged: (newValue) {
            setState(() {
              dharaOption = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildOtherDharaField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(Dimensions.height20),
        BigText(text: 'Select Due Date', size: Dimensions.font12,),
        Gap(Dimensions.height10/2),
        CustomDatePicker(
          width: MediaQuery.of(context).size.width,
          selectedDate: selectedDate,
          firstDate: firstDate,
          lastDate: lastDate
        )
      ],
    );
  }

  String? _validateLotNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lot Number is required';
    }
    return null;
  }

  String? _validateNetWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Net Weight is required';
    }
    return null;
  }

  String? _validateBoxOrdered(String? value) {
    if (value == null || value.isEmpty) {
      return 'Box Ordered is required';
    }
    return null;
  }

  String? _validateDenyar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Denyar is required';
    }
    return null;
  }

  String? _validateRate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Rate is required';
    }
    return null;
  }

  String? _validateCops(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cops is required';
    }
    return null;
  }

  bool _isFormValid() {
    String lotNumberError = _validateLotNumber(lotNumberController.text) ?? '';
    String netWeightError = _validateNetWeight(netWeightController.text) ?? '';
    String boxOrderedError = _validateBoxOrdered(boxOrderedController.text) ?? '';
    String denyarError = _validateDenyar(denyarController.text) ?? '';
    String rateError = _validateRate(rateController.text) ?? '';
    String copsError = _validateCops(copsController.text) ?? '';

    return lotNumberError.isEmpty && netWeightError.isEmpty && boxOrderedError.isEmpty && denyarError.isEmpty && rateError.isEmpty && copsError.isEmpty ? true : false;
  }

}
