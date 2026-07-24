import 'package:flutter/material.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/core/storage/storage_service.dart';
import 'package:frontend/features/auth/model/agency_login_response.dart';
import 'package:frontend/features/auth/model/employee_login_response.dart';
import 'package:frontend/features/auth/model/login_request.dart';
import 'package:frontend/features/auth/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final StorageService _storageService;

  AuthProvider(
    this._authService,
    this._storageService
    );

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

      //save token
      await _storageService.saveToken(employee.token);

      //save logged-in user details
      await _storageService.saveUser(
        employeeId: employee.employeeId, 
        clientId: employee.clientId, 
        name: employee.name, 
        role: employee.role
        );
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

      await _storageService.saveToken(agency.token);

      await _storageService.saveUser(
        employeeId: agency.userId, 
        name: agency.userName, 
        role: agency.userRole,
        userType: agency.userType
        );
    } on ApiException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(LoginRequest request)
  async{
    await employeeLogin(request);

    if(_employee != null){
      await agencyLogin(request);
    }
  }
}
