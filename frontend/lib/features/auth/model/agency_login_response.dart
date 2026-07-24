class AgencyLoginResponse {
  final String token;
  final int userId;
  final String userName;
  final String userRole;
  final String userType;

  AgencyLoginResponse({
    required this.token,
    required this.userId,
    required this.userName,
    required this.userRole,
    required this.userType
  });

  factory AgencyLoginResponse.fromJson(
    Map<String, dynamic> json){
      final user=json["user"];

      return AgencyLoginResponse(
        token: json["token"], 
        userId: user["userId"], 
        userName: user["userName"], 
        userRole: user["userRole"],
        userType: user["userType"]
        );

  }
}