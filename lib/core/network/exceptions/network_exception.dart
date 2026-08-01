/// Base exception for network-related failures.
sealed class NetworkException implements Exception {
  const NetworkException({
    this.message,
    this.statusCode,
  });

  final String? message;
  final int? statusCode;

  @override
  String toString() {
    return message ?? 'A network error occurred.';
  }
}

/// The request exceeded the configured connection timeout.
final class NetworkConnectionTimeoutException
    extends NetworkException {
  const NetworkConnectionTimeoutException({
    super.message,
  });
}

/// The request exceeded the configured send timeout.
final class NetworkSendTimeoutException
    extends NetworkException {
  const NetworkSendTimeoutException({
    super.message,
  });
}

/// The server response exceeded the configured receive timeout.
final class NetworkReceiveTimeoutException
    extends NetworkException {
  const NetworkReceiveTimeoutException({
    super.message,
  });
}

/// The response/data transformation exceeded the configured timeout.
final class NetworkTransformTimeoutException
    extends NetworkException {
  const NetworkTransformTimeoutException({
    super.message,
  });
}


/// The device could not establish a connection to the server.
final class NetworkConnectionException
    extends NetworkException {
  const NetworkConnectionException({
    super.message,
  });
}

/// The server returned an unsuccessful HTTP status code.
final class NetworkResponseException
    extends NetworkException {
  const NetworkResponseException({
    super.message,
    super.statusCode,
  });
}

/// The request was cancelled.
final class NetworkCancelledException
    extends NetworkException {
  const NetworkCancelledException({
    super.message,
  });
}

/// An unexpected network error occurred.
final class NetworkUnknownException
    extends NetworkException {
  const NetworkUnknownException({
    super.message,
  });
}