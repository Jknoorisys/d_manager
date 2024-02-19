import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
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

class InvoiceAdd extends StatefulWidget {
  final Map<String, dynamic>? invoiceData;
  const InvoiceAdd({Key? key, this.invoiceData}) : super(key: key);

  @override
  _InvoiceAddState createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd> {
  bool submitted = false;
  DateTime selectedDate = DateTime.now();
  DateTime invoiceDate = DateTime.now();
  String myFirm = 'Danish Textiles';
  String partyName = 'Mahesh Textiles';
  bool isPaymentReceived = false;
  String paymentMethod = 'RTGS';
  String paymentType = 'Current';
  String dharaOption = '15 days';
  FilePickerResult? billImageResult;
  List<RowData> rowsData = [RowData(baleNumber: '', than: '', meter: '')];

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
    print('Invoice Date: $invoiceDate');
    return CustomDrawer(
        content: CustomBody(
          title: widget.invoiceData == null ? 'Add Invoice' : 'Edit Invoice',
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
                                hintText: "Enter Rate",
                                keyboardType: TextInputType.number,
                                borderRadius: Dimensions.radius10,
                                width: MediaQuery.of(context).size.width/2.65,
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
                          BigText(text: 'Invoice Number', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomTextField(
                            hintText: "Enter Invoice Number",
                            keyboardType: TextInputType.number,
                            borderRadius: Dimensions.radius10,
                          )
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
                                  keyboardType: TextInputType.number,
                                  borderRadius: Dimensions.radius10,
                                  width: MediaQuery.of(context).size.width/2.65,
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
                                  keyboardType: TextInputType.number,
                                  borderRadius: Dimensions.radius10,
                                  width: MediaQuery.of(context).size.width/2.65,
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
                              selectedDate: selectedDate,
                              width: MediaQuery.of(context).size.width,
                            )
                          ],
                        ),
                      if (isPaymentReceived)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(Dimensions.height20),
                            BigText(text: 'Reason', size: Dimensions.font12,),
                            Gap(Dimensions.height10/2),
                            CustomTextField(
                              hintText: "Enter Reason",
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
                  hintText: "Bale Number",
                  keyboardType: TextInputType.number,
                  borderRadius: Dimensions.radius10,
                  width: MediaQuery.of(context).size.width/2.65,
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
                  keyboardType: TextInputType.number,
                  borderRadius: Dimensions.radius10,
                  width: MediaQuery.of(context).size.width/6,
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
                  keyboardType: TextInputType.number,
                  borderRadius: Dimensions.radius10,
                  width: MediaQuery.of(context).size.width/6,
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
          selectedDate: selectedDate,
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
            width: MediaQuery.of(context).size.width,
            selectedDate: selectedDate,
        )
      ],
    );
  }
}

class RowData {
  String baleNumber;
  String than;
  String meter;

  RowData({required this.baleNumber, required this.than, required this.meter});
}