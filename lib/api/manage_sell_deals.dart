import 'package:dio/dio.dart';
import '../constants/constants.dart';
import '../helpers/helper_functions.dart';
import '../models/sell_models/create_sell_deal_model.dart';
import '../models/sell_models/get_sell_deal_model.dart';
import '../models/sell_models/sell_deal_list_model.dart';
import '../models/sell_models/status_sell_deal_model.dart';
import '../models/sell_models/update_sell_deal_model.dart';

final dio = Dio();
class SellDealDetails{
  Future<CreateSellDealModel?> createNewSellDeal(
      String sellDate,
      String firmID,
      String partyID,
      String qualityID,
      String totalThan,
      String rate,
      String sellDueDate)async{
    try{
      Map<String, dynamic> body = {
        "user_id": HelperFunctions.getUserID(),
        "sell_date": sellDate,
        "firm_id": firmID,
        "party_id": partyID,
        "quality_id": qualityID,
        "total_than": totalThan,
        "rate": rate,
        "sell_due_date":sellDueDate
      };
      Response response = await dio.post(createSellDeal, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),);
      if (response.statusCode == 200)
      {
        return CreateSellDealModel.fromJson(response.data);
      }
      else {
        return CreateSellDealModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<SellDealListModel?> sellDealListApi(
      String pageNo,
      String search,
      )async{
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "page_no":pageNo,
        "search":search,
        "firm_id":HelperFunctions.getFirmID() ?? "",
        "party_id":HelperFunctions.getPartyID() ?? "",
        "quality_id":HelperFunctions.getClothID() ?? "",
        "deal_status":HelperFunctions.getDealStatus() ?? "",
      };
      print("partyid==== ${HelperFunctions.getPartyID()}");
      print("dealStatus==== ${body}");
      Response response = await dio.post(sellDealList, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );
      if (response.statusCode == 200)
      {
        return SellDealListModel.fromJson(response.data);
      }
      else {
        return SellDealListModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<GetSellDealModel?> getSellDealApi(
      String sellID,
      )async{
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "sell_id": sellID
      };
      Response response = await dio.post(getSellDeal, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );
      if (response.statusCode == 200) {
        return GetSellDealModel.fromJson(response.data);
      }
      else {
        return GetSellDealModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<UpdateSellDealModel?> updateSellDealApi(
      String sellID,
      String sellDate,
      String firmID,
      String partyID,
      String qualityID,
      String totalThan,
      String rate,
      String sellDueDate)async{
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "sell_id":sellID,
        "sell_date": sellDate,
        "firm_id": firmID,
        "party_id": partyID,
        "quality_id": qualityID,
        "total_than": totalThan,
        "rate": rate,
        "sell_due_date":sellDueDate
      };
      Response response = await dio.post(updateSellDeal, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),);
      if (response.statusCode == 200) {
        return UpdateSellDealModel.fromJson(response.data);
      }
      else {
        return UpdateSellDealModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<UpdateSellDealStatusModel?> updateSellDealStatus(
      String sellID,
      String dealStatus,
      )async{
    try{
      Map<String, dynamic> body = {
        "user_id":HelperFunctions.getUserID(),
        "sell_id": sellID,
        "deal_status":dealStatus,
      };
      print("bodey==== $body");
      Response response = await dio.post(statusSellDeal, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );

      if (response.statusCode == 200) {
        return UpdateSellDealStatusModel.fromJson(response.data);
      }
      else {
        return UpdateSellDealStatusModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }
}