import 'package:dio/dio.dart';

import 'network_exception.dart';

/// Converts Dio-specific exceptions into application-level
/// network exceptions.
abstract final class DioExceptionMapper {
  const DioExceptionMapper._();

  static NetworkException map(
    DioException exception,
  ) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkConnectionTimeoutException(
          message: exception.message,
        );

      case DioExceptionType.sendTimeout:
        return NetworkSendTimeoutException(
          message: exception.message,
        );

      case DioExceptionType.receiveTimeout:
        return NetworkReceiveTimeoutException(
          message: exception.message,
        );

      case DioExceptionType.transformTimeout:
        return NetworkTransformTimeoutException(
          message: exception.message,
        );

      case DioExceptionType.connectionError:
        return NetworkConnectionException(
          message: exception.message,
        );

      case DioExceptionType.badResponse:
        return NetworkResponseException(
          message: exception.message,
          statusCode: exception.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return NetworkCancelledException(
          message: exception.message,
        );

      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return NetworkUnknownException(
          message: exception.message,
        );
    }
  }
}
