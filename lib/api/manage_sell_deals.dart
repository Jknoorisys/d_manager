import 'package:dio/dio.dart';
import '../constants/constants.dart';
import '../models/sell_models/create_sell_deal_model.dart';
import '../models/sell_models/get_sell_deal_model.dart';
import '../models/sell_models/sell_deal_list_model.dart';

final dio = Dio();
class SellDealDetails{
  Future<CreateSellDealModel?> createNewSellDeal(
      String userID,
      String sellDate,
      String firmID,
      String partyID,
      String qualityID,
      String totalThan,
      String rate)async{

    // String userID = await HelperFunctions.getUserID();
    try{
      Map<String, dynamic> body = {
        "user_id": userID,
        "sell_date": sellDate,
        "firm_id": firmID,
        "party_id": partyID,
        "quality_id": qualityID,
        "total_than": totalThan,
        "rate": rate,
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

  Future<SellDealListModel?> sellDealListApi()async{
    try{
      Map<String, dynamic> body = {};
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
        "sell_id": sellID
      };
      print("aaaaa======");
      Response response = await dio.post(getSellDeal, data: body,
        options: Options(
          headers: {
            "X-API-Key":"NYS03223"
          },
        ),
      );
      if (response.statusCode == 200) {
        print("response===== ${response.data}");
        return GetSellDealModel.fromJson(response.data);
      }
      else {
        return GetSellDealModel.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
    }
  }
}