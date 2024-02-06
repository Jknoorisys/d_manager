import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';

import '../../../generated/l10n.dart';
import '../../dashboard/purchases.dart';

class BoxToBeReceivedScreen extends StatefulWidget {
  const BoxToBeReceivedScreen({super.key});

  @override
  State<BoxToBeReceivedScreen> createState() => _BoxToBeReceivedScreenState();
}

class _BoxToBeReceivedScreenState extends State<BoxToBeReceivedScreen> {
  List<Map<String, dynamic>> yarnPurchaseList = [
    {'no': 1, 'dealDate': '25-01-2024','myFirm': 'Danish Textiles','partyName': 'Mehta and Sons Yarn Trades','yarnName':'Golden','yarnType':'Roto','grossWeight':'4000','pendingBox':'200','rate':'23.20'},
    {'no': 2, 'dealDate': '26-01-2024','myFirm': 'Danish Textiles','partyName': 'SS Textile','yarnName':'Golden','yarnType':'Roto','grossWeight':'5000','pendingBox':'400','rate':'21.20'},
    {'no': 3, 'dealDate': '27-01-2024','myFirm': 'Danish Textiles','partyName': 'Nageena Tex','yarnName':'Golden','yarnType':'Roto','grossWeight':'7000','pendingBox':'600','rate':'20.20'},
    {'no': 4, 'dealDate': '28-01-2024','myFirm': 'Danish Textiles','partyName': 'Bluesky Cloth Sale','yarnName':'Golden','yarnType':'Roto','grossWeight':'9000','pendingBox':'400','rate':'22.20'},
    {'no': 5, 'dealDate': '29-01-2024','myFirm': 'Danish Textiles','partyName': 'Suntex Textiles','yarnName':'Golden','yarnType':'Roto','grossWeight':'8000','pendingBox':'100','rate':'22.20'},
  ];
  final List<Widget> _pages = [
    const Purchases(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          content:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 10),
                    child: Text(S.of(context).yarnPurchaseBoxToBeReceived, style: AppTheme.headline ),
                  ),
                ],
              ),
              Expanded(child: _pages[_currentIndex]),
            ],
          )
        )
    );
  }
}
