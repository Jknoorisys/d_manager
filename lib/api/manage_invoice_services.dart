import 'dart:convert';

import 'package:d_manager/models/invoice_models/add_invoice_model.dart';
import 'package:d_manager/models/invoice_models/invoice_list_model.dart';
import 'package:http/http.dart';
import '../constants/constants.dart';
import '../helpers/helper_functions.dart';
import 'manage_sell_deals.dart';

class ManageInvoiceServices{
  Future<InvoiceListModel?> showInvoiceList(String sellId, String pageNo, String search) async{
    try{
      Map<String, dynamic> body = {
        "sell_id":sellId,
        "sellId": HelperFunctions.getUserID(),
        "page_no":pageNo,
        "search":search,
      };
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };

      Response response = await post(Uri.parse(invoiceListApi), body: body, headers: headers);
      if (response.statusCode == 200) {
        return invoiceListModelFromJson(response.body);
      }
      else {
        return invoiceListModelFromJson(response.body);
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<AddInvoiceModel?> addInvoice(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(addInvoiceUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return addInvoiceModelFromJson(response.body);
      } else {
        return addInvoiceModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

}