import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';

class ClothSells extends StatefulWidget {
  const ClothSells({Key? key}) : super(key: key);

  @override
  _ClothSellsState createState() => _ClothSellsState();
}

class _ClothSellsState extends State<ClothSells> {

  List<Map<String, dynamic>> clothSellList = [
    {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Mahesh Textiles','clothQuality':'5 - Kilo','totalThan':'500','thanDelivered':'100','thanRemaining':'400','rate':'150', 'status': 'On Going'},
    {'no': 2, 'dealDate': '2024-01-26','myFirm': 'Danish Textiles','partyName': 'Tulsi Textiles','clothQuality':'5 - Kilo','totalThan':'500','thanDelivered':'100','thanRemaining':'400','rate':'150', 'status': 'On Going'},
    {'no': 3, 'dealDate': '2024-01-27','myFirm': 'Danish Textiles','partyName': 'Laxmi Traders','clothQuality':'5 - Kilo','totalThan':'500','thanDelivered':'100','thanRemaining':'400','rate':'150', 'status': 'On Going'},
    {'no': 4, 'dealDate': '2024-01-28','myFirm': 'Danish Textiles','partyName': 'Mahalaxmi Textiles','clothQuality':'5 - Kilo','totalThan':'500','thanDelivered':'100','thanRemaining':'400','rate':'150', 'status': 'On Going'},
    {'no': 5, 'dealDate': '2024-01-29','myFirm': 'Danish Textiles','partyName': 'Veenapani Textiles','clothQuality':'5 - Kilo','totalThan':'500','thanDelivered':'100','thanRemaining':'400','rate':'150', 'status': 'On Going'},
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.height15),
      child: ListView.builder(
        itemCount: clothSellList.length,
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
                          child: BigText(text: clothSellList[index]['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                        ),
                        SizedBox(width: Dimensions.height10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BigText(text: clothSellList[index]['partyName'], color: AppTheme.primary, size: Dimensions.font16),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppTheme.black,
                                  radius: Dimensions.height10,
                                  child: BigText(text: clothSellList[index]['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                ),
                                SizedBox(width: Dimensions.width10),
                                SmallText(text: clothSellList[index]['myFirm'], color: AppTheme.black, size: Dimensions.font12),
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
                    _buildInfoColumn('Deal Date', clothSellList[index]['dealDate']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Cloth Quality', clothSellList[index]['clothQuality']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Total Than', clothSellList[index]['totalThan']),
                  ],
                ),
              ],
            ),
            contentChild: Column(
              children: [
                Row(
                  children: [
                    _buildInfoColumn('Than Delivered', clothSellList[index]['thanDelivered']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Than Remaining', clothSellList[index]['thanRemaining']),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Rate', clothSellList[index]['rate']),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    _buildInfoColumn('Status', clothSellList[index]['status']),
                  ],
                ),
                SizedBox(height: Dimensions.height15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AppRoutes.clothSellView, arguments: {'clothSellData': clothSellList[index]});
                      },
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
