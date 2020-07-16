import 'package:psp_developer/src/blocs/validators/validators.dart';
import 'package:psp_developer/src/models/base_parts_model.dart';
import 'package:psp_developer/src/models/program_parts_model.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/repositories/programs_repository.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class ProgramsBloc with Validators {
  final _programsRepository = ProgramsRepository();

  final _programsByModuleIdController =
  BehaviorSubject<Tuple2<int, List<ProgramModel>>>();

  final _programsByOrganizationController =
  BehaviorSubject<Tuple2<int, List<Tuple2<int, String>>>>();

  Stream<Tuple2<int, List<ProgramModel>>> get programsByModuleIdStream =>
      _programsByModuleIdController.stream;

  Tuple2<int, List<ProgramModel>> get lastValueProgramsByModuleIdController =>
      _programsByModuleIdController.value;

  Stream<Tuple2<int, List<Tuple2<int, String>>>>
  get programsByOrganizationStream =>
      _programsByOrganizationController.stream;

  Tuple2<int, List<Tuple2<int, String>>>
  get lastValueProgramsByOrganizationController =>
      _programsByOrganizationController.value;

  void getPrograms(bool isRefresing, int moduleId) async {
    final programsWithStatusCode = await _programsRepository
        .getAllProgramsByModulesId(isRefresing, moduleId);

    if (programsWithStatusCode.item1 == 200) {
      getProgramsByOrganization(null);
    }

    _programsByModuleIdController.sink.add(programsWithStatusCode);
  }

  void getProgramsByOrganization(int currentProgramId) async {
    final programsWithStatusCode = await _programsRepository
        .getAllProgramsByOrganization(currentProgramId);
    _programsByOrganizationController.sink.add(programsWithStatusCode);
  }

  Future<int> updateProgramWithProgramParts(ProgramModel program,
      ProgramPartsModel programParts) async {
    program.totalLines = _getProgramTotalLines(programParts);

    final programPartsStatusCode =
    await _programsRepository.addProgramParts(programParts);

    if (programPartsStatusCode != 201) return programPartsStatusCode;

    final statusCode = await _programsRepository.updateProgram(program);

    if (statusCode == 204) {
      final tempProgramsByModuleId =
          lastValueProgramsByModuleIdController.item2;

      final indexOfOldProgramByModuleId = tempProgramsByModuleId
          .indexWhere((element) => element.id == program.id);

      if (indexOfOldProgramByModuleId != -1) {
        tempProgramsByModuleId[indexOfOldProgramByModuleId] = program;
      }

      _programsByModuleIdController.sink
          .add(Tuple2(200, tempProgramsByModuleId));
    }
    return statusCode;
  }

  int _getProgramTotalLines(ProgramPartsModel programParts) {
    final basePartsTotalLines = _getBasePartsTotalLines(programParts.baseParts);
    final reusablePartsTotalLines =
    _getReusableAndNewPartsTotalLines(programParts.reusableParts);
    final newPartsTotalLines =
    _getReusableAndNewPartsTotalLines(programParts.newParts);

    return basePartsTotalLines + reusablePartsTotalLines + newPartsTotalLines;
  }

  int _getBasePartsTotalLines(List<BasePartModel> baseParts) {
    var totalLines = 0;

    if (isNullOrEmpty(baseParts)) return totalLines;

    baseParts.forEach((basePart) {
      totalLines += basePart.plannedLinesAdded;
      totalLines += basePart.plannedLinesBase;
      totalLines -= basePart.plannedLinesDeleted;
    });

    return totalLines;
  }

  int _getReusableAndNewPartsTotalLines(List<dynamic> parts) {
    var totalLines = 0;

    if (isNullOrEmpty(parts)) return totalLines;

    parts.forEach((part) {
      totalLines += part.plannedLines;
    });

    return totalLines;
  }

  void dispose() {
    _programsByModuleIdController.sink.add(null);
    _programsByOrganizationController.sink.add(null);
  }

}
