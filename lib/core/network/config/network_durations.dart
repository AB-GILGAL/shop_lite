/// Network timeout durations.
///
/// These values are used by Dio when establishing a connection,
/// sending data, and waiting for a response.
abstract final class NetworkDurations {
  const NetworkDurations._();

  /// Maximum time allowed to establish a connection.
  static const Duration connectTimeout = Duration(seconds: 15);

  /// Maximum time allowed to send request data.
  static const Duration sendTimeout = Duration(seconds: 15);

  /// Maximum time allowed to receive response data.
  static const Duration receiveTimeout = Duration(seconds: 15);
}