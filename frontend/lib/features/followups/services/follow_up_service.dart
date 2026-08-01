
import 'package:frontend/core/constants/api_endpoints.dart';
import 'package:frontend/core/network/api_service.dart';
import 'package:frontend/features/followups/models/follow_up_model.dart';

class FollowUpService {
  final ApiService _apiService;

  FollowUpService(this._apiService);

  //dashboard- today's follow ups
  Future<List<FollowUpModel>> fetchTodayFollowUps() async{
    final Response =await _apiService.get(
      path: ApiEndpoints.fetchTodayFollowUps.replaceFirst(":filter", "today")
    );

    final List<dynamic> data=Response.data["result"];

    return data
    .map((json)=>FollowUpModel.fromJson(json))
    .toList();
  }
}