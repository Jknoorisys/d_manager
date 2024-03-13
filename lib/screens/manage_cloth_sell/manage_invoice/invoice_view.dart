import 'package:d_manager/api/dropdown_services.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/dropdown_models/dropdown_hammal_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_transport_list_model.dart';
import 'package:d_manager/models/invoice_models/add_transport_detail_model.dart';
import 'package:d_manager/screens/manage_cloth_sell/manage_invoice/manage_transport_details/transport_detail_add.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_datepicker.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../api/manage_invoice_services.dart';
import '../../../models/invoice_models/invoice_detail_model.dart';
import '../../widgets/buttons.dart';
import '../../widgets/texts.dart';
class InvoiceView extends StatefulWidget {
  final int invoiceId;
  final String sellId;
  const InvoiceView({Key? key, required this.invoiceId,required this.sellId}) : super(key: key);

  @override
  _InvoiceViewState createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  GetInvoiceModel? getInvoiceModel;

  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  bool noRecordFound = false;
  bool isNetworkAvailable = true;

  ManageInvoiceServices invoiceServices = ManageInvoiceServices();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    if (widget.invoiceId != null && widget.sellId != null) {
      _getInvoiceDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      content: CustomBody(
        title: 'Invoice Details',
          isLoading: isLoading,
          noRecordFound: noRecordFound,
          internetNotAvailable: isNetworkAvailable,
          filterButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.remove_red_eye, color: AppTheme.black),
              SizedBox(width: Dimensions.width25),
              const Icon(Icons.print, color: AppTheme.black),
            ],
          ),
        content: getInvoiceModel?.data! == null ? Container() : SingleChildScrollView(
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
                              'Bale Number', '${getInvoiceModel!.data!.baleDetails!.first.baleNumber!} - ${getInvoiceModel!.data!.baleDetails!.last.baleNumber!}'),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Than', '${getInvoiceModel!.data!.baleDetails!.first.than!} - ${getInvoiceModel!.data!.baleDetails!.last.than!}'),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Meter', '${getInvoiceModel!.data!.baleDetails!.first.meter!} - ${getInvoiceModel!.data!.baleDetails!.last.meter!}'),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          _buildInfoColumn(
                              'Payment Type', (getInvoiceModel!.data!.paymentType! == 'current') ? 'Current' : 'Dhara'),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Additional Discount',getInvoiceModel!.data!.discount!),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Payment Received', getInvoiceModel!.data!.paidStatus! == 'yes' ? 'Yes' : 'No'),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          _buildInfoColumn('Payment Amount Received',getInvoiceModel!.data!.invoiceAmount! ?? 'N/A'),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Difference in Amount', getInvoiceModel!.data!.differenceAmount ?? 'N/A'),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Payment Method', getInvoiceModel!.data!.paymentMethod ?? 'N/A'),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          _buildInfoColumn('Due Date', getInvoiceModel!.data!.dueDate.toString() ?? 'N/A'),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Payment Received Date', getInvoiceModel!.data!.paymentDate.toString() ?? 'N/A'),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Reason', getInvoiceModel!.data!.reason ?? 'N/A'),
                        ],
                      ),
                      // link to GST portal part here ...
                      // SizedBox(height: Dimensions.height10),
                      // Row(
                      //   children: [
                      //     _buildInfoColumn('Status', getInvoiceModel!.data!.status! == 'active' ? 'Active' : 'Inactive'),
                      //     SizedBox(width: Dimensions.width20),
                      //     _buildInfoColumn('', ''),
                      //     SizedBox(width: Dimensions.width20),
                      //     _buildInfoColumn('', ''),
                      //   ],
                      // ),
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
                      Text(getInvoiceModel!.data!.transportDetails == null ? 'Add Transport Details' : 'Transport Details', style: AppTheme.heading2),
                      getInvoiceModel!.data!.transportDetails == null ? CustomIconButton(
                          radius: Dimensions.radius10,
                          backgroundColor: AppTheme.primary,
                          iconColor: AppTheme.white,
                          iconData: Icons.add,
                          onPressed: () {
                            // addTransportDialog(context);
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return TransportDetailAdd(invoiceId: widget.invoiceId.toString(), sellId: widget.sellId);
                                }
                            );
                          }) : Container(),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                getInvoiceModel!.data!.transportDetails == null ?
                Column(
                  children: [
                    SizedBox(height: Dimensions.height30),
                    const NoRecordFound(),
                  ],
                ) : Card(
                  elevation: 10,
                  color: AppTheme.white,
                  shadowColor: AppTheme.nearlyWhite,
                  surfaceTintColor: AppTheme.nearlyWhite,
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.height15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildInfoColumn(
                                'Delivery Date', getInvoiceModel!.data!.transportDetails!.transportDate.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn(
                                'Hammal Name', getInvoiceModel!.data!.transportDetails!.hammalName.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn(
                                'Transport Name', getInvoiceModel!.data!.transportDetails!.transportName.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
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

  Future<void> _getInvoiceDetails() async {
    setState(() {
      isLoading = true;
    });
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      GetInvoiceModel? invoiceDetailModel = await invoiceServices.viewInvoice(widget.invoiceId, int.parse(widget.sellId));
      if (invoiceDetailModel?.message != null) {
        if (invoiceDetailModel?.success == true) {
          if (invoiceDetailModel?.data != null) {
            setState(() {
              getInvoiceModel = invoiceDetailModel;
              isLoading = false;
            });
          } else {
            setState(() {
              noRecordFound = true;
              isLoading = false;
            });
          }
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
        isNetworkAvailable = false;
        isLoading = false;
      });
    }
  }
}
