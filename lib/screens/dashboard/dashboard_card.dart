import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DashboardCard extends StatefulWidget {
  final String? title;
  final String? value;
  final String? date;
  final String? image;
  final void Function() fetchDataCallback;// Define the callback function

  const DashboardCard({Key? key,
    this.title,
    this.value,
    this.date,
    this.image,
    required this.fetchDataCallback,}) : super(key: key);

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  DateTime firstDate = DateTime(2000);
  DateTime lastDate = DateTime(2050);
  String startDateString = DateTime.now().toString();
  String endDateString = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height60*4,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child:
            Container(
              height: Dimensions.height50*4,
              decoration: BoxDecoration(
                color: AppTheme.secondary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.radius30),
                  bottomRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child:
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height15, horizontal: Dimensions.height30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).dashboard, style: AppTheme.headline),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            visualDensity: VisualDensity.comfortable,
                          ),
                          onPressed: () async {
                            DateTimeRange? pickedDateRange = await showDateRangePicker(
                              initialEntryMode: DatePickerEntryMode.input,
                              helpText: S.of(context).selectDate,
                              context: context,
                              initialDateRange: DateTimeRange(
                                start: DateTime.now(),
                                end: DateTime.now().add(const Duration(days: 7)),
                              ),
                              firstDate: firstDate,
                              lastDate: lastDate,
                            );
                            if (pickedDateRange != null) {
                              DateTime startDate = pickedDateRange.start;
                              DateTime endDate = pickedDateRange.end;
                              String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
                              String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);
                              await HelperFunctions.setStartDate(formattedStartDate);
                              await HelperFunctions.setEndDate(formattedEndDate);
                              widget.fetchDataCallback();
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height25*2, // Adjust this value to position the second container
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height30),
              child: Container(
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
                          SvgPicture.asset(
                            widget.image ?? AppImages.purchaseIcon,
                            width: Dimensions.height50,
                            height: Dimensions.height50,
                          ),
                          SizedBox(width: Dimensions.width10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title ?? S.of(context).totalPurchaseAmount,
                                style: AppTheme.title.copyWith(color: AppTheme.white)),
                              Row(
                                children: [
                                  const Icon(Icons.currency_rupee,
                                    color: AppTheme.secondary,),
                                  Text(widget.value ?? "0.00" ,style: AppTheme.title.copyWith(color: AppTheme.secondary))
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
                              Text(widget.date ?? DateFormat('dd-MM-yyyy').format(DateTime.now()), style: AppTheme.title.copyWith(color: AppTheme.secondary)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


