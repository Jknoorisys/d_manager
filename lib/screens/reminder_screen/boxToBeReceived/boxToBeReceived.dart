import 'package:d_manager/screens/reminder_screen/boxToBeReceived/viewDetails_BoxToBeReceived.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';

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
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add your Text widget here
                const Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child: Text(
                    'Yarn Purchase - Box to be Received',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Spacer or SizedBox for spacing if needed
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: yarnPurchaseList.length,
                    itemBuilder: (context, index) {
                      return CustomAccordion(
                        titleChild: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    SizedBox(width: Dimensions.width10),
                                    CircleAvatar(
                                      backgroundColor: AppTheme.secondary,
                                      radius: Dimensions.height20,
                                      child: BigText(text: yarnPurchaseList[index]['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                    ),
                                    SizedBox(width: Dimensions.height10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BigText(text: yarnPurchaseList[index]['partyName'], color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppTheme.black,
                                              radius: Dimensions.height10,
                                              child: BigText(text: yarnPurchaseList[index]['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                            ),
                                            SizedBox(width: Dimensions.width10),
                                            SmallText(text: yarnPurchaseList[index]['myFirm'], color: AppTheme.black, size: Dimensions.font12),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            AppTheme.divider,
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                _buildInfoColumn('Due Date \n ', yarnPurchaseList[index]['dealDate']),
                                SizedBox(width:12),
                                _buildInfoColumn('Gross weight (Remaining)', yarnPurchaseList[index]['grossWeight']),
                                _buildInfoColumn('Pending box \ncount', yarnPurchaseList[index]['pendingBox']),
                              ],
                            ),
                          ],
                        ),
                        contentChild: Column(
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildInfoColumn('Yarn Name', yarnPurchaseList[index]['yarnName']),
                                _buildInfoColumn('Yarn Type', yarnPurchaseList[index]['yarnType']),
                                _buildInfoColumn('Rate', yarnPurchaseList[index]['rate']),
                              ],
                            ),
                            SizedBox(height: Dimensions.height15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => ViewDetailsBoxToBeReceived()));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [AppTheme.primary, AppTheme.secondary],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                      child: Text("View Details",
                                      style: TextStyle(color: AppTheme.secondaryLight,
                                      fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
  Widget _buildInfoColumn(String title, String value) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.grey, size: Dimensions.font12),
          BigText(text: value, color: AppTheme.primary, size: Dimensions.font16),
        ],
      ),
    );
  }
}
