import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/add_firm_model.dart';
import 'package:http/http.dart';

class ManageFirmServices {
  Future<AddFirmModel?> addFirm(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(addFirmUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return AddFirmModel.fromJson(data);
      } else {
        return AddFirmModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }
}