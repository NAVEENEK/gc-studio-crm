//this create a single dio object for all communication with backend, without this we need to create separate dio object for each communication
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/login_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient(){
    dio=Dio(
      BaseOptions(
        baseUrl:ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',//informing the server what is the body content type here json
          'Accept': 'application/json',//inform the server which type the data should be returned ,here json
        },
        ),
    );
    print("base url :${dio.options.baseUrl}");
    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(AuthInterceptor());
  }
}