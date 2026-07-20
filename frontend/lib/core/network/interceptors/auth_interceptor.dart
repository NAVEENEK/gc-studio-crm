// automatically attach the jwt token to the request so that the backend can access the jwt token,without this we need to the attach jwt to all the request individually  
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor{
  //we extends Interceptor to this class beacuse the dio is designed to work with the object of type Interceptor 
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  )async{

    handler.next(options);
  }
}