import 'package:d_manager/api/inventory_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/inventory_models/inventory_dashboard_model.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class InventoryDashboard extends StatefulWidget {
  const InventoryDashboard({Key? key}) : super(key: key);

  @override
  _InventoryDashboardState createState() => _InventoryDashboardState();
}

class _InventoryDashboardState extends State<InventoryDashboard> {
  bool isLoading = false;
  bool isNetworkAvailable = true;
  ManageInventoryServices inventoryServices = ManageInventoryServices();
  InventoryDetail? dashboardModel;
  String rotoConsumed = "0.00";
  String rotoReceived = "0.00";
  String rotoRemaining = "0.00";
  String zeroConsumed = "0.00";
  String zeroReceived = "0.00";
  String zeroRemaining = "0.00";

  @override
  void initState() {
    setState(() {
      isLoading = !isLoading;
    });
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height60*4.5,
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
                        Text('Manage Inventory', style: AppTheme.headline),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height25*2,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height30),
              child: Container(
                height: Dimensions.height40*4.5,
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
                          Expanded(child: BigText(text: 'Roto', color: AppTheme.white, size: Dimensions.font20)),
                          _buildInfoColumn('Received', rotoReceived == "0.00" ? "0.00" : HelperFunctions.formatPrice(rotoReceived)),
                          _buildInfoColumn('Consumed', rotoConsumed == "0.00" ? "0.00" : HelperFunctions.formatPrice(rotoConsumed)),
                          _buildInfoColumn('Remaining', rotoRemaining == "0.00" ? "0.00" : HelperFunctions.formatPrice(rotoRemaining)),
                        ],
                      ),
                      const Divider(
                        color: AppTheme.white,
                        thickness: 1.2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(child: BigText(text: 'Zero', color: AppTheme.white, size: Dimensions.font20)),
                          _buildInfoColumn('Received', zeroReceived == "0.00" ? "0.00" : HelperFunctions.formatPrice(zeroReceived)),
                          _buildInfoColumn('Consumed', zeroConsumed == "0.00" ? "0.00" : HelperFunctions.formatPrice(zeroConsumed)),
                          _buildInfoColumn('Remaining', zeroRemaining == "0.00" ? "0.00" : HelperFunctions.formatPrice(zeroRemaining)),
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

  Widget _buildInfoColumn(String title, String value) {
    List<String> parts = value.split('.');
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.white, size: Dimensions.font12),
          // BigText(text: value, color: AppTheme.secondary, size: Dimensions.font15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: '${parts[0]}.', color: AppTheme.secondary, size: Dimensions.font16), // Larger Part
              BigText(text: parts[1], color: AppTheme.secondary, size: Dimensions.font12),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        InventoryDashboardModel? inventoryModel = await inventoryServices.inventoryDashboard();
        if (inventoryModel != null) {
          if (inventoryModel.success == true) {
            setState(() {
              dashboardModel = inventoryModel.data;
              rotoConsumed = inventoryModel.data!.rotoConsumed == null ? "0.00" : inventoryModel.data!.rotoConsumed.toString();
              rotoReceived = inventoryModel.data!.rotoReceived == null ? "0.00" : inventoryModel.data!.rotoReceived.toString();
              rotoRemaining = inventoryModel.data!.rotoRemaining == null ? "0.00" : inventoryModel.data!.rotoRemaining.toString();
              zeroConsumed = inventoryModel.data!.zeroConsumed == null ? "0.00" : inventoryModel.data!.zeroConsumed.toString();
              zeroReceived = inventoryModel.data!.zeroReceived == null ? "0.00" : inventoryModel.data!.zeroReceived.toString();
              zeroRemaining = inventoryModel.data!.zeroRemaining == null ? "0.00" : inventoryModel.data!.zeroRemaining.toString();
            });
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              inventoryModel.message.toString(),
              mode: SnackbarMode.error,
            );
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            'Something went wrong, please try again later.',
            mode: SnackbarMode.error,
          );
        }
      } else {
        setState(() {
          isNetworkAvailable = false;
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
