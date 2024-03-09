import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/delivery_models/AddDeliveryModel.dart';
import 'package:d_manager/models/delivery_models/DeliveryDetailModel.dart';
import 'package:d_manager/models/delivery_models/UpdateDeliveryModel.dart';
import 'package:http/http.dart';

class ManageDeliveryServices {
  Future<AddDeliveryModel?> addDelivery(Map<String, String> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };

      Response response = await post(Uri.parse(addDeliveryDetailUrl), body: body, headers: headers);
      print("Add Delivery Response: ${response.body}");

      if (response.statusCode == 200) {
        return addDeliveryModelFromJson(response.body);
      } else {
        return addDeliveryModelFromJson(response.body);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UpdateDeliveryModel?> updateDelivery(Map<String, String> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };

      Response response = await post(Uri.parse(updateDeliveryDetailUrl), body: body, headers: headers);
      print("Update Delivery Response: ${response.body}");

      if (response.statusCode == 200) {
        return updateDeliveryModelFromJson(response.body);
      } else {
        return updateDeliveryModelFromJson(response.body);
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