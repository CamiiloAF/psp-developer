import 'package:psp_developer/src/blocs/Validators.dart';
import 'package:psp_developer/src/models/base_parts_model.dart';

class BasePartsBloc with Validators {
  final List<BasePartModel> addedBaseParts = [];

  void dispose() {
    addedBaseParts.clear();
  }
}
