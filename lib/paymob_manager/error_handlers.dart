// error_handlers.dart
import 'package:dio/dio.dart';

class ErrorHandler {
  static String handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please try again later.';
      case DioExceptionType.sendTimeout:
        return 'Request timed out while sending data.';
      case DioExceptionType.receiveTimeout:
        return 'Server response timed out.';
      case DioExceptionType.badResponse:
        return 'Server error: ${dioError.response?.data ?? 'No data'}';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
        return 'An unexpected error occurred: ${dioError.message}';
      default:
        return 'Unknown error: ${dioError.message}';
    }
  }

  static String handleGeneralError(dynamic error) {
    return 'An error occurred: ${error.toString()}';
  }
}
