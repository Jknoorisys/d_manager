
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../widgets/body.dart';
import '../../widgets/drawer/zoom_drawer.dart';

import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';

class PaymentToBeReceived extends StatefulWidget {
  const PaymentToBeReceived({super.key});

  @override
  State<PaymentToBeReceived> createState() => _PaymentToBeReceivedState();
}

class _PaymentToBeReceivedState extends State<PaymentToBeReceived> {
  List<Map<String, dynamic>> paymentToBeReceived = [
    {'no': 1, 'dueDate': '2024-01-25','myFirm': 'Danish Textiles','partyName':'Mahesh Cloth Sales','clothQuality': '5-kilo','dueAmount':'4,00,000'},
    {'no': 2, 'dueDate': '2024-01-26','myFirm': 'Danish Textiles','partyName':'Jaju Cloth Traders','clothQuality': '6-kilo','dueAmount':'2,00,000'},
    {'no': 3, 'dueDate': '2024-01-27','myFirm': 'Danish Textiles','partyName':'Kalantri Textiles','clothQuality': '3-kilo','dueAmount':'90000'},
    {'no': 4, 'dueDate': '2024-01-28','myFirm': 'Danish Textiles','partyName':'Bablu Tex','clothQuality': '2-kilo','dueAmount':'1,40,000'},

  ];
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
            title: S.of(context).paymentToBeReceived,
            content:
            Padding(
              padding: EdgeInsets.all(Dimensions.height15),
              child:
              ListView.builder(
                itemCount: paymentToBeReceived.length,
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
                                  child: BigText(text: paymentToBeReceived[index]['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BigText(text: paymentToBeReceived[index]['partyName'], color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: BigText(text: paymentToBeReceived[index]['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SmallText(text: paymentToBeReceived[index]['myFirm'], color: AppTheme.black, size: Dimensions.font12),
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
                            _buildInfoColumn('Due Date', paymentToBeReceived[index]['dueDate']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Cloth Quality', paymentToBeReceived[index]['clothQuality']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Amount due', paymentToBeReceived[index]['dueAmount']),
                          ],
                        ),
                      ],
                    ),
                    contentChild:Container()
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
