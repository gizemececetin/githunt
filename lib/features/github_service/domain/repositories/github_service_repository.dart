import 'package:dartz/dartz.dart';
import 'package:githunt/features/github_service/github_service.dart';

import '../../../../core/core.dart';

abstract class GithubServiceRepository {
  Future<Either<Failure, List<RepoModel>>> getRepositoryResults(String query);
  Future<Either<Failure, List<RepoModel>>> getRepositoryIssues(
      {required String owner, required String repo});
}
