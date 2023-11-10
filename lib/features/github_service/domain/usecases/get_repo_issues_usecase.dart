import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../github_service.dart';

class GetRepoIssuesUsecase extends Equatable
    implements UseCase<dynamic, GetRepoIssuesParams> {
  final GithubServiceRepository repository;

  const GetRepoIssuesUsecase(this.repository);

  @override
  Future<Either<Failure, List<RepoModel>>> call(
      GetRepoIssuesParams params) async {
    return await repository.getRepositoryIssues(
        owner: params.owner, repo: params.repo);
  }

  @override
  List<Object?> get props => [repository];
}

class GetRepoIssuesParams extends Equatable {
  final String owner;
  final String repo;

  const GetRepoIssuesParams({required this.owner, required this.repo});
  @override
  List<Object?> get props => [owner, repo];
}
