import 'package:dio/dio.dart';
import 'package:frontend/core/constants/api_endpoints.dart';
import 'package:frontend/core/network/api_service.dart';
import 'package:frontend/features/auth/model/agency_login_response.dart';
import 'package:frontend/features/auth/model/employee_login_response.dart';
import 'package:frontend/features/auth/model/login_request.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<EmployeeLoginResponse> employeeLogin(
    LoginRequest request
  )async{
    final response=await _apiService.post(
      path: ApiEndpoints.employeeLogin,
      data: request.toJson(),
    );
    return EmployeeLoginResponse.fromJson(response.data);
  }

  Future<AgencyLoginResponse> agencyLogin(
    LoginRequest request
  )async{
    final response=await _apiService.post(
      path: ApiEndpoints.agencyLogin,
      data:request.toJson()
      );
      return AgencyLoginResponse.fromJson(response.data);
  }
}