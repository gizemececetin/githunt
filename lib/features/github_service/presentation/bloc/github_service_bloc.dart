import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:githunt/features/github_service/domain/usecases/get_repo_issues_usecase.dart';
import 'package:githunt/features/github_service/github_service.dart';

part 'github_service_event.dart';
part 'github_service_state.dart';

class GithubServiceBloc extends Bloc<GithubServiceEvent, GithubServiceState> {
  String query;
  final GetRepoResultsUsecase getRepoResultsUsecase;
  final GetRepoIssuesUsecase getRepoIssuesUsecase;

  GithubServiceBloc({
    required this.query,
    required this.getRepoResultsUsecase,
    required this.getRepoIssuesUsecase,
  }) : super(GithubServiceInitial()) {
    on<GetRepoResults>((event, emit) async {
      emit(GithubServiceLoading());
      final failureOrValue =
          await getRepoResultsUsecase(GetRepoResultsParams(query: query));
      failureOrValue.fold(
        (failure) => emit(GithubServiceInitial()),
        (value) {
          value.sort((a, b) {
            return a.repoName.toLowerCase().compareTo(b.repoName.toLowerCase());
          });
          emit(GithubSearchResults(repoList: value));
        },
      );
    });
    on<GetRepoRefresh>((event, emit) async {
      emit(GithubServiceLoading());

      add(GetRepoResults());
    });
    on<GetRepoIssues>((event, emit) async {
      emit(GithubServiceLoading());
      final failureOrValue = await getRepoIssuesUsecase(GetRepoIssuesParams(
        owner: event.owner,
        repo: event.owner,
      ));
      failureOrValue.fold(
        (failure) => emit(GithubServiceInitial()),
        (value) {
          emit(GithubIssuesResults(issueList: value));
        },
      );
    });
  }
}
