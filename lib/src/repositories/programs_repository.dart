import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:psp_developer/src/models/program_parts_model.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/providers/db_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/insert_and_update_bound_resource.dart';
import 'package:psp_developer/src/utils/network_bound_resources/network_bound_resource.dart';
import 'package:psp_developer/src/utils/rate_limiter.dart';
import 'package:tuple/tuple.dart';

class ProgramsRepository {
  Future<Tuple2<int, List<ProgramModel>>> getAllProgramsByModulesId(
      bool isRefreshing, int moduleId) async {
    final networkBoundResource =
        _ProgramsNetworkBoundResource(RateLimiter(), '$moduleId');

    final response = await networkBoundResource.execute(isRefreshing);

    return (response.item2 == null) ? Tuple2(response.item1, []) : response;
  }

  Future<Tuple2<int, List<Tuple2<int, String>>>> getAllProgramsByOrganization(
      int currentProgramId) async {
    final networkBoundResource =
        _ProgramsByOrganizationNetworkBoundResource(currentProgramId);

    final response = await networkBoundResource.execute(true);

    if (response.item2 == null) {
      return Tuple2(response.item1, []);
    } else {
      return response;
    }
  }

  Future<int> updateProgram(ProgramModel program) async {
    final url = '${Constants.baseUrl}/programs/${program.id}';
    return await _ProgramsUpdateBoundResource()
        .executeUpdate(programModelToJson(program), program, url);
  }

  Future<int> addProgramParts(ProgramPartsModel programParts) async {
    final url = '${Constants.baseUrl}/parts/set-program';
    final result = await _ProgramPartsInsertBoundResource()
        .executeInsert(programPartsModelToJson(programParts), url);
    return result.item1;
  }

  Future<int> endProgram(ProgramModel program) async {
    try {
      final url = '${Constants.baseUrl}/programs/end/${program.id}';

      final body = json.encode({'delivery_date': program.deliveryDate});

      final resp =
          await http.patch(url, headers: Constants.getHeaders(), body: body);

      if (resp.statusCode == 204) {
        _ProgramsUpdateBoundResource().doOperationInDb(program);
      } else if (resp.statusCode == 400) {
        final body = resp.body;

        if (programDoesNotMeetAllRecords(body)) {
          return Constants.PROGRAM_DOES_NOT_MEET_ALL_RECORDS;
        } else if (programDoesHaveCurrentParts(body)) {
          return Constants.PROGRAM_DOES_NOT_HAVE_CURRENT_PARTS;
        } else if (programDoesHaveDeltaTimes(body)) {
          return Constants.PROGRAM_DOES_NOT_HAVE_DELTA_TIMES;
        }
      }

      return resp.statusCode;
    } on SocketException catch (e) {
      return e.osError.errorCode;
    } on http.ClientException catch (_) {
      return 7;
    } catch (e) {
      return -1;
    }
  }

  bool programDoesNotMeetAllRecords(String body) =>
      body.contains('Current program does not meet records to end');

  bool programDoesHaveCurrentParts(String body) =>
      body.contains('The program does not have the current parts');

  bool programDoesHaveDeltaTimes(String body) =>
      body.contains('The program does not have the delta times');
}

class _ProgramsNetworkBoundResource
    extends NetworkBoundResource<List<ProgramModel>> {
  final RateLimiter rateLimiter;
  final String moduleId;

  final tableName = Constants.PROGRAMS_TABLE_NAME;
  final _allPrograms = 'allPrograms';

  _ProgramsNetworkBoundResource(this.rateLimiter, this.moduleId);

  @override
  Future<http.Response> createCall() async {
    final url = '${Constants.baseUrl}/programs/by-module/$moduleId';
    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  Future saveCallResult(List<ProgramModel> item) async {
    await DBProvider.db.deleteAllByModuleId(moduleId, tableName);

    if (item != null && item.isNotEmpty) {
      await DBProvider.db.insertList(item, tableName);
    }
  }

  @override
  bool shouldFetch(List<ProgramModel> data) =>
      data == null ||
      data.isEmpty ||
      rateLimiter.shouldFetch(_allPrograms, Duration(minutes: 10));

  @override
  Future<List<ProgramModel>> loadFromLocalStorage() async =>
      _getProgramsFromJson(
          await DBProvider.db.getAllProgramsByModuleId(moduleId));

  List<ProgramModel> _getProgramsFromJson(List<Map<String, dynamic>> res) {
    return res.isNotEmpty
        ? res.map((program) => ProgramModel.fromJson(program)).toList()
        : [];
  }

  @override
  void onFetchFailed() {
    rateLimiter.reset(_allPrograms);
  }

  @override
  List<ProgramModel> decodeData(List<dynamic> payload) =>
      ProgramsModel.fromJsonList(payload).programs;
}

class _ProgramsByOrganizationNetworkBoundResource
    extends NetworkBoundResource<List<Tuple2<int, String>>> {
  List<Tuple2<int, String>> callResult;

  final int _currentProgramId;

  _ProgramsByOrganizationNetworkBoundResource(this._currentProgramId);

  @override
  Future<http.Response> createCall() async {
    final url = '${Constants.baseUrl}/programs/by-organization';
    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  Future saveCallResult(List<dynamic> item) async => callResult = item;

  @override
  bool shouldFetch(List<dynamic> data) => true;

  @override
  Future<List<Tuple2<int, String>>> loadFromLocalStorage() async =>
      (callResult == null) ? null : callResult;

  @override
  void onFetchFailed() {}

  @override
  List<Tuple2<int, String>> decodeData(List<dynamic> payload) {
    final items = <Tuple2<int, String>>[];

    if (payload != null && payload.isNotEmpty) {
      payload.forEach((element) {
        final int elementId = element['id'];
        if (elementId != _currentProgramId &&
            (items.indexWhere((element) => element.item1 == elementId) == -1)) {
          items.add(Tuple2(elementId, element['name']));
        }
      });
    }

    return items;
  }
}

class _ProgramsUpdateBoundResource
    extends InsertAndUpdateBoundResource<ProgramModel> {
  @override
  ProgramModel buildNewModel(payload) => null;

  @override
  void doOperationInDb(ProgramModel model) =>
      DBProvider.db.update(model, Constants.PROGRAMS_TABLE_NAME);
}

class _ProgramPartsInsertBoundResource
    extends InsertAndUpdateBoundResource<ProgramPartsModel> {
  @override
  ProgramPartsModel buildNewModel(payload) => null;

  @override
  void doOperationInDb(ProgramPartsModel model) => null;
}
