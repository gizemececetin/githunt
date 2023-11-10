import 'default_environment_configuration.dart';

abstract class EnvironmentConfiguration {
  static EnvironmentConfiguration current = DefaultEnvironmentConfiguration();

  final String baseUrl;

  final String port;

  final String defaultToken;

  final String pathPrefix;

  String get fullUrl =>
      baseUrl + (port.isNotEmpty ? ':$port' : '') + pathPrefix;

  EnvironmentConfiguration({
    required this.baseUrl,
    this.port = '',
    required this.defaultToken,
    this.pathPrefix = '',
  });
}
