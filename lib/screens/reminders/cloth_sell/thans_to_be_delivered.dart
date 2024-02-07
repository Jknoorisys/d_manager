
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

class ThansToBeDelivered extends StatefulWidget {
  const ThansToBeDelivered({super.key});

  @override
  State<ThansToBeDelivered> createState() => _ThansToBeDeliveredState();
}

class _ThansToBeDeliveredState extends State<ThansToBeDelivered> {
  List<Map<String, dynamic>> thansToBeDelivered = [
    {'no': 1, 'dueDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Tulsi Cloth Traders','thansForDelivery':'230'},
    {'no': 2, 'dueDate': '2024-01-26','myFirm': 'Danish Textiles','partyName': 'Shilpa Textiles','thansForDelivery':'330'},
    {'no': 3, 'dueDate': '2024-01-27','myFirm': 'Danish Textiles','partyName': 'Sundar Traders','thansForDelivery':'500'},
    {'no': 4, 'dueDate': '2024-01-28','myFirm': 'Danish Textiles','partyName': 'Mehta Cloth Sales','thansForDelivery':'200'},

  ];
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
            title: S.of(context).thansToBeDelivered,
            content:
            Padding(
              padding: EdgeInsets.all(Dimensions.height15),
              child:
              ListView.builder(
                itemCount: thansToBeDelivered.length,
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
                                  child: BigText(text: thansToBeDelivered[index]['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BigText(text: thansToBeDelivered[index]['partyName'], color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: BigText(text: thansToBeDelivered[index]['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SmallText(text: thansToBeDelivered[index]['myFirm'], color: AppTheme.black, size: Dimensions.font12),
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
                            _buildInfoColumn('Due Date', thansToBeDelivered[index]['dueDate']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Remaining Thans for Delivery', thansToBeDelivered[index]['thansForDelivery']),
                          ],
                        ),
                      ],
                    ),
                    contentChild:
                    Column(
                      children: [

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
