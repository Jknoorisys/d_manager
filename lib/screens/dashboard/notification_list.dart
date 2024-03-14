import 'package:d_manager/api/notification_services.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/notification_models/notification_list_model.dart';
import 'package:d_manager/models/notification_models/read_notifcation_model.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../constants/dimension.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  final List<Map<String, String>> notificationList = [
    {'partyName': 'Kalantri Yarn Agency','title': 'Yarn to be Received', 'body': 'Body 1','date':'20/03/2024'},
    {'partyName': 'Laxmi Yarns','title': 'Payment Due Date', 'body': 'Body 1','date':'22/03/2024'},
    {'partyName': 'Tulsi Textiles','title': 'Thans to be Delivered', 'body': 'Body 1','date':'25/03/2024'},
    {'partyName': 'Jakhotya Textiles','title': 'Payment to be Received', 'body': 'Body 1','date':'29/03/2024'},

  ];

  final RefreshController _refreshController = RefreshController();
  List<NotificationDetail> notifications = [];
  int currentPage = 1;
  bool isLoading = false;
  bool noRecordFound = false;
  bool isNetworkAvailable = true;

  NotificationServices apiServices = NotificationServices();

  @override
  void initState() {
    _loadData(currentPage);
    _markAsRead();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          title: 'Notifications',
          internetNotAvailable: isNetworkAvailable,
          isLoading: isLoading,
          noRecordFound: noRecordFound,
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () async {
                setState(() {
                  notifications.clear();
                  currentPage = 1;
                });
                await _loadData(currentPage);
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                await _loadData(currentPage);
                _refreshController.loadComplete();
              },
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  var notification = notifications[index];
                  return CustomAccordionWithoutExpanded(
                      titleChild:
                      Row(
                        children: [
                          SizedBox(width: Dimensions.width10),
                          CircleAvatar(
                            backgroundColor: AppTheme.secondary,
                            radius: Dimensions.height20,
                            child: BigText(text: notification.title![0], color: AppTheme.primary, size: Dimensions.font18),
                          ),
                          SizedBox(width: Dimensions.height10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BigText(text: notification.title!, color: AppTheme.primary, size: Dimensions.font16),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppTheme.black,
                                      radius: Dimensions.height10,
                                      child: Icon(Icons.calendar_month, color: AppTheme.secondaryLight, size: Dimensions.font12),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    SmallText(text: notification.createdAt!, color: AppTheme.black, size: Dimensions.font12),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  contentChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTheme.divider,
                      SizedBox(height: Dimensions.height10),
                      SmallText(text: notification.message!, color: AppTheme.black, size: Dimensions.font14),
                    ],
                  )
                  );
                },
              ),
            ),
          ),
        )
    );
  }

  Future<void> _loadData(int pageNo) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        NotificationListModel? notificationListModel = await apiServices.notificationList(pageNo);
        if (notificationListModel != null) {
          if (notificationListModel.success == true) {
            if (notificationListModel.notification != null) {
              if (notificationListModel.notification!.isNotEmpty) {
                if (pageNo == 1) {
                  notifications.clear();
                }

                setState(() {
                  notifications.addAll(notificationListModel.notification!);
                  HelperFunctions.setNotificationCount(notificationListModel.totalUnseen!.toInt());
                  currentPage++;
                });
              } else {
                _refreshController.loadNoData();
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
              notificationListModel.message.toString(),
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
      });
    }
  }

  Future<void> _markAsRead() async {
    setState(() {
      isLoading = true;
    });

    try {
      ReadNotificationModel? readNotificationModel = await apiServices.readNotification();
      if (readNotificationModel != null) {
        if (readNotificationModel.success == true) {
          HelperFunctions.setNotificationCount(0);
          // CustomApiSnackbar.show(
          //   context,
          //   'Success',
          //   readNotificationModel.message.toString(),
          //   mode: SnackbarMode.success,
          // );
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            readNotificationModel.message.toString(),
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
        isLoading = false;
      });
    }
  }
}
