import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_cloth_quality_model.dart';
import 'package:d_manager/models/master_models/cloth_quality_detail_model.dart';
import 'package:d_manager/models/master_models/cloth_quality_list_model.dart';
import 'package:d_manager/models/master_models/update_cloth_quality_model.dart';
import 'package:d_manager/models/master_models/update_cloth_quality_status_model.dart';
import 'package:http/http.dart';

class ManageClothQualityServices {
  Future<AddClothQualityModel?> addClothQuality(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(addClothQualityUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return AddClothQualityModel.fromJson(data);
      } else {
        return AddClothQualityModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<ClothQualityListModel?> clothQualityList(int pageNo, String search) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "search": search,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(clothQualityListUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return clothQualityListModelFromJson(response.body);
      } else {
        return clothQualityListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<ClothQualityDetailModel?> viewClothQuality(int clothQualityId) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "quality_id": clothQualityId.toString(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(getClothQualityUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return clothQualityDetailModelFromJson(response.body);
      } else {
        return clothQualityDetailModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateClothQualityModel?> updateClothQuality(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateClothQualityUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateClothQualityModel.fromJson(data);
      } else {
        return UpdateClothQualityModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdateClothQualityStatusModel?> updateClothQualityStatus(int clothQualityId, String status) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "quality_id": clothQualityId.toString(),
        "status": status,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updateClothQualityStatusUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdateClothQualityStatusModel.fromJson(data);
      } else {
        return UpdateClothQualityStatusModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }
}