import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import '../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import '../../models/sell_models/get_sell_deal_model.dart';

class GSTReturnAmount extends StatefulWidget {
  const GSTReturnAmount({super.key});

  @override
  State<GSTReturnAmount> createState() => _GSTReturnAmountState();
}

class _GSTReturnAmountState extends State<GSTReturnAmount> {
  GetSellDealModel? getSellDealModel;
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          title: S.of(context).returnGstAmount,
          content:  Column(
            children: [
              CustomAccordionWithoutExpanded(
                titleChild: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: Dimensions.width10),
                            CircleAvatar(
                              backgroundColor: AppTheme.secondary,
                              radius: Dimensions.height20,
                              child: BigText(text: 'C', color: AppTheme.primary, size: Dimensions.font18),
                            ),
                            SizedBox(width: Dimensions.height10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BigText(text: 'Current Amount', color: AppTheme.primary, size: Dimensions.font16),
                                BigText(text: '2,50,000', color: AppTheme.primary, size: Dimensions.font16),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    AppTheme.divider,
                    SizedBox(height: Dimensions.height10),
                  ],
                ),
                contentChild: Column(
                  children: [
                    Row(
                      children: [
                        _buildInfoColumn('Total Than', '200'),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                  ],
                ),
              ),
            ],
          ),
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
