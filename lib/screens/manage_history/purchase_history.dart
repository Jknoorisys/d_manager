import 'package:d_manager/constants/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import '../widgets/body.dart';
import '../widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  final searchController = TextEditingController();
  List<Map<String, dynamic>> purchaseHistory = [
    {'no': 1, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Mehta and Sons Yarn Traders', 'yarnName':'Golden', 'yarnType':'Roto', 'lotNumber':'25', 'paymentType':'Dhara', 'boxReceived':'300', 'rate':'22.20', 'netWeight':'4990', 'billAmount':'25,00,000', 'GST12%':'12%', 'dueDate':'2024-01-29', 'paidDate':'2024-01-25', 'amountPaid' : '25,00,000', 'differenceAmount':'300','paymentMethod':'Cheque', 'cops' : '4000', 'diener':'34', 'billReceived':'Yes',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'Rathi Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'Tulsi Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'Rahun Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'SK Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'Diamond Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'Rathi Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
  ];
  List<Map<String, dynamic>> filteredPurchaseHistoryList = [];
  @override
  void initState() {
    super.initState();
    filteredPurchaseHistoryList = purchaseHistory;
  }
  @override
  Widget build(BuildContext context) {
    return
      CustomDrawer(
        content: CustomBody(
            title: S.of(context).purchaseHistory,
            content:
            Padding(
              padding: EdgeInsets.all(Dimensions.height15),
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextField(
                            isFilled: false,
                            controller: searchController,
                            hintText: S.of(context).searchParty,
                            prefixIcon: Icons.search,
                            suffixIcon: Icons.close,
                            borderRadius: Dimensions.radius10,
                            borderColor: AppTheme.primary,
                            onSuffixTap: () {
                              searchController.clear();
                              setState(() {
                                filteredPurchaseHistoryList = purchaseHistory;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                filteredPurchaseHistoryList = purchaseHistory
                                    .where((firm) =>
                                firm['partyName']
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                    firm['myFirm']
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                              });
                            }
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  AppTheme.divider,
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredPurchaseHistoryList.length,
                      itemBuilder: (context, index) {
                        return CustomAccordion(
                          titleChild: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    SizedBox(height: Dimensions.height10),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          SizedBox(width: Dimensions.width10),
                                          CircleAvatar(
                                            backgroundColor: AppTheme.secondary,
                                            radius: Dimensions.height20,
                                            child: BigText(text: filteredPurchaseHistoryList[index]['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                          ),
                                          SizedBox(width: Dimensions.height10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              BigText(text: filteredPurchaseHistoryList[index]['partyName'], color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: AppTheme.black,
                                                    radius: Dimensions.height10,
                                                    child: BigText(text: filteredPurchaseHistoryList[index]['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                                  ),
                                                  SizedBox(width: Dimensions.width10),
                                                  SmallText(text: filteredPurchaseHistoryList[index]['myFirm'], color: AppTheme.black, size: Dimensions.font12),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          contentChild: Column(
                            children: [
                              SizedBox(height: Dimensions.height10),
                              AppTheme.divider,
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Deal Date', filteredPurchaseHistoryList[index]['dealDate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Yarn Name', filteredPurchaseHistoryList[index]['yarnName']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Yarn Type', filteredPurchaseHistoryList[index]['yarnType']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Lot Number', filteredPurchaseHistoryList[index]['lotNumber']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Payment Type', filteredPurchaseHistoryList[index]['paymentType']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Box Received', filteredPurchaseHistoryList[index]['boxReceived']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Rate', filteredPurchaseHistoryList[index]['rate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Net Weight', filteredPurchaseHistoryList[index]['netWeight']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Bill Amount', filteredPurchaseHistoryList[index]['billAmount']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('GST 12%', filteredPurchaseHistoryList[index]['GST12%']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Due Date', filteredPurchaseHistoryList[index]['dueDate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Paid Date', filteredPurchaseHistoryList[index]['paidDate']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Amount Paid', filteredPurchaseHistoryList[index]['amountPaid']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Difference Amount', filteredPurchaseHistoryList[index]['differenceAmount']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Payment Method', filteredPurchaseHistoryList[index]['paymentMethod']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Cops', filteredPurchaseHistoryList[index]['cops']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Diener', filteredPurchaseHistoryList[index]['diener']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Bill received', filteredPurchaseHistoryList[index]['billReceived']),
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
                                          BigText(text: 'Box Received', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontSize: Dimensions.font18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(text: filteredPurchaseHistoryList[index]['boxReceived'],),
                                              ],
                                            ),
                                          ),
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
                                          BigText(text: 'Bill Amount', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                          BigText(text: '${filteredPurchaseHistoryList[index]['billAmount']}',color: AppTheme.primary, size: Dimensions.font18)
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
                                      // Navigator.pushNamed(context, AppRoutes.yarnPurchaseView, arguments: {'yarnPurchaseData': filteredPurchaseHistoryList[index]});
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
                  ),
                ],
              ),
            )
        )
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
}
