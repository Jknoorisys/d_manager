import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/unpaid_models/unpaid_purchase_model.dart';
import 'package:d_manager/models/unpaid_models/unpaid_sell_model.dart';
import 'package:http/http.dart';

class ManageUnpaidServices {
  Future<UnpaidPurchaseModel?> unpaidPurchaseList(int pageNo, String search) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "search": search,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(unpaidPurchaseListUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return unpaidPurchaseModelFromJson(response.body);
      } else {
        return unpaidPurchaseModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UnpaidSellModel?> unpaidSellList(int pageNo, String search) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "search": search,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(unpaidSellListUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return unpaidSellModelFromJson(response.body);
      } else {
        return unpaidSellModelFromJson(response.body);
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}