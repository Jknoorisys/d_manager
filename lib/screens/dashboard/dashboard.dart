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
  final List<Widget> _pages = [
    // yarn purchases
    const Purchases(),
    // cloth sells
    const ClothSells(),
  ];
  bool isLoading = false;
  DashboardServices dashboardServices = DashboardServices();
  List<PurchaseDeal>? purchaseDeals = [];

  @override
  void initState() {
    super.initState();
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();
    fetchData(startDate,endDate);
  }
  void fetchData(DateTime startDate, DateTime endDate) async {
    setState(() {
      isLoading = true;
    });
    try {
      DashboardModel? model = await GetDashboardData(startDate, endDate);
      if (model?.success == true) {
        setState(() {
          purchaseDeals?.addAll(model!.data!.purchaseDeals!);
          isLoading = false;
        });
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          model!.message!,
          mode: SnackbarMode.error,
        );
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget dynamicDashboardCard = const DashboardCard();
    if (_currentIndex == 0) {
      // Total Yarn Purchases card
      dynamicDashboardCard = DashboardCard(
        title: 'Total Yarn Purchases',
        value: '1,00,000',
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        image: AppImages.purchaseIcon,
      );
    } else if (_currentIndex == 1) {
      // Other card for Cloth Sells
      dynamicDashboardCard = DashboardCard(
        title: 'Total Cloth Sells Deals',
        value: '500,000',
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        image: AppImages.salesIcon,
      );
    }
    return CustomDrawer(
      content: CustomBody(
        dashboardCard: dynamicDashboardCard,
        content: _pages[_currentIndex],
        // BottomNavigationBar
        bottomNavigationBar: Container(
          padding: EdgeInsets.all( Dimensions.width20),
          height: Dimensions.height60 + Dimensions.height10,
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20),
              topRight: Radius.circular(Dimensions.radius20),),
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
                onPressed: (){
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                buttonText: S.of(context).purchases,
                image: SvgPicture.asset(
                  AppImages.purchaseFillIcon,
                  color: _currentIndex == 0 ? AppTheme.white : AppTheme.primary,
                  width: Dimensions.iconSize24,
                  height: Dimensions.iconSize24,
                ),
                isBackgroundGradient: _currentIndex == 0 ? true : false,
                color: _currentIndex == 0 ? AppTheme.white : AppTheme.primary,
              ),
              CustomElevatedButton(
                onPressed: (){
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                buttonText: S.of(context).clothSells,
                image: SvgPicture.asset(
                  AppImages.salesFillIcon,
                  color: _currentIndex == 1 ? AppTheme.white : AppTheme.primary,
                  width: Dimensions.iconSize24,
                  height: Dimensions.iconSize24,
                ),
                isBackgroundGradient: _currentIndex == 1 ? true : false,
                color: _currentIndex == 1 ? AppTheme.white : AppTheme.primary,
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
    try {
      String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
      String formattedEndDueDate = DateFormat('yyyy-MM-dd').format(endDate);
      DashboardModel? model = await dashboardServices.showDashboardData(
        formattedStartDate,
        formattedEndDueDate
      );
      if (model != null && model.success == true) {
        print("Api Call Successfull $model");
        return model;
      } else {
        Navigator.of(context).pop(); // Close the loading dialog
        CustomApiSnackbar.show(
          context,
          'Error',
          model?.message ?? 'Unknown error occurred',
          mode: SnackbarMode.error,
        );
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }
}