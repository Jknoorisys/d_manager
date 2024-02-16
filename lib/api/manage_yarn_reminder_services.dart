import '../constants/constants.dart';
import '../helpers/helper_functions.dart';
import '../models/reminder_models/thans_to_be_delivered_model.dart';
import '../models/reminder_models/yarnPayementDueDateModel.dart';
import '../models/reminder_models/yarn_to_be_received_model.dart';
import 'manage_sell_deals.dart';
import 'package:dio/dio.dart';

class ManageYarnReminderServices{

  Future<YarnToBeReceivedModel?> yarnToBeReceived(
      String pageNo,
      )async{
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "page_no": pageNo,
      };
      Response response = await dio.post(yarnToBeReceivedForReminder, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );

      if (response.statusCode == 200) {
        return YarnToBeReceivedModel.fromJson(response.data);
      }
      else {
        return YarnToBeReceivedModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<YarnPaymentDueDateModel?> yarnPaymentToBePaid(
      String pageNo,
      )async{
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "page_no": pageNo,
      };
      Response response = await dio.post(yarnPaymentToBePaidForReminder, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );

      if (response.statusCode == 200) {
        return YarnPaymentDueDateModel.fromJson(response.data);
      }
      else {
        return YarnPaymentDueDateModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<ThansToBeDeliveredModel?> thansToBeDeliveredApi(
      String pageNo,
      )async{
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "page_no": pageNo,
      };
      Response response = await dio.post(thansToBeDelivered, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );

      if (response.statusCode == 200) {
        return ThansToBeDeliveredModel.fromJson(response.data);
      }
      else {
        return ThansToBeDeliveredModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }
}