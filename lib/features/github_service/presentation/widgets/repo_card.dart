import 'package:flutter/material.dart';

import '../../domain/entities/repo.dart';

class RepoCard extends StatelessWidget {
  final Repo repo;
  const RepoCard({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListTile(
            title: Text(repo.repoName,
                style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(repo.ownerName,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  repo.watchersCount.toString(),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.remove_red_eye_outlined,
                  size: 20,
                ),
              ],
            ),
          )),
    );
  }
}
