//this is like a bridge between feature services(request senders) and dio so that any changes to the request format can be done in a single place
import 'package:dio/dio.dart';
import 'api_exception.dart';
import 'dio_client.dart';

class ApiService {
  late final Dio _dio;

  ApiService(DioClient dioClient) {
    _dio = dioClient.dio;
  }

  //GET request
  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  //POST request
  Future<Response> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  //PUT request
  Future<Response> put({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  //PATCH request
  Future<Response> patch({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  //DELETE request
  Future<Response> delete({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
