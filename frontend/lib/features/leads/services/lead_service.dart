
import 'package:frontend/core/constants/api_endpoints.dart';
import 'package:frontend/core/network/api_service.dart';
import 'package:frontend/features/leads/models/lead_model.dart';
import 'package:frontend/features/leads/models/lead_status_model.dart';

class LeadService {
  final ApiService _apiService;

  LeadService(this._apiService);

  //lead statis count
  Future<List<LeadStatusModel>> getLeadStatusCount() async{
    final Response =await _apiService.get(
      path:ApiEndpoints.leadStatusCount
       );
       final List<dynamic> data=Response.data["result"];

       return data
       .map((json)=>LeadStatusModel.fromJson(json))
       .toList();
  }

  Future<List<LeadModel>> getMyLeads({
    String? status,
    String? leadName
  })async{
    final Response=await _apiService.get(
      path: ApiEndpoints.getMyLeads,
      queryParameters: {
        if(status != null)"status":status,
        if(leadName != null && leadName.isNotEmpty)"leadName":leadName,
      }
      );

      final List<dynamic> data=Response.data["data"];

      return data
      .map((json)=>LeadModel.fromJson(json))
      .toList();
  }
}