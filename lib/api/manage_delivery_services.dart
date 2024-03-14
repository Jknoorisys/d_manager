import 'dart:convert';
import 'dart:io';

import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/delivery_models/AddDeliveryModel.dart';
import 'package:d_manager/models/delivery_models/DeliveryDetailModel.dart';
import 'package:d_manager/models/delivery_models/DeliveryListModel.dart';
import 'package:d_manager/models/delivery_models/UpdateDeliveryModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';

class ManageDeliveryServices {
  Future<DeliveryListModel?> deliveryList(int pageNo, String purchaseId, [String? isPaid, String? isBillReceived]) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "purchase_id": purchaseId,
      };

      if (isPaid != null && isPaid.isNotEmpty) {
        body["paid_status"] = isPaid;
      }

      if (isBillReceived != null && isBillReceived.isNotEmpty) {
        body["bill_received"] = isBillReceived;
      }

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      print("Delivery List Body: $body");
      Response response = await post(Uri.parse(deliveryDetailListUrl), body: body, headers: headers);
      print("Delivery List Response: ${response.body}");
      if (response.statusCode == 200) {
        return deliveryListModelFromJson(response.body);
      } else {
        return deliveryListModelFromJson(response.body);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AddDeliveryModel?> addDelivery(Map<String, String> body, [File? billUrl]) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
        "Content-Type": "multipart/form-data",
      };

      var request = MultipartRequest('POST', Uri.parse(addDeliveryDetailUrl));
      request.headers.addAll(headers);
      request.fields.addAll(body);
      if (billUrl != null) {
        request.files.add(await MultipartFile.fromPath('bill_url', billUrl.path, filename: billUrl.path.split('/').last));
      }
      var response = await request.send();
      var data = json.decode(await response.stream.bytesToString());
      print("Add Delivery Response: $data");

      if (response.statusCode == 200) {
        return AddDeliveryModel.fromJson(data);
      } else {
        return AddDeliveryModel.fromJson(data);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UpdateDeliveryModel?> updateDelivery(Map<String, String> body, billUrl) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
        "Content-Type": "multipart/form-data",
      };

      var request = MultipartRequest('POST', Uri.parse(updateDeliveryDetailUrl));
      request.headers.addAll(headers);
      request.fields.addAll(body);
      if (billUrl != null) {
        request.files.add(await MultipartFile.fromPath('bill_url', billUrl.path, filename: billUrl.path.split('/').last));
      }
      var response = await request.send();
      var data = json.decode(await response.stream.bytesToString());
      print("Update Delivery Response: $data");

      if (response.statusCode == 200) {
        return UpdateDeliveryModel.fromJson(data);
      } else {
        return UpdateDeliveryModel.fromJson(data);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<DeliveryDetailModel?> viewDeliveryDetail(int purchaseId, int deliveryId) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "purchase_id": purchaseId.toString(),
        "delivery_id": deliveryId.toString(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(getDeliveryDetailUrl), body: body, headers: headers);

      if (response.statusCode == 200) {
        return deliveryDetailModelFromJson(response.body);
      } else {
        return deliveryDetailModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

}