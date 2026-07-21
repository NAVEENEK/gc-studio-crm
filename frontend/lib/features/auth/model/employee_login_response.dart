class EmployeeLoginResponse {
  final String token;
  final int employeeId;
  final int clientId;
  final String name;
  final String role;
  

  EmployeeLoginResponse({
    required this.token,
    required this.employeeId,
    required this.clientId,
    required this.name,
    required this.role,
  });

  factory EmployeeLoginResponse.fromJson(
    Map<String, dynamic> json){
      final employee=json["employee"];

      return EmployeeLoginResponse(
        token: json["token"], 
        employeeId: employee["employeeId"], 
        clientId: employee["clientId"],
        name: employee["name"], 
        role: employee["role"], 
        );
    }
}