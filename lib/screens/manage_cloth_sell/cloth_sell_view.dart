import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
class ClothSellView extends StatefulWidget {
  final Map<String, dynamic>? clothSellData;
  const ClothSellView({Key? key, this.clothSellData}) : super(key: key);
  @override
  _ClothSellViewState createState() => _ClothSellViewState();
}

class _ClothSellViewState extends State<ClothSellView> {
  List<Map<String, dynamic>> unFilteredClothSellList = [
    {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Mahesh Textiles','clothQuality':'5 - Kilo','totalThan':'500','thanDelivered':'100','thanRemaining':'400','rate':'20.10', 'status': 'Ongoing'},
  ];

  List<Map<String, dynamic>> invoiceDataList = [
    {'no': 1,
      'invoiceDate': '2024-01-25',
      'invoiceNumber': '24-25_10',
      'rate': '20.10',
      'baleNumber': '1-10',
      'than': '80',
      'meter': '191.90',
      'clothQuality': '5-kilo',
      'gst': '12%',
      'invoiceAmount': '10,80,000',
      'paymentType': 'Current',
      'additionalDiscount': '1000',
      'paymentReceived': 'Yes',
      'paymentAmountReceived': '10,00,000',
      'differenceInAmount': '3000',
      'paymentMethod': 'Chque',
      'dueDate': '2024-01-29',
      'paymentReceivedDate': '2024-01-27',
      'reason': 'XYZ',
      'viewPDF': 'sample.pdf',
      'status': 'On Going'
    },
    {'no': 2,
      'invoiceDate': '2024-01-25',
      'invoiceNumber': '24-25_11',
      'rate': '20.10',
      'baleNumber': '1-10',
      'than': '80',
      'meter': '191.90',
      'clothQuality': '5-kilo',
      'gst': '12%',
      'invoiceAmount': '10,80,000',
      'paymentType': 'Current',
      'additionalDiscount': '1000',
      'paymentReceived': 'Yes',
      'paymentAmountReceived': '10,00,000',
      'differenceInAmount': '3000',
      'paymentMethod': 'Chque',
      'dueDate': '2024-01-29',
      'paymentReceivedDate': '2024-01-27',
      'reason': 'XYZ',
      'viewPDF': 'sample.pdf',
      'status': 'On Going'
    },
  ];

  List<Map<String, dynamic>> invoicesList = [];
  String billReceived = 'Yes';
  String paymentPaid = 'Yes';


  @override
  void initState() {
    super.initState();
    invoicesList = invoiceDataList;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> clothSellData = unFilteredClothSellList.first;
    return CustomDrawer(
        content: CustomBody(
          title: S.of(context).clothSellDealDetails,
          content: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.height10, right: Dimensions.height10, bottom: Dimensions.height20),
              child: Column(
                children: [
                  CustomAccordionWithoutExpanded(
                    titleChild: Column(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: Dimensions.width10),
                                CircleAvatar(
                                  backgroundColor: AppTheme.secondary,
                                  radius: Dimensions.height20,
                                  child: BigText(text: clothSellData['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BigText(text: clothSellData['partyName'], color: AppTheme.primary, size: Dimensions.font16),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: BigText(text: clothSellData['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SmallText(text: clothSellData['myFirm'], color: AppTheme.black, size: Dimensions.font12),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        AppTheme.divider,
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Deal Date', clothSellData['dealDate']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Cloth Quality', clothSellData['clothQuality']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Rate', clothSellData['rate']),
                          ],
                        ),
                      ],
                    ),
                    contentChild: Column(
                      children: [
                        Row(
                          children: [
                            _buildInfoColumn('Total Than', clothSellData['totalThan']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Than Delivered', clothSellData['thanDelivered']),
                            SizedBox(width: Dimensions.width20),
                            _buildInfoColumn('Than Remaining', clothSellData['thanRemaining']),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            _buildInfoColumn('Status', clothSellData['status']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Invoice List', style: AppTheme.heading2),
                      CustomIconButton(
                          radius: Dimensions.radius10,
                          backgroundColor: AppTheme.primary,
                          iconColor: AppTheme.white,
                          iconData: Icons.add,
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.invoiceAdd);
                          }
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  AppTheme.divider,
                  SizedBox(height: Dimensions.height10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'Bill Received', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomDropdown(
                            dropdownItems: const ['Yes', 'No'],
                            selectedValue: billReceived,
                            onChanged: (newValue) {
                              setState(() {
                                billReceived = newValue!;
                              });
                            },
                            width: Dimensions.height30 * 3,
                          ),
                        ],
                      ),
                      SizedBox(width: Dimensions.width20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'Payment Paid', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomDropdown(
                            dropdownItems: const ['Yes', 'No'],
                            selectedValue: paymentPaid,
                            onChanged: (newValue) {
                              setState(() {
                                paymentPaid = newValue!;
                              });
                            },
                            width: Dimensions.height30 * 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView.builder(
                      itemCount: invoicesList.length,
                      itemBuilder: (context, index) {
                        return CustomAccordion(
                          titleChild: Row(
                            children: [
                              _buildInfoColumn('Invoice Date', invoiceDataList[index]['invoiceDate']),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Invoice No', invoiceDataList[index]['invoiceNumber']),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Rate', invoiceDataList[index]['rate']),
                            ],
                          ),
                          contentChild: Column(
                            children: [
                              AppTheme.divider,
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Bale Number', invoiceDataList[index]['baleNumber']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Than', invoiceDataList[index]['than']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Meter', invoiceDataList[index]['meter']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Cloth Quality', invoiceDataList[index]['clothQuality']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('GST', invoiceDataList[index]['gst']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Invoice Amount', invoiceDataList[index]['invoiceAmount']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Payment Type', invoiceDataList[index]['paymentType']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Additional Discount', invoiceDataList[index]['additionalDiscount']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Payment Received', invoiceDataList[index]['paymentReceived']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Payment Amount Received', invoiceDataList[index]['paymentAmountReceived']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Difference in Amount', invoiceDataList[index]['differenceInAmount']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Payment Method', invoiceDataList[index]['paymentMethod']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Due Date', invoiceDataList[index]['dueDate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Payment Received Date', invoiceDataList[index]['paymentReceivedDate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Reason', invoiceDataList[index]['reason']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('View PDF', 'viewPDF'),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Status', 'status'),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('', ''),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      //Navigator.of(context).pushNamed(AppRoutes.yarnPurchaseView, arguments: {'yarnPurchaseData': unfilteredDeliveryDetailList[index]});
                                    },
                                    icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      //Navigator.of(context).pushNamed(AppRoutes.yarnPurchaseAdd, arguments: {'yarnPurchaseData': unfilteredDeliveryDetailList[index]});
                                    },
                                    icon: const Icon(Icons.edit_outlined, color: AppTheme.primary),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        //unfilteredDeliveryDetailList.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.delete_outline, color: AppTheme.primary),
                                  ),
                                  GFCheckbox(
                                    size: Dimensions.height20,
                                    type: GFCheckboxType.custom,
                                    inactiveBgColor: AppTheme.nearlyWhite,
                                    inactiveBorderColor: AppTheme.primary,
                                    customBgColor: AppTheme.primary,
                                    activeBorderColor: AppTheme.primary,
                                    onChanged: (value) {
                                      setState(() {
                                        invoiceDataList[index]['status'] = value == true ? 'Completed' : 'On Going';
                                      });
                                    },
                                    value: invoiceDataList[index]['status'] == 'Completed' ? true : false,
                                    inactiveIcon: null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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

