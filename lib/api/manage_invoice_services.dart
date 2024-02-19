import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/invoice_models/add_invoice_model.dart';
import 'package:http/http.dart';
import '../constants/constants.dart';
import '../helpers/helper_functions.dart';
import '../models/invoices_models/invoices_list_model.dart';
import 'package:dio/dio.dart';
import 'manage_sell_deals.dart';

class ManageInvoiceServices{
  Future<InvoiceListModel?> showInvoiceList(
      String sellId,
      String pageNo,
      String search,
      )async{
    try{
      Map<String, dynamic> body = {
        "sell_id":sellId,
        "sellId": HelperFunctions.getUserID(),
        "page_no":pageNo,
        "search":search,
      };
      Response response = await dio.post(invoiceListApi, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );
      if (response.statusCode == 200) {
        return InvoiceListModel.fromJson(response.data);
      }
      else {
        return InvoiceListModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }
}