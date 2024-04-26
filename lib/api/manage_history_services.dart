import 'dart:convert';

import '../constants/constants.dart';
import '../helpers/helper_functions.dart';
import '../models/history_models/purchase_history_model.dart';
import '../models/history_models/sell_history_model.dart';
import 'manage_sell_deals.dart';
import 'package:dio/dio.dart';

class ManageHistoryServices{
  Future<SellHistoryModel?> showSellHistory(String pageNo, String search, [int? firmId, int? partyId, int? yarnId, String? startDate, String? endDate]) async {
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "page_no": pageNo,
        "search":search,
        "firm_id": firmId != null ? firmId.toString() : "",
        "party_id": partyId != null ? partyId.toString() : "",
        "quality_id": yarnId != null ? yarnId.toString() : "",
      };

      if(startDate != null){
        body["start_date"] = startDate;
      }

      if(endDate != null){
        body["end_date"] = endDate;
      }

      Response response = await dio.post(sellHistoryApi, data: body,
        options: Options(
          headers: {
            "X-API-Key": HelperFunctions.getApiKey(),
          },
        ),
      );

      print("response: ${response.data}");
      if (response.statusCode == 200) {
        return sellHistoryModelFromJson(jsonEncode(response.data));
      }
      else {
        return sellHistoryModelFromJson(jsonEncode(response.data));
      }
    }catch(e){
      print("error: ${e.toString()}");
      return null;
    }
  }

  Future<PurchaseHistoryModel?> showPurchaseHistory(String pageNo, String search, [int? firmId, int? partyId, int? yarnId, String? startDate, String? endDate]) async {
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "page_no": pageNo,
        "search":search,
        "firm_id": firmId != null ? firmId.toString() : "",
        "party_id": partyId != null ? partyId.toString() : "",
        "yarn_type_id": yarnId != null ? yarnId.toString() : "",
      };

      if(startDate != null){
        body["start_date"] = startDate;
      }
      if(endDate != null){
        body["end_date"] = endDate;
      }

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
      return null;
    }
  }
}