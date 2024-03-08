import 'package:d_manager/api/manage_delivery_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/delivery_models/AddDeliveryModel.dart';
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
  final String? purchaseID;
  const DeliveryDetailAdd({Key? key, this.purchaseID}) : super(key: key);

  @override
  _DeliveryDetailAddState createState() => _DeliveryDetailAddState();
}

class _DeliveryDetailAddState extends State<DeliveryDetailAdd> {
  bool submitted = false;
  DateTime selectedDueDate = DateTime.now();
  DateTime selectedDeliveryDate = DateTime.now();
  DateTime selectedPaidDate = DateTime.now();
  String paymentType = 'Current';
  String dharaOption = '15 days';

  bool isPaid = false;
  String paymentMethod = 'RTGS';
  double amountPaid = 0.0;
  bool isBillReceived = false;
  FilePickerResult? billImageResult;
  bool isLoading = false;
  ManageDeliveryServices deliveryServices = ManageDeliveryServices();


  TextEditingController amountPaidController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController grossReceivedController = TextEditingController();
  TextEditingController denierController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController copsController = TextEditingController();
  TextEditingController paymentRemarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    if (widget.purchaseID != null) {
      // Fetch data from API
    }
  }

  @override
  void dispose() {
    amountPaidController.dispose();
    netWeightController.dispose();
    grossReceivedController.dispose();
    denierController.dispose();
    rateController.dispose();
    copsController.dispose();
    super.dispose();
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
        errorBoxReceived = submitted == true ? _validateGrossReceived(grossReceivedController.text) : null,
        errorDenier = submitted == true ? _validateDenier(denierController.text) : null,
        errorRate = submitted == true ? _validateRate(rateController.text) : null,
        errorAmountPaid = submitted == true ? _validateAmountPaid(amountPaidController.text) : null,
        errorPaymentRemark = submitted == true ? _validatePaymentRemark(paymentRemarkController.text) : null,
        errorCops = submitted == true ? _validateCops(copsController.text) : null;
    return CustomDrawer(
        content: CustomBody(
          title: widget.purchaseID == null ? 'Create Delivery Detail' : 'Update Delivery Detail',
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
                              CustomDatePicker(
                                selectedDate: selectedDeliveryDate,
                                onDateSelected: (date) {
                                  setState(() {
                                    selectedDeliveryDate = date;
                                  });
                                },
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Gross Received', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomTextField(
                                controller: grossReceivedController,
                                hintText: "Enter Gross Received",
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
                              BigText(text: 'Denier', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomTextField(
                                controller: denierController,
                                hintText: "Enter Denier",
                                keyboardType: TextInputType.number,
                                borderRadius: Dimensions.radius10,
                                width: MediaQuery.of(context).size.width/2.65,
                                errorText: errorDenier.toString() != 'null' ? errorDenier.toString() : '',
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
                                CustomDatePicker(
                                  selectedDate: selectedPaidDate,
                                  onDateSelected: (date) {
                                    setState(() {
                                      selectedPaidDate = date;
                                    });
                                  },
                                )
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
                      if (isPaid)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(Dimensions.height20),
                            BigText(text: 'Remark', size: Dimensions.font12,),
                            Gap(Dimensions.height10/2),
                            CustomTextField(
                              hintText: "Enter Payment Remark",
                              controller: paymentRemarkController,
                              keyboardType: TextInputType.text,
                              borderRadius: Dimensions.radius10,
                              maxLines: 3,
                              width: MediaQuery.of(context).size.width,
                              errorText: errorPaymentRemark.toString() != 'null' ? errorPaymentRemark.toString() : '',
                            )
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
                            if (HelperFunctions.checkInternet() == false) {
                              CustomApiSnackbar.show(
                                context,
                                'Warning',
                                'No internet connection',
                                mode: SnackbarMode.warning,
                              );
                            } else {
                              setState(() {
                                isLoading = !isLoading;
                              });
                              Map<String, String> body = {
                                'purchase_id': '${widget.purchaseID}',
                                'user_id': HelperFunctions.getUserID(),
                                'delivery_date': DateFormat('yyyy-MM-dd').format(selectedDeliveryDate),
                                'rate': rateController.text,
                                'gross_weight': grossReceivedController.text,
                                'net_weight': netWeightController.text,
                                'denier': denierController.text,
                                'cops': copsController.text,
                                'payment_type': paymentType == 'Current' ? 'current' : 'dhara',
                                'payment_due_date' : (paymentType == 'Current' || (paymentType == 'Dhara' && dharaOption == 'Other')) ? DateFormat('yyyy-MM-dd').format(selectedDueDate) : '',
                                'dhara_days': paymentType != 'Current' ? (dharaOption == '15 days' ? '15' : dharaOption == '40 days' ? '40' : '') : '',
                                'paid_status': isPaid ? 'yes' : 'no',
                                'payment_method': isPaid ? paymentMethod : '',
                                'paid_amount': isPaid ? amountPaidController.text : '',
                                'payment_notes': isPaid ? paymentRemarkController.text : '',
                                'next_delivery_date': isPaid ? DateFormat('yyyy-MM-dd').format(selectedPaidDate) : '',
                                'bill_received': isBillReceived ? 'yes' : 'no',
                                'bill_url': billImageResult != null ? '${billImageResult!.files.single.path}' : '',
                              };
                              if (widget.purchaseID != null) {
                                _addDeliveryDetail(body);
                              } else {
                                // _updateDeliveryDetail(body);
                              }
                            }
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
          selectedDate: selectedDueDate,
          onDateSelected: (date) {
            setState(() {
              selectedDueDate = date;
            });
          },
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
          selectedDate: selectedDueDate,
          width: MediaQuery.of(context).size.width,
          onDateSelected: (date) {
            setState(() {
              selectedDueDate = date;
            });
          },
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

  String? _validateGrossReceived(String? value) {
    if (value == null || value.isEmpty) {
      return 'Gross Weight Received is required';
    }
    return null;
  }

  String? _validateDenier(String? value) {
    if (value == null || value.isEmpty) {
      return 'Denier is required';
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

  String? _validatePaymentRemark(String? value) {
    if (value == null || value.isEmpty) {
      return 'Payment Remark is required';
    }
    return null;
  }

  bool _isFormValid() {
    String netWeightError = _validateNetWeight(netWeightController.text) ?? '';
    String grossReceivedError = _validateGrossReceived(grossReceivedController.text) ?? '';
    String denierError = _validateDenier(denierController.text) ?? '';
    String rateError = _validateRate(rateController.text) ?? '';
    String copsError = _validateCops(copsController.text) ?? '';
    String amountPaidError = isPaid ? (_validateAmountPaid(amountPaidController.text) ?? '') : '';
    String paymentRemarkError = isPaid ? (_validatePaymentRemark(paymentRemarkController.text) ?? '') : '';

    return netWeightError.isEmpty && grossReceivedError.isEmpty && denierError.isEmpty && rateError.isEmpty && copsError.isEmpty && amountPaidError.isEmpty ? true : false;
  }

  Future<void> _addDeliveryDetail(Map<String, String> body) async {
    print("Purchase Id: ${widget.purchaseID}");
    print("Body: $body");
    AddDeliveryModel? addDeliveryModel = await deliveryServices.addDelivery(body);
    print("Add Delivery Model: ${addDeliveryModel?.toJson()}");
    if (addDeliveryModel?.message != null) {
      if (addDeliveryModel?.success == true) {
        CustomApiSnackbar.show(
          context,
          'Success',
          addDeliveryModel!.message.toString(),
          mode: SnackbarMode.success,
        );
        Navigator.of(context).pushReplacementNamed(AppRoutes.yarnPurchaseView, arguments: {'purchaseId': widget.purchaseID});
      }  else {
        CustomApiSnackbar.show(
          context,
          'Error',
          addDeliveryModel!.message.toString(),
          mode: SnackbarMode.error,
        );
      }

      setState(() {
        isLoading = false;
      });
    } else {
      CustomApiSnackbar.show(
        context,
        'Error',
        'Something went wrong, please try again',
        mode: SnackbarMode.error,
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}
