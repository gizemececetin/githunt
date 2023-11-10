import '../../../../core/constants/app_constants.dart';
import '../models/models.dart';
import '../network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class GithubServiceRemoteDataSource {
  Future getRepositoryResults(String query);
  Future getRepositoryIssues({required String owner, required String repo});
}

class GithubServiceRemoteDataSourceImpl
    implements GithubServiceRemoteDataSource {
  /// The NetClient to use for the network requests
  final NetClient netClient;

  GithubServiceRemoteDataSourceImpl({required this.netClient});

  @override
  Future<List<RepoModel>> getRepositoryResults(String query) async {
    final url =
        Uri.parse('${AppConstants.githubRepoUrl}?q=$query&per_page=50&sort=');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> itemList = data['items'];
      List<RepoModel> repoList =
          itemList.map((e) => RepoModel.fromJson(e)).toList();

      return repoList;
    } else {
      throw Exception('Failed to fetch repositories');
    }
  }

  @override
  Future<List<RepoModel>> getRepositoryIssues({
    required String owner,
    required String repo,
  }) async {
    final url = Uri.parse('${AppConstants.githubIssueUrl}/$owner/$repo/issues');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    } else {
      throw Exception('Failed to fetch repositories');
    }
  }
}
