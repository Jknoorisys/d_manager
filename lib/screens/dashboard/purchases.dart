import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/dashboard_services.dart';
import '../../models/dashboard_models/dashboard_models.dart';
import '../widgets/snackbar.dart';

class Purchases extends StatefulWidget {
  final List<PurchaseDeal> purchaseDeals;
  const Purchases({Key? key, required this.purchaseDeals}) : super(key: key);

  @override
  _PurchasesState createState() => _PurchasesState();
}
class _PurchasesState extends State<Purchases> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.height15),
      child: ListView.builder(
        itemCount: widget.purchaseDeals.length,
        itemBuilder: (context, index) {
          return CustomAccordion(
            titleChild: Column(
              children: [
                Row(
                  children: [
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        SizedBox(width: Dimensions.width10),
                        CircleAvatar(
                          backgroundColor: AppTheme.secondary,
                          radius: Dimensions.height20,
                          child: BigText(text: widget.purchaseDeals[index].partyFirm![0], color: AppTheme.primary, size: Dimensions.font18),
                        ),
                        SizedBox(width: Dimensions.height10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BigText(text: widget.purchaseDeals[index].partyFirm!, color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppTheme.black,
                                  radius: Dimensions.height10,
                                  child: BigText(text: widget.purchaseDeals[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                ),
                                SizedBox(width: Dimensions.width10),
                                SmallText(text: widget.purchaseDeals[index].firmName!, color: AppTheme.black, size: Dimensions.font12),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                AppTheme.divider,
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    Expanded(flex:1,child: _buildInfoColumn('Deal Date', widget.purchaseDeals[index].purchaseDate!.toString())),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Rate', widget.purchaseDeals[index].rate!)),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Yarn Type', widget.purchaseDeals[index].yarnTypeName!)),
                  ],
                ),
              ],
            ),
            contentChild: Column(
              children: [
                Row(
                  children: [
                    Expanded(flex:1,child: _buildInfoColumn('Payment Type', widget.purchaseDeals[index].paymentType!)),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Lot Number', widget.purchaseDeals[index].lotNumber!)),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Box Ordered', widget.purchaseDeals[index].orderedBoxCount!)),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    Expanded(flex:1,child: _buildInfoColumn('Box Delivered', widget.purchaseDeals[index].deliveredBoxCount!)),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Box Remaining', widget.purchaseDeals[index].yarnTypeId!)),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Cops', widget.purchaseDeals[index].cops!)),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    Expanded(flex:1,child: _buildInfoColumn('Deiner', widget.purchaseDeals[index].denier!)),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Status', widget.purchaseDeals[index].status!)),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('', '')),
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
                                  text: widget.purchaseDeals[index].netWeight!,
                                ),
                                TextSpan(
                                  text: ' Ton',
                                  style: TextStyle(
                                    fontSize: Dimensions.font12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BigText(text: 'Gross Weight ${widget.purchaseDeals[index].grossWeight!} Ton', color: AppTheme.nearlyBlack, size: Dimensions.font12),
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
                            BigText(text: 'Yarn Name', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                            BigText(text: '${widget.purchaseDeals[index].yarnName!}',color: AppTheme.primary, size: Dimensions.font18)
                          ],
                        )
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      onPressed: (){
                        //Navigator.pushNamed(context, AppRoutes.yarnPurchaseView, arguments: {'yarnPurchaseData': yarnPurchaseList[index]});
                      },
                      buttonText: 'View Details',
                      isBackgroundGradient: false,
                      backgroundColor: AppTheme.primary,
                      textSize: Dimensions.font14,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    String formattedValue = value;
    if (title == 'Deal Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }else if (title == 'Due Date') {
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
}
