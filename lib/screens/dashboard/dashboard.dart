import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/dashboard/cloth_sells.dart';
import 'package:d_manager/screens/dashboard/purchases.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';


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

  List<Map<String, dynamic>> yarnPurchaseList = [
    {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Mehta and Sons Yarn Trades','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25','totalNetWeight':'4950','Deiner':'30','status':'On Going'},
    {'no': 2, 'dealDate': '2024-01-26','myFirm': 'Danish Textiles','partyName': 'SS Textile','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25','totalNetWeight':'4950','Deiner':'30','status':'On Going'},
    {'no': 3, 'dealDate': '2024-01-27','myFirm': 'Danish Textiles','partyName': 'Nageena Tex','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25','totalNetWeight':'4950','Deiner':'30','status':'Completed'},
    {'no': 4, 'dealDate': '2024-01-28','myFirm': 'Danish Textiles','partyName': 'Bluesky Cloth Sale','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25','totalNetWeight':'4950','Deiner':'30','status':'On Going'},
    {'no': 5, 'dealDate': '2024-01-29','myFirm': 'Danish Textiles','partyName': 'Suntex Textiles','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25','totalNetWeight':'4950','Deiner':'30','status':'Completed'},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      content: CustomBody(
        title: S.of(context).dashboard,
        filterButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
          ),
          onPressed: (){},
          child: Row(
            children: [
              SmallText(text: 'Select Date', color: AppTheme.white,),
              SizedBox(width: Dimensions.width20,),
              SvgPicture.asset(AppImages.calenderIcon, width: Dimensions.iconSize20, height: Dimensions.iconSize20,),
            ],
          ),
        ),
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
                icon: FontAwesomeIcons.cartFlatbedSuitcase,
                iconSize: Dimensions.iconSize20,
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
                icon: FontAwesomeIcons.cashRegister,
                iconSize: Dimensions.iconSize20,
                isBackgroundGradient: _currentIndex == 1 ? true : false,
                color: _currentIndex == 1 ? AppTheme.white : AppTheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}