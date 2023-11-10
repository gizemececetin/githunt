import 'package:githunt/features/github_service/data/network.dart';
import 'package:githunt/features/github_service/github_service.dart';

import '../../../features/github_service/presentation/bloc/bloc.dart';
import '../injection_container.dart';

void initGithubServiceFeatures() {
  // Bloc
  sl.registerFactory(() => GithubServiceBloc(
        query: "",
        getRepoResultsUsecase: sl<GetRepoResultsUsecase>(),
        getRepoIssuesUsecase: sl<GetRepoIssuesUsecase>(),
      ));

  // Use cases
  sl.registerLazySingleton(
      () => GetRepoResultsUsecase(sl<GithubServiceRepositoryImpl>()));
  sl.registerLazySingleton(
      () => GetRepoIssuesUsecase(sl<GithubServiceRepositoryImpl>()));

  // Repository
  sl.registerLazySingleton(() => GithubServiceRepositoryImpl(
      remoteDataSource: sl<GithubServiceRemoteDataSourceImpl>()));

  // Data sources
  sl.registerLazySingleton(
      () => GithubServiceRemoteDataSourceImpl(netClient: sl<NetClient>()));
}
