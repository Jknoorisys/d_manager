import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/dashboard/cloth_sells.dart';
import 'package:d_manager/screens/dashboard/purchases.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../api/dashboard_services.dart';
import '../../constants/routes.dart';
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
  late List<Widget> _pages;
  late List<PurchaseDeal> purchaseDeals;
  late List<SellDeal> sellDeal;
  bool isLoading = false;
  DashboardServices dashboardServices = DashboardServices();
  late Widget dynamicDashboardCard;
  DashboardModel? dashboardModel;

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
      DateTime startDate = DateTime.now();
      DateTime endDate = DateTime.now();
      purchaseDeals = await fetchPurchaseDeals(startDate,endDate);
      sellDeal = await fetchSellDeals(startDate,endDate);

      // Wait for purchaseDeals and sellDeal to be fetched before initializing _pages
      _pages = [
        Purchases(purchaseDeals: purchaseDeals),
        ClothSells(sellDeal: sellDeal),
      ];
      updateDashboardCard(purchaseDeals, sellDeal);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error occurred: $e");
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<List<PurchaseDeal>> fetchPurchaseDeals(DateTime startDate, DateTime endDate) async {
    try {
      DashboardModel? model = await GetDashboardData(startDate, endDate);
      if (model != null && model.success == true) {
        return model.data!.purchaseDeals ?? [];
      } else {
        // Handle error
        return [];
      }
    } catch (e) {
      print("Error occurred: $e");
      return [];
    }
  }

  Future<List<SellDeal>> fetchSellDeals(DateTime startDate, DateTime endDate) async {
    try {
      DashboardModel? model = await GetDashboardData(startDate, endDate);
      if (model != null && model.success == true) {
        return model.data!.sellDeal ?? [];
      } else {
        // Handle error
        return [];
      }
    } catch (e) {
      print("Error occurred: $e");
      return [];
    }
  }

  void updateDashboardCard(List<PurchaseDeal> purchaseDeals, List<SellDeal> sellDeal) {
    if (_currentIndex == 0) {
      // Update DashboardCard for purchases
      setState(() {
        dynamicDashboardCard = DashboardCard(
          title: 'Total Yarn Purchases',
          value: purchaseDeals.length.toString(), // You can update this with the actual data
          date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          image: AppImages.purchaseIcon,
        );
      });
    } else if (_currentIndex == 1) {
      // Update DashboardCard for cloth sells
      setState(() {
        dynamicDashboardCard = DashboardCard(
          title: 'Total Cloth Sells Deals',
          value: sellDeal.length.toString(), // You can update this with the actual data
          date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          image: AppImages.salesIcon,
        );
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      content: CustomBody(
        dashboardCard: dynamicDashboardCard,
        content: _pages[_currentIndex],
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
  Future<DashboardModel?> GetDashboardData(
      DateTime startDate,
      DateTime endDate
      ) async {
    setState(() {
      isLoading = true;
    });
    try {
      String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
      String formattedEndDueDate = DateFormat('yyyy-MM-dd').format(endDate);

      DashboardModel? model = await dashboardServices.showDashboardData(
          formattedStartDate,
          formattedEndDueDate
      );
      if (model?.success == true) {
        // purchaseDeals?.addAll(model!.data!.purchaseDeals!);
        setState(() {
          dashboardModel = model;
          purchaseDeals.addAll(model!.data!.purchaseDeals!);
          sellDeal.addAll(model.data!.sellDeal!);
        });
      } else {
        Navigator.of(context).pop(); // Close the loading dialog
        CustomApiSnackbar.show(
          context,
          'Error',
          model!.message!,
          mode: SnackbarMode.error,
        );
      }
    } catch (e) {
      print("Error occurred: $e");
    }finally {
      // Update isLoading state regardless of success or failure
      setState(() {
        isLoading = false;
      });
    }
  }
}

