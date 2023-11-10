import 'package:get_it/get_it.dart';
import 'package:githunt/features/github_service/data/network.dart';

import 'features/features.dart';

final sl = GetIt.instance;

@override
Future<void> init() async {
  // Core
  await initCore();
  // Features
  initGithubServiceFeatures();
}

initCore() async => sl.registerLazySingleton<NetClient>(() => NetClient());
