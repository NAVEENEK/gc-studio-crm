//convert dio error into user friendly messages
import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  const ApiException({required this.message, this.statusCode});
  //A factory constructor is a constructor that contains logic to decide what object to return based on the input.
  factory ApiException.fromDioException(DioException exception) {
    //convert dio error
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiException(
          message: "Connection timeout. please try again",
        );

      case DioExceptionType.sendTimeout:
        return const ApiException(
          message: "Request timeout while sending data",
        );

      case DioExceptionType.receiveTimeout:
        return const ApiException(message: "Server took too long to respond.");

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final data = exception.response?.data;
        final message = data is Map<String, dynamic>
            ? data["message"] ?? 'Something went wrong'
            : 'Something went wrong';

        return ApiException(message: message, statusCode: statusCode);

      case DioExceptionType.connectionError:
        return const ApiException(message: 'No internet connection');

      case DioExceptionType.cancel:
        return const ApiException(message: "Request was cancelled");

      case DioExceptionType.unknown:
        return const ApiException(message: "An unexpected error occurred");
      default:
        return const ApiException(message: "Something went wrong");
    }
  }

  @override
  String toString() => message;
}
