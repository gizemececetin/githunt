import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:githunt/features/github_service/presentation/pages/detail_page.dart';

import 'features/github_service/presentation/bloc/bloc.dart';
import 'features/github_service/presentation/pages/pages.dart';
import 'lib.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(const GitHuntApp());
}

class GitHuntApp extends StatelessWidget {
  const GitHuntApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<GithubServiceBloc>(),
        child: MaterialApp(
          title: 'Github Search',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const RepoPage(),
            '/issues': (context) => IssuePage(),
          },
        ));
  }
}
