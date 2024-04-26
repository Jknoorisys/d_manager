import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../api/manage_yarn_reminder_services.dart';
import '../../../generated/l10n.dart';
import '../../../helpers/helper_functions.dart';
import '../../../models/reminder_models/yarn_to_be_received_model.dart';
import '../../manage_yarn_purchase/yarn_purchase_view.dart';
import '../../widgets/body.dart';
import '../../widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';

import '../../widgets/snackbar.dart';

class BoxToBeReceived extends StatefulWidget {
  const BoxToBeReceived({Key? key}) : super(key: key);

  @override
  _BoxToBeReceivedState createState() => _BoxToBeReceivedState();
}

class _BoxToBeReceivedState extends State<BoxToBeReceived> {
  bool _isLoading = false;
  bool noRecordFound = false;
  bool isNetworkAvailable = true;
  int currentPage = 1;
  List<YarnToBeReceivedReminderList> reminderForYarnToBeReceived = [];
  ManageYarnReminderServices manageYarnReminderServices = ManageYarnReminderServices();
  final _controller = ScrollController();
  int totalItems = 0;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = !_isLoading;
    });
    yarnToBeReceivedData(currentPage.toString());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (totalItems > reminderForYarnToBeReceived.length && !isLoadingMore) {
          currentPage++;
          isLoadingMore = true;
          yarnToBeReceivedData(currentPage.toString());
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      CustomDrawer(
        content: CustomBody(
            isLoading: _isLoading,
            internetNotAvailable: isNetworkAvailable,
            noRecordFound: noRecordFound,
            title: S.of(context).yarnToBeReceived,
            content: Padding(
              padding: EdgeInsets.all(Dimensions.height15),
              child: ListView.builder(
                itemCount: reminderForYarnToBeReceived.length + 1,
                controller: _controller,
                itemBuilder: (context, index) {
                  if (index < reminderForYarnToBeReceived.length) {
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
                                    child: BigText(text: reminderForYarnToBeReceived[index].partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                                  ),
                                  SizedBox(width: Dimensions.height10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      BigText(text: reminderForYarnToBeReceived[index].partyName!, color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppTheme.black,
                                            radius: Dimensions.height10,
                                            child: BigText(text: reminderForYarnToBeReceived[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          SmallText(text: reminderForYarnToBeReceived[index].firmName!, color: AppTheme.black, size: Dimensions.font12),
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
                              Expanded(flex:1,child: _buildInfoColumn('Due Date', reminderForYarnToBeReceived[index].dueDate!.toString(),index)),
                              SizedBox(width: Dimensions.width20),
                              Expanded(flex:1,child: _buildInfoColumn('Yarn Name', reminderForYarnToBeReceived[index].yarnName!,index)),
                              SizedBox(width: Dimensions.width20),
                              Expanded(flex:1,child: _buildInfoColumn('Rate', '₹${HelperFunctions.formatPrice(reminderForYarnToBeReceived[index].rate.toString())}', index)),
                            ],
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
                                              text: reminderForYarnToBeReceived[index].grossWeight,
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
                                      BigText(text: 'Gross Received ${reminderForYarnToBeReceived[index].grossReceivedWeight ?? 'N/A'} ton', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                    ],
                                  )
                              ),
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
                                      BigText(text: 'Gross Remaining', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                      BigText(text: '${double.parse(reminderForYarnToBeReceived[index].grossWeight.toString()) - double.parse(reminderForYarnToBeReceived[index].grossReceivedWeight.toString())} ton',color: AppTheme.primary, size: Dimensions.font18)
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => YarnPurchaseView(purchaseId:reminderForYarnToBeReceived[index].purchaseId!.toString())));
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
                  } else {
                    const SizedBox();
                  }
                },
              ),
            )
        )
    );
  }

  Widget _buildInfoColumn(String title, String value,int index) {
    String formattedValue = value;
    if (title.contains('Date') && value != 'N/A' && value != '' && value != null) {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd MMM yy').format(date);
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width / 3.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.nearlyBlack, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font14),
        ],
      ),
    );
  }

  Future<void> yarnToBeReceivedData(String pageNo) async {
    setState(() {
      _isLoading = true; // Show loader before making API call
    });
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        YarnToBeReceivedModel? model = await manageYarnReminderServices.yarnToBeReceived(
            pageNo);
        if (model!.success == true) {
          if (model.data != null) {
            if (model.data!.isEmpty) {
              setState(() {
                _isLoading = false;
              });
            } else {
              if (currentPage == 1) {
                reminderForYarnToBeReceived.clear();
              }
              setState(() {
                reminderForYarnToBeReceived.addAll(model.data!);
                totalItems = model.total ?? 0;
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
    } catch (e) {
      CustomApiSnackbar.show(
        context,
        'Error',
        'Something went wrong, please try again later.',
        mode: SnackbarMode.error,
      );
    } finally {
      setState(() {
        _isLoading = false;
        isLoadingMore = false;
      });
    }
  }
}
