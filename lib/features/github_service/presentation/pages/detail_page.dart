import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class IssuePage extends StatefulWidget {
  const IssuePage({super.key});

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  late GithubServiceBloc _githubServiceBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    _githubServiceBloc = BlocProvider.of<GithubServiceBloc>(context);

    return BlocBuilder<GithubServiceBloc, GithubServiceState>(
      bloc: _githubServiceBloc,
      builder: (context, state) {
        return state is GithubIssuesResults
            ? ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.issueList[index].toString()),
                  );
                })
            : state is GithubServiceLoading
                ? const Center(child: CircularProgressIndicator())
                : const Center(child: Text("No data"));
      },
    );
  }
}
