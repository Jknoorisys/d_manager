import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_datepicker.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DeliveryDetailAdd extends StatefulWidget {
  final Map<String, dynamic>? deliveryDetailData;
  const DeliveryDetailAdd({Key? key, this.deliveryDetailData}) : super(key: key);

  @override
  _DeliveryDetailAddState createState() => _DeliveryDetailAddState();
}

class _DeliveryDetailAddState extends State<DeliveryDetailAdd> {
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

  bool isPaid = false;
  String paymentMethod = 'RTGS';
  DateTime paidDate = DateTime.now();
  double amountPaid = 0.0;
  bool isBillReceived = false;
  FilePickerResult? billImageResult;


  TextEditingController amountPaidController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController boxReceivedController = TextEditingController();
  TextEditingController denyarController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController copsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.deliveryDetailData != null) {
      selectedDate = DateFormat('dd-MM-yyyy').parse(widget.deliveryDetailData!['dealDate']);
      status = widget.deliveryDetailData!['status'];
      amountPaidController.text = widget.deliveryDetailData!['amountPaid'];
      netWeightController.text = widget.deliveryDetailData!['netWeight'];
      boxReceivedController.text = widget.deliveryDetailData!['boxReceived'];
      denyarController.text = widget.deliveryDetailData!['denyar'];
      rateController.text = widget.deliveryDetailData!['rate'];
      copsController.text = widget.deliveryDetailData!['cops'];
      paymentType = widget.deliveryDetailData!['paymentType'];
    }
  }

  void openFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.any);
    if (result != null) {
      setState(() {
        billImageResult = result;
      });
    } else {
      CustomSnackbar.show(title: 'Error', message: 'No file selected');
    }
  }
  @override
  Widget build(BuildContext context) {
    var errorNetWeight = submitted == true ? _validateNetWeight(netWeightController.text) : null,
        errorBoxReceived = submitted == true ? _validateBoxOrdered(boxReceivedController.text) : null,
        errorDenyar = submitted == true ? _validateDenyar(denyarController.text) : null,
        errorRate = submitted == true ? _validateRate(rateController.text) : null,
        errorAmountPaid = submitted == true ? _validateAmountPaid(amountPaidController.text) : null,
        errorCops = submitted == true ? _validateCops(copsController.text) : null;
    return CustomDrawer(
        content: CustomBody(
          title: widget.deliveryDetailData == null ? 'Create Delivery Detail' : 'Update Delivery Detail',
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
                      Text("Delivery Details", style: AppTheme.heading2,),
                      Gap(Dimensions.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select Delivery Date', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDatePicker(selectedDate: selectedDate, firstDate: firstDate, lastDate: lastDate),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Box Received', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomTextField(
                                controller: boxReceivedController,
                                hintText: "Enter Box Received",
                                keyboardType: TextInputType.number,
                                borderRadius: Dimensions.radius10,
                                width: MediaQuery.of(context).size.width/2.65,
                                errorText: errorBoxReceived.toString() != 'null' ? errorBoxReceived.toString() : '',
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
                      Gap(Dimensions.height30),

                      // Payment Details
                      Text("Payment Details", style: AppTheme.heading2,),
                      Gap(Dimensions.height10),
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
                                dropdownItems: const ['Current', 'Dhara'],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Paid', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDropdown(
                                dropdownItems: const ['Yes', 'No'],
                                selectedValue: isPaid ? 'Yes' : 'No',
                                onChanged: (newValue) {
                                  setState(() {
                                    isPaid = newValue == 'Yes' ? true : false;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Bill Received', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDropdown(
                                dropdownItems: const ['Yes', 'No'],
                                selectedValue: isBillReceived ? 'Yes' : 'No',
                                onChanged: (newValue) {
                                  setState(() {
                                    isBillReceived = newValue == 'Yes' ? true : false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (isPaid)
                        Gap(Dimensions.height20),
                      if (isPaid)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Payment type', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomDropdown(
                                  dropdownItems: const ['Cheque', 'RTGS'],
                                  selectedValue: paymentMethod,
                                  onChanged: (newValue) {
                                    setState(() {
                                      paymentMethod = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Select Paid Date', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomDatePicker(selectedDate: selectedDate, firstDate: firstDate, lastDate: lastDate)
                              ],
                            ),
                          ],
                        ),
                      if (isPaid)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(Dimensions.height20),
                            BigText(text: 'Amount Paid', size: Dimensions.font12,),
                            Gap(Dimensions.height10/2),
                            CustomTextField(
                              controller: amountPaidController,
                              hintText: "Enter Amount Paid",
                              keyboardType: TextInputType.number,
                              borderRadius: Dimensions.radius10,
                              errorText: errorAmountPaid.toString() != 'null' ? errorAmountPaid.toString() : '',
                            ),
                          ],
                        ),
                      if (isBillReceived)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(Dimensions.height20),
                            BigText(text: 'Upload Bill', size: Dimensions.font12,),
                            Gap(Dimensions.height10/2),
                            CustomElevatedButton(
                              onPressed: () async {
                                openFiles();
                              },
                              buttonText: 'Upload Bill',
                              isBackgroundGradient: false,
                              backgroundColor: AppTheme.primary,
                            )
                          ],
                        ),

                      Gap(Dimensions.height20),
                      CustomElevatedButton(
                        onPressed: () {
                          setState(() {
                            submitted = true;
                          });
                          if (_isFormValid()) {
                            Navigator.of(context).pushReplacementNamed(AppRoutes.yarnPurchaseList);
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

  String? _validateAmountPaid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount Paid is required';
    }
    return null;
  }

  bool _isFormValid() {
    String netWeightError = _validateNetWeight(netWeightController.text) ?? '';
    String boxOrderedError = _validateBoxOrdered(boxReceivedController.text) ?? '';
    String denyarError = _validateDenyar(denyarController.text) ?? '';
    String rateError = _validateRate(rateController.text) ?? '';
    String copsError = _validateCops(copsController.text) ?? '';
    String amountPaidError = _validateAmountPaid(amountPaidController.text) ?? '';

    return netWeightError.isEmpty && boxOrderedError.isEmpty && denyarError.isEmpty && rateError.isEmpty && copsError.isEmpty && amountPaidError.isEmpty == 'Current' ? true : false;
  }
}
