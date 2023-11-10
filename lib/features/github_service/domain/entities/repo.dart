import 'package:equatable/equatable.dart';

/// An entity representing an github repo.
class Repo extends Equatable {
  final String repoName;
  final String url;
  final String ownerName;
  final int watchersCount;

  const Repo({
    required this.repoName,
    required this.url,
    required this.ownerName,
    required this.watchersCount,
  });
  @override
  List<Object?> get props => [
        repoName,
        url,
        ownerName,
        watchersCount,
      ];
}
