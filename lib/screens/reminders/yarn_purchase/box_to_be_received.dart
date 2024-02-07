import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../widgets/body.dart';
import '../../widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';

class BoxToBeReceived extends StatefulWidget {
  const BoxToBeReceived({Key? key}) : super(key: key);

  @override
  _BoxToBeReceivedState createState() => _BoxToBeReceivedState();
}

class _BoxToBeReceivedState extends State<BoxToBeReceived> {
  List<Map<String, dynamic>> boxToBeReceived = [
    {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Mehta and Sons Yarn Trades','yarnName':'Golden','yarnType':'Roto','grossWeight':'4000','boxCount':'200','rate':'25.00'},
    {'no': 2, 'dealDate': '2024-01-26','myFirm': 'Danish Textiles','partyName': 'kalantri Yarn Agency','yarnName':'Golden','yarnType':'Roto','grossWeight':'3990','boxCount':'300','rate':'21.00'},
    {'no': 3, 'dealDate': '2024-01-27','myFirm': 'Danish Textiles','partyName': 'Rathi Yarns','yarnName':'Golden','yarnType':'Roto','grossWeight':'8500','boxCount':'400','rate':'22.00'},
    {'no': 4, 'dealDate': '2024-01-28','myFirm': 'Danish Textiles','partyName': 'SK Yarn Traders','yarnName':'Golden','yarnType':'Roto','grossWeight':'9700','boxCount':'600','rate':'23.00'},
    {'no': 5, 'dealDate': '2024-01-29','myFirm': 'Danish Textiles','partyName': 'Malegaon Yarns','yarnName':'Golden','yarnType':'Roto','grossWeight':'8900','boxCount':'300','rate':'24.00'},
    {'no': 6, 'dealDate': '2024-01-30','myFirm': 'Danish Textiles','partyName': 'AI-Yarns Agency','yarnName':'Golden','yarnType':'Roto','grossWeight':'8770','boxCount':'700','rate':'22.00'},
  ];
  @override
  Widget build(BuildContext context) {
    return
      CustomDrawer(
        content: CustomBody(
            title: S.of(context).boxToBeReceived,
            content:
            Padding(
              padding: EdgeInsets.all(Dimensions.height15),
              child:
              ListView.builder(
                itemCount: boxToBeReceived.length,
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
                                  child: BigText(text: boxToBeReceived[index]['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BigText(text: boxToBeReceived[index]['partyName'], color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: BigText(text: boxToBeReceived[index]['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SmallText(text: boxToBeReceived[index]['myFirm'], color: AppTheme.black, size: Dimensions.font12),
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
                            _buildInfoColumn('Due Date', boxToBeReceived[index]['dealDate']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Yarn Name', boxToBeReceived[index]['yarnName']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Yarn Type', boxToBeReceived[index]['yarnType']),
                          ],
                        ),
                      ],
                    ),
                    contentChild: Column(
                      children: [
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
                                    BigText(text: 'Gross Weight', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: AppTheme.primary,
                                          fontSize: Dimensions.font18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: boxToBeReceived[index]['grossWeight'],
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
                                    BigText(text: 'Box Count ${boxToBeReceived[index]['boxCount']}', color: AppTheme.nearlyBlack, size: Dimensions.font12),
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
                                    BigText(text: '₹ ${boxToBeReceived[index]['rate']}',color: AppTheme.primary, size: Dimensions.font18)
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
