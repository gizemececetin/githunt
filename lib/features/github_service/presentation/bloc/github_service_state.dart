part of 'github_service_bloc.dart';

abstract class GithubServiceState extends Equatable {
  const GithubServiceState();

  @override
  List<Object> get props => [];
}

class GithubServiceInitial extends GithubServiceState {}

class GithubServiceLoading extends GithubServiceState {}

class GithubSearchResults extends GithubServiceState {
  final List<RepoModel> repoList;

  const GithubSearchResults({required this.repoList});

  @override
  List<Object> get props => [repoList];
}

class GithubIssuesResults extends GithubServiceState {
  final List<RepoModel> issueList;

  const GithubIssuesResults({required this.issueList});

  @override
  List<Object> get props => [issueList];
}
