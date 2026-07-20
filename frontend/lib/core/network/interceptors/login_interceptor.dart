//this is for developer to underatand(display) about the request that send and responce to that 
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor{
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ){
    print('========REQUEST========');
    print('${options.method} ${options.uri}');
    print('Headers: ${options.headers}');
    print('Body: ${options.data}');

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler
  ){
    print('========RESPONSE========');
    print('${response.statusCode} ${response.requestOptions.uri}');
    print('Response: ${response.data}');
    
    handler.next(response);
  }

  @override 
  void onError(
    DioException err,
    ErrorInterceptorHandler handler
  ){
    print('========Error========');
    print('${err.response?.statusCode}');
    print('${err.requestOptions.uri}');
    print('${err.message}');

    handler.next(err);
  }
}