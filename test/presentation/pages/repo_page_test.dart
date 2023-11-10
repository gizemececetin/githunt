import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:githunt/features/github_service/presentation/bloc/github_service_bloc.dart';
import 'package:githunt/features/github_service/presentation/pages/repo_page.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('RepoPage Widget Test', () {
    late MockGithubServiceBloc mockBloc;

    setUp(() {
      mockBloc = MockGithubServiceBloc();
    });

    testWidgets('Renders RepoPage correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockBloc,
            child: RepoPage(),
          ),
        ),
      );

      // Verify if the RepoPage is rendered correctly
      expect(find.byType(RepoPage), findsOneWidget);
      expect(find.text("Search repositories..."), findsOneWidget);
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('Renders loading indicator when bloc is in loading state',
        (WidgetTester tester) async {
      when(mockBloc.state).thenReturn(GithubServiceLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockBloc,
            child: RepoPage(),
          ),
        ),
      );

      // Verify if the loading indicator is rendered correctly
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Renders repo list when bloc is in search results state',
        (WidgetTester tester) async {
      when(mockBloc.state).thenReturn(GithubSearchResults(repoList: []));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockBloc,
            child: RepoPage(),
          ),
        ),
      );

      // Verify if the repo list is rendered correctly
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Triggers search when user enters query',
        (WidgetTester tester) async {
      when(mockBloc.state).thenReturn(GithubSearchResults(repoList: []));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockBloc,
            child: RepoPage(),
          ),
        ),
      );

      // Simulate user entering a query
      await tester.enterText(find.byType(TextFormField), 'flutter');

      // Trigger the search
      await tester.pump();

      // Verify if the search is triggered correctly
      verify(mockBloc.add(GetRepoResults()));
    });
  });
}

class MockGithubServiceBloc extends Mock
    implements Bloc<GithubServiceEvent, GithubServiceState> {}

class MockBloc<T extends BlocBase<Object>, R> extends Mock
    implements BlocBase<Object> {}
