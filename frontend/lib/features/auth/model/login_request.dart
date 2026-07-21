//This model represents the login data our app sends to the backend
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password
  });
//this convert the object to json 
  Map<String, dynamic> toJson(){
    return{
      "email":email,
      "password":password
    };
  }
}