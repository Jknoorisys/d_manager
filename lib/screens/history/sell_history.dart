
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
import '../widgets/text_field.dart';

class SellHistory extends StatefulWidget {
  const SellHistory({super.key});

  @override
  State<SellHistory> createState() => _SellHistoryState();
}

class _SellHistoryState extends State<SellHistory> {
  final searchController = TextEditingController();
  List<Map<String, dynamic>> sellHistory = [
    {'no': 1, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Kalantri Cloth Traders', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
    {'no': 2, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Pooja Cloth Agency', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
    {'no': 3, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Harshad Textile', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
    {'no': 4, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Veenapani Cloths', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
    {'no': 5, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Aneesa Tex', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
    {'no': 6, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Sarika Textiles', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
  ];
  List<Map<String, dynamic>> filteredPartyList = [];
  @override
  void initState() {
    super.initState();
    filteredPartyList = sellHistory;
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
            title: S.of(context).sellHistory,
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
                                filteredPartyList = sellHistory;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                filteredPartyList = sellHistory
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
                      itemCount: filteredPartyList.length,
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
                                            child: BigText(text: filteredPartyList[index]['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                          ),
                                          SizedBox(width: Dimensions.height10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              BigText(text: filteredPartyList[index]['partyName'], color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: AppTheme.black,
                                                    radius: Dimensions.height10,
                                                    child: BigText(text: filteredPartyList[index]['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                                  ),
                                                  SizedBox(width: Dimensions.width10),
                                                  SmallText(text: filteredPartyList[index]['myFirm'], color: AppTheme.black, size: Dimensions.font12),
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
                                  _buildInfoColumn('Deal Date', filteredPartyList[index]['dealDate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Cloth Quality', filteredPartyList[index]['clothQuality']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Invoice Date', filteredPartyList[index]['invoiceDate']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Invoice Number', filteredPartyList[index]['invoiceNumber']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Bale Number', filteredPartyList[index]['baleNumber']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Than', filteredPartyList[index]['than']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Meter', filteredPartyList[index]['meter']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Rate', filteredPartyList[index]['rate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('GST', filteredPartyList[index]['gst']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Invoice Amount', filteredPartyList[index]['invoiceAmount']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Payment Type', filteredPartyList[index]['paymentType']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Additional Discount', filteredPartyList[index]['additionalDiscount']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Due Date', filteredPartyList[index]['dueDate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Difference Amount', filteredPartyList[index]['differenceAmount']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Payment Method', filteredPartyList[index]['paymentMethod']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Transport Details', filteredPartyList[index]['transportDetails']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Payment Received Date', filteredPartyList[index]['paymentReceivedDate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Reason(Notes)', filteredPartyList[index]['reason']),
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
                                          BigText(text: 'Invoice Amount', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontSize: Dimensions.font18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(text: filteredPartyList[index]['invoiceAmount'],),
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
                                          BigText(text: 'Payment Received', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                          BigText(text: '${filteredPartyList[index]['paymentReceived']}',color: AppTheme.primary, size: Dimensions.font18)
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
                                    onPressed: (){},
                                    buttonText: 'View Details',
                                    isBackgroundGradient: false,
                                    backgroundColor: AppTheme.primary,
                                    textSize: Dimensions.font14,
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
