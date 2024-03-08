import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/delivery_models/AddDeliveryModel.dart';
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
}