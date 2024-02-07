import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../widgets/body.dart';
import '../../widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';

class PaymentDueDate extends StatefulWidget {
  const PaymentDueDate({Key? key}) : super(key: key);

  @override
  _PaymentDueDateState createState() => _PaymentDueDateState();
}

class _PaymentDueDateState extends State<PaymentDueDate> {
  List<Map<String, dynamic>> paymentDueDate = [
    {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName':'SK Yarns','clothQuality': '5-kilo','balanceAmount':'4,00,000'},
    {'no': 2, 'dealDate': '2024-01-26','myFirm': 'Danish Textiles','partyName':'Rathi Yarns','clothQuality': '5-kilo','balanceAmount':'4,00,000'},
    {'no': 3, 'dealDate': '2024-01-27','myFirm': 'Danish Textiles','partyName':'JB Yarns Agency','clothQuality': '5-kilo','balanceAmount':'4,00,000'},
    {'no': 4, 'dealDate': '2024-01-28','myFirm': 'Danish Textiles','partyName':'Kalantri','clothQuality': '5-kilo','balanceAmount':'4,00,000'},
  ];
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
            title: S.of(context).paymentDueDate,
            content:
            Padding(
              padding: EdgeInsets.all(Dimensions.height15),
              child:
              ListView.builder(
                itemCount: paymentDueDate.length,
                itemBuilder: (context, index) {
                  return CustomAccordionWithoutExpanded(
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
                                  child: BigText(text: paymentDueDate[index]['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BigText(text: paymentDueDate[index]['partyName'], color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: BigText(text: paymentDueDate[index]['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SmallText(text: paymentDueDate[index]['myFirm'], color: AppTheme.black, size: Dimensions.font12),
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                          child: Row(
                            children: [
                              _buildInfoColumn('Cloth Quality', paymentDueDate[index]['clothQuality']),
                              _buildInfoColumn('Amount To Be Received', paymentDueDate[index]['balanceAmount']),
                            ],
                          ),
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
