import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/dropdown_models/drop_down_party_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_cloth_quality_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_film_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_hammal_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_transport_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_yarn_list_model.dart';
import 'package:http/http.dart';

class DropdownServices {
  Future<DropdownFirmListModel?> firmList() async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(dropdownFirmListUrl), headers: headers);
      if (response.statusCode == 200) {
        return dropdownFirmListModelFromJson(response.body);
      } else {
        return dropdownFirmListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<DropdownPartyListModel?> partyList() async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(dropdownPartyListUrl), headers: headers);
      if (response.statusCode == 200) {
        return dropdownPartyListModelFromJson(response.body);
      } else {
        return dropdownPartyListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<DropdownClothQualityListModel?> clothQualityList() async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(dropdownClothQualityListUrl), headers: headers);
      if (response.statusCode == 200) {
        return dropdownClothQualityListModelFromJson(response.body);
      } else {
        return dropdownClothQualityListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<DropdownYarnListModel?> yarnList() async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(dropdownYarnListUrl), headers: headers);
      if (response.statusCode == 200) {
        return dropdownYarnListModelFromJson(response.body);
      } else {
        return dropdownYarnListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<DropdownTransportListModel?> transportList() async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(dropdownTransportListUrl), headers: headers);
      if (response.statusCode == 200) {
        return dropdownTransportListModelFromJson(response.body);
      } else {
        return dropdownTransportListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<DropdownHammalListModel?> hammalList() async {
    try {
      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };
      Response response = await post(Uri.parse(dropdownHammalListUrl), headers: headers);
      if (response.statusCode == 200) {
        return dropdownHammalListModelFromJson(response.body);
      } else {
        return dropdownHammalListModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }
}