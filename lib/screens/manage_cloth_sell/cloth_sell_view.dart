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
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../api/manage_invoice_services.dart';
import '../../api/manage_sell_deals.dart';
import '../../helpers/helper_functions.dart';
import '../../models/invoice_models/invoice_list_model.dart';
import '../../models/sell_models/get_sell_deal_model.dart';
import '../../models/sell_models/sell_deal_list_model.dart';
import '../widgets/snackbar.dart';
import 'manage_invoice/invoice_view.dart';
class ClothSellView extends StatefulWidget {
  final int sellID;
  const ClothSellView({Key? key,required this.sellID}) : super(key: key);
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
  final RefreshController _refreshController = RefreshController();
  final searchController = TextEditingController();
  int currentPage = 1;
  bool _isLoading = true;
  List<Map<String, dynamic>> invoicesList = [];
  List<invoiceList> manageInvoiceList = [];
  String billReceived = 'Yes';
  String paymentPaid = 'Yes';
  SellDealDetails sellDealDetails = SellDealDetails();
  ManageInvoiceServices manageInvoiceServices = ManageInvoiceServices();
  GetSellDealModel? getSellDealModel;
  @override
  void initState() {
    super.initState();
    getSellDealData();
    getInvoiceList(currentPage, searchController.text.trim());
  }

  Future<void> handleViewDeal()async{
    if (HelperFunctions.checkInternet() == false) {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No internet connection',
        mode: SnackbarMode.warning,
      );
    } else{
      await getSellDealData();
    }
  }

  //await getSellDealData();
  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> clothSellData = unFilteredClothSellList.first;
    return CustomDrawer(
        content: CustomBody(
          isLoading:_isLoading,
          title: S.of(context).clothSellDealDetails,
          content: _isLoading ? Container() : Padding(
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
                                child: BigText(text: getSellDealModel!.data!.partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                              ),
                              SizedBox(width: Dimensions.height10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BigText(text: getSellDealModel!.data!.partyName!, color: AppTheme.primary, size: Dimensions.font16),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppTheme.black,
                                        radius: Dimensions.height10,
                                        child: BigText(text: getSellDealModel!.data!.firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                      ),
                                      SizedBox(width: Dimensions.width10),
                                      SmallText(text: getSellDealModel!.data!.firmName!, color: AppTheme.black, size: Dimensions.font12),
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
                          _buildInfoColumn('Deal Date', getSellDealModel!.data!.sellDate!.toString()),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Cloth Quality', getSellDealModel!.data!.qualityName!),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Rate', getSellDealModel!.data!.rate!),
                        ],
                      ),
                    ],
                  ),
                  contentChild: Column(
                    children: [
                      Row(
                        children: [
                          _buildInfoColumn('Total Than', getSellDealModel!.data!.totalThan!),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Than Delivered', getSellDealModel!.data!.thanDelivered!),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Than Remaining', getSellDealModel!.data!.thanRemaining!),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          _buildInfoColumn('Status', getSellDealModel!.data!.dealStatus!),
                          SizedBox(width: Dimensions.width20),
                          _buildInfoColumn('Due Date', getSellDealModel!.data!.sellDueDate!.toString()),
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
                Expanded(
                  child: manageInvoiceList.isEmpty
                      ? Center(
                    child: Text(
                      'No Data Found',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                      :SmartRefresher(
                    enablePullUp: true,
                    controller: _refreshController,
                    onRefresh: () async {
                      setState(() {
                        manageInvoiceList.clear();
                        currentPage = 1;
                      });
                      getInvoiceList(currentPage, searchController.text.trim());
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      getInvoiceList(currentPage, searchController.text.trim());
                      _refreshController.loadComplete();
                    },
                    child:
                    Expanded(
                      child: ListView.builder(
                        itemCount: manageInvoiceList.length,
                        itemBuilder: (context, index) {
                          return CustomAccordion(
                            titleChild: Row(
                              children: [
                                Expanded(flex:1,child: _buildInfoColumn('Invoice Date', manageInvoiceList[index].invoiceDate.toString())),
                                SizedBox(width: Dimensions.width20),
                                Expanded(flex:1,child: _buildInfoColumn('Invoice No', manageInvoiceList[index].invoiceNumber!)),
                                SizedBox(width: Dimensions.width20),
                                Expanded(flex:1,child: _buildInfoColumn('Rate', '₹ ${manageInvoiceList[index].rate!}')),
                              ],
                            ),
                            contentChild: Column(
                              children: [
                                AppTheme.divider,
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    _buildInfoColumn('Bale Number', manageInvoiceList[index].baleDetails![index].baleNumber!),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Than', manageInvoiceList[index].baleDetails![index].than!),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Meter', manageInvoiceList[index].baleDetails![index].meter!),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    _buildInfoColumn('Transport Name', manageInvoiceList[index].transportName!),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('GST', manageInvoiceList[index].gst!),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Invoice Amount', manageInvoiceList[index].invoiceAmount!),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    _buildInfoColumn('Payment Type', manageInvoiceList[index].paymentType!),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Additional Discount', manageInvoiceList[index].discount!),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Payment Received', manageInvoiceList[index].receivedAmount!),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    _buildInfoColumn('Payment Amount Received', manageInvoiceList[index].receivedAmount!),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Difference in Amount', manageInvoiceList[index].differenceAmount!),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Payment Method', manageInvoiceList[index].differenceAmount!),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    _buildInfoColumn('Due Date', manageInvoiceList[index].dueDate.toString()),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Payment Received Date', manageInvoiceList[index].dueDate.toString()),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Reason', manageInvoiceList[index].invoiceNumber!),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    _buildInfoColumn('View PDF', manageInvoiceList[index].invoiceNumber!),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Status', manageInvoiceList[index].status!),
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
                                        // Navigator.of(context).pushNamed(AppRoutes.invoiceView, arguments: {'invoiceData': invoiceDataList[index]});
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            InvoiceView( invoiceId: manageInvoiceList[index].invoiceId!,
                                            sellId:manageInvoiceList[index].sellId.toString())));
                                      },
                                      icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRoutes.invoiceAdd, arguments: {'invoiceData': invoiceDataList[index]});
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
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
  Widget _buildInfoColumn(String title, String value) {
    String formattedValue = value;
    if (title == 'Invoice Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }else if (title == 'Due Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }else if (title == 'Payment Received Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }else if (title == 'Deal Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }
    return Container(
      width: MediaQuery.of(context).size.width / 3.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.nearlyBlack, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font12),
        ],
      ),
    );
  }
  Future<GetSellDealModel?> getSellDealData() async {
    setState(() {
      _isLoading = true; // Show loader before making API call
    });
    try {
      GetSellDealModel? model = await sellDealDetails.getSellDealApi(
          widget.sellID.toString());
      if (model!.success == true) {
        setState(() {
        getSellDealModel = model;
      });
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again later.',
          mode: SnackbarMode.error,
        );
      }
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  Future<InvoiceListModel?> getInvoiceList(int pageNo, String search) async {
    setState(() {
      _isLoading = true;
    });
    try {
      InvoiceListModel? model = await manageInvoiceServices.showInvoiceList(
        widget.sellID.toString(),
        pageNo.toString(),
        search,
      );
      if (model != null) {
        if (model.success == true) {
          if (model.data!.isNotEmpty) {
            if (pageNo == 1) {
              manageInvoiceList.clear();
            }
            setState(() {
              manageInvoiceList.addAll(model.data!);
              currentPage++;
            });
          } else {
             _refreshController.loadNoData();
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            model.message.toString(),
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

