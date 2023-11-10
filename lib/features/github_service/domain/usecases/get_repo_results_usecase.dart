import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../github_service.dart';

class GetRepoResultsUsecase extends Equatable
    implements UseCase<dynamic, GetRepoResultsParams> {
  final GithubServiceRepository repository;

  const GetRepoResultsUsecase(this.repository);

  @override
  Future<Either<Failure, List<RepoModel>>> call(GetRepoResultsParams params) async {
    return await repository.getRepositoryResults(params.query);
  }

  @override
  List<Object?> get props => [repository];
}

class GetRepoResultsParams extends Equatable {
  final String query;

  const GetRepoResultsParams({required this.query});
  @override
  List<Object?> get props => [query];
}
