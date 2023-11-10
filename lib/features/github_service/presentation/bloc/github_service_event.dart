part of 'github_service_bloc.dart';

abstract class GithubServiceEvent extends Equatable {
  const GithubServiceEvent();

  @override
  List<Object> get props => [];
}

class GetRepoResults extends GithubServiceEvent {}

class GetRepoRefresh extends GithubServiceEvent {}

class GetRepoIssues extends GithubServiceEvent {
  final String owner;
  final String repo;

  const GetRepoIssues({required this.owner, required this.repo});

  @override
  List<Object> get props => [owner, repo];
}
