import 'package:d_manager/api/manage_invoice_services.dart';
import 'package:d_manager/api/manage_sell_deals.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/invoice_models/invoice_list_model.dart';
import 'package:d_manager/models/sell_models/get_sell_deal_model.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ClothSellView extends StatefulWidget {
  final int sellID;
  const ClothSellView({Key? key, required this.sellID}) : super(key: key);

  @override
  _ClothSellViewState createState() => _ClothSellViewState();
}

class _ClothSellViewState extends State<ClothSellView> {
  final _controller = ScrollController();
  int totalItems = 0;
  bool isLoadingMore = false;
  List<InvoiceDetail> invoices = [];
  int currentPage = 1;
  bool isFilterApplied = false;
  SellDealDetails sellServices = SellDealDetails();
  var selectedBillRecieved;
  var selectedPaymentPaid;

  String billReceived = 'Yes';
  String paymentPaid = 'Yes';
  bool isLoading = false;
  bool isNetworkAvailable = true;
  Data? clothSellData;
  bool noRecordFound = false;
  ManageInvoiceServices manageInvoiceServices = ManageInvoiceServices();
  @override
  void initState() {
    isLoading = true;
    if (widget.sellID != null) {
      _getSellDetails();
      _loadData(currentPage);
      _controller.addListener(() {
        if (_controller.position.pixels == _controller.position.maxScrollExtent) {
          if (totalItems > invoices.length && !isLoadingMore) {
            currentPage++;
            isLoadingMore = true;
            _loadData(currentPage);
          }
        }
      });
    } else {
      setState(() {
        noRecordFound = true;
        isLoading = false;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
            title: S.of(context).clothSellDealDetails,
            isLoading: isLoading,
            noRecordFound: noRecordFound,
            content: SingleChildScrollView(
              child: clothSellData == null ? Container() : Padding(
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
                                  child: BigText(text: clothSellData!.partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: Dimensions.screenWidth * 0.5,
                                        child: BigText(text: clothSellData!.partyName!, color: AppTheme.primary, size: Dimensions.font16)),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: BigText(text: clothSellData!.firmName![0] ?? '', color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SizedBox(
                                            width: Dimensions.screenWidth * 0.5,
                                            child: SmallText(text: clothSellData!.firmName!, color: AppTheme.black, size: Dimensions.font12)),
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
                                _buildInfoColumn('Deal Date', clothSellData!.sellDate!.toString()),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Cloth Quality', clothSellData!.qualityName ?? 'N/A'),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Rate', '₹${HelperFunctions.formatPrice(clothSellData!.rate.toString())}'),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                _buildInfoColumn('Total Than', clothSellData!.totalThan ?? 'N/A'),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Than Delivered', clothSellData!.thanDelivered ?? 'N/A'),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Than Remaining', clothSellData!.thanRemaining ?? 'N/A'),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                _buildInfoColumn('Due Date', clothSellData!.sellDueDate!.toString()),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Status', clothSellData!.dealStatus! == 'ongoing' ? 'On Going' : 'Completed'),SizedBox(width: Dimensions.width20),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('', ''),
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
                        Text('Invoice List', style: AppTheme.heading2),
                        CustomIconButton(
                            radius: Dimensions.radius10,
                            backgroundColor: AppTheme.primary,
                            iconColor: AppTheme.white,
                            iconData: Icons.add,
                            onPressed: () {
                              Navigator.of(context).pushNamed(AppRoutes.invoiceAdd, arguments: {'sellID': widget.sellID});                            }
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
                            BigText(text: 'Payment Paid', size: Dimensions.font12,),
                            Gap(Dimensions.height10/2),
                            CustomDropdown(
                              dropdownItems: const ['Yes', 'No'],
                              selectedValue: paymentPaid,
                              width: Dimensions.screenWidth * 0.8,
                              onChanged: (newValue) {
                                setState(() {
                                  paymentPaid = newValue!;
                                  selectedPaymentPaid = newValue == 'Yes' ? 'yes' : 'no';
                                  isLoading = true;
                                  invoices.clear();
                                  currentPage = 1;
                                  isFilterApplied = true;
                                  _loadData(currentPage);
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: '', size: Dimensions.font12,),
                            Gap(Dimensions.height10/2),
                            IconButton(
                              tooltip: 'Clear Filter',
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                  invoices.clear();
                                  currentPage = 1;
                                  isFilterApplied = false;
                                  selectedBillRecieved = null;
                                  selectedPaymentPaid = null;
                                  _loadData(currentPage);
                                });
                              },
                              icon: const FaIcon(FontAwesomeIcons.filterCircleXmark, color: AppTheme.black),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                    invoices.isNotEmpty ? SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: invoices.length + 1,
                        itemBuilder: (context, index) {
                          if (index < invoices.length) {
                            var invoice = invoices[index];
                            List<int> thanList = [];
                            List<int> meterList = [];

                            for(var detail in invoice.baleDetails!) {
                              thanList.add(int.parse(detail.than!));
                              meterList.add(int.parse(detail.meter!));
                            }

                            // Calculate Totals
                            int totalThan = thanList.reduce((sum, element) => sum + element);
                            int totalMeter = meterList.reduce((sum, element) => sum + element);
                            return CustomAccordion(
                              titleChild: Row(
                                children: [
                                  _buildInfoColumn('Invoice Date', invoice.invoiceDate.toString()),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Invoice No', invoice.invoiceNumber!),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Total Than', '$totalThan'),
                                ],
                              ),
                              contentChild: Column(
                                children: [
                                  SizedBox(height: Dimensions.height10),
                                  AppTheme.divider,
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    children: [
                                      _buildInfoColumn('Bale Number', '${invoice.baleDetails!.first.baleNumber!} to ${invoice.baleDetails!.last.baleNumber!}'),
                                      SizedBox(width: Dimensions.width20),
                                      _buildInfoColumn('Meter', '$totalMeter'),
                                      SizedBox(width: Dimensions.width20),
                                      _buildInfoColumn('Rate', '₹${HelperFunctions.formatPrice(invoice.rate.toString())}'),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    children: [
                                      _buildInfoColumn('Transport Name', invoice.transportName ?? 'N/A'),
                                      SizedBox(width: Dimensions.width20),
                                      _buildInfoColumn('GST', invoice.gst!),
                                      SizedBox(width: Dimensions.width20),
                                      _buildInfoColumn('Invoice Amount', '₹${HelperFunctions.formatPrice(invoice.invoiceAmount.toString())}' ?? 'N/A'),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    children: [
                                      _buildInfoColumn('Payment Type', invoice.paymentType == 'current' ? 'Current' : 'Dhara'),
                                      SizedBox(width: Dimensions.width20),
                                      _buildInfoColumn('Additional Discount', '${invoice.discount}%' ?? 'N/A'),
                                      SizedBox(width: Dimensions.width20),
                                      _buildInfoColumn('Payment Received', invoice.paidStatus == 'yes' ? 'Yes' : 'No'),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    children: [
                                      _buildInfoColumn('Payment Amount Received', '₹${HelperFunctions.formatPrice(invoice.receivedAmount.toString())}' ?? 'N/A' ),
                                      SizedBox(width: Dimensions.width20),
                                      _buildInfoColumn('Difference in Amount', '₹${HelperFunctions.formatPrice(invoice.differenceAmount.toString())}' ?? 'N/A'),
                                      SizedBox(width: Dimensions.width20),
                                      _buildInfoColumn('Payment Method', invoice.paymentMethod != null ? invoice.paymentMethod == 'rtgs' ? 'RTGS' : 'Cheque' : 'N/A'),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    children: [
                                      _buildInfoColumn('Due Date', invoice.dueDate.toString() ?? 'N/A' ),
                                      SizedBox(width: Dimensions.width20),
                                      _buildInfoColumn('Payment Received Date', invoice.dueDate.toString() ?? 'N/A'),
                                      SizedBox(width: Dimensions.width20),
                                      _buildInfoColumn('Reason', invoice.reason ?? 'N/A'),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(AppRoutes.invoiceView, arguments: {'sellId': widget.sellID, 'invoiceId': invoice.invoiceId});
                                        },
                                        icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(AppRoutes.invoiceAdd, arguments: {'sellID': widget.sellID, 'invoiceID': invoice.invoiceId});
                                        },
                                        icon: const Icon(Icons.edit_outlined, color: AppTheme.primary),
                                      ),
                                      // GFCheckbox(
                                      //   size: Dimensions.height20,
                                      //   type: GFCheckboxType.custom,
                                      //   inactiveBgColor: AppTheme.nearlyWhite,
                                      //   inactiveBorderColor: AppTheme.primary,
                                      //   customBgColor: AppTheme.primary,
                                      //   activeBorderColor: AppTheme.primary,
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       invoice.status = value == true ? 'Active' : 'Inactive';
                                      //     });
                                      //   },
                                      //   value: invoice.status == 'active' ? true : false,
                                      //   inactiveIcon: null,
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ) : Center(child: Column(
                      children: [
                        SizedBox(height: Dimensions.height30),
                        const NoRecordFound(),
                      ],
                    )),
                  ],
                ),
              ),
            )
        )
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    String formattedValue = value;
    if (title.contains('Date') && value != 'N/A' && value != '' && value != null) {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd MMM yy').format(date);
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.grey, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font14),
        ],
      ),
    );
  }

  Future<void> _getSellDetails() async {
    setState(() {
      isLoading = true;
    });
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      GetSellDealModel? dealDetailModel = await sellServices.getSellDealApi(widget.sellID.toString());

      if (dealDetailModel?.message != null) {
        if (dealDetailModel?.success == true) {
          setState(() {
            isLoading = false;
            if (dealDetailModel!.data != null) {
              clothSellData = dealDetailModel.data;
            } else {
              noRecordFound = true;
            }
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
    } else {
      setState(() {
        isLoading = false;
        isNetworkAvailable = false;
      });
    }
  }

  Future<void> _loadData(int pageNo) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        InvoiceListModel? deliveryListModel = await manageInvoiceServices.showInvoiceList(
            widget.sellID.toString(), currentPage.toString(),  selectedPaymentPaid, selectedBillRecieved);

        if (deliveryListModel != null) {
          if (deliveryListModel.success == true) {
            if (deliveryListModel.data != null) {
              if (deliveryListModel.data!.isNotEmpty) {
                if (pageNo == 1) {
                  invoices.clear();
                }

                setState(() {
                  invoices.addAll(deliveryListModel.data!);
                  isLoading = false;
                  noRecordFound = false;
                  totalItems = deliveryListModel.total ?? 0;
                });
              } else {
                setState(() {
                  isLoading = false;
                });
              }
            } else {
              setState(() {
                noRecordFound = true;
              });
            }
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              deliveryListModel.message.toString(),
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
      } else {
        setState(() {
          isNetworkAvailable = false;
        });
      }
    } finally {
      setState(() {
        isLoading = false;
        isLoadingMore = false;
      });
    }
  }
}
