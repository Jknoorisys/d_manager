import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';

class DeliveryDetailView extends StatefulWidget {
  final Map<String, dynamic>? deliveryDetailData;
  const DeliveryDetailView({Key? key, this.deliveryDetailData}) : super(key: key);

  @override
  _DeliveryDetailViewState createState() => _DeliveryDetailViewState();
}

class _DeliveryDetailViewState extends State<DeliveryDetailView> {
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
            title: S.of(context).deliveryDetail,
            content: SingleChildScrollView(
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
                            _buildInfoColumn('Deal Date', widget.deliveryDetailData!['dealDate']),
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
                            _buildInfoColumn('Payment Type', widget.deliveryDetailData!['paymentType']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Payment Method', widget.deliveryDetailData!['paymentMethod']),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Box Ordered', '1000'),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Box Received', widget.deliveryDetailData!['boxReceived']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Box Remaining', '200'),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Net Weight', widget.deliveryDetailData!['netWeight']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Rate', widget.deliveryDetailData!['rate']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Bill Amount', widget.deliveryDetailData!['billAmount']),
                          ],
                        ),
                        Row(
                          children: [
                            _buildInfoColumn('GST', widget.deliveryDetailData!['GST']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Due Date', widget.deliveryDetailData!['dueDate']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Paid', widget.deliveryDetailData!['paid'] == true ? 'Yes' : 'No'),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Paid Date', widget.deliveryDetailData!['paidDate']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Amount Paid', widget.deliveryDetailData!['amountPaid']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Difference In Amount', widget.deliveryDetailData!['differenceInAmount']),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Cops', widget.deliveryDetailData!['cops']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Denyar', widget.deliveryDetailData!['denyar']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Bill Received', widget.deliveryDetailData!['billReceived'] == true ? 'Yes' : 'No'),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('View PDF', widget.deliveryDetailData!['viewPDF']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Status', widget.deliveryDetailData!['status']),
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
                                            text: widget.deliveryDetailData!['netWeight'],
                                          ),
                                          TextSpan(
                                            text: ' kg',
                                            style: TextStyle(
                                              fontSize: Dimensions.font12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BigText(text: 'Gross Weight 500 kg', color: AppTheme.nearlyBlack, size: Dimensions.font12),
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
                                    BigText(text: '₹ ${widget.deliveryDetailData!['rate']}',color: AppTheme.primary, size: Dimensions.font18)
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
}
