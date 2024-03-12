import 'package:dio/dio.dart';
import '../constants/constants.dart';
import '../helpers/helper_functions.dart';
import '../models/gst_return_models/gst_return_models.dart';
import 'manage_sell_deals.dart';

class GstReturnServices{
  Future<GstReturnAmountModel?> showGstReturnAmount()async{
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "month": HelperFunctions.getSelectedMonth(),
        "year":HelperFunctions.getSelectedYear()
      };
      print("param === "+ body.toString() + "URL ==== "+ gstReturnApi);
      Response response = await dio.post(gstReturnApi, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );
      print("Response === " + response.data.toString());
      if (response.statusCode == 200) {
        return GstReturnAmountModel.fromJson(response.data);
      }
      else {
        return GstReturnAmountModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }
}