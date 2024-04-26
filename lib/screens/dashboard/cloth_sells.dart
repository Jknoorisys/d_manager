import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/dashboard_models/dashboard_models.dart';

class ClothSells extends StatefulWidget {
  final List<SellDeal> sellDeal;
  const ClothSells({Key? key, required this.sellDeal}) : super(key: key);

  @override
  _ClothSellsState createState() => _ClothSellsState();
}

class _ClothSellsState extends State<ClothSells> {
  @override
  Widget build(BuildContext context) {
    return (widget.sellDeal.isEmpty) ? const NoRecordFound() : Padding(
      padding: EdgeInsets.all(Dimensions.height15),
      child: ListView.builder(
        itemCount: widget.sellDeal.length,
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
                          child: BigText(text: widget.sellDeal[index].partyFirm![0], color: AppTheme.primary, size: Dimensions.font18),
                        ),
                        SizedBox(width: Dimensions.height10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: Dimensions.screenWidth * 0.5,
                                child: BigText(text: widget.sellDeal[index].partyFirm!, color: AppTheme.primary, size: Dimensions.font16)),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppTheme.black,
                                  radius: Dimensions.height10,
                                  child: BigText(text: widget.sellDeal[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                ),
                                SizedBox(width: Dimensions.width10),
                                SizedBox(
                                    width: Dimensions.screenWidth * 0.5,
                                    child: SmallText(text: widget.sellDeal[index].firmName!, color: AppTheme.black, size: Dimensions.font12)),
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
                    Expanded(flex:1,child: _buildInfoColumn('Deal Date', widget.sellDeal[index].sellDate!.toString())),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Cloth Quality', widget.sellDeal[index].qualityName!)),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Total Than', widget.sellDeal[index].totalThan!)),
                  ],
                ),
              ],
            ),
            contentChild: Column(
              children: [
                Row(
                  children: [
                    Expanded(flex:1,child: _buildInfoColumn('Than Delivered', widget.sellDeal[index].thanDelivered!)),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Than Remaining', widget.sellDeal[index].thanRemaining!)),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('Rate',  '₹${HelperFunctions.formatPrice(widget.sellDeal[index].rate.toString())}')),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    Expanded(flex:1,child: _buildInfoColumn('Status', widget.sellDeal[index].dealStatus! == 'completed' ? 'Completed' : 'On Going')),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('', '')),
                    SizedBox(width: Dimensions.width20),
                    Expanded(flex:1,child: _buildInfoColumn('', '')),
                  ],
                ),
                SizedBox(height: Dimensions.height15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AppRoutes.clothSellView, arguments: {'sellID': widget.sellDeal[index].sellId});
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
    if (title.contains('Date') && value != 'N/A' && value != '' && value != null) {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd MMM yy').format(date);
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.nearlyBlack, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font14),
        ],
      ),
    );
  }
}
