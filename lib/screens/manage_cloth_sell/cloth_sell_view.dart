import 'package:flutter/material.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
class ClothSellView extends StatefulWidget {
  final Map<String, dynamic>? clothSellData;
  const ClothSellView({Key? key, this.clothSellData}) : super(key: key);
  @override
  _ClothSellViewState createState() => _ClothSellViewState();
}

class _ClothSellViewState extends State<ClothSellView> {
  List<Map<String, dynamic>> unFilteredClothSellList = [
    {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Mahesh Textiles','clothQuality':'5 - Kilo','totalThan':'500','thanDelivered':'100','thanRemaining':'400','rate':'150', 'status': 'Ongoing'},
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> clothSellData = unFilteredClothSellList.first;

    return CustomBody(
      title: 'Cloth Sell View',
      content: Padding(
        padding: EdgeInsets.all(Dimensions.height15),
        child: Column(
          children: [
            SizedBox(height: Dimensions.height10),
            CustomAccordionWithoutExpanded(
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
                            child: BigText(text: clothSellData['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                          ),
                          SizedBox(width: Dimensions.height10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BigText(text: clothSellData['partyName'], color: AppTheme.primary, size: Dimensions.font16),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppTheme.black,
                                    radius: Dimensions.height10,
                                    child: BigText(text: clothSellData['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  SmallText(text: clothSellData['myFirm'], color: AppTheme.black, size: Dimensions.font12),
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
                      _buildInfoColumn('Deal Date', clothSellData['dealDate']),
                      SizedBox(width: Dimensions.width20),
                      _buildInfoColumn('Cloth Quality', clothSellData['clothQuality']),
                      SizedBox(width: Dimensions.width20),
                      _buildInfoColumn('Rate', clothSellData['totalThan']),
                    ],
                  ),
                ],
              ),
              contentChild: Column(
                children: [
                  Row(
                    children: [
                      _buildInfoColumn('Total Than', clothSellData['thanDelivered']),
                      SizedBox(width: Dimensions.width20),
                      _buildInfoColumn('Than Delivered', clothSellData['thanRemaining']),
                      SizedBox(width: Dimensions.width20),
                      _buildInfoColumn('Than Remaining', clothSellData['rate']),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  Row(
                    children: [
                      _buildInfoColumn('Status', clothSellData['status']),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            // Navigator.of(context).pushNamed(AppRoutes.clothSellView, arguments: {'clothSellData': clothSellData});
                          },
                          icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary)
                      ),
                      IconButton(
                          onPressed: () {
                            // Navigator.of(context).pushNamed(AppRoutes.clothSellAdd, arguments: {'clothSellData': clothSellData});
                          },
                          icon: const Icon(Icons.edit_outlined, color: AppTheme.primary)
                      ),
                      IconButton(
                          onPressed: () {
                            // setState(() {
                            //   unFilteredClothSellList.removeAt(index);
                            // });
                          },
                          icon: const Icon(Icons.delete_outline, color: AppTheme.primary)
                      ),
                      GFCheckbox(
                        size: Dimensions.height20,
                        type: GFCheckboxType.custom,
                        inactiveBgColor: AppTheme.nearlyWhite,
                        inactiveBorderColor: AppTheme.primary,
                        customBgColor: AppTheme.primary,
                        activeBorderColor: AppTheme.primary,
                        onChanged: (value) {
                          setState(() {
                            clothSellData['status'] = value == true ? 'Completed' : 'Ongoing';
                          });
                        },
                        value: clothSellData['status'] == 'Completed' ? true : false,
                        inactiveIcon: null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

