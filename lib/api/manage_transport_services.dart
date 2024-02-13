import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_transport_model.dart';
import 'package:d_manager/models/master_models/transport_detail_model.dart';
import 'package:d_manager/models/master_models/transport_list_model.dart';
import 'package:d_manager/models/master_models/update_transport_model.dart';
import 'package:d_manager/models/master_models/update_transport_status_model.dart';
import 'package:http/http.dart';

class ManageTransportServices {
  Future<AddTransportModel?> addTransport(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(addTransportUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return AddTransportModel.fromJson(data);
      } else {
        return AddTransportModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<TransportListModel?> transportList(int pageNo, String search) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "search": search,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(transportListUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return transportListModelFromJson(response.body);
      } else {
        return transportListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<TransportDetailModel?> viewTransport(int transportId) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "quality_id": transportId.toString(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(getTransportUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return transportDetailModelFromJson(response.body);
      } else {
        return transportDetailModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateTransportModel?> updateTransport(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateTransportUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateTransportModel.fromJson(data);
      } else {
        return UpdateTransportModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateTransportStatusModel?> updateTransportStatus(int transportId, String status) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "quality_id": transportId.toString(),
        "status": status,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateTransportStatusUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateTransportStatusModel.fromJson(data);
      } else {
        return UpdateTransportStatusModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }
}