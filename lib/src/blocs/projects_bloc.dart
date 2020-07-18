import 'package:psp_developer/src/models/projects_model.dart';
import 'package:psp_developer/src/repositories/projects_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class ProjectsBloc {
  final _projectsRepository = ProjectsRepository();

  final _projectsController =
      BehaviorSubject<Tuple2<int, List<ProjectModel>>>();

  Stream<Tuple2<int, List<ProjectModel>>> get projectStream =>
      _projectsController.stream;

  Tuple2<int, List<ProjectModel>> get lastValueProjectsController =>
      _projectsController.value;

  void getProjects(bool isRefreshing) async {
    final projectsWithStatusCode =
        await _projectsRepository.getAllProjects(isRefreshing);
    _projectsController.sink.add(projectsWithStatusCode);
  }

  void dispose() => _projectsController?.sink?.add(null);
}
