import 'package:d_manager/models/notification_models/notification_list_model.dart';
import 'package:d_manager/models/notification_models/read_notifcation_model.dart';
import 'package:http/http.dart';
import '../constants/constants.dart';
import '../helpers/helper_functions.dart';

class NotificationServices{
  Future<NotificationListModel?> notificationList(int pageNo) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(notificationListApi), body: body, headers: headers);
      if (response.statusCode == 200) {
        return notificationListModelFromJson(response.body);
      } else {
        return notificationListModelFromJson(response.body);
      }
    } catch (e) {
      print("Notification List Error: $e");
      return null;
    }
  }

  Future<ReadNotificationModel?> readNotification() async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };

      Response response = await post(Uri.parse(readNotificationApi), body: body, headers: headers);
      if (response.statusCode == 200) {
        return readNotificationModelFromJson(response.body);
      } else {
        return readNotificationModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }
}