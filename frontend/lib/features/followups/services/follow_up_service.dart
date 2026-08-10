
import 'package:frontend/core/constants/api_endpoints.dart';
import 'package:frontend/core/network/api_service.dart';
import 'package:frontend/features/followups/models/follow_up_model.dart';

class FollowUpService {
  final ApiService _apiService;

  FollowUpService(this._apiService);

  //dashboard- today's follow ups
  Future<List<FollowUpModel>> fetchTodayFollowUps() async{
    final response =await _apiService.get(
      path: ApiEndpoints.fetchMyFollowUps,
      queryParameters: {
        "filter":"today"
      }
    );

    final List<dynamic> data=response.data["result"];

    return data
    .map((json)=>FollowUpModel.fromJson(json))
    .toList();
  }

  Future<List<FollowUpModel>> fetchMyFollowUps({
    String? leadName,
    String? status,
    String? filter
  })
  async{
    final response=await _apiService.get(
      path: ApiEndpoints.fetchMyFollowUps,
      queryParameters: {
        if(status != null)"status":status,
        if(leadName != null && leadName.isNotEmpty)"leadName":leadName,
        if(filter != null)"filter":filter
      }
      );

      final List<dynamic> data=response.data["result"];

      return data
      .map((json)=>FollowUpModel.fromJson(json))
      .toList();
  }
}