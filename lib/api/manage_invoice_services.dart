import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/invoice_models/add_invoice_model.dart';
import 'package:http/http.dart';

class ManageInvoiceServices {
  Future<AddInvoiceModel?> addInvoice(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(addInvoiceUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return AddInvoiceModel.fromJson(data);
      } else {
        return AddInvoiceModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }
}