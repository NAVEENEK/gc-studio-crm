import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  //keys
  static const _tokenKey = 'token';
  static const _employeeKey = 'employee_id';
  static const _clientKey = 'client_id';
  static const _nameKey = 'name';
  static const _roleKey = 'role';
  static const _userTypeKey = 'user_Type';

  //save jwt token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  //get jwt token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  //save logged in user information
  Future<void> saveUser({
    required int employeeId,
    int? clientId,
    required String name,
    required String role,
    String? userType,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_employeeKey, employeeId);
    if(clientId != null){
      await prefs.setInt(_clientKey, clientId);
    }
    await prefs.setString(_nameKey, name);
    await prefs.setString(_roleKey, role);
    if (userType != null) {
      await prefs.setString(_userTypeKey, userType);
    }
  }

  //get employee id
  Future<int?> getEmployeeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_employeeKey);
  }

  //get client id
  Future<int?> getClientId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_clientKey);
  }

  //get employee name
  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  //get employee role
  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  //get user type
  Future<String?> getuserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  //clear everything during logout
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
