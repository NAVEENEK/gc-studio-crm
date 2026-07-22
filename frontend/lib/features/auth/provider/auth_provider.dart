import 'package:flutter/material.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/features/auth/model/agency_login_response.dart';
import 'package:frontend/features/auth/model/employee_login_response.dart';
import 'package:frontend/features/auth/model/login_request.dart';
import 'package:frontend/features/auth/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  EmployeeLoginResponse? _employee;
  AgencyLoginResponse? _agency;

  EmployeeLoginResponse? get employee => _employee;
  AgencyLoginResponse? get agency => _agency;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // Getter: allows other classes to read the loading state
  // without allowing them to modify it.

  Future<void> employeeLogin(LoginRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    _employee = null;
    notifyListeners();

    try {
      final employee = await _authService.employeeLogin(request);
      _employee = employee;
    } on ApiException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> agencyLogin(LoginRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    _agency = null;
    notifyListeners();

    try {
      final agency = await _authService.agencyLogin(request);
      _agency = agency;
    } on ApiException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
