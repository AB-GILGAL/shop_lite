import 'package:dio/dio.dart';
import 'package:shop_lite/core/network/exceptions/dio_exception_mapper.dart';
import 'package:shop_lite/core/network/interceptors/network_logging_interceptor.dart';

import '../config/network_configuration.dart';
import '../config/network_constants.dart';
import '../config/network_durations.dart';
import '../config/network_headers.dart';

/// Central HTTP client used by the application.
///
/// ApiClient is responsible for configuring Dio and providing
/// a consistent interface for making HTTP requests.
///
/// Feature-specific data sources should communicate with the
/// backend through this client rather than creating their own
/// Dio instances.
final class ApiClient {
  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: NetworkConfiguration.baseUrl,
          connectTimeout: NetworkDurations.connectTimeout,
          sendTimeout: NetworkDurations.sendTimeout,
          receiveTimeout: NetworkDurations.receiveTimeout,
          headers: {
            NetworkHeaders.contentType: NetworkConstants.jsonContentType,
            NetworkHeaders.accept: NetworkConstants.jsonAccept,
          },
        ),
      ) {
    _dio.interceptors.add(NetworkLoggingInterceptor());
  }

  final Dio _dio;

  /// Performs a GET request.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (exception) {
      throw DioExceptionMapper.map(exception);
    }
  }

  /// Performs a POST request.
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (exception) {
      throw DioExceptionMapper.map(exception);
    }
  }

  /// Performs a PUT request.
  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (exception) {
      throw DioExceptionMapper.map(exception);
    }
  }

  /// Performs a DELETE request.
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (exception) {
      throw DioExceptionMapper.map(exception);
    }
  }
}
