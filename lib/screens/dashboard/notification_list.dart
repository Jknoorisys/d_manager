import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/dimension.dart';
import '../../generated/l10n.dart';
import 'package:d_manager/screens/manage_cloth_sell/update_sell_deal.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import '../../models/sell_models/active_parties_model.dart';
import '../../models/dropdown_models/dropdown_cloth_quality_list_model.dart';
import '../../models/sell_models/active_firms_model.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  final List<Map<String, String>> notificationList = [
    {'partyName': 'Kalantri Yarn Agency','title': 'Yarn to be Received', 'body': 'Body 1','date':'20/03/2024'},
    {'partyName': 'Laxmi Yarns','title': 'Payment Due Date', 'body': 'Body 1','date':'22/03/2024'},
    {'partyName': 'Tulsi Textiles','title': 'Thans to be Delivered', 'body': 'Body 1','date':'25/03/2024'},
    {'partyName': 'Jakhotya Textiles','title': 'Payment to be Received', 'body': 'Body 1','date':'29/03/2024'},

  ];

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          title: S.of(context).notificationList,
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                return CustomAccordionWithoutExpanded(
                    titleChild:
                    Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppTheme.secondary,
                                      radius: Dimensions.height20,
                                      child: BigText(text: notificationList[index]['title']![0], color: AppTheme.primary, size: Dimensions.font18),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BigText(text: notificationList[index]['title']!, color: AppTheme.primary, size: Dimensions.font16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: BigText(text: notificationList[index]['partyName']![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SmallText(text: notificationList[index]['partyName']!, color: AppTheme.black, size: Dimensions.font12),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    BigText(text:notificationList[index]['date']!, color: AppTheme.primary, size: Dimensions.font14),
                                  ],
                                ),
                              )
                            ],
                          ),
                    ]
                ),
                contentChild: Container()
                );
              },
            ),
          ),
        )
    );
  }
}
