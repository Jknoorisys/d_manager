import 'dart:convert';

import 'package:d_manager/models/invoice_models/add_invoice_model.dart';
import 'package:d_manager/models/invoice_models/add_transport_detail_model.dart';
import 'package:d_manager/models/invoice_models/invoice_detail_model.dart';
import 'package:d_manager/models/invoice_models/invoice_list_model.dart';
import 'package:d_manager/models/invoice_models/update_invoice_model.dart';
import 'package:http/http.dart';
import '../constants/constants.dart';
import '../helpers/helper_functions.dart';
import 'manage_sell_deals.dart';

class ManageInvoiceServices{
  Future<InvoiceListModel?> showInvoiceList(String sellId, String pageNo, [String? isPaid, String? isBillReceived]) async{
    try{

      Map<String, dynamic> body = {
        "user_id": HelperFunctions.getUserID(),
        "sell_id":sellId,
        "page_no":pageNo,
      };

      if(isPaid != null){
        body["paid_status"] = isPaid;
      }

      if(isBillReceived != null){
        body["is_bill_received"] = isBillReceived;
      }

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
      return null;
    }
  }

  Future<AddInvoiceModel?> addInvoice(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
        "Content-Type": "application/json"
      };

      Response response = await post(Uri.parse(addInvoiceUrl), body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        return addInvoiceModelFromJson(response.body);
      } else {
        return addInvoiceModelFromJson(response.body);
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<GetInvoiceModel?> viewInvoice(int invoiceId, int sellId) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "invoice_id": invoiceId.toString(),
        "sell_id": sellId.toString(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(getInvoiceUrl), body: body, headers: headers);

      if (response.statusCode == 200) {
        return getInvoiceModelFromJson(response.body);
      } else {
        return getInvoiceModelFromJson(response.body);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UpdateInvoiceModel?> updateInvoice(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
        "Content-Type": "application/json"
      };
      Response response = await post(Uri.parse(updateInvoiceUrl), body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        return updateInvoiceModelFromJson(response.body);
      } else {
        return updateInvoiceModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<AddTransportDetailModel?> addTransportDetail(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
        "Content-Type": "application/json"
      };

      Response response = await post(Uri.parse(addTransportDetailUrl), body: jsonEncode(body), headers: headers);
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        return addTransportDetailModelFromJson(response.body);
      } else {
        return addTransportDetailModelFromJson(response.body);
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

}