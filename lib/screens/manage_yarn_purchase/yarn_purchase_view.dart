import 'package:d_manager/api/manage_purchase_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/models/yarn_purchase_models/yarn_purchase_detail_model.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class YarnPurchaseView extends StatefulWidget {
  final String purchaseId;
  const YarnPurchaseView({Key? key, required this.purchaseId}) : super(key: key);

  @override
  _YarnPurchaseViewState createState() => _YarnPurchaseViewState();
}

class _YarnPurchaseViewState extends State<YarnPurchaseView> {
  String billReceived = 'Yes'; 
  String paymentPaid = 'Yes';
  bool isLoading = false;
  Data? yarnPurchaseData;
  bool noRecordFound = true;

  ManagePurchaseServices purchaseServices = ManagePurchaseServices();

  List<Map<String, dynamic>> deliveryDetailList = [
    {'no': 1, 'dealDate': '2024-01-25', 'paymentType': 'Current', 'paymentMethod': 'Cheque', 'boxReceived': '500', 'grossWeight': '4950', 'rate': '25', 'billAmount': '123750', 'GST': '18562.5', 'dueDate': '2024-02-10', 'paid': false, 'paidDate': '2024-02-05', 'amountPaid': '0', 'differenceInAmount': '0', 'cops': '2000', 'denyar': '30', 'billReceived': false, 'viewPDF': 'sample.pdf', 'status': 'On Going'},
    {'no': 2, 'dealDate': '2024-01-26', 'paymentType': 'Dhara', 'paymentMethod': 'RTGS', 'boxReceived': '400', 'grossWeight': '4950', 'rate': '25', 'billAmount': '123750', 'GST': '18562.5', 'dueDate': '2024-02-12', 'paid': true, 'paidDate': '2024-02-05', 'amountPaid': '123750', 'differenceInAmount': '0', 'cops': '2000', 'denyar': '30', 'billReceived': true, 'viewPDF': 'sample.pdf', 'status': 'On Going'},
    {'no': 3, 'dealDate': '2024-01-27', 'paymentType': 'Current', 'paymentMethod': 'RTGS', 'boxReceived': '650', 'grossWeight': '4950', 'rate': '25', 'billAmount': '123750', 'GST': '18562.5', 'dueDate': '2024-02-15', 'paid': false, 'paidDate': '2024-02-05', 'amountPaid': '0', 'differenceInAmount': '0', 'cops': '2000', 'denyar': '30', 'billReceived': false, 'viewPDF': 'sample.pdf', 'status': 'Completed'},
    {'no': 4, 'dealDate': '2024-01-28', 'paymentType': 'Dhara', 'paymentMethod': 'Cheque', 'boxReceived': '550', 'grossWeight': '4950', 'rate': '25', 'billAmount': '123750', 'GST': '18562.5', 'dueDate': '2024-02-18', 'paid': true, 'paidDate': '2024-02-10', 'amountPaid': '123750', 'differenceInAmount': '0', 'cops': '2000', 'denyar': '30', 'billReceived': true, 'viewPDF': 'invoice.pdf', 'status': 'On Going'},
    {'no': 5, 'dealDate': '2024-01-29', 'paymentType': 'Current', 'paymentMethod': 'RTGS', 'boxReceived': '600', 'grossWeight': '4950', 'rate': '25', 'billAmount': '123750', 'GST': '18562.5', 'dueDate': '2024-02-20', 'paid': false, 'paidDate': '2024-02-05', 'amountPaid': '0', 'differenceInAmount': '0', 'cops': '2000', 'denyar': '30', 'billReceived': false, 'viewPDF': 'sample.pdf', 'status': 'On Going'},
  ];

  @override
  void initState() {
    isLoading = true;
    _getPurchaseDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          title: S.of(context).yarnPurchaseDealDetails,
          isLoading: isLoading,
          noRecordFound: noRecordFound,
          content: SingleChildScrollView(
            child: yarnPurchaseData == null ? const NoRecordFound() : Padding(
              padding: EdgeInsets.only(left: Dimensions.height10, right: Dimensions.height10, bottom: Dimensions.height20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 10,
                    color: AppTheme.white,
                    shadowColor: AppTheme.nearlyWhite,
                    surfaceTintColor: AppTheme.nearlyWhite,
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.height15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: Dimensions.width10),
                              CircleAvatar(
                                backgroundColor: AppTheme.secondary,
                                radius: Dimensions.height20,
                                child: BigText(text: yarnPurchaseData!.partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                              ),
                              SizedBox(width: Dimensions.height10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BigText(text: yarnPurchaseData!.partyName!, color: AppTheme.primary, size: Dimensions.font16),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppTheme.black,
                                        radius: Dimensions.height10,
                                        child: BigText(text: yarnPurchaseData!.firmName![0] ?? '', color: AppTheme.secondaryLight, size: Dimensions.font12),
                                      ),
                                      SizedBox(width: Dimensions.width10),
                                      SmallText(text: yarnPurchaseData!.firmName!, color: AppTheme.black, size: Dimensions.font12),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          AppTheme.divider,
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              _buildInfoColumn('Deal Date', yarnPurchaseData!.purchaseDate!.toString().split(' ')[0]),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Payment Type', yarnPurchaseData!.paymentType!.toUpperCase()),
                              // _buildInfoColumn('Yarn Name', yarnPurchaseData!['yarnName']),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Yarn Type', yarnPurchaseData!.typeName!),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              _buildInfoColumn('Yarn Name', yarnPurchaseData!.yarnName!),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Lot Number', yarnPurchaseData!.lotNumber!),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Box Ordered', yarnPurchaseData!.orderedBoxCount!),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              _buildInfoColumn('Gross Received', yarnPurchaseData!.grossReceivedWeight!),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Gross Remaining', (double.parse(yarnPurchaseData!.grossWeight!) - double.parse(yarnPurchaseData!.grossReceivedWeight!)).toString()),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Cops', yarnPurchaseData!.cops!),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              _buildInfoColumn('Deiner', yarnPurchaseData!.denier!),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Status', yarnPurchaseData!.dealStatus! == 'completed' ? 'Completed' : 'On Going'),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('', ''),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width/2.65,
                                  height: Dimensions.height40*2.5,
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
                                              text: yarnPurchaseData!.netWeight!,
                                            ),
                                            TextSpan(
                                              text: ' ton',
                                              style: TextStyle(
                                                fontSize: Dimensions.font12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      BigText(text: 'Gross Weight\n ${yarnPurchaseData!.grossWeight} ton', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                    ],
                                  )
                              ),
                              SizedBox(width: Dimensions.width20),
                              Container(
                                  width: MediaQuery.of(context).size.width/2.65,
                                  height: Dimensions.height40*2.5,
                                  padding: EdgeInsets.all(Dimensions.height10),
                                  decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                    border: Border.all(color: AppTheme.primary),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BigText(text: 'Rate', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                      BigText(text: '₹ ${yarnPurchaseData!.rate}',color: AppTheme.primary, size: Dimensions.font18)
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Details List', style: AppTheme.heading2),
                      CustomIconButton(
                          radius: Dimensions.radius10,
                          backgroundColor: AppTheme.primary,
                          iconColor: AppTheme.white,
                          iconData: Icons.add,
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.deliveryDetailAdd);
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
                          ),
                        ],
                      ),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView.builder(
                      itemCount: deliveryDetailList.length,
                      itemBuilder: (context, index) {
                        return CustomAccordion(
                          titleChild: Row(
                            children: [
                              _buildInfoColumn('Delivery Date', deliveryDetailList[index]['dealDate']),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Payment Type', deliveryDetailList[index]['paymentType']),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Payment Method', deliveryDetailList[index]['paymentMethod']),
                            ],
                          ),
                          contentChild: Column(
                            children: [
                              SizedBox(height: Dimensions.height10),
                              AppTheme.divider,
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Box Ordered', yarnPurchaseData!.orderedBoxCount!),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Box Received', deliveryDetailList[index]['boxReceived']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Box Remaining', yarnPurchaseData!.deliveredBoxCount!),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('Paid Date', deliveryDetailList[index]['paidDate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Amount Paid', deliveryDetailList[index]['amountPaid']),
                                  // SizedBox(width: Dimensions.width20),
                                  // _buildInfoColumn('Rate', deliveryDetailList[index]['rate']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Bill Amount', deliveryDetailList[index]['billAmount']),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  _buildInfoColumn('GST', deliveryDetailList[index]['GST']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Due Date', deliveryDetailList[index]['dueDate']),
                                   SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Difference In Amount', deliveryDetailList[index]['differenceInAmount']),
                                  // _buildInfoColumn('Paid', deliveryDetailList[index]['paid'] == true ? 'Yes' : 'No'),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  // _buildInfoColumn('Paid Date', deliveryDetailList[index]['paidDate']),
                                  // SizedBox(width: Dimensions.width20),
                                  // _buildInfoColumn('Amount Paid', deliveryDetailList[index]['amountPaid']),
                                  // SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Denyar', deliveryDetailList[index]['denyar']),
                                   SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Cops', deliveryDetailList[index]['cops']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Net Weight', '${deliveryDetailList[index]['netWeight']} Kg'),
                                  // _buildInfoColumn('Bill Received', deliveryDetailList[index]['billReceived'] == true ? 'Yes' : 'No'),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  // _buildInfoColumn('Cops', deliveryDetailList[index]['cops']),
                                  // SizedBox(width: Dimensions.width20),
                                  // _buildInfoColumn('Denyar', deliveryDetailList[index]['denyar']),
                                  // SizedBox(width: Dimensions.width20),
                                  // _buildInfoColumn('Bill Received', deliveryDetailList[index]['billReceived'] == true ? 'Yes' : 'No'),
                                  _buildInfoColumn('View PDF', deliveryDetailList[index]['viewPDF']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Status', deliveryDetailList[index]['status']),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('', ''),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  // _buildInfoColumn('View PDF', deliveryDetailList[index]['viewPDF']),
                                  // // SizedBox(width: Dimensions.width20),
                                  // _buildInfoColumn('Status', deliveryDetailList[index]['status']),
                                  // SizedBox(width: Dimensions.width20),
                                  // _buildInfoColumn('', ''),
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
                                          BigText(text: 'Gross wt (ton)', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontSize: Dimensions.font18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: deliveryDetailList[index]['netWeight'],
                                                ),
                                                TextSpan(
                                                  text: ' kg',
                                                  style: TextStyle(
                                                    fontSize: Dimensions.font12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          BigText(text: 'Gross Weight ${yarnPurchaseData!.grossWeight!} ton', color: AppTheme.nearlyBlack, size: Dimensions.font12),
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
                                          BigText(text: 'Rate', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                          BigText(text: '₹ ${yarnPurchaseData!.rate!}',color: AppTheme.primary, size: Dimensions.font18)
                                        ],
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(AppRoutes.deliveryDetailView, arguments: {'deliveryDetailData': deliveryDetailList[index]});
                                    },
                                    icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(AppRoutes.deliveryDetailAdd, arguments: {'deliveryDetailData': deliveryDetailList[index]});
                                    },
                                    icon: const Icon(Icons.edit_outlined, color: AppTheme.primary),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        deliveryDetailList.removeAt(index);
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
                                        deliveryDetailList[index]['status'] = value == true ? 'Completed' : 'On Going';
                                      });
                                    },
                                    value: deliveryDetailList[index]['status'] == 'Completed' ? true : false,
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

  Future<void> _getPurchaseDetails() async {
    setState(() {
      isLoading = true;
    });
    YarnPurchaseDetailModel? dealDetailModel = await purchaseServices.viewPurchase(int.parse(widget.purchaseId));

    if (dealDetailModel?.message != null) {
      if (dealDetailModel?.success == true) {
        setState(() {
          isLoading = false;
          yarnPurchaseData = dealDetailModel!.data;
          noRecordFound = false;
        });
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          dealDetailModel!.message.toString(),
          mode: SnackbarMode.error,
        );
      }
    } else {
      CustomApiSnackbar.show(
        context,
        'Error',
        'Something went wrong, please try again',
        mode: SnackbarMode.error,
      );
    }
  }
}

