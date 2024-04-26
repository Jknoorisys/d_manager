import 'package:d_manager/api/manage_delivery_services.dart';
import 'package:d_manager/api/manage_purchase_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/delivery_models/DeliveryListModel.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class YarnPurchaseView extends StatefulWidget {
  final String purchaseId;
  const YarnPurchaseView({Key? key, required this.purchaseId}) : super(key: key);

  @override
  _YarnPurchaseViewState createState() => _YarnPurchaseViewState();
}

class _YarnPurchaseViewState extends State<YarnPurchaseView> {

  final _controller = ScrollController();
  int totalItems = 0;
  bool isLoadingMore = false;
  List<DeliveryDetails> deliveries = [];
  int currentPage = 1;
  bool isFilterApplied = false;
  ManagePurchaseServices purchaseServices = ManagePurchaseServices();
  var selectedBillRecieved;
  var selectedPaymentPaid;

  String billReceived = 'Yes'; 
  String paymentPaid = 'Yes';
  bool isLoading = false;
  bool isNetworkAvailable = true;
  Data? yarnPurchaseData;
  bool noRecordFound = false;
  ManageDeliveryServices deliveryServices = ManageDeliveryServices();
  @override
  void initState() {
    isLoading = true;
    if (widget.purchaseId != null) {
      _getPurchaseDetails();
      _loadData(currentPage);
      _controller.addListener(() {
        if (_controller.position.pixels == _controller.position.maxScrollExtent) {
          if (totalItems > deliveries.length && !isLoadingMore) {
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
          title: S.of(context).yarnPurchaseDealDetails,
          isLoading: isLoading,
          noRecordFound: noRecordFound,
          content: SingleChildScrollView(
            child: yarnPurchaseData == null ? Container() : Padding(
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
                                  SizedBox(
                                    width: Dimensions.screenWidth * 0.5,
                                      child: BigText(text: yarnPurchaseData!.partyName!, color: AppTheme.primary, size: Dimensions.font16)),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppTheme.black,
                                        radius: Dimensions.height10,
                                        child: BigText(text: yarnPurchaseData!.firmName![0] ?? '', color: AppTheme.secondaryLight, size: Dimensions.font12),
                                      ),
                                      SizedBox(width: Dimensions.width10),
                                      SizedBox(
                                          width: Dimensions.screenWidth * 0.5,
                                          child: SmallText(text: yarnPurchaseData!.firmName!, color: AppTheme.black, size: Dimensions.font12)),
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
                              _buildInfoColumn('Payment Type', yarnPurchaseData!.paymentType! == 'current' ? 'Current' : 'Dhara'),
                              // _buildInfoColumn('Yarn Name', yarnPurchaseData!['yarnName']),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Yarn Type', yarnPurchaseData!.typeName ?? 'N/A'),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              _buildInfoColumn('Yarn Name', yarnPurchaseData!.yarnName ?? 'N/A'),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Lot Number', yarnPurchaseData!.lotNumber ?? 'N/A'),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Cops', yarnPurchaseData!.cops!),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              _buildInfoColumn('Gross Ordered', yarnPurchaseData!.grossWeight ?? 'N/A'),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Gross Received', yarnPurchaseData!.grossReceivedWeight ?? 'N/A'),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Gross Remaining', (double.parse(yarnPurchaseData!.grossWeight ?? 'N/A') - double.parse(yarnPurchaseData!.grossReceivedWeight!)).toString()),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              _buildInfoColumn('Deiner', yarnPurchaseData!.denier ?? 'N/A'),
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
                                              text: ' Kg',
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
                                      BigText(text: '₹ ${HelperFunctions.formatPrice(yarnPurchaseData!.rate.toString())}',color: AppTheme.primary, size: Dimensions.font18)
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
                            Navigator.of(context).pushNamed(AppRoutes.deliveryDetailAdd, arguments: {'purchaseID': widget.purchaseId});
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
                                selectedBillRecieved = newValue == 'Yes' ? 'yes' : 'no';
                                isLoading = true;
                                deliveries.clear();
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
                          BigText(text: 'Payment Paid', size: Dimensions.font12,),
                          Gap(Dimensions.height10/2),
                          CustomDropdown(
                            dropdownItems: const ['Yes', 'No'],
                            selectedValue: paymentPaid,
                            onChanged: (newValue) {
                              setState(() {
                                paymentPaid = newValue!;
                                selectedPaymentPaid = newValue == 'Yes' ? 'yes' : 'no';
                                isLoading = true;
                                deliveries.clear();
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
                                  deliveries.clear();
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
                  (deliveries.isEmpty && isLoading == false) ? Center(child: Column(
                    children: [
                      SizedBox(height: Dimensions.height30),
                      const NoRecordFound(),
                    ],
                  )) : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: deliveries.length + 1,
                      itemBuilder: (context, index) {
                        if (index < deliveries.length) {
                          var delivery = deliveries[index];
                          return CustomAccordion(
                            titleChild: Row(
                              children: [
                                _buildInfoColumn('Delivery Date', delivery.deliveryDate!.toString().split(' ')[0]),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Payment Type', delivery.paymentType! == 'current' ? 'Current' : 'Dhara'),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Payment Method', delivery.paymentMethod == null ? 'N/A' : delivery.paymentMethod!),
                              ],
                            ),
                            contentChild: Column(
                              children: [
                                SizedBox(height: Dimensions.height10),
                                AppTheme.divider,
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    _buildInfoColumn('Paid Date', delivery.paymentDate == null ? 'N/A' : delivery.paymentDate!.toString().split(' ')[0]),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Amount Paid', '₹${HelperFunctions.formatPrice(delivery.paidAmount.toString())}'),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Bill Amount', '₹${HelperFunctions.formatPrice(delivery.purchaseAmount.toString())}'),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    _buildInfoColumn('GST', '₹${HelperFunctions.formatPrice(delivery.gstBillAmount.toString())}'),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Due Date', delivery.paymentDueDate != null ? delivery.paymentDueDate!.toString().split(' ')[0] : 'N/A'),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Dhara Days', delivery.dharaDays ?? 'N/A'),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    _buildInfoColumn('Denier', delivery.denier ?? 'N/A'),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Cops', delivery.cops ?? 'N/A'),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('Net Weight', delivery.netWeight ?? 'N/A'),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    _buildInfoColumn('Payment Notes', delivery.paymentNotes == null ? 'N/A' : delivery.paymentNotes!),
                                    SizedBox(width: Dimensions.width20),
                                    _buildInfoColumn('', ''),
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
                                            BigText(text: 'Net Weight (ton)', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: AppTheme.primary,
                                                  fontSize: Dimensions.font18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: delivery.netWeight!,
                                                  ),
                                                  TextSpan(
                                                    text: ' Kg',
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
                                            BigText(text: '₹ ${HelperFunctions.formatPrice(yarnPurchaseData!.rate.toString())}',color: AppTheme.primary, size: Dimensions.font18)
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
                                        Navigator.of(context).pushNamed(AppRoutes.deliveryDetailView, arguments: {'purchaseID' : widget.purchaseId, 'deliveryID': delivery.purchaseDeliveryId.toString()});
                                      },
                                      icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRoutes.deliveryDetailAdd, arguments: {'purchaseID': widget.purchaseId, 'deliveryID': delivery.purchaseDeliveryId.toString()});
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
                                    //       deliveryDetailList[index]['status'] = value == true ? 'Completed' : 'On Going';
                                    //     });
                                    //   },
                                    //   value: deliveryDetailList[index]['status'] == 'Completed' ? true : false,
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
                  ),
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

  Future<void> _getPurchaseDetails() async {
    setState(() {
      isLoading = true;
    });
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      YarnPurchaseDetailModel? dealDetailModel = await purchaseServices.viewPurchase(int.parse(widget.purchaseId));

      if (dealDetailModel?.message != null) {
        if (dealDetailModel?.success == true) {
          setState(() {
            isLoading = false;
            if (dealDetailModel!.data != null) {
              yarnPurchaseData = dealDetailModel.data;
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
        DeliveryListModel? deliveryListModel = await deliveryServices.deliveryList(
            pageNo, widget.purchaseId, selectedPaymentPaid, selectedBillRecieved);

        if (deliveryListModel != null) {
          if (deliveryListModel.success == true) {
            if (deliveryListModel.data != null) {
              if (deliveryListModel.data!.isNotEmpty) {
                if (pageNo == 1) {
                  deliveries.clear();
                }

                setState(() {
                  deliveries.addAll(deliveryListModel.data!);
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

