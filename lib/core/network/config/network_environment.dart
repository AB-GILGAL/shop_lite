/// Available backend environments.
///
/// The current project only uses the development environment,
/// but the enum allows easy expansion to staging and production.
enum NetworkEnvironment {
  development,
  staging,
  production,
}