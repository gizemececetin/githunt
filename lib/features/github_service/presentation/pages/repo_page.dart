import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:githunt/core/extensions/navigation_extension.dart';
import 'package:githunt/features/github_service/presentation/bloc/github_service_bloc.dart';

import '../../domain/entities/repo.dart';
import '../widgets/repo_card.dart';

class RepoPage extends StatefulWidget {
  const RepoPage({super.key});

  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  late GithubServiceBloc _githubServiceBloc;
  final TextEditingController _searchQuery = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: RefreshIndicator(
          onRefresh: () async => _onRefresh(), child: _buildBody(context)),
    );
  }

  AppBar _buildAppBar() => AppBar(
          title: TextFormField(
        autofocus: true,
        controller: _searchQuery,
        onChanged: (value) => _onSearch(value),
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(end: 16.0),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            hintText: "Search repositories...",
            hintStyle: TextStyle(color: Colors.white)),
      ));

  Widget _buildBody(context) {
    _githubServiceBloc = BlocProvider.of<GithubServiceBloc>(context);

    return BlocConsumer<GithubServiceBloc, GithubServiceState>(
      bloc: _githubServiceBloc,
      listener: (context, state) {
        switch (state.runtimeType) {
          case GithubIssuesResults:
            context.navigateTo('/issues');
            break;
        }
      },
      builder: (context, state) {
        return state is GithubSearchResults
            ? ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onRepoCardTapped(state.repoList[index]),
                    child: RepoCard(
                      repo: state.repoList[index],
                    ),
                  );
                })
            : state is GithubServiceLoading
                ? const Center(child: CircularProgressIndicator())
                : const Center(child: Text("No data"));
      },
    );
  }

  _onSearch(String query) {
    if (query.length >= 4) {
      _githubServiceBloc.query = query;
      _submitQuery();
    }
  }

  _submitQuery() {
    _githubServiceBloc.add(GetRepoResults());
  }

  _onRefresh() {
    _githubServiceBloc.add(GetRepoRefresh());
  }

  onRepoCardTapped(Repo repo) {
    
    _githubServiceBloc
        .add(GetRepoIssues(owner: repo.ownerName, repo: repo.repoName));
  }
}
