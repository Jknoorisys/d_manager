import 'package:d_manager/api/manage_delivery_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/models/delivery_models/DeliveryDetailModel.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryDetailView extends StatefulWidget {
  final String? purchaseID;
  final String? deliveryID;
  const DeliveryDetailView({Key? key, this.purchaseID, this.deliveryID}) : super(key: key);

  @override
  _DeliveryDetailViewState createState() => _DeliveryDetailViewState();
}

class _DeliveryDetailViewState extends State<DeliveryDetailView> {
  bool isLoading = false;
  bool noRecordFound = false;
  ManageDeliveryServices deliveryServices = ManageDeliveryServices();
  Data? deliveryDetailData;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    if (widget.purchaseID != null && widget.deliveryID != null) {
      _getDeliveryDetails();
    } else {
      setState(() {
        noRecordFound = true;
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
            title: S.of(context).deliveryDetail,
            isLoading: isLoading,
            noRecordFound: noRecordFound,
            content: deliveryDetailData == null ? Container() : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: Dimensions.height10, right: Dimensions.height10, bottom: Dimensions.height20),
                child: Card(
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
                            _buildInfoColumn('Delivery Date', deliveryDetailData!.deliveryDate.toString().split(' ')[0]),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Payment Type', deliveryDetailData!.paymentType.toString() == 'current' ? 'Current' : 'Dhara'),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Payment Method', deliveryDetailData!.paymentMethod == null ? 'N/A' : deliveryDetailData!.paymentMethod.toString()),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        AppTheme.divider,
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Cops', deliveryDetailData!.cops.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Rate', '₹${deliveryDetailData!.rate.toString()}'),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Denier', deliveryDetailData!.denier.toString()),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Box Delivered', deliveryDetailData!.deliveredBoxCount.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Net Weight', '${deliveryDetailData!.netWeight.toString()} ton'),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Gross Weight', '${deliveryDetailData!.grossWeight.toString()} ton'),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Gross Remaining', (double.parse(deliveryDetailData!.netWeight!) - double.parse(deliveryDetailData!.grossWeight!) > 0 ? '${double.parse(deliveryDetailData!.netWeight!) - double.parse(deliveryDetailData!.grossWeight!)} ton' : '0 ton')),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Payment Due Date', deliveryDetailData!.paymentDueDate.toString().split(' ')[0]),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Gst Bill Amount', deliveryDetailData!.gstBillAmount.toString()),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Paid Status', deliveryDetailData!.paidStatus.toString() == 'yes' ? 'Paid' : 'Unpaid'),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Payment Date', deliveryDetailData!.paymentDate == null ? 'N/A' : deliveryDetailData!.paymentDate.toString().split(' ')[0]),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Paid Amount', deliveryDetailData!.paidAmount == null ? 'N/A' : deliveryDetailData!.paidAmount.toString()),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Payment Notes', deliveryDetailData!.paymentNotes == null ? 'N/A' : deliveryDetailData!.paymentNotes.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Bill Received', deliveryDetailData!.billReceived.toString() == 'yes' ? 'Yes' : 'No'),
                            SizedBox(width: Dimensions.width20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(text: 'View Bill', color: AppTheme.grey, size: Dimensions.font12),
                                  deliveryDetailData!.billUrl == null ? BigText(text: 'N/A', color: AppTheme.primary, size: Dimensions.font14) : InkWell(
                                      onTap: () {
                                        _launchUrl(Uri.parse('$baseUrl/${deliveryDetailData!.billUrl!}'));
                                      },
                                      child: BigText(text: 'View', color: AppTheme.primary, size: Dimensions.font14)
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
        )
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
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

  Future<void> _getDeliveryDetails() async {
    try {
      setState(() {
        isLoading = true;
      });

      DeliveryDetailModel? dealDetailModel = await deliveryServices.viewDeliveryDetail(
        int.parse(widget.purchaseID!),
        int.parse(widget.deliveryID!),
      );

      if (dealDetailModel?.message != null) {
        if (dealDetailModel?.success == true) {
          if (dealDetailModel!.data != null) {
            setState(() {
              deliveryDetailData = dealDetailModel.data;
            });
          } else {
            setState(() {
              noRecordFound = true;
            });
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            dealDetailModel!.message.toString(),
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
      print('Error: $error');
      CustomApiSnackbar.show(
        context,
        'Error',
        'Something went wrong, please try again',
        mode: SnackbarMode.error,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
