import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_hammal_model.dart';
import 'package:d_manager/models/master_models/hammal_detail_model.dart';
import 'package:d_manager/models/master_models/hammal_list_model.dart';
import 'package:d_manager/models/master_models/update_hammal_model.dart';
import 'package:d_manager/models/master_models/update_hammal_status_model.dart';
import 'package:http/http.dart';

class ManageHammalServices {
  Future<AddHammalModel?> addHammal(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(addHammalUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return AddHammalModel.fromJson(data);
      } else {
        return AddHammalModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<HammalListModel?> hammalList(int pageNo, String search) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "search": search,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(hammalListUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return hammalListModelFromJson(response.body);
      } else {
        return hammalListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<HammalDetailModel?> viewHammal(int hammalId) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "hammal_id": hammalId.toString(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(getHammalUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return hammalDetailModelFromJson(response.body);
      } else {
        return hammalDetailModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateHammalModel?> updateHammal(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateHammalUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateHammalModel.fromJson(data);
      } else {
        return UpdateHammalModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateHammalStatusModel?> updateHammalStatus(int hammalId, String status) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "hammal_id": hammalId.toString(),
        "status": status,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateHammalStatusUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateHammalStatusModel.fromJson(data);
      } else {
        return UpdateHammalStatusModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }
}