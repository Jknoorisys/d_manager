import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_theme.dart';
import '../../../constants/dimension.dart';
import '../../../constants/images.dart';
import '../../widgets/texts.dart';

class ViewDetailsBoxToBeReceived extends StatefulWidget {
  const ViewDetailsBoxToBeReceived({super.key});

  @override
  State<ViewDetailsBoxToBeReceived> createState() => _ViewDetailsBoxToBeReceivedState();
}

class _ViewDetailsBoxToBeReceivedState extends State<ViewDetailsBoxToBeReceived> {
  List<Map<String, dynamic>> yarnPurchaseList = [
    {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Mehta and Sons Yarn Trades','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25','totalNetWeight':'4950','Deiner':'30','status':'On Going'},
    {'no': 2, 'dealDate': '2024-01-26','myFirm': 'Danish Textiles','partyName': 'SS Textile','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25','totalNetWeight':'4950','Deiner':'30','status':'On Going'},
    {'no': 3, 'dealDate': '2024-01-27','myFirm': 'Danish Textiles','partyName': 'Nageena Tex','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25','totalNetWeight':'4950','Deiner':'30','status':'Completed'},
    {'no': 4, 'dealDate': '2024-01-28','myFirm': 'Danish Textiles','partyName': 'Bluesky Cloth Sale','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25','totalNetWeight':'4950','Deiner':'30','status':'On Going'},
    {'no': 5, 'dealDate': '2024-01-29','myFirm': 'Danish Textiles','partyName': 'Suntex Textiles','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25','totalNetWeight':'4950','Deiner':'30','status':'Completed'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppImages.appLogoHorizontal, width: Dimensions.width50*5, height: Dimensions.height50*5),
        centerTitle: true,
      ),
      body:Column(
        children: [
          Container(
            height: 100,
            decoration:BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppTheme.primary, AppTheme.secondary],
              ),
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Mehta & Sons Yarn Trade",style: TextStyle(color:AppTheme.secondaryLight,
                    fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.all(12),
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildInfoColumn('Yarn Name', 'yarnName'),
                        _buildInfoColumn('Yarn Type', 'yarnType'),
                        _buildInfoColumn('Rate', 'rate'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildInfoColumn(String title, String value) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.grey, size: Dimensions.font14),
          BigText(text: value, color: AppTheme.primary, size: Dimensions.font18),
        ],
      ),
    );
  }
}
