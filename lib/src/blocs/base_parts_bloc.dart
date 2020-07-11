import 'package:psp_developer/src/blocs/validators/validators.dart';
import 'package:psp_developer/src/models/base_parts_model.dart';
import 'package:psp_developer/src/repositories/base_parts_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class BasePartsBloc with Validators {
  final List<BasePartModel> addedBaseParts = [];

  final _basePartsProvider = BasePartsRepository();

  final _basePartsController =
      BehaviorSubject<Tuple2<int, List<BasePartModel>>>();

  Stream<Tuple2<int, List<BasePartModel>>> get basePartsStream =>
      _basePartsController.stream;

  Tuple2<int, List<BasePartModel>> get lastValueBasePartsController =>
      _basePartsController.value;

  void getBaseParts(bool isRefreshing, int programId) async {
    final basePartsWithStatusCode =
        await _basePartsProvider.getAllBaseParts(isRefreshing, programId);
    _basePartsController.sink.add(basePartsWithStatusCode);
  }

  Future<int> updateBasePart(BasePartModel basePart) async {
    final statusCode = await _basePartsProvider.updateBasePart(basePart);

    if (statusCode == 204) {
      final tempBaseParts = lastValueBasePartsController.item2;

      final indexOfOldBasePart =
          tempBaseParts.indexWhere((element) => element.id == basePart.id);

      tempBaseParts[indexOfOldBasePart] = basePart;

      _basePartsController.sink.add(Tuple2(200, tempBaseParts));
    }
    return statusCode;
  }

  void dispose() {
    addedBaseParts.clear();
    _basePartsController?.sink?.add(null);
  }
}
