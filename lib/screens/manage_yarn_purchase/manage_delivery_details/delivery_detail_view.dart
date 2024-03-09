import 'package:d_manager/api/manage_delivery_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/models/delivery_models/DeliveryDetailModel.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';

class DeliveryDetailView extends StatefulWidget {
  final String? purchaseID;
  final String? deliveryID;
  const DeliveryDetailView({Key? key, this.purchaseID, this.deliveryID}) : super(key: key);

  @override
  _DeliveryDetailViewState createState() => _DeliveryDetailViewState();
}

class _DeliveryDetailViewState extends State<DeliveryDetailView> {
  bool isLoading = false;
  ManageDeliveryServices deliveryServices = ManageDeliveryServices();
  Data? deliveryDetailData;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    if (widget.purchaseID != null) {
      // Fetch data from API
      _getDeliveryDetails();
    }
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
            title: S.of(context).deliveryDetail,
            content: deliveryDetailData == null ? NoRecordFound() : SingleChildScrollView(
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
                            SizedBox(width: Dimensions.width10),
                            CircleAvatar(
                              backgroundColor: AppTheme.secondary,
                              radius: Dimensions.height20,
                              child: BigText(text: 'D', color: AppTheme.primary, size: Dimensions.font18),
                            ),
                            SizedBox(width: Dimensions.height10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BigText(text: 'Danish Textiles', color: AppTheme.primary, size: Dimensions.font16),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppTheme.black,
                                      radius: Dimensions.height10,
                                      child: BigText(text: 'S', color: AppTheme.secondaryLight, size: Dimensions.font12),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    SmallText(text: 'SS Textiles', color: AppTheme.black, size: Dimensions.font12),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        AppTheme.divider,
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Deal Date', deliveryDetailData!.deliveryDate.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Yarn Name', 'Bhilosa'),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Yarn Type', 'Roto'),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Lot Number', '123'),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Payment Type', deliveryDetailData!.paymentType.toString() == 'current' ? 'Current' : 'Dhara'),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Payment Method', deliveryDetailData!.paymentMethod.toString()),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Box Ordered', deliveryDetailData!.deliveredBoxCount.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Box Received', deliveryDetailData!.deliveredBoxCount.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Box Remaining', deliveryDetailData!.deliveredBoxCount.toString() ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Net Weight', deliveryDetailData!.netWeight.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Rate', deliveryDetailData!.rate.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Bill Amount', deliveryDetailData!.gstBillAmount.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            _buildInfoColumn('GST', deliveryDetailData!.gstBillAmount.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Due Date', deliveryDetailData!.paymentDueDate.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Paid', deliveryDetailData!.paidStatus.toString() == '1' ? 'Yes' : 'No'),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Paid Date', deliveryDetailData!.paymentDate.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Amount Paid', deliveryDetailData!.paidAmount.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Difference In Amount', deliveryDetailData!.paidAmount.toString()),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Cops', deliveryDetailData!.cops.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Denyar', deliveryDetailData!.denier.toString()),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Bill Received', deliveryDetailData!.billReceived.toString() == '1' ? 'Yes' : 'No'),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('View PDF', deliveryDetailData!.billUrl.toString() == '' ? 'No' : 'Yes'),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Status', deliveryDetailData!.paidStatus.toString() == '1' ? 'Paid' : 'Unpaid'),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('', ''),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width/2.65,
                                height: Dimensions.height40*2,
                                padding: EdgeInsets.all(Dimensions.height10),
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                  border: Border.all(color: AppTheme.primary),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(text: 'Total Net Weight', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: AppTheme.primary,
                                          fontSize: Dimensions.font18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: deliveryDetailData!.netWeight.toString(),
                                          ),
                                          TextSpan(
                                            text: ' ton',
                                            style: TextStyle(
                                              fontSize: Dimensions.font12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BigText(text: 'Gross Weight', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                  ],
                                )
                            ),
                            SizedBox(width: Dimensions.width20),
                            Container(
                                width: MediaQuery.of(context).size.width/2.65,
                                height: Dimensions.height40*2,
                                padding: EdgeInsets.all(Dimensions.height10),
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                  border: Border.all(color: AppTheme.primary),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(text: 'Rate', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                    BigText(text: '₹ ${deliveryDetailData!.rate}',color: AppTheme.primary, size: Dimensions.font18)
                                  ],
                                )
                            ),
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
    setState(() {
      isLoading = true;
    });
    DeliveryDetailModel? dealDetailModel = await deliveryServices.viewDeliveryDetail(int.parse(widget.purchaseID!), int.parse(widget.deliveryID!));

    if (dealDetailModel?.message != null) {
      if (dealDetailModel?.success == true) {
        deliveryDetailData = dealDetailModel?.data;
        setState(() {
          isLoading = false;
        });
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
  }
}
