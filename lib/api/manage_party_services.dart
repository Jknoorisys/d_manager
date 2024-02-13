import 'dart:convert';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/master_models/add_party_model.dart';
import 'package:d_manager/models/master_models/party_detail_model.dart';
import 'package:d_manager/models/master_models/party_list_model.dart';
import 'package:d_manager/models/master_models/update_party_model.dart';
import 'package:d_manager/models/master_models/update_party_status_model.dart';
import 'package:http/http.dart';

import '../models/sell_models/active_parties_model.dart';

class ManagePartyServices {
  Future<AddPartyModel?> addParty(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(addPartyUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return AddPartyModel.fromJson(data);
      } else {
        return AddPartyModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<PartyListModel?> partyList(int pageNo, String search) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "page_no": pageNo.toString(),
        "search": search,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(partyListUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return partyListModelFromJson(response.body);
      } else {
        return partyListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<PartyDetailModel?> viewParty(int partyId) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "party_id": partyId.toString(),
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(getPartyUrl), body: body, headers: headers);
      if (response.statusCode == 200) {
        return partyDetailModelFromJson(response.body);
      } else {
        return partyDetailModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdatePartyModel?> updateParty(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(updatePartyUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdatePartyModel.fromJson(data);
      } else {
        return UpdatePartyModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UpdatePartyStatusModel?> updatePartyStatus(int partyId, String status) async {
    try {
      Map<String, String> body = {
        "user_id" : HelperFunctions.getUserID(),
        "party_id": partyId.toString(),
        "status": status,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };

      Response response = await post(Uri.parse(updatePartyStatusUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return UpdatePartyStatusModel.fromJson(data);
      } else {
        return UpdatePartyStatusModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }
  Future<ActivePartiesModel?> activeParties() async {
    try {
      Map<String, String> body = {};
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(activePartiesWithoutPagination), body: body, headers: headers);
      if (response.statusCode == 200) {
        return activePartiesModelFromJson(response.body);
      } else {
        return activePartiesModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }
}