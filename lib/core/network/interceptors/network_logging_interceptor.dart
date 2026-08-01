import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Logs HTTP requests, responses, and errors.
///
/// This interceptor is intended for development and debugging.
/// Sensitive information such as authorization tokens should not
/// be logged in production.
final class NetworkLoggingInterceptor extends Interceptor {
  NetworkLoggingInterceptor({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d(
      'REQUEST\n'
      '${options.method} ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Query Parameters: ${options.queryParameters}\n'
      'Body: ${options.data}',
    );

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;

    final dataSummary = switch (data) {
      List<dynamic> value => 'List (${value.length} items)',
      Map<String, dynamic> value => 'Map (${value.length} fields)',
      null => 'null',
      _ => data.runtimeType.toString(),
    };

    _logger.d(
      'RESPONSE\n'
      '${response.statusCode} ${response.requestOptions.uri}\n'
      'Data: $dataSummary',
    );

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final responseData = err.response?.data;

    final responseSummary = switch (responseData) {
      List<dynamic> value => 'List (${value.length} items)',
      Map<String, dynamic> value => 'Map (${value.length} fields)',
      null => 'null',
      _ => responseData.runtimeType.toString(),
    };
    _logger.e(
      'NETWORK ERROR\n'
      '${err.requestOptions.method} ${err.requestOptions.uri}\n'
      'Status Code: ${err.response?.statusCode}\n'
      'Type: ${err.type}\n'
      'Message: ${err.message}\n'
      'Response: $responseSummary',
      error: err.error,
      stackTrace: err.stackTrace,
    );

    handler.next(err);
  }
}
