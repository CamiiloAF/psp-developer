import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/repositories/programs_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class ProgramsBloc {
  final _programsProvider = ProgramsRepository();

  final _programsController =
      BehaviorSubject<Tuple2<int, List<ProgramModel>>>();

  Stream<Tuple2<int, List<ProgramModel>>> get programsStream =>
      _programsController.stream;

  Tuple2<int, List<ProgramModel>> get lastValueProgramsController =>
      _programsController.value;

  void getPrograms(bool isRefresing, int moduleId) async {
    final programsWithStatusCode =
        await _programsProvider.getAllPrograms(isRefresing, moduleId);
    _programsController.sink.add(programsWithStatusCode);
  }

  void dispose() {
    _programsController.sink.add(null);
  }
}
