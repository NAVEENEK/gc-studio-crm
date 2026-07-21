class AgencyLoginResponse {
  final String token;
  final int userId;
  final String userName;
  final String userRole;

  AgencyLoginResponse({
    required this.token,
    required this.userId,
    required this.userName,
    required this.userRole
  });

  factory AgencyLoginResponse.fromJson(
    Map<String, dynamic> json){
      final user=json["user"];

      return AgencyLoginResponse(
        token: json["token"], 
        userId: user["userId"], 
        userName: user["userName"], 
        userRole: user["userRole"]
        );

  }
}