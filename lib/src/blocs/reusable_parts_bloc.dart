import 'package:psp_developer/src/blocs/validators/validators.dart';
import 'package:psp_developer/src/models/reusable_parts_model.dart';
import 'package:psp_developer/src/repositories/reusable_parts_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class ReusablePartsBloc with Validators {
  final List<ReusablePartModel> addedReusableParts = [];
  final _reusablePartsProvider = ReusablePartsRepository();

  final _reusablePartsController =
      BehaviorSubject<Tuple2<int, List<ReusablePartModel>>>();

  Stream<Tuple2<int, List<ReusablePartModel>>> get reusablePartsStream =>
      _reusablePartsController.stream;

  Tuple2<int, List<ReusablePartModel>> get lastValueReusablePartsController =>
      _reusablePartsController.value;

  void getReusableParts(bool isRefreshing, int programId) async {
    final reusablePartsWithStatusCode = await _reusablePartsProvider
        .getAllReusableParts(isRefreshing, programId);
    _reusablePartsController.sink.add(reusablePartsWithStatusCode);
  }

  void dispose() {
    addedReusableParts.clear();
    _reusablePartsController.sink.add(null);
  }
}
