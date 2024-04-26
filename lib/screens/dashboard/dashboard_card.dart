import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../api/dashboard_services.dart';
import '../../models/dashboard_models/dashboard_models.dart';
import '../widgets/snackbar.dart';

class DashboardCard extends StatefulWidget {
  final String type;
  final String? title;
  final String? image;
  const DashboardCard({Key? key, this.title, this.image, required this.type,}) : super(key: key);

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  String startDateString = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  String endDateString = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();

  DateTime firstDate = DateTime(2000);
  DateTime lastDate = DateTime(2050);
  var selectedStartDate;
  var selectedEndDate;
  DashboardServices dashboardServices = DashboardServices();
  DashboardModel? dashboardModel;

  bool isLoading = false;
  bool isNetworkAvailable = true;
  bool isFilterApplied = false;
  bool noRecordFound = false;
  String purchaseAmount = "0.00";
  String saleAmount = "0.00";
  String value = "0.00";

  @override
  void initState() {
    setState(() {
      isLoading = !isLoading;
    });
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.type == 'purchase'){
      setState(() {
        value = HelperFunctions.formatPrice(purchaseAmount.toString());
      });
    } else if (widget.type == 'sell') {
      setState(() {
        value = HelperFunctions.formatPrice(saleAmount.toString());
      });
    } else {
      setState(() {
        value = "0.00";
      });
    }
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
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                visualDensity: VisualDensity.comfortable,
                              ),
                              onPressed: () async {
                                DateTimeRange? pickedDateRange = await showDateRangePicker(
                                  initialEntryMode: DatePickerEntryMode.calendar,
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
                                  DateTime startDateForPurchaseHistory = pickedDateRange.start;
                                  DateTime endDateForPurchaseHistory = pickedDateRange.end;
                                  String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDateForPurchaseHistory);
                                  String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDateForPurchaseHistory);
                                  setState(() {
                                    selectedStartDate = formattedStartDate;
                                    selectedEndDate = formattedEndDate;
                                    startDateString = DateFormat('dd-MM-yyyy').format(startDateForPurchaseHistory);
                                    endDateString = DateFormat('dd-MM-yyyy').format(endDateForPurchaseHistory);
                                    isFilterApplied = true;
                                  });
                                  fetchData();
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
                            isFilterApplied == false ? Container() : GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFilterApplied = false;
                                  selectedStartDate = null;
                                  selectedEndDate = null;
                                  startDateString = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
                                  endDateString = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
                                });
                                fetchData();
                              },
                              child: Container(
                                width: Dimensions.height20,
                                height: Dimensions.height20,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.clear, color: AppTheme.primary, size: 12),
                              ),
                            ),
                          ],
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
                                  Text(value ?? "0.00" ,style: AppTheme.title.copyWith(color: AppTheme.secondary))
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
                              Text(endDateString , style: AppTheme.title.copyWith(color: AppTheme.secondary)),
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

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        DashboardModel? model = await dashboardServices.showDashboardData(
          selectedStartDate,
          selectedEndDate,
        );
        if (model != null) {
          if (model.success == true) {
            if (model.data != null) {
              setState(() {
                dashboardModel = model;
                purchaseAmount = "${dashboardModel?.purchaseAmount}";
                saleAmount = "${dashboardModel?.sellAmount}";
                if (widget.type == 'purchase') {
                  value = HelperFunctions.formatPrice(purchaseAmount.toString());
                } else if (widget.type == 'sell') {
                  value = HelperFunctions.formatPrice(saleAmount.toString());
                } else {
                  value = "0.00";
                }
              });
            } else {
              noRecordFound = true;
              setState(() {
                purchaseAmount = "0.00";
                saleAmount = "0.00";
              });
            }
          } else {
            setState(() {
              purchaseAmount = "0.00";
              saleAmount = "0.00";
            });
          }
        }
      } else{
        setState(() {
          isNetworkAvailable = false;
          purchaseAmount = "0.00";
          saleAmount = "0.00";
        });
      }
    } catch (e) {
      CustomApiSnackbar.show(
        context,
        'Error',
        'Something went wrong. Please try again later.',
        mode: SnackbarMode.error,
      );
    } finally{
      setState(() {
        isLoading = false;
      });
    }
  }
}


