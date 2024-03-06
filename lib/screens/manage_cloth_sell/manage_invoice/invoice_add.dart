import 'package:d_manager/api/manage_invoice_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/invoice_models/add_invoice_model.dart';
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

class InvoiceAdd extends StatefulWidget {
  final int? sellID;
  final int? invoiceID;
  const InvoiceAdd({Key? key, this.sellID, this.invoiceID}) : super(key: key);

  @override
  _InvoiceAddState createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd> {

  ManageInvoiceServices invoiceServices = ManageInvoiceServices();
  bool submitted = false;
  DateTime selectedDate = DateTime.now();
  DateTime selectedPaidDate = DateTime.now();
  DateTime selectedDueDate = DateTime.now();
  DateTime invoiceDate = DateTime.now();
  bool isPaymentReceived = false;
  String paymentMethod = 'RTGS';
  String paymentType = 'Current';
  String dharaOption = '15 days';
  FilePickerResult? billImageResult;
  List<RowData> rowsData = [RowData(baleNumber: '', than: '', meter: '')];
  bool isLoading = false;

  List<String> baleNumbersList = [];
  List<String> thanList = [];
  List<String> meterList = [];

  TextEditingController baleNumberController = TextEditingController();
  TextEditingController thanController = TextEditingController();
  TextEditingController meterController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController amountReceivedController = TextEditingController();
  TextEditingController differenceAmountController = TextEditingController();
  TextEditingController paymentRemarkController = TextEditingController();
  TextEditingController discountController = TextEditingController();


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
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    discountController.text = '9';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    rateController.dispose();
    invoiceNumberController.dispose();
    baleNumberController.dispose();
    thanController.dispose();
    meterController.dispose();
    amountReceivedController.dispose();
    differenceAmountController.dispose();
    paymentRemarkController.dispose();
    discountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var errorRate = submitted == true ? _validateRate(rateController.text) : null,
        errorInvoiceNumber = submitted == true ? _validateInvoiceNumber(invoiceNumberController.text) : null,
        errorAmountReceived = (submitted == true && isPaymentReceived == true) ? _validateAmountReceived(amountReceivedController.text) : null,
        errorDifferenceAmount = (submitted == true && isPaymentReceived == true) ? _validateDifferenceAmount(differenceAmountController.text) : null,
        errorPaymentRemark = submitted == true ? _validatePaymentRemark(paymentRemarkController.text) : null;
    return CustomDrawer(
        content: CustomBody(
          title: widget.invoiceID == null ? 'Add Invoice' : 'Edit Invoice',
          // isLoading: isLoading,
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
                      Text("Invoice Details", style: AppTheme.heading2,),
                      Gap(Dimensions.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select Invoice Date', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDatePicker(
                                selectedDate: invoiceDate,
                                onDateSelected: (date) {
                                  setState(() {
                                    invoiceDate = date;
                                  });
                                },
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
                              BigText(text: 'Invoice Number', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomTextField(
                                hintText: "Enter Invoice Number",
                                controller: invoiceNumberController,
                                keyboardType: TextInputType.number,
                                borderRadius: Dimensions.radius10,
                                width: MediaQuery.of(context).size.width/2.65,
                                errorText: errorInvoiceNumber.toString() != 'null' ? errorInvoiceNumber.toString() : '',
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Discount', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomTextField(
                                hintText: "Enter Discount",
                                controller: discountController,
                                keyboardType: TextInputType.number,
                                borderRadius: Dimensions.radius10,
                                width: MediaQuery.of(context).size.width/2.65,
                                errorText: errorInvoiceNumber.toString() != 'null' ? errorInvoiceNumber.toString() : '',
                              )
                            ],
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),

                      // Multiple Rows
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: rowsData.length,
                        itemBuilder: (context, index) {
                          return _buildDynamicRow(index);
                        },
                      ),

                      // Add buttons to add and remove rows
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomIconButton(
                            radius: Dimensions.radius10,
                            backgroundColor: AppTheme.primary,
                            iconColor: AppTheme.white,
                            iconData: Icons.remove,
                            onPressed: () {
                              setState(() {
                                if (rowsData.length > 1) {
                                  rowsData.removeLast();
                                }
                              });
                            },
                          ),
                          Gap(Dimensions.width10),
                          CustomIconButton(
                            radius: Dimensions.radius10,
                            backgroundColor: AppTheme.primary,
                            iconColor: AppTheme.white,
                            iconData: Icons.add,
                            onPressed: () {
                              setState(() {
                                rowsData.add(RowData(baleNumber: '', than: '', meter: ''));
                              });
                            },
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
                              BigText(text: 'Select Payment Type', size: Dimensions.font12,),
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
                              BigText(text: 'Payment Received', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              CustomDropdown(
                                dropdownItems: const ['Yes', 'No'],
                                selectedValue: isPaymentReceived ? 'Yes' : 'No',
                                onChanged: (newValue) {
                                  setState(() {
                                    isPaymentReceived = newValue == 'Yes' ? true : false;
                                  });
                                },
                              )
                            ],
                          ),
                          if (isPaymentReceived)
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
                        ],
                      ),
                      if (isPaymentReceived)
                        Gap(Dimensions.height20),
                      if (isPaymentReceived)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Amount Received', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomTextField(
                                  hintText: "Enter Amount",
                                  controller: amountReceivedController,
                                  keyboardType: TextInputType.number,
                                  borderRadius: Dimensions.radius10,
                                  width: MediaQuery.of(context).size.width/2.65,
                                  errorText: errorAmountReceived.toString() != 'null' ? errorAmountReceived.toString() : '',
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: 'Difference in Amount', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomTextField(
                                  hintText: "Enter Difference",
                                  controller: differenceAmountController,
                                  keyboardType: TextInputType.number,
                                  borderRadius: Dimensions.radius10,
                                  width: MediaQuery.of(context).size.width/2.65,
                                  errorText: errorDifferenceAmount.toString() != 'null' ? errorDifferenceAmount.toString() : '',
                                )
                              ],
                            ),
                          ],
                        ),
                      if (isPaymentReceived)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(Dimensions.height20),
                            BigText(text: 'Select Paid Date', size: Dimensions.font12,),
                            Gap(Dimensions.height10/2),
                            CustomDatePicker(
                              selectedDate: selectedPaidDate,
                              width: MediaQuery.of(context).size.width,
                              onDateSelected: (date) {
                                setState(() {
                                  selectedPaidDate = date;
                                });
                              },
                            ),
                          ],
                        ),
                      if (isPaymentReceived)
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

                              if (widget.invoiceID == null) {
                                Map<String, dynamic> body = {
                                  "invoice_id" : widget.invoiceID ?? '',
                                  "user_id": HelperFunctions.getUserID(),
                                  "sell_id": widget.sellID ?? '',
                                  "invoice_date": DateFormat('yyyy-MM-dd').format(invoiceDate),
                                  "rate": rateController.text,
                                  "invoice_number": invoiceNumberController.text,
                                  "bill_number": baleNumbersList,
                                  "than": thanList,
                                  "meter": meterList,
                                  "discount": discountController.text,
                                  "payment_type": paymentType == 'Current' ? 'current' : 'dhara',
                                  'payment_due_date' : (paymentType == 'Current' || (paymentType == 'Dhara' && dharaOption == 'Other')) ? DateFormat('yyyy-MM-dd').format(selectedDueDate) : '',
                                  'dhara_days': paymentType != 'Current' ? (dharaOption == '15 days' ? '15' : dharaOption == '40 days' ? '40' : '') : '',
                                  "paid_status": isPaymentReceived ? 'yes' : 'no',
                                  "payment_method": paymentMethod,
                                  "received_amount": amountReceivedController.text,
                                  "difference_amount": differenceAmountController.text,
                                  "payment_date": DateFormat('yyyy-MM-dd').format(selectedPaidDate),
                                  "reason": paymentRemarkController.text,
                                };
                                print('Body: $body');
                                _addInvoice(body);
                              } else {
                                // _updateInvoice(body);
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
            )
          )
        )
    );
  }
  Widget _buildDynamicRow(int index) {
    var  errorBaleNumber = submitted == true ? _validateBaleNumber(baleNumberController.text) : null,
        errorThan = submitted == true ? _validateThan(thanController.text) : null,
        errorMeter = submitted == true ? _validateMeter(meterController.text) : null;

    baleNumbersList.add(baleNumberController.text);
    thanList.add(thanController.text);
    meterList.add(meterController.text);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: 'Bale Number', size: Dimensions.font12,),
                Gap(Dimensions.height10/2),
                CustomTextField(
                  controller: baleNumberController,
                  hintText: "Bale Number",
                  keyboardType: TextInputType.number,
                  borderRadius: Dimensions.radius10,
                  width: MediaQuery.of(context).size.width/2.65,
                  errorText: index == 0 ? errorBaleNumber.toString() != 'null' ? errorBaleNumber.toString() : '' : '',
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: 'Than', size: Dimensions.font12,),
                Gap(Dimensions.height10/2),
                CustomTextField(
                  hintText: "Than",
                  controller: thanController,
                  keyboardType: TextInputType.number,
                  borderRadius: Dimensions.radius10,
                  width: MediaQuery.of(context).size.width/6,
                  errorText: index == 0 ? errorThan.toString() != 'null' ? errorThan.toString() : '' : '',
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: 'Meter', size: Dimensions.font12,),
                Gap(Dimensions.height10/2),
                CustomTextField(
                  hintText: "Meter",
                  controller: meterController,
                  keyboardType: TextInputType.number,
                  borderRadius: Dimensions.radius10,
                  width: MediaQuery.of(context).size.width/6,
                  errorText: index == 0 ? errorMeter.toString() != 'null' ? errorMeter.toString() : '' : '',
                )
              ],
            ),
          ],
        ),
        Gap(Dimensions.height20),
      ],
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
        ),
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
          dropdownItems: const ['15 days', '40 days', 'Other'],
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
        ),
      ],
    );
  }

  String? _validateRate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Rate is required';
    }
    return null;
  }

  String? _validateInvoiceNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Invoice Number is required';
    }
    return null;
  }

  String? _validateBaleNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bale Number is required';
    }
    return null;
  }

  String? _validateThan(String? value) {
    if (value == null || value.isEmpty) {
      return 'Than is required';
    }
    return null;
  }

  String? _validateMeter(String? value) {
    if (value == null || value.isEmpty) {
      return 'Meter is required';
    }
    return null;
  }

  String? _validateAmountReceived(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount Received is required';
    }
    return null;
  }

  String? _validateDifferenceAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Difference Amount is required';
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

    String rateError = _validateRate(rateController.text) ?? '';
    String invoiceNumberError = _validateInvoiceNumber(invoiceNumberController.text) ?? '';
    String baleNumberError = _validateBaleNumber(baleNumberController.text) ?? '';
    String thanError = _validateThan(thanController.text) ?? '';
    String meterError = _validateMeter(meterController.text) ?? '';
    String amountReceivedError = _validateAmountReceived(amountReceivedController.text) ?? '';
    String differenceAmountError = _validateDifferenceAmount(differenceAmountController.text) ?? '';
    String paymentRemarkError = _validatePaymentRemark(paymentRemarkController.text) ?? '';
    if (isPaymentReceived == true) {
      return rateError.isEmpty && invoiceNumberError.isEmpty && baleNumberError.isEmpty && thanError.isEmpty && meterError.isEmpty && amountReceivedError.isEmpty && differenceAmountError.isEmpty ? true : false;
    } else {
      return rateError.isEmpty && invoiceNumberError.isEmpty && baleNumberError.isEmpty && thanError.isEmpty && meterError.isEmpty ? true : false;
    }
  }

  Future<void> _addInvoice(Map<String, dynamic> body) async {
    print('Body: $body');
    AddInvoiceModel? addInvoiceModel = await invoiceServices.addInvoice(body);
    if (addInvoiceModel?.message != null) {
      if (addInvoiceModel?.success == true) {
        CustomApiSnackbar.show(
          context,
          'Success',
          addInvoiceModel!.message.toString(),
          mode: SnackbarMode.success,
        );
        Navigator.of(context).pushReplacementNamed(AppRoutes.clothSellView, arguments: {'sellID': widget.sellID});
      }  else {
        CustomApiSnackbar.show(
          context,
          'Error',
          addInvoiceModel!.message.toString(),
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

class RowData {
  String baleNumber;
  String than;
  String meter;

  RowData({required this.baleNumber, required this.than, required this.meter});
}