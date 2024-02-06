import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

class Purchases extends StatefulWidget {
  const Purchases({Key? key}) : super(key: key);

  @override
  _PurchasesState createState() => _PurchasesState();
}
class _PurchasesState extends State<Purchases> {
  List<Map<String, dynamic>> yarnPurchaseList = [
    {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Mehta and Sons Yarn Trades','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25.00','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'On Going'},
    {'no': 2, 'dealDate': '2024-01-26','myFirm': 'Danish Textiles','partyName': 'SS Textile','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25.12','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'On Going'},
    {'no': 3, 'dealDate': '2024-01-27','myFirm': 'Danish Textiles','partyName': 'Nageena Textile','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'22.98','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'Completed'},
    {'no': 4, 'dealDate': '2024-01-28','myFirm': 'Danish Textiles','partyName': 'Bluesky Cloth Sale','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25.45','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'On Going'},
    {'no': 5, 'dealDate': '2024-01-29','myFirm': 'Danish Textiles','partyName': 'Suntex Textiles','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'24.62','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'Completed'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.height15),
      child:
      ListView.builder(
        itemCount: yarnPurchaseList.length,
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
                          child: BigText(text: yarnPurchaseList[index]['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                        ),
                        SizedBox(width: Dimensions.height10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BigText(text: yarnPurchaseList[index]['partyName'], color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppTheme.black,
                                  radius: Dimensions.height10,
                                  child: BigText(text: yarnPurchaseList[index]['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                ),
                                SizedBox(width: Dimensions.width10),
                                SmallText(text: yarnPurchaseList[index]['myFirm'], color: AppTheme.black, size: Dimensions.font12),
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
                    _buildInfoColumn('Deal Date', yarnPurchaseList[index]['dealDate']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Yarn Name', yarnPurchaseList[index]['yarnName']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Yarn Type', yarnPurchaseList[index]['yarnType']),
                  ],
                ),
              ],
            ),
            contentChild: Column(
              children: [
                Row(
                  children: [
                    _buildInfoColumn('Payment Type', yarnPurchaseList[index]['paymentType']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Lot Number', yarnPurchaseList[index]['lotNumber']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Box Ordered', yarnPurchaseList[index]['boxOrdered']),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    _buildInfoColumn('Box Delivered', yarnPurchaseList[index]['boxDelivered']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Box Remaining', yarnPurchaseList[index]['boxRemaining']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Cops', yarnPurchaseList[index]['cops']),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    _buildInfoColumn('Deiner', yarnPurchaseList[index]['Deiner']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Status', yarnPurchaseList[index]['status']),
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
                                  text: yarnPurchaseList[index]['totalNetWeight'],
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
                          BigText(text: 'Gross Weight ${yarnPurchaseList[index]['grossWeight']} kg', color: AppTheme.nearlyBlack, size: Dimensions.font12),
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
                            BigText(text: '₹ ${yarnPurchaseList[index]['rate']}',color: AppTheme.primary, size: Dimensions.font18)
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
                      onPressed: (){},
                      buttonText: 'View Details',
                      isBackgroundGradient: false,
                      backgroundColor: AppTheme.primary,
                      textSize: Dimensions.font14,
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
