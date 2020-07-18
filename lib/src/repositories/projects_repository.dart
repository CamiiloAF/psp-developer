import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:psp_developer/src/models/projects_model.dart';
import 'package:psp_developer/src/providers/db_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/network_bound_resource.dart';
import 'package:psp_developer/src/utils/rate_limiter.dart';
import 'package:tuple/tuple.dart';

class ProjectsRepository {
  Future<Tuple2<int, List<ProjectModel>>> getAllProjects(
      bool isRefreshing) async {
    final networkBoundResource = _ProjectsNetworkBoundResource(RateLimiter());
    final response = await networkBoundResource.execute(isRefreshing);

    if (response.item2 == null) {
      return Tuple2(response.item1, []);
    } else {
      return response;
    }
  }
}

class _ProjectsNetworkBoundResource
    extends NetworkBoundResource<List<ProjectModel>> {
  final RateLimiter rateLimiter;

  final tableName = Constants.PROJECTS_TABLE_NAME;
  final _allProjects = 'allProjects';

  _ProjectsNetworkBoundResource(this.rateLimiter);

  @override
  Future<http.Response> createCall() async {
    final userId = json.decode(preferences.currentUser)['id'];
    final url = '${Constants.baseUrl}/projects/by-user/$userId';

    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  Future saveCallResult(List<ProjectModel> item) async {
    await DBProvider.db.deleteAll(tableName);

    if (item != null && item.isNotEmpty) {
      await DBProvider.db.insertList(item, tableName);
    }
  }

  @override
  bool shouldFetch(List<ProjectModel> data) =>
      data == null ||
      data.isEmpty ||
      rateLimiter.shouldFetch(_allProjects, Duration(minutes: 10));

  @override
  Future<List<ProjectModel>> loadFromLocalStorage() async => _getProjectsFromJson(
      await DBProvider.db.getAllModels(Constants.PROJECTS_TABLE_NAME));

  List<ProjectModel> _getProjectsFromJson(List<Map<String, dynamic>> res) {
    return res.isNotEmpty
        ? res
            .map((projectModel) => ProjectModel.fromJson(projectModel))
            .toList()
        : [];
  }

  @override
  void onFetchFailed() {
    rateLimiter.reset(_allProjects);
  }

  @override
  List<ProjectModel> decodeData(List<dynamic> payload) =>
      ProjectsModel.fromJsonList(payload).projects;
}
