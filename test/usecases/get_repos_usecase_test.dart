import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:githunt/features/github_service/github_service.dart';
import 'package:mockito/mockito.dart';

class MockGithubServiceRepository extends Mock
    implements GithubServiceRepository {}

void main() {
  late GetRepoResultsUsecase usecase;
  late MockGithubServiceRepository mockRepository;

  setUp(() {
    mockRepository = MockGithubServiceRepository();
    usecase = GetRepoResultsUsecase(mockRepository);
  });

  const testQuery = 'flutter';

  test('should get a list of RepoModel from the repository', () async {
    // Arrange
    final List<RepoModel> mockRepoList = [
      const RepoModel(
          repoName: "repoName",
          url: "url",
          ownerName: "ownerName",
          watchersCount: 123),
      const RepoModel(
          repoName: "repoName",
          url: "url",
          ownerName: "ownerName",
          watchersCount: 123)
    ];
    when(mockRepository.getRepositoryResults(testQuery))
        .thenAnswer((_) async => Future.value(Right(mockRepoList)));

    // Act
    final result = await usecase(const GetRepoResultsParams(query: testQuery));

    // Assert
    expect(result, Right(mockRepoList));
    verify(mockRepository.getRepositoryResults(testQuery));
    verifyNoMoreInteractions(mockRepository);
  });
}
