import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:intl/intl.dart';
import '../../api/manage_gst_return_services.dart';
import '../../constants/images.dart';
import '../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';

import '../../helpers/helper_functions.dart';
import '../../models/gst_return_models/gst_return_models.dart';
import '../widgets/snackbar.dart';

class GSTReturnAmount extends StatefulWidget {
  const GSTReturnAmount({super.key});

  @override
  State<GSTReturnAmount> createState() => _GSTReturnAmountState();
}

class _GSTReturnAmountState extends State<GSTReturnAmount> {
  DateTime selectedDate = DateTime.now();
  GstReturnServices gstReturnServices = GstReturnServices();
  bool _isLoading = false;
  GstReturnAmountModel? gstReturnAmountModel;

  @override
  void initState() {
    super.initState();
    gstReturnAmount();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          isLoading: _isLoading,
          title: S.of(context).returnGstAmount,
          filterButton: IconButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                helpText: S.of(context).selectDate,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2050),
                initialDatePickerMode: DatePickerMode.day,
              );
              if (pickedDate != null && pickedDate != selectedDate) {
                await HelperFunctions.setSelectedMonth(selectedDate.month.toString());
                await HelperFunctions.setSelectedYear(selectedDate.year.toString());
                await gstReturnAmount();
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
            icon: const Icon(Icons.calendar_month, color: AppTheme.black),
          ),
          content: gstReturnAmountModel != null ? Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child: SingleChildScrollView(
              child: Column(
                children:[
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
                                AppImages.gstIcon,
                                width: Dimensions.height50,
                                height: Dimensions.height50,
                                color: AppTheme.white,
                              ),
                              SizedBox(width: Dimensions.width10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.of(context).currentMonthAmount,
                                      style: AppTheme.title.copyWith(color: AppTheme.white)),
                                  Row(
                                    children: [
                                      const Icon(Icons.currency_rupee,
                                        color: AppTheme.secondary,),
                                      Text((gstReturnAmountModel?.data?.currentMonthReturn ?? "0").toString(),style: AppTheme.title.copyWith(color: AppTheme.secondary))
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
                                  Text('${gstReturnAmountModel!.filter!.month}', style: AppTheme.title.copyWith(color: AppTheme.secondary)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height30,),
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
                                AppImages.gstIcon,
                                width: Dimensions.height50,
                                height: Dimensions.height50,
                                color: AppTheme.white,
                              ),
                              SizedBox(width: Dimensions.width10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.of(context).lastMonthAmount,
                                      style: AppTheme.title.copyWith(color: AppTheme.white)),
                                  Row(
                                    children: [
                                      const Icon(Icons.currency_rupee,
                                        color: AppTheme.secondary,),
                                      Text('${gstReturnAmountModel!.data!.lastMonthReturn!}' ,style: AppTheme.title.copyWith(color: AppTheme.secondary))
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
                                  Text('${gstReturnAmountModel!.filter!.lastMonth!.toString()} - ${gstReturnAmountModel!.filter!.lastYear!.toString()}',
                                      style: AppTheme.title.copyWith(color: AppTheme.secondary)),
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
          ) : Container(),
          
        )
    );
  }

  Future<GstReturnAmountModel?> gstReturnAmount() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if(await HelperFunctions.isPossiblyNetworkAvailable() ) {
        GstReturnAmountModel? model = await gstReturnServices.showGstReturnAmount();
        if (model!.success == true) {
          setState(() {
            if (model.data != null) {
              gstReturnAmountModel = model;
            }
            print("modelOfGSTReturnAmount=== $gstReturnAmountModel");
          });
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            'Something went wrong, please try again later.',
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Warning',
          'No Internet Connection',
          mode: SnackbarMode.warning,
        );
      }
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
