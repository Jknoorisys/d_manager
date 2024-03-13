import '../constants/constants.dart';
import '../helpers/helper_functions.dart';
import '../models/history_models/purchase_history_model.dart';
import '../models/history_models/sell_history_model.dart';
import 'manage_sell_deals.dart';
import 'package:dio/dio.dart';

class ManageHistoryServices{
  Future<SellHistoryModel?> showSellHistory(
      String pageNo,
      String search,
      )async{
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "page_no": pageNo,
        "search":search,
        "firm_id":HelperFunctions.getFirmID() ?? "",
        "party_id":HelperFunctions.getPartyID() ?? "",
        "quality_id":HelperFunctions.getClothID() ?? "",
        "start_date":HelperFunctions.getStartDateForSellHistory() ?? "",
        "end_date":HelperFunctions.getEndDateForSellHistory() ?? ""
      };
      Response response = await dio.post(sellHistoryApi, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );
      if (response.statusCode == 200) {
        return SellHistoryModel.fromJson(response.data);
      }
      else {
        return SellHistoryModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<PurchaseHistoryModel?> showPurchaseHistory(
      String pageNo,
      String search,
      )async{
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "page_no": pageNo,
        "search":search,
        "firm_id":HelperFunctions.getFirmID() ?? "",
        "party_id":HelperFunctions.getPartyID() ?? "",
        "quality_id":HelperFunctions.getClothID() ?? "",
        // "start_date":HelperFunctions.getStartDateForPurchaseHistory() ?? "",
        // "end_date":HelperFunctions.getEndDateForPurchaseHistory() ?? ""
      };
      Response response = await dio.post(purchaseHistoryApi, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );
      if (response.statusCode == 200) {
        return PurchaseHistoryModel.fromJson(response.data);
      }
      else {
        return PurchaseHistoryModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }
}