import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/yarn_purchase_models/add_yarn_purchase_model.dart';
import 'package:d_manager/models/yarn_purchase_models/update_yarn_purchase_model.dart';
import 'package:d_manager/models/yarn_purchase_models/update_yarn_purchase_status_model.dart';
import 'package:d_manager/models/yarn_purchase_models/yarn_purchase_list_model.dart';
import 'package:http/http.dart';
class ManagePurchaseServices {
  Future<AddYarnPurchaseModel?> addPurchase(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(addYarnPurchaseDealUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return AddYarnPurchaseModel.fromJson(data);
      } else {
        return AddYarnPurchaseModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<YarnPurchaseListModel?> purchaseList(int pageNo, String search, [int? firmId, int? partyId, int? yarnId, String? status]) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "firm_id": firmId != null ? firmId.toString() : "",
        "party_id": partyId != null ? partyId.toString() : "",
        "yarn_type_id": yarnId != null ? yarnId.toString() : "",
        "deal_status": status ?? "",
        "search": search,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(yarnPurchaseDealListUrl), body: body, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        return yarnPurchaseListModelFromJson(response.body);
      } else {
        return yarnPurchaseListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  // Future<PurchaseDetailModel?> viewPurchase(int firmId) async {
  //   try {
  //     Map<String, String> body = {
  //       "user_id" : HelperFunctions.getUserID(),
  //       "firm_id": firmId.toString(),
  //     };
  //
  //     Map<String, String> headers = {
  //       "X-API-Key": HelperFunctions.getApiKey(),
  //     };
  //     Response response = await post(Uri.parse(getPurchaseUrl), body: body, headers: headers);
  //     if (response.statusCode == 200) {
  //       return firmDetailModelFromJson(response.body);
  //     } else {
  //       return firmDetailModelFromJson(response.body);
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future<UpdateYarnPurchaseModel?> updatePurchase(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateYarnPurchaseDealUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateYarnPurchaseModel.fromJson(data);
      } else {
        return UpdateYarnPurchaseModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateYarnPurchaseStatusModel?> updatePurchaseStatus(int purchaseId, String status) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "purchase_id": purchaseId.toString(),
        "status": status,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateYarnPurchaseDealStatusUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateYarnPurchaseStatusModel.fromJson(data);
      } else {
        return UpdateYarnPurchaseStatusModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }
}