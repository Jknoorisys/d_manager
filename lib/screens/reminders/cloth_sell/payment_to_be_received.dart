import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../api/manage_yarn_reminder_services.dart';
import '../../../generated/l10n.dart';
import '../../../helpers/helper_functions.dart';
import '../../../models/reminder_models/payment_to_be_received_model.dart';
import '../../manage_cloth_sell/cloth_sell_view.dart';
import '../../widgets/body.dart';
import '../../widgets/buttons.dart';
import '../../widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';

import '../../widgets/snackbar.dart';

class PaymentToBeReceived extends StatefulWidget {
  const PaymentToBeReceived({super.key});

  @override
  State<PaymentToBeReceived> createState() => _PaymentToBeReceivedState();
}

class _PaymentToBeReceivedState extends State<PaymentToBeReceived> {
  bool _isLoading = false;
  bool noRecordFound = false;
  bool isNetworkAvailable = true;
  int currentPage = 1;
  List<PaymentReceived> paymentToBeReceivedList = [];
  ManageYarnReminderServices manageYarnReminderServices = ManageYarnReminderServices();
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = !_isLoading;
    });
    paymentToBeReceivedApi(currentPage.toString());
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          isLoading: _isLoading,
          internetNotAvailable: isNetworkAvailable,
          noRecordFound: noRecordFound,
          title: S.of(context).paymentToBeReceived,
          content: Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child: SmartRefresher(
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: () async {
                setState(() {
                  paymentToBeReceivedList.clear();
                  currentPage = 1;
                });
                paymentToBeReceivedApi(currentPage.toString());
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                paymentToBeReceivedApi(currentPage.toString());
                _refreshController.loadComplete();
              },
              child: ListView.builder(
                itemCount: paymentToBeReceivedList.length,
                itemBuilder: (context, index) {
                  return CustomAccordionWithoutExpanded(
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
                                    child: BigText(text: paymentToBeReceivedList[index].partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                                  ),
                                  SizedBox(width: Dimensions.height10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      BigText(text: paymentToBeReceivedList[index].partyName!, color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppTheme.black,
                                            radius: Dimensions.height10,
                                            child: BigText(text: paymentToBeReceivedList[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          SmallText(text: paymentToBeReceivedList[index].firmName!, color: AppTheme.black, size: Dimensions.font12),
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
                              _buildInfoColumn('Due Date', paymentToBeReceivedList[index].dueDate!.toString()),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Cloth Quality', paymentToBeReceivedList[index].qualityName!),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Invoice Amount', '₹ ${paymentToBeReceivedList[index].invoiceAmount!}'),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              _buildInfoColumn('Total Than', paymentToBeReceivedList[index].totalThan!),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Total Meter', paymentToBeReceivedList[index].totalMeter!),
                              SizedBox(width: Dimensions.width20),
                              _buildInfoColumn('Rate', '₹ ${paymentToBeReceivedList[index].rate!}'),
                            ],
                          ),
                        ],
                      ),
                      contentChild:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomElevatedButton(
                            onPressed: (){
                              //Navigator.pushNamed(context, AppRoutes.yarnPurchaseView, arguments: {'yarnPurchaseData': reminderForYarnToBeReceived[index]});
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ClothSellView(sellID: int.parse(paymentToBeReceivedList[index].sellId!))));
                            },
                            buttonText: 'View Details',
                            isBackgroundGradient: false,
                            backgroundColor: AppTheme.primary,
                            textSize: Dimensions.font14,
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      )
                  );
                },
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
      formattedValue = DateFormat('dd-MMM-yy').format(date);
    }
    return Container(
      width: MediaQuery.of(context).size.width / 4.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.grey, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font14),
        ],
      ),
    );
  }
  Future<PaymentToBeReceivedModel?> paymentToBeReceivedApi(
      String pageNo
      ) async {
    setState(() {
      _isLoading = true; // Show loader before making API call
    });
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        PaymentToBeReceivedModel? model = await manageYarnReminderServices.paymentToBeReceived(
            pageNo);
        if (model!.success == true) {
          if(model.data != null) {
            if (model.data!.isEmpty) {
              if (currentPage == 1) {
                setState(() {
                  noRecordFound = true;
                });
              } else {
                _refreshController.loadNoData();
              }
            } else {
              if (currentPage == 1) {
                paymentToBeReceivedList.clear();
              }
              setState(() {
                noRecordFound = false;
                paymentToBeReceivedList.addAll(model.data!);
                currentPage++;
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
            'Something went wrong, please try again later.',
            mode: SnackbarMode.error,
          );
        }
      } else {
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
}
