import '../environment.dart';

class DefaultEnvironmentConfiguration extends EnvironmentConfiguration {
  DefaultEnvironmentConfiguration({
    String? experienceAppId,
  }) : super(
          baseUrl: 'https://v3test.ubanquity.io',
          defaultToken: '',
        );
}
