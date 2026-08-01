/// Standard HTTP header names.
///
/// Using constants helps prevent typos and provides
/// a single source of truth across the application.
abstract final class NetworkHeaders {
  const NetworkHeaders._();

  /// Request media type expected from the server.
  static const String accept = 'Accept';

  /// Media type of the request body.
  static const String contentType = 'Content-Type';

  /// Authorization token.
  static const String authorization = 'Authorization';

  /// Preferred response language.
  static const String acceptLanguage = 'Accept-Language';

  /// Information about the client application.
  static const String userAgent = 'User-Agent';

  /// Cache directives.
  static const String cacheControl = 'Cache-Control';

  /// Entity tag for cache validation.
  static const String eTag = 'ETag';

  /// Conditional request using the last modified date.
  static const String ifModifiedSince = 'If-Modified-Since';

  /// Conditional request using an entity tag.
  static const String ifNoneMatch = 'If-None-Match';
}