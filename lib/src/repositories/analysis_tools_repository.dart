import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';
import 'package:psp_developer/src/models/analysis_tools/analysis_tools_model.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/network_bound_resource.dart';
import 'package:tuple/tuple.dart';

class AnalysisToolsRepository {
  Future<Tuple2<int, List<AnalysisToolsModel>>> getAnalysisTools(
      int userId) async {
    final networkBoundResource = _AnalysisToolsNetworkBoundResource(userId);

    final response = await networkBoundResource.execute(true);

    if (response.item2 == null) {
      return Tuple2(response.item1, []);
    } else {
      return response;
    }
  }
}

class _AnalysisToolsNetworkBoundResource
    extends NetworkBoundResource<List<AnalysisToolsModel>> {
  final int userId;

  _AnalysisToolsNetworkBoundResource(this.userId);

  @override
  Future<Response> createCall() async {
    final url = '${Constants.baseUrl}/analysis-tools/by-user/$userId';
    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  List<AnalysisToolsModel> decodeData(List<dynamic> payload) =>
      ListOfAnalysisToolsModel.fromJsonList(payload).analysisToolsModel;

  @override
  Future<List<AnalysisToolsModel>> loadFromLocalStorage() async {
    final data = Preferences().analysisToolsData;
    if (data.isEmpty) return [];

    final decodedData = json.decode(data);
    return ListOfAnalysisToolsModel.fromJsonList(decodedData)
        .analysisToolsModel;
  }

  @override
  void onFetchFailed() {}

  @override
  Future saveCallResult(List<AnalysisToolsModel> item) async =>
      Preferences().analysisToolsData = json.encode(item);

  @override
  bool shouldFetch(List<AnalysisToolsModel> data) => true;
}
