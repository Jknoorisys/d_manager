import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../api/manage_yarn_reminder_services.dart';
import '../../../generated/l10n.dart';
import '../../../helpers/helper_functions.dart';
import '../../../models/reminder_models/yarnPayementDueDateModel.dart';
import '../../widgets/body.dart';
import '../../widgets/buttons.dart';
import '../../widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';

import '../../widgets/snackbar.dart';

class PaymentDueDate extends StatefulWidget {
  const PaymentDueDate({Key? key}) : super(key: key);

  @override
  _PaymentDueDateState createState() => _PaymentDueDateState();
}

class _PaymentDueDateState extends State<PaymentDueDate> {
  bool _isLoading = false;
  int currentPage = 1;
  List<yarnPaymentDueDate> yarnPaymentTobePaid = [];
  ManageYarnReminderServices manageYarnReminderServices = ManageYarnReminderServices();
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    if (HelperFunctions.checkInternet() == false) {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No internet connection',
        mode: SnackbarMode.warning,
      );
    } else {
      setState(() {
        _isLoading = !_isLoading;
      });
      yarnPaymentToBePaidApi(currentPage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          isLoading:_isLoading,
            title: S.of(context).paymentDueDate,
            content:
            Padding(
              padding: EdgeInsets.all(Dimensions.height15),
              child: SmartRefresher(
                enablePullUp: true,
                controller: _refreshController,
                onRefresh: () async {
                  setState(() {
                    yarnPaymentTobePaid.clear();
                    currentPage = 1;
                  });
                  yarnPaymentToBePaidApi(currentPage.toString());
                  _refreshController.refreshCompleted();
                },
                onLoading: () async {
                  yarnPaymentToBePaidApi(currentPage.toString());
                  _refreshController.loadComplete();
                },
                child: ListView.builder(
                  itemCount: yarnPaymentTobePaid.length,
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
                                      child: BigText(text: yarnPaymentTobePaid[index].partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                                    ),
                                    SizedBox(width: Dimensions.height10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BigText(text: yarnPaymentTobePaid[index].partyName!, color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppTheme.black,
                                              radius: Dimensions.height10,
                                              child: BigText(text: yarnPaymentTobePaid[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                            ),
                                            SizedBox(width: Dimensions.width10),
                                            SmallText(text: yarnPaymentTobePaid[index].firmName!, color: AppTheme.black, size: Dimensions.font12),
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildInfoColumn('Due Date', yarnPaymentTobePaid[index].dueDate!.toString()),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Yarn Name', yarnPaymentTobePaid[index].yarnName!),
                                  SizedBox(width: Dimensions.width20),
                                  _buildInfoColumn('Rate', '₹ ${yarnPaymentTobePaid[index].rate!}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      contentChild: Column(
                        children: [
                          SizedBox(height: Dimensions.height10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      BigText(text: 'Gross Weight', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: AppTheme.primary,
                                            fontSize: Dimensions.font18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: yarnPaymentTobePaid[index].grossWeight,
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
                                    ],
                                  )
                              ),
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
                                      BigText(text: 'Amount to be Paid', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                      BigText(text:' ${yarnPaymentTobePaid[index].gstBillAmount.toString()}',color: AppTheme.primary, size: Dimensions.font18)
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
                                  //Navigator.pushNamed(context, AppRoutes.yarnPurchaseView, arguments: {'yarnPurchaseData': reminderForYarnToBeReceived[index]});
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => YarnPurchaseView( purchaseId: reminderForYarnToBeReceived[index].purchaseId.toString())));
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
            )
        )
    );
  }
  Widget _buildInfoColumn(String title, String value) {
    String formattedValue = value;
    if (title == 'Due Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
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
  Future<YarnPaymentDueDateModel?> yarnPaymentToBePaidApi(
      String pageNo
      ) async {
    setState(() {
      _isLoading = true; // Show loader before making API call
    });
    try {
      YarnPaymentDueDateModel? model = await manageYarnReminderServices.yarnPaymentToBePaid(
          pageNo);
      if (model!.success == true) {
        setState(() {
          yarnPaymentTobePaid.addAll(model.data!);
          currentPage++;
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
}
