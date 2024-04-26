import 'package:d_manager/api/manage_sell_deals.dart';

import '../constants/constants.dart';
import '../helpers/helper_functions.dart';
import '../models/dashboard_models/dashboard_models.dart';
import 'package:dio/dio.dart';

class DashboardServices{
  Future<DashboardModel?> showDashboardData([String? startDate, String? endDate]) async{
    try{
      Map<String, dynamic> body = {
        "user_id": HelperFunctions.getUserID(),
      };

      if(startDate != null && endDate != null){
        body["start_date"] = startDate;
        body["end_date"] = endDate;
      }

      Response response = await dio.post(dashBoardApi, data: body,
        options: Options(
          headers: {
            "X-API-Key": HelperFunctions.getApiKey(),
          },
        ),);

      print(response.data);
      if (response.statusCode == 200)
      {
        return DashboardModel.fromJson(response.data);
      }
      else {
        return DashboardModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}