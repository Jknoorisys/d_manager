import 'package:d_manager/api/notification_services.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/notification_models/notification_list_model.dart';
import 'package:d_manager/models/notification_models/read_notifcation_model.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
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
  bool isLoadingMore = false;
  int totalItems = 0;
  final _controller = ScrollController();
  List<NotificationDetail> notifications = [];
  int currentPage = 1;
  bool isLoading = false;
  bool noRecordFound = false;
  bool isNetworkAvailable = true;

  NotificationServices apiServices = NotificationServices();

  @override
  void initState() {
    _loadData(currentPage);
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (totalItems > notifications.length && !isLoadingMore) {
          currentPage++;
          isLoadingMore = true;
          _loadData(currentPage);
        }
      }
    });
    _markAsRead();
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
          title: 'Notifications',
          internetNotAvailable: isNetworkAvailable,
          isLoading: isLoading,
          noRecordFound: noRecordFound,
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              controller: _controller,
              itemCount: notifications.length + 1,
              itemBuilder: (context, index) {
                if (index < notifications.length) {
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
                } else {
                  return const SizedBox();
                }
              },
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
                  totalItems = notificationListModel.total ?? 0;
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
        isLoadingMore = false;
      });
    }
  }

  Future<void> _markAsRead() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        ReadNotificationModel? readNotificationModel = await apiServices.readNotification();
        if (readNotificationModel != null) {
          if (readNotificationModel.success == true) {
            HelperFunctions.setNotificationCount(0);
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
}
