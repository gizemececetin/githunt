import 'package:githunt/features/github_service/domain/entities/repo.dart';

class RepoModel extends Repo {
  const RepoModel({
    required super.repoName,
    required super.url,
    required super.ownerName,
    required super.watchersCount,
  });
  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      repoName: json["name"],
      url: json['html_url'],
      ownerName: json["owner"]["login"],
      watchersCount: json["watchers_count"],
    );
  }
}
