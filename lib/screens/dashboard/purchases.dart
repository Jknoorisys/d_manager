import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/dashboard_services.dart';
import '../../models/dashboard_models/dashboard_models.dart';
import '../widgets/snackbar.dart';

class Purchases extends StatefulWidget {
  const Purchases({Key? key}) : super(key: key);

  @override
  _PurchasesState createState() => _PurchasesState();
}
class _PurchasesState extends State<Purchases> {
  DashboardServices dashboardServices = DashboardServices();
  bool isLoading = false;
  List<Map<String, dynamic>> yarnPurchaseList = [
    {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Mehta and Sons Yarn Trades','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25.00','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'On Going'},
    {'no': 2, 'dealDate': '2024-01-26','myFirm': 'Danish Textiles','partyName': 'SS Textile','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25.12','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'On Going'},
    {'no': 3, 'dealDate': '2024-01-27','myFirm': 'Danish Textiles','partyName': 'Nageena Textile','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'22.98','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'Completed'},
    {'no': 4, 'dealDate': '2024-01-28','myFirm': 'Danish Textiles','partyName': 'Bluesky Cloth Sale','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25.45','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'On Going'},
    {'no': 5, 'dealDate': '2024-01-29','myFirm': 'Danish Textiles','partyName': 'Suntex Textiles','yarnName':'Golden','yarnType':'Roto','paymentType':'Cheque','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'24.62','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'Completed'},
  ];
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
    return
      Padding(
      padding: EdgeInsets.all(Dimensions.height15),
      child:
      ListView.builder(
        itemCount: purchaseDeals?.length,
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
                          child: BigText(text: purchaseDeals![index].partyFirm![0], color: AppTheme.primary, size: Dimensions.font18),
                        ),
                        SizedBox(width: Dimensions.height10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BigText(text: purchaseDeals![index].partyFirm!, color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppTheme.black,
                                  radius: Dimensions.height10,
                                  child: BigText(text: purchaseDeals![index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                ),
                                SizedBox(width: Dimensions.width10),
                                SmallText(text: purchaseDeals![index].firmName!, color: AppTheme.black, size: Dimensions.font12),
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
                    _buildInfoColumn('Deal Date', purchaseDeals![index].purchaseDate!.toString()),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Rate', purchaseDeals![index].rate!),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Yarn Type', purchaseDeals![index].yarnTypeName!),
                  ],
                ),
              ],
            ),
            contentChild: Column(
              children: [
                Row(
                  children: [
                    _buildInfoColumn('Payment Type', purchaseDeals![index].paymentType!),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Lot Number', purchaseDeals![index].lotNumber!),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Box Ordered', purchaseDeals![index].orderedBoxCount!),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    _buildInfoColumn('Box Delivered', purchaseDeals![index].deliveredBoxCount!),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Box Remaining', purchaseDeals![index].yarnTypeId!),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Cops', purchaseDeals![index].cops!),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    _buildInfoColumn('Deiner', purchaseDeals![index].denier!),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('Status', purchaseDeals![index].status!),
                    SizedBox(width: Dimensions.width20),
                    _buildInfoColumn('', ''),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2.65,
                      height: Dimensions.height40*2,
                      padding: EdgeInsets.all(Dimensions.height10),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                        border: Border.all(color: AppTheme.primary),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'Total Net Weight', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontSize: Dimensions.font18,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: purchaseDeals![index].netWeight!,
                                ),
                                TextSpan(
                                  text: ' Ton',
                                  style: TextStyle(
                                    fontSize: Dimensions.font12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BigText(text: 'Gross Weight ${purchaseDeals![index].grossWeight!} Ton', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                        ],
                      )
                    ),
                    SizedBox(width: Dimensions.width20),
                    Container(
                        width: MediaQuery.of(context).size.width/2.65,
                        height: Dimensions.height40*2,
                        padding: EdgeInsets.all(Dimensions.height10),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                          border: Border.all(color: AppTheme.primary),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: 'Yarn Name', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                            BigText(text: '${purchaseDeals![index].yarnName!}',color: AppTheme.primary, size: Dimensions.font18)
                          ],
                        )
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AppRoutes.yarnPurchaseView, arguments: {'yarnPurchaseData': yarnPurchaseList[index]});
                      },
                      buttonText: 'View Details',
                      isBackgroundGradient: false,
                      backgroundColor: AppTheme.primary,
                      textSize: Dimensions.font14,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.grey, size: Dimensions.font12),
          BigText(text: value, color: AppTheme.primary, size: Dimensions.font14),
        ],
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
        purchaseDeals?.addAll(model!.data!.purchaseDeals!);
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
    }
  }
}
