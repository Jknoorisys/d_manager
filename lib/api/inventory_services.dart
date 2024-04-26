import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/inventory_models/add_update_inventory_model.dart';
import 'package:d_manager/models/inventory_models/inventory_dashboard_model.dart';
import 'package:d_manager/models/inventory_models/inventory_detail_model.dart';
import 'package:d_manager/models/inventory_models/purchase_inventory_list_model.dart';
import 'package:d_manager/models/inventory_models/sell_inventory_list_model.dart';
import 'package:http/http.dart';

class ManageInventoryServices {
  Future<AddUpdateInventoryModel?> addInventory(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(addInventoryUrl), body: body, headers: headers);
      print(response.body);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return addUpdateInventoryModelFromJson((jsonEncode(data)));
      } else {
        return addUpdateInventoryModelFromJson(jsonEncode(data));
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<AddUpdateInventoryModel?> updateInventory(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateInventoryUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return addUpdateInventoryModelFromJson(jsonEncode(data));
      } else {
        return addUpdateInventoryModelFromJson(jsonEncode(data));
      }
    } catch (e) {
      return null;
    }
  }

  Future<PurchaseInventoryListModel?> purchaseInventoryList(int pageNo, String search, [String? startDate, String? endDate]) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "search": search,
      };

      if (startDate != null && endDate != null) {
        body["start_date"] = startDate;
        body["end_date"] = endDate;
      }

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(purchaseInventoryListUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return purchaseInventoryListModelFromJson(response.body);
      } else {
        return purchaseInventoryListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<SellInventoryListModel?> sellInventoryList(int pageNo, String search, [String? startDate, String? endDate]) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "search": search,
      };

      if (startDate != null && endDate != null) {
        body["start_date"] = startDate;
        body["end_date"] = endDate;
      }

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(sellInventoryListUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return sellInventoryListModelFromJson(response.body);
      } else {
        return sellInventoryListModelFromJson(response.body);
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<InventoryDashboardModel?> inventoryDashboard() async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(inventoryDashboardUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return inventoryDashboardModelFromJson(response.body);
      } else {
        return inventoryDashboardModelFromJson(response.body);
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<InventoryDetailModel?> viewInventory(String inventoryId) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "cloth_inventory_id": inventoryId.toString(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(getInventoryUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return inventoryDetailModelFromJson(response.body);
      } else {
        return inventoryDetailModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }
}