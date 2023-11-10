import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../github_service.dart';

class GithubServiceRepositoryImpl extends GithubServiceRepository {
  final GithubServiceRemoteDataSource remoteDataSource;
  ServerFailure serverFailure = ServerFailure();

  GithubServiceRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<RepoModel>>> getRepositoryResults(
      String query) async {
    try {
      final List<RepoModel> response =
          await remoteDataSource.getRepositoryResults(query);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  @override
  Future<Either<Failure, List<RepoModel>>> getRepositoryIssues(
      {required String owner, required String repo}) async {
    try {
      final List<RepoModel> response =
          await remoteDataSource.getRepositoryIssues(owner:owner, repo: repo);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
