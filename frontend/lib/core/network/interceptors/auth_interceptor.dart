// automatically attach the jwt token to the request so that the backend can access the jwt token,without this we need to the attach jwt to all the request individually  
import 'package:dio/dio.dart';
import 'package:frontend/core/storage/storage_service.dart';

class AuthInterceptor extends Interceptor{
  //we extends Interceptor to this class beacuse the dio is designed to work with the object of type Interceptor 

  final StorageService _storageService;

  AuthInterceptor(this._storageService);
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  )async{

    final token =await _storageService.getToken();

    if(token != null){
      options.headers["Authorization"]="Bearer $token";
    }

    handler.next(options);
  }
}