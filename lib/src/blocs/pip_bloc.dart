import 'package:psp_developer/src/blocs/Validators.dart';
import 'package:psp_developer/src/models/pip_model.dart';
import 'package:psp_developer/src/repositories/pip_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class PIPBloc with Validators {
  final _pipProvider = PIPRepository();

  final _pipController = BehaviorSubject<Tuple2<int, PIPModel>>();

  Stream<Tuple2<int, PIPModel>> get pipStream => _pipController.stream;

  void getPIP(bool isRefresing, int programId) async {
    final pipWithStatusCode = await _pipProvider.getPIP(isRefresing, programId);
    _pipController.sink.add(pipWithStatusCode);
  }

  Future<int> insertPIP(PIPModel pip) async {
    final result = await _pipProvider.insertPIP(pip);
    final statusCode = result.item1;

    if (statusCode == 201) {
      _pipController.sink.add(Tuple2(200, result.item2));
    }
    return statusCode;
  }

  Future<int> updatePIP(PIPModel pip) async {
    final statusCode = await _pipProvider.updatePIP(pip);

    if (statusCode == 204) {
      _pipController.sink.add(Tuple2(200, pip));
    }
    return statusCode;
  }

  void dispose() {
    _pipController.sink.add(null);
  }
}
