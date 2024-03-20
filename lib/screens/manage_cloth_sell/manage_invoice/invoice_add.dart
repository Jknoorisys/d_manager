import 'package:d_manager/api/manage_invoice_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/invoice_models/add_invoice_model.dart';
import 'package:d_manager/models/invoice_models/invoice_detail_model.dart';
import 'package:d_manager/models/invoice_models/update_invoice_model.dart';
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

  List<TextEditingController> baleNumberControllers = [];
  List<TextEditingController> thanControllers = [];
  List<TextEditingController> meterControllers = [];
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController amountReceivedController = TextEditingController();
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
    super.initState();
    discountController.text = '9';
    baleNumberControllers = [TextEditingController()];
    thanControllers = [TextEditingController()];
    meterControllers = [TextEditingController()];

    if (widget.invoiceID != null && widget.sellID != null) {
      _getInvoiceDetails();
    }
  }

  @override
  void dispose() {
    rateController.dispose();
    invoiceNumberController.dispose();
    amountReceivedController.dispose();
    paymentRemarkController.dispose();
    discountController.dispose();
    for (var controller in baleNumberControllers) {
      controller.dispose();
    }
    for (var controller in thanControllers) {
      controller.dispose();
    }
    for (var controller in meterControllers) {
      controller.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var errorRate = submitted == true ? _validateRate(rateController.text) : null,
        errorInvoiceNumber = submitted == true ? _validateInvoiceNumber(invoiceNumberController.text) : null,
        errorAmountReceived = (submitted == true && isPaymentReceived == true) ? _validateAmountReceived(amountReceivedController.text) : null,
        errorPaymentRemark = submitted == true ? _validatePaymentRemark(paymentRemarkController.text) : null;
    return CustomDrawer(
        content: CustomBody(
          title: widget.invoiceID == null ? 'Add Invoice' : 'Edit Invoice',
          isLoading: isLoading,
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
                                Gap(Dimensions.height20),
                                BigText(text: 'Select Paid Date', size: Dimensions.font12,),
                                Gap(Dimensions.height10/2),
                                CustomDatePicker(
                                  selectedDate: selectedPaidDate,
                                  width: MediaQuery.of(context).size.width/2.65,
                                  onDateSelected: (date) {
                                    setState(() {
                                      selectedPaidDate = date;
                                    });
                                  },
                                ),
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

                            for (int i = 0; i < rowsData.length; i++) {
                              baleNumbersList.add(baleNumberControllers[i].text);
                              thanList.add(thanControllers[i].text);
                              meterList.add(meterControllers[i].text);
                            }

                            Map<String, dynamic> body = {
                              "invoice_id": "${widget.invoiceID}",
                              "user_id": HelperFunctions.getUserID(),
                              "sell_id":  '${widget.sellID}',
                              "invoice_date": DateFormat('yyyy-MM-dd').format(invoiceDate),
                              "rate": rateController.text,
                              "invoice_number": invoiceNumberController.text,
                              "bale_number": baleNumbersList,
                              "than": thanList,
                              "meter": meterList,
                              "discount": discountController.text,
                              "payment_type": paymentType == 'Current' ? 'current' : 'dhara',
                              'payment_due_date' : (paymentType == 'Current' || (paymentType == 'Dhara' && dharaOption == 'Other')) ? DateFormat('yyyy-MM-dd').format(selectedDueDate) : '',
                              'dhara_days': paymentType != 'Current' ? (dharaOption == '15 days' ? '15' : dharaOption == '40 days' ? '40' : '') : '',
                              "paid_status": isPaymentReceived ? 'yes' : 'no',
                              "payment_method": isPaymentReceived ? paymentMethod : '',
                              "received_amount": isPaymentReceived ? amountReceivedController.text : '',
                              "payment_date": isPaymentReceived ? DateFormat('yyyy-MM-dd').format(selectedPaidDate) : '',
                              "reason": paymentRemarkController.text ?? '',
                            };
                            if (widget.invoiceID == null) {
                              _addInvoice(body);
                            } else {
                              _updateInvoice(body);
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
    var  errorBaleNumber = submitted == true ? _validateBaleNumber(baleNumberControllers[0].text) : null,
        errorThan = submitted == true ? _validateThan(thanControllers[0].text) : null,
        errorMeter = submitted == true ? _validateMeter(meterControllers[0].text) : null;

    if (index >= baleNumberControllers.length) {
      baleNumberControllers.add(TextEditingController());
      thanControllers.add(TextEditingController());
      meterControllers.add(TextEditingController());
    }

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
                  controller: baleNumberControllers[index],
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
                  controller: thanControllers[index],
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
                  controller: meterControllers[index],
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
    String baleNumberError = _validateBaleNumber(baleNumberControllers[0].text) ?? '';
    String thanError = _validateThan(thanControllers[0].text) ?? '';
    String meterError = _validateMeter(meterControllers[0].text) ?? '';
    String amountReceivedError = _validateAmountReceived(amountReceivedController.text) ?? '';
    // String differenceAmountError = _validateDifferenceAmount(differenceAmountController.text) ?? '';
    String paymentRemarkError = _validatePaymentRemark(paymentRemarkController.text) ?? '';
    if (isPaymentReceived == true) {
      return rateError.isEmpty && invoiceNumberError.isEmpty && baleNumberError.isEmpty && thanError.isEmpty && meterError.isEmpty && amountReceivedError.isEmpty && paymentRemarkError.isEmpty ? true : false;
    } else {
      return rateError.isEmpty && invoiceNumberError.isEmpty && baleNumberError.isEmpty && thanError.isEmpty && meterError.isEmpty ? true : false;
    }
  }

  Future<void> _addInvoice(Map<String, dynamic> body) async {
    try {
      setState(() {
        isLoading = true;
      });

      AddInvoiceModel? addInvoiceModel = await invoiceServices.addInvoice((body));
      if (addInvoiceModel?.message != null) {
        if (addInvoiceModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            addInvoiceModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).pushReplacementNamed(AppRoutes.clothSellView, arguments: {'sellID': widget.sellID});
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            addInvoiceModel!.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again',
          mode: SnackbarMode.error,
        );
      }
    } catch (error) {
      CustomApiSnackbar.show(
        context,
        'Error',
        'An error occurred: $error',
        mode: SnackbarMode.error,
      );
    } finally {
      setState(() {
        isLoading = false;
       baleNumbersList = [];
        thanList = [];
        meterList = [];
      });
    }
  }

  Future<void> _getInvoiceDetails() async {
    setState(() {
      isLoading = true;
    });

    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      GetInvoiceModel? invoiceDetailModel = await invoiceServices.viewInvoice(widget.invoiceID!, widget.sellID!);
      if (invoiceDetailModel?.message != null) {
        if (invoiceDetailModel?.success == true) {
          baleNumberControllers.clear();
          thanControllers.clear();
          meterControllers.clear();
          rowsData.clear();
          var invoiceModel = invoiceDetailModel?.data!;
          invoiceDate = invoiceModel?.invoiceDate != null ? DateFormat('yyyy-MM-dd').parse(invoiceModel!.invoiceDate.toString()) : DateTime.now();
          rateController.text = invoiceModel!.rate.toString();
          invoiceNumberController.text = invoiceModel.invoiceNumber.toString();
          discountController.text = invoiceModel.discount.toString();
          amountReceivedController.text = invoiceModel.receivedAmount.toString();
          paymentRemarkController.text = invoiceModel.reason.toString();
          selectedPaidDate = invoiceModel.paymentDate != null ? DateFormat('yyyy-MM-dd').parse(invoiceModel.paymentDate.toString()) : DateTime.now();
          selectedDueDate = invoiceModel.paymentDueDate != null ? DateFormat('yyyy-MM-dd').parse(invoiceModel.paymentDueDate.toString()) : DateTime.now();
          isPaymentReceived = invoiceModel.paidStatus == 'yes' ? true : false;
          paymentMethod = invoiceModel.paymentMethod.toString() == 'cheque' ? 'Cheque' : 'RTGS';
          paymentType = invoiceModel.paymentType.toString() == 'current' ? 'Current' : 'Dhara';
          dharaOption = invoiceModel.paymentType.toString() == 'current' ? invoiceModel.dharaDays.toString() == '15' ? '15 days' : invoiceModel.dharaDays.toString() == '40' ? '40 days' : 'Other' : '15 days';
          for (var baleDetail in invoiceModel.baleDetails!) {
            baleNumberControllers.add(TextEditingController(text: baleDetail.baleNumber.toString()));
            thanControllers.add(TextEditingController(text: baleDetail.than.toString()));
            meterControllers.add(TextEditingController(text: baleDetail.meter.toString()));
            rowsData.add(RowData(baleNumber: baleDetail.baleNumber.toString(), than: baleDetail.than.toString(), meter: baleDetail.meter.toString()));
          }

          setState(() {
            isLoading = false;
          });
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            invoiceDetailModel!.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again',
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
  }

  Future<void> _updateInvoice(Map<String, dynamic> body) async {
    try {
      setState(() {
        isLoading = true;
      });

      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        UpdateInvoiceModel? updateInvoiceModel = await invoiceServices.updateInvoice(body);

        if (updateInvoiceModel?.message != null) {
          if (updateInvoiceModel?.success == true) {
            CustomApiSnackbar.show(
              context,
              'Success',
              updateInvoiceModel!.message.toString(),
              mode: SnackbarMode.success,
            );
            Navigator.of(context).pushReplacementNamed(AppRoutes.clothSellView, arguments: {'sellID': widget.sellID});
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              updateInvoiceModel!.message.toString(),
              mode: SnackbarMode.error,
            );
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            'Something went wrong, please try again',
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Warning',
          'No Internet Connection',
          mode: SnackbarMode.warning,
        );
      }
    } catch (error) {
      CustomApiSnackbar.show(
        context,
        'Error',
        'An error occurred: $error',
        mode: SnackbarMode.error,
      );
    } finally {
      setState(() {
        isLoading = false;
        baleNumbersList = [];
        thanList = [];
        meterList = [];
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