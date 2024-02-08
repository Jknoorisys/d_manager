import 'package:d_manager/screens/manage_cloth_sell/manage_invoice/manage_transport_details/transport_detail_add.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:gap/gap.dart';
import '../../../constants/routes.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_datepicker.dart';
import '../../widgets/text_field.dart';
import '../../widgets/texts.dart';
import 'package:intl/intl.dart';

class InvoiceView extends StatefulWidget {
  final Map<String, dynamic>? invoiceData;
  const InvoiceView({Key? key, this.invoiceData}) : super(key: key);

  @override
  _InvoiceViewState createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  List<DeliveryDetails> deliveryDetailsList = [];

  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  TextEditingController transportNameController = TextEditingController();
  TextEditingController hammalNameController = TextEditingController();

  void _addDeliveryDetails(
      String deliveryDate, String transportName, String hammalName) {
    setState(() {
      deliveryDetailsList.add(
        DeliveryDetails(
          deliveryDate: deliveryDate,
          transportName: transportName,
          hammalName: hammalName,
        ),
      );
    });
  }

  void _deleteDeliveryDetails(int index) {
    setState(() {
      deliveryDetailsList.removeAt(index);
    });
  }

  void _showAddDeliveryDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppTheme.white,
            elevation: 10,
            surfaceTintColor: AppTheme.white,
            shadowColor: AppTheme.primary.withOpacity(0.5),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).addTransportDetail,
                  style: AppTheme.heading2,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppTheme.primary),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'Select Delivery Date',
                      size: Dimensions.font12,
                      color: AppTheme.black,
                      weight: FontWeight.bold,
                    ),
                    Gap(Dimensions.height10 / 2),
                    CustomDatePicker(
                      selectedDate: selectedDate,
                      firstDate: firstDate,
                      lastDate: lastDate,
                      width: Dimensions.screenWidth,
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'Transport Name',
                      size: Dimensions.font12,
                      color: AppTheme.black,
                      weight: FontWeight.bold,
                    ),
                    Gap(Dimensions.height10 / 2),
                    TextField(
                      controller: transportNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter Transport Name',
                        hintStyle:TextStyle(color: AppTheme.grey,fontSize: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius10),
                          borderSide: BorderSide(
                              color: AppTheme.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.black,
                          )
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: Dimensions.height15, horizontal: Dimensions.width15),
                      ),
                    ),
                    // CustomDropdown(
                    //   dropdownItems: const ['Dharma Transport', 'Kamal Carrier', 'Yadav Brothers India', 'Kamdhenu Cargo Carriers'],
                    //   selectedValue: transportName,
                    //   width: Dimensions.screenWidth,
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       transportName = newValue!;
                    //     });
                    //   },
                    // ),
                  ],
                ),
                SizedBox(height: Dimensions.height15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'Hammal Name',
                      size: Dimensions.font12,
                      color: AppTheme.black,
                      weight: FontWeight.bold,
                    ),
                    Gap(Dimensions.height10 / 2),
                    CustomTextFieldForDialog(
                      controller: hammalNameController,
                      keyboardType: TextInputType.text,
                      hintText: 'Enter Hammal Name',
                    ),

                    // CustomDropdown(
                    //   width: Dimensions.screenWidth,
                    //   dropdownItems: const ['Kamlesh', 'Sami Khan', 'Prakash', 'Rajesh'],
                    //   selectedValue: hammalName,
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       hammalName = newValue!;
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
            actions: [
              CustomElevatedButton(
                onPressed: () {
                  //Navigator.of(context).pop();
                  _addDeliveryDetails(
                    DateFormat('dd-MM-yyyy').format(selectedDate),
                    transportNameController.text,
                    hammalNameController.text,
                  );
                  Navigator.of(context).pop();
                },
                buttonText: "Submit",
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      content: CustomBody(
          content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
          child: Column(
            children: [
              CustomAccordionWithoutExpanded(
                titleChild: Row(
                  children: [
                    _buildInfoColumn(
                        'Invoice Date', widget.invoiceData?['invoiceDate']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn(
                        'Invoice No', widget.invoiceData?['invoiceNumber']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Rate', widget.invoiceData?['rate']),
                  ],
                ),
                contentChild: Column(
                  children: [
                    AppTheme.divider,
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        _buildInfoColumn(
                            'Bale Number', widget.invoiceData?['baleNumber']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('Than', widget.invoiceData?['than']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('Meter', widget.invoiceData?['meter']),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        _buildInfoColumn('Cloth Quality',
                            widget.invoiceData?['clothQuality']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('GST', widget.invoiceData?['gst']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('Invoice Amount',
                            widget.invoiceData?['invoiceAmount']),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        _buildInfoColumn(
                            'Payment Type', widget.invoiceData?['paymentType']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('Additional Discount',
                            widget.invoiceData?['additionalDiscount']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('Payment Received',
                            widget.invoiceData?['paymentReceived']),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        _buildInfoColumn('Payment Amount Received',
                            widget.invoiceData?['paymentAmountReceived']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('Difference in Amount',
                            widget.invoiceData?['differenceInAmount']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('Payment Method',
                            widget.invoiceData?['paymentMethod']),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        _buildInfoColumn(
                            'Due Date', widget.invoiceData?['dueDate']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('Payment Received Date',
                            widget.invoiceData?['paymentReceivedDate']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn(
                            'Reason', widget.invoiceData?['reason']),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        _buildInfoColumn('View PDF', 'viewPDF'),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('Status', 'status'),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('', ''),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                    vertical: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Add Transport Details', style: AppTheme.heading2),
                    CustomIconButton(
                        radius: Dimensions.radius10,
                        backgroundColor: AppTheme.primary,
                        iconColor: AppTheme.white,
                        iconData: Icons.add,
                        onPressed: () {
                          _showAddDeliveryDialog(context);
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return _showAddDeliveryDialog(context);
                          //     //return DeliveryListScreen();
                          //   },
                          // );
                        }),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: ListView.builder(
                    itemCount: deliveryDetailsList.length,
                    itemBuilder: (context, index) {
                      final delivery = deliveryDetailsList[index];
                      return CustomAccordionWithoutExpanded(
                        titleChild: Column(
                          children: [
                            Row(
                              children: [
                                _buildInfoColumn(
                                    'Delivery Date', delivery.deliveryDate),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn(
                                    'Hammal Name', delivery.hammalName),
                              ],
                            ),
                            SizedBox(height: Dimensions.height20),
                            Row(
                              children: [
                                _buildInfoColumn(
                                    'Transport Name', delivery.transportName),
                              ],
                            ),
                          ],
                        ),
                        contentChild: Column(
                          children: [
                            AppTheme.divider,
                            SizedBox(height: Dimensions.height10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    //Navigator.of(context).pushNamed(AppRoutes.invoiceView, arguments: {'invoiceData': invoiceDataList[index]});
                                  },
                                  icon: const Icon(Icons.visibility_outlined,
                                      color: AppTheme.primary),
                                ),
                                IconButton(
                                  onPressed: () {
                                    //Navigator.of(context).pushNamed(AppRoutes.invoiceAdd, arguments: {'invoiceData': invoiceDataList[index]});
                                  },
                                  icon: const Icon(Icons.edit_outlined,
                                      color: AppTheme.primary),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _deleteDeliveryDetails(index);
                                  },
                                  icon: const Icon(Icons.delete_outline,
                                      color: AppTheme.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.grey, size: Dimensions.font12),
          BigText(
              text: value, color: AppTheme.primary, size: Dimensions.font14),
        ],
      ),
    );
  }
}

class DeliveryDetails {
  String deliveryDate;
  String transportName;
  String hammalName;

  DeliveryDetails({
    required this.deliveryDate,
    required this.transportName,
    required this.hammalName,
  });
}
