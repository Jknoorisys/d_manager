import 'package:d_manager/screens/manage_cloth_sell/manage_invoice/manage_transport_details/transport_detail_add.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../api/manage_invoice_services.dart';
import '../../../models/invoice_models/invoice_detail_model.dart';
import '../../widgets/buttons.dart';
import '../../widgets/snackbar.dart';
import '../../widgets/texts.dart';
class InvoiceView extends StatefulWidget {
  final Map<String, dynamic>? invoiceData;
  final int invoiceId;
  final String sellId;
  const InvoiceView({Key? key, this.invoiceData, required this.invoiceId,required this.sellId}) : super(key: key);

  @override
  _InvoiceViewState createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  //
  List<DeliveryDetails> transportDetails = [];
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  String transportName = 'Dharma Transport';
  String hammalName = 'Prakash';
  GetInvoiceModel? getInvoiceModel;

  bool _isLoading = true;
  ManageInvoiceServices manageInvoiceServices = ManageInvoiceServices();

  void _addTransportDetails(
      String deliveryDate, String transportName, String hammalName) {
    setState(() {
      transportDetails.add(
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
      transportDetails.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    // getInvoiceDetails(widget.sellId,widget.invoiceId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      content: CustomBody(
        title: 'Invoice Details',
          filterButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.remove_red_eye, color: AppTheme.black),
              SizedBox(width: Dimensions.width25),
              const Icon(Icons.print, color: AppTheme.black),
            ],
          ),
        content: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            child: Column(
              children: [
                CustomAccordionWithoutExpanded(
                  titleChild: Row(
                    children: [
                      _buildInfoColumn(
                          'Invoice Date', getInvoiceModel!.data!.invoiceDate!.toString()),
                      SizedBox(width: Dimensions.width20),
                      _buildInfoColumn(
                          'Invoice No', getInvoiceModel!.data!.invoiceNumber!),
                      SizedBox(width: Dimensions.width20),
                      _buildInfoColumn('Rate', getInvoiceModel!.data!.rate!),
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
                          _buildInfoColumn('GST Portal', 'abc'),
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return TransportDetailAdd(
                                    addDeliveryDetails: _addTransportDetails
                                );
                              },
                            );
                          }),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child:transportDetails.isEmpty?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/icons/nodata.png",height: 200,width: 200,),
                    ],
                  )
                      : ListView.builder(
                      itemCount: transportDetails.length,
                      itemBuilder: (context, index) {
                        final delivery = transportDetails[index];
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      //Navigator.of(context).pushNamed(AppRoutes.invoiceAdd, arguments: {'invoiceData': invoiceDataList[index]});
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return TransportDetailAdd(
                                              addDeliveryDetails: _addTransportDetails
                                          );
                                        },
                                      );
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
        )
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    String formattedValue = value;
    if (title == 'Invoice Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }
    else if (title == 'Due Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }else if (title == 'Payment Received Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }
    return Container(
      width: MediaQuery.of(context).size.width / 3.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.nearlyBlack, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font12),
        ],
      ),
    );
  }

  // Future<GetInvoiceModel?> getInvoiceDetails(String sellID, int invoiceID) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     GetInvoiceModel? model = await manageInvoiceServices.getInvoice(
  //       widget.sellId,
  //       widget.invoiceId.toString()
  //     );
  //     if (model != null) {
  //       if (model.success == true) {
  //         getInvoiceModel = model;
  //       } else {
  //         CustomApiSnackbar.show(
  //           context,
  //           'Error',
  //           model.message.toString(),
  //           mode: SnackbarMode.error,
  //         );
  //       }
  //     } else {
  //       CustomApiSnackbar.show(
  //         context,
  //         'Error',
  //         'Something went wrong, please try again later.',
  //         mode: SnackbarMode.error,
  //       );
  //     }
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
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
