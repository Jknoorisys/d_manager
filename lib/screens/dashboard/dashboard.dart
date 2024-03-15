import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/screens/dashboard/cloth_sells.dart';
import 'package:d_manager/screens/dashboard/purchases.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../api/dashboard_services.dart';
import '../../models/dashboard_models/dashboard_models.dart';
import '../widgets/snackbar.dart';
import 'dashboard_card.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages = [];
  late List<PurchaseDeal> purchaseDeals = [];
  late List<SellDeal> sellDeal = [];
  bool isLoading = false;
  bool isNetworkAvailable = true;
  bool noRecordFound = false;
  DashboardServices dashboardServices = DashboardServices();
  late Widget dynamicDashboardCard = Container();
  DashboardModel? dashboardModel;

  String purchaseAmount = "0.00";
  String saleAmount = "0.00";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        dashboardModel = await GetDashboardData();
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
    }
    finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  void updatePages() {
    // Update pages with the fetched data
    _pages = [
      Purchases(purchaseDeals: dashboardModel!.data!.purchaseDeals ?? []),
      ClothSells(sellDeal: dashboardModel!.data!.sellDeal ?? []),
    ];
  }
  void updateDashboardCard() {
    if (_currentIndex == 0) {
      setState(() {
        dynamicDashboardCard = DashboardCard(
          title: 'Total Yarn Purchases',
          value:(purchaseAmount),
          date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          image: AppImages.purchaseIcon,
          fetchDataCallback: () {
            fetchData();
          },

        );
      });
    } else if (_currentIndex == 1) {
      // Update DashboardCard for cloth sells
      setState(() {
        dynamicDashboardCard = DashboardCard(
          title: 'Total Cloth Sells Deals',
          value: saleAmount,
          date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          image: AppImages.salesIcon,
          fetchDataCallback: () {
            fetchData();
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      content: CustomBody(
        dashboardCard: dynamicDashboardCard,
        content: _pages.isNotEmpty ? _pages[_currentIndex] : SizedBox(),
        isLoading: isLoading,
        internetNotAvailable: isNetworkAvailable,
        noRecordFound: noRecordFound,
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(Dimensions.width20),
          height: Dimensions.height60 + Dimensions.height10,
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20),
              topRight: Radius.circular(Dimensions.radius20),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                    updateDashboardCard();
                  });
                },
                buttonText: S.of(context).purchases,
                image: SvgPicture.asset(
                  AppImages.purchaseFillIcon,
                  color: _currentIndex == 0
                      ? AppTheme.white
                      : AppTheme.primary,
                  width: Dimensions.iconSize24,
                  height: Dimensions.iconSize24,
                ),
                isBackgroundGradient: _currentIndex == 0,
                color: _currentIndex == 0
                    ? AppTheme.white
                    : AppTheme.primary,
              ),
              CustomElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                    updateDashboardCard();
                  });
                },
                buttonText: S.of(context).clothSells,
                image: SvgPicture.asset(
                  AppImages.salesFillIcon,
                  color: _currentIndex == 1
                      ? AppTheme.white
                      : AppTheme.primary,
                  width: Dimensions.iconSize24,
                  height: Dimensions.iconSize24,
                ),
                isBackgroundGradient: _currentIndex == 1,
                color: _currentIndex == 1
                    ? AppTheme.white
                    : AppTheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<DashboardModel?> GetDashboardData() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        DashboardModel? model = await dashboardServices.showDashboardData();
        if (model?.success == true) {
         if (model?.data != null) {
           setState(() {
             dashboardModel = model;
             purchaseAmount = "${dashboardModel?.purchaseAmount}";
             saleAmount = "${dashboardModel?.sellAmount}";
             purchaseDeals.addAll(model!.data!.purchaseDeals!);
             sellDeal.addAll(model.data!.sellDeal!);
           });
           updateDashboardCard();
           updatePages();
         } else {
           noRecordFound = true;
         }
        } else {
          Navigator.of(context).pop(); // Close the loading dialog
          CustomApiSnackbar.show(
            context,
            'Error',
            model!.message!,
            mode: SnackbarMode.error,
          );
        }
      } else {
        isNetworkAvailable = false;
        purchaseAmount = "0.00";
        saleAmount = "0.00";
      }
    } catch (e) {
      CustomApiSnackbar.show(
        context,
        'Error',
        'Something went wrong. Please try again later.',
        mode: SnackbarMode.error,
      );
    }finally {
      // Update isLoading state regardless of success or failure
      setState(() {
        isLoading = false;
      });
    }
  }
}

