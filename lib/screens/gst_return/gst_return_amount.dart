import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/images.dart';
import '../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import '../../models/sell_models/get_sell_deal_model.dart';

class GSTReturnAmount extends StatefulWidget {
  final String? title;
  final String? value;
  final String? date;
  final String? image;
  const GSTReturnAmount({super.key, this.title, this.value, this.date, this.image});

  @override
  State<GSTReturnAmount> createState() => _GSTReturnAmountState();
}

class _GSTReturnAmountState extends State<GSTReturnAmount> {
  GetSellDealModel? getSellDealModel;
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          title: S.of(context).returnGstAmount,
          filterButton:ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              visualDensity: VisualDensity.comfortable,
            ),
            onPressed: () async {
              DateTime? pickedDate = (
                  await showDateRangePicker(
                    initialEntryMode: DatePickerEntryMode.input,
                    helpText: S.of(context).selectDate,
                    context: context,
                    firstDate: firstDate,
                    lastDate: lastDate,
                  )
              ) as DateTime?;
              if (pickedDate != null && pickedDate != selectedDate) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
            child: Row(
              children: [
                SmallText(text: S.of(context).selectDate, color: AppTheme.white,),
                SizedBox(width: Dimensions.width20,),
                SvgPicture.asset(AppImages.calenderIcon, width: Dimensions.iconSize20, height: Dimensions.iconSize20,),
              ],
            ),
          ),
          content:
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children:[
                  SizedBox(height: Dimensions.height50,),
                  Container(
                    height: Dimensions.height40*4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppTheme.white,
                      image: const DecorationImage(
                        image: AssetImage(AppImages.cardBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.height20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                widget.image ?? AppImages.gstIcon,
                                width: Dimensions.height50,
                                height: Dimensions.height50,
                                color: AppTheme.white,
                              ),
                              SizedBox(width: Dimensions.width10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.title ?? S.of(context).currentAmount,
                                      style: AppTheme.title.copyWith(color: AppTheme.white)),
                                  Row(
                                    children: [
                                      const Icon(Icons.currency_rupee,
                                        color: AppTheme.secondary,),
                                      Text(widget.value ?? "1,50,000" ,style: AppTheme.title.copyWith(color: AppTheme.secondary))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Till Date', style: AppTheme.title.copyWith(color: AppTheme.white)),
                                  Text(widget.date ?? "31-01-2024", style: AppTheme.title.copyWith(color: AppTheme.secondary)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height50,),
                  Container(
                    height: Dimensions.height40*4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppTheme.white,
                      image: const DecorationImage(
                        image: AssetImage(AppImages.cardBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.height20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                widget.image ?? AppImages.gstIcon,
                                width: Dimensions.height50,
                                height: Dimensions.height50,
                                color: AppTheme.white,
                              ),
                              SizedBox(width: Dimensions.width10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.title ?? S.of(context).lastMonthAmount,
                                      style: AppTheme.title.copyWith(color: AppTheme.white)),
                                  Row(
                                    children: [
                                      const Icon(Icons.currency_rupee,
                                        color: AppTheme.secondary,),
                                      Text(widget.value ?? "1,00,000" ,style: AppTheme.title.copyWith(color: AppTheme.secondary))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Till Date', style: AppTheme.title.copyWith(color: AppTheme.white)),
                                  Text(widget.date ?? "31-01-2024", style: AppTheme.title.copyWith(color: AppTheme.secondary)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        )
    );
  }
}
