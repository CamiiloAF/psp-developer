import 'package:psp_developer/src/blocs/validators/validators.dart';
import 'package:psp_developer/src/models/new_parts_model.dart';
import 'package:psp_developer/src/repositories/new_parts_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class NewPartsBloc with Validators {
  final List<NewPartModel> addedNewParts = [];

  final _newPartsProvider = NewPartsRepository();

  final _newPartsController =
      BehaviorSubject<Tuple2<int, List<NewPartModel>>>();

  Stream<Tuple2<int, List<NewPartModel>>> get newPartsStream =>
      _newPartsController.stream;

  Tuple2<int, List<NewPartModel>> get lastValueNewPartsController =>
      _newPartsController.value;

  void getNewParts(bool isRefreshing, int programId) async {
    final newPartsWithStatusCode =
        await _newPartsProvider.getAllNewParts(isRefreshing, programId);
    _newPartsController.sink.add(newPartsWithStatusCode);
  }

  Future<int> updateNewPart(NewPartModel newPart) async {
    final statusCode = await _newPartsProvider.updateNewPart(newPart);

    if (statusCode == 204) {
      final tempNewParts = lastValueNewPartsController.item2;

      final indexOfOldNewPart =
          tempNewParts.indexWhere((element) => element.id == newPart.id);

      tempNewParts[indexOfOldNewPart] = newPart;

      _newPartsController.sink.add(Tuple2(200, tempNewParts));
    }
    return statusCode;
  }

  void dispose() {
    addedNewParts.clear();
    _newPartsController?.sink?.add(null);
  }
}
