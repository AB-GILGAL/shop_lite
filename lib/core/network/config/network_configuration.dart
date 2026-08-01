import 'network_environment.dart';

/// Provides environment-specific network configuration.
abstract final class NetworkConfiguration {
  const NetworkConfiguration._();

  /// Current application environment.
  ///
  /// Change this when switching between backend environments.
  static const NetworkEnvironment environment = NetworkEnvironment.development;

  static String get baseUrl {
    switch (environment) {
      case NetworkEnvironment.development:
      case NetworkEnvironment.staging:
      case NetworkEnvironment.production:
        return 'https://api.escuelajs.co/api/v1';
    }
  }

  /// Example configuration for projects with separate
  /// development, staging, and production servers.
  /// or
  /// Example implementation when each environment
  /// has its own backend.

  // static String get baseUrl {
  //   switch (environment) {
  //     case NetworkEnvironment.development:
  //       return 'https://dev-api.company.com/api/v1';

  //     case NetworkEnvironment.staging:
  //       return 'https://staging-api.company.com/api/v1';

  //     case NetworkEnvironment.production:
  //       return 'https://api.company.com/api/v1';
  //   }
  // }
}
