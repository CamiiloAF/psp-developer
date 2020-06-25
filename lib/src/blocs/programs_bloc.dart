import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/repositories/programs_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class ProgramsBloc {
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
    _programsByModuleIdController.sink.add(programsWithStatusCode);
  }

  void getProgramsByOrganization(int currentProgramId) async {
    final programsWithStatusCode = await _programsRepository
        .getAllProgramsByOrganization(currentProgramId);
    _programsByOrganizationController.sink.add(programsWithStatusCode);
  }

  void dispose() {
    _programsByModuleIdController.sink.add(null);
  }
}
