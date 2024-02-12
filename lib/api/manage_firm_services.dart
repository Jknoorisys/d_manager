import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_firm_model.dart';
import 'package:d_manager/models/master_models/firm_detail_model.dart';
import 'package:d_manager/models/master_models/firm_list_model.dart';
import 'package:d_manager/models/master_models/update_firm_model.dart';
import 'package:d_manager/models/master_models/update_firm_status_model.dart';
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

  Future<FirmListModel?> firmList(int pageNo, String search) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "search": search,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(firmListUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return firmListModelFromJson(response.body);
      } else {
        return firmListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<FirmDetailModel?> viewFirm(int firmId) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "firm_id": firmId.toString(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(getFirmUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return firmDetailModelFromJson(response.body);
      } else {
        return firmDetailModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateFirmModel?> updateFirm(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateFirmUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateFirmModel.fromJson(data);
      } else {
        return UpdateFirmModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateFirmStatusModel?> updateFirmStatus(int firmId, String status) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "firm_id": firmId.toString(),
        "status": status,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateFirmStatusUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateFirmStatusModel.fromJson(data);
      } else {
        return UpdateFirmStatusModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }
}