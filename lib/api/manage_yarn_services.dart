import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_yarn_model.dart';
import 'package:d_manager/models/master_models/update_yarn_model.dart';
import 'package:d_manager/models/master_models/update_yarn_status_model.dart';
import 'package:d_manager/models/master_models/yarn_detail_model.dart';
import 'package:d_manager/models/master_models/yarn_list_model.dart';
import 'package:http/http.dart';

class ManageYarnServices {
  Future<AddYarnModel?> addYarn(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(addYarnUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return AddYarnModel.fromJson(data);
      } else {
        return AddYarnModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<YarnListModel?> yarnList(int pageNo, String search) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "search": search,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(yarnListUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return yarnListModelFromJson(response.body);
      } else {
        return yarnListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<YarnDetailModel?> viewYarn(int yarnId) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "yarn_type_id": yarnId.toString(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(getYarnUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return yarnDetailModelFromJson(response.body);
      } else {
        return yarnDetailModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateYarnModel?> updateYarn(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateYarnUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateYarnModel.fromJson(data);
      } else {
        return UpdateYarnModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateYarnStatusModel?> updateYarnStatus(int yarnTypeId, String status) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "yarn_type_id": yarnTypeId.toString(),
        "status": status,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateYarnStatusUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateYarnStatusModel.fromJson(data);
      } else {
        return UpdateYarnStatusModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }
}