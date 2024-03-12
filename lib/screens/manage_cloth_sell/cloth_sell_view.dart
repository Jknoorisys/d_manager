import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
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
import '../widgets/snackbar.dart';
import 'manage_invoice/invoice_view.dart';
class ClothSellView extends StatefulWidget {
  final int sellID;
  const ClothSellView({Key? key,required this.sellID}) : super(key: key);
  @override
  _ClothSellViewState createState() => _ClothSellViewState();
}

class _ClothSellViewState extends State<ClothSellView> {
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
  bool noRecordFound = false;
  bool isNetworkAvailable = true;
  @override
  void initState() {
    super.initState();
    if (widget.sellID != 0) {
      getSellDealData();
      getInvoiceList(currentPage, searchController.text.trim());
    } else {
      setState(() {
        _isLoading = false;
        noRecordFound = true;
      });
    }
  }

  //await getSellDealData();
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          isLoading:_isLoading,
          noRecordFound: noRecordFound,
          internetNotAvailable: isNetworkAvailable,
          title: S.of(context).clothSellDealDetails,
          content: getSellDealModel?.data! == null ? Container() :  Padding(
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
                          _buildInfoColumn('Rate', '₹ ${getSellDealModel!.data!.rate!}'),
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
                          _buildInfoColumn('Status', getSellDealModel!.data!.dealStatus! == 'ongoing' ? 'Ongoing' : 'Completed'),
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
                          Navigator.of(context).pushNamed(AppRoutes.invoiceAdd, arguments: {'sellID': widget.sellID});
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
                  child: manageInvoiceList.isEmpty ? NoRecordFound() :SmartRefresher(
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
                      child:ListView.builder(
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
                                    Expanded(flex:1,child: _buildInfoColumn('Bale Number', '${manageInvoiceList[index].baleDetails!.first.baleNumber!} - ${manageInvoiceList[index].baleDetails!.last.baleNumber!}')),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Than', '${manageInvoiceList[index].baleDetails!.first.than!} - ${manageInvoiceList[index].baleDetails!.last.than!}')),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Meter', '${manageInvoiceList[index].baleDetails!.first.meter!} - ${manageInvoiceList[index].baleDetails!.last.meter!}')),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Transport Name', manageInvoiceList[index].transportName!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('GST', manageInvoiceList[index].gst!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Invoice Amount', manageInvoiceList[index].invoiceAmount!)),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Payment Type', manageInvoiceList[index].paymentType!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Additional Discount', manageInvoiceList[index].discount!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Payment Received', manageInvoiceList[index].receivedAmount!)),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Payment Amount Received', manageInvoiceList[index].receivedAmount!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Difference in Amount', manageInvoiceList[index].differenceAmount!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Payment Method', manageInvoiceList[index].differenceAmount!)),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Due Date', manageInvoiceList[index].dueDate.toString())),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Payment Received Date', manageInvoiceList[index].dueDate.toString())),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Reason', manageInvoiceList[index].invoiceNumber!)),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('View PDF', manageInvoiceList[index].invoiceNumber!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Status', manageInvoiceList[index].status!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('', '')),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRoutes.invoiceView, arguments: {'sellId': widget.sellID, 'invoiceId': manageInvoiceList[index].invoiceId});
                                      },
                                      icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRoutes.invoiceAdd, arguments: {'sellID': widget.sellID, 'invoiceID': manageInvoiceList[index].invoiceId});
                                      },
                                      icon: const Icon(Icons.edit_outlined, color: AppTheme.primary),
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
                                          manageInvoiceList[index].status = value == true ? 'Completed' : 'On Going';
                                        });
                                      },
                                      value: manageInvoiceList[index].status == 'completed' ? true : false,
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
      _isLoading = true;
    });
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        GetSellDealModel? model = await sellDealDetails.getSellDealApi(
            widget.sellID.toString());
        if (model!.success == true) {
          setState(() {
            if (model.data != null) {
              getSellDealModel = model;
            } else {
              noRecordFound = true;
            }
          });
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            'Something went wrong, please try again later.',
            mode: SnackbarMode.error,
          );
        }
      }else {
        setState(() {
          isNetworkAvailable = false;
        });
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
      if(await HelperFunctions.isPossiblyNetworkAvailable()) {
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
        }
      } else {
        setState(() {
          isNetworkAvailable = false;
        });
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

