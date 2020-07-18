import 'package:psp_developer/src/models/modules_model.dart';
import 'package:psp_developer/src/repositories/modules_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class ModulesBloc {
  final _modulesProvider = ModulesRepository();

  final _modulesController = BehaviorSubject<Tuple2<int, List<ModuleModel>>>();

  Stream<Tuple2<int, List<ModuleModel>>> get modulesStream =>
      _modulesController.stream;

  Tuple2<int, List<ModuleModel>> get lastValueModulesController =>
      _modulesController.value;

  void getModules(bool isRefreshing, String projectId) async {
    final modulesWithStatusCode =
        await _modulesProvider.getAllModules(isRefreshing, projectId);
    _modulesController.sink.add(modulesWithStatusCode);
  }

  void dispose() => _modulesController?.sink?.add(null);
}
