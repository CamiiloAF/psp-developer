import 'package:http/http.dart' as http;
import 'package:psp_developer/src/models/languages_model.dart';
import 'package:psp_developer/src/providers/db_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/network_bound_resource.dart';
import 'package:psp_developer/src/utils/rate_limiter.dart';
import 'package:tuple/tuple.dart';

class LanguagesRepository {
  Future<Tuple2<int, List<LanguageModel>>> getAllLanguages(
      bool isRefreshing) async {
    final networkBoundResource = _LanguagesNetworkBoundResource(RateLimiter());
    final response = await networkBoundResource.execute(isRefreshing);

    if (response.item2 == null) {
      return Tuple2(response.item1, []);
    } else {
      return response;
    }
  }
}

class _LanguagesNetworkBoundResource
    extends NetworkBoundResource<List<LanguageModel>> {
  final RateLimiter rateLimiter;

  final tableName = Constants.LANGUAGES_TABLE_NAME;
  final _allLanguages = 'allLanguages';

  _LanguagesNetworkBoundResource(this.rateLimiter);

  @override
  Future<http.Response> createCall() async {
    final url = '${Constants.baseUrl}/languages';
    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  Future saveCallResult(List<LanguageModel> item) async {
    await DBProvider.db.deleteAll(tableName);

    if (item != null && item.isNotEmpty) {
      await DBProvider.db.insertList(item, tableName);
    }
  }

  @override
  bool shouldFetch(List<LanguageModel> data) =>
      data == null ||
      data.isEmpty ||
      rateLimiter.shouldFetch(_allLanguages, Duration(minutes: 10));

  @override
  Future<List<LanguageModel>> loadFromDb() async => _getLanguagesFromJson(
      await DBProvider.db.getAllModels(Constants.LANGUAGES_TABLE_NAME));

  List<LanguageModel> _getLanguagesFromJson(List<Map<String, dynamic>> res) {
    return res.isNotEmpty
        ? res
            .map((languageModel) => LanguageModel.fromJson(languageModel))
            .toList()
        : [];
  }

  @override
  void onFetchFailed() => rateLimiter.reset(_allLanguages);

  @override
  List<LanguageModel> decodeData(List<dynamic> payload) =>
      LanguagesModel.fromJsonList(payload).languages;
}
