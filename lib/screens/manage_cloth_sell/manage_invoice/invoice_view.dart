import 'package:d_manager/screens/manage_cloth_sell/manage_invoice/manage_transport_details/transport_detail_add.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import '../../widgets/buttons.dart';
import '../../widgets/texts.dart';

class InvoiceView extends StatefulWidget {
  final Map<String, dynamic>? invoiceData;
  const InvoiceView({Key? key, this.invoiceData}) : super(key: key);

  @override
  _InvoiceViewState createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
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
                        _buildInfoColumn('Invoice Date', widget.invoiceData?['invoiceDate']),
                        SizedBox(width: Dimensions.width20),
                        _buildInfoColumn('Invoice No', widget.invoiceData?['invoiceNumber']),
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
                            _buildInfoColumn('Bale Number', widget.invoiceData?['baleNumber']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Than', widget.invoiceData?['than']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Meter', widget.invoiceData?['meter']),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Cloth Quality', widget.invoiceData?['clothQuality']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('GST', widget.invoiceData?['gst']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Invoice Amount', widget.invoiceData?['invoiceAmount']),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Payment Type', widget.invoiceData?['paymentType']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Additional Discount', widget.invoiceData?['additionalDiscount']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Payment Received', widget.invoiceData?['paymentReceived']),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Payment Amount Received', widget.invoiceData?['paymentAmountReceived']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Difference in Amount', widget.invoiceData?['differenceInAmount']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Payment Method', widget.invoiceData?['paymentMethod']),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Due Date', widget.invoiceData?['dueDate']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Payment Received Date', widget.invoiceData?['paymentReceivedDate']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Reason', widget.invoiceData?['reason']),
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
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,
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
                                  return const TransportDetailAdd();
                                },
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        )
    );
  }
  Widget _buildInfoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.grey, size: Dimensions.font12),
          BigText(text: value, color: AppTheme.primary, size: Dimensions.font14),
        ],
      ),
    );
  }
}
