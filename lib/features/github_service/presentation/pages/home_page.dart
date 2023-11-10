import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:githunt/features/github_service/presentation/bloc/github_service_bloc.dart';
import '../../../../../lib.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GithubServiceBloc>(),
    );
  }
}
