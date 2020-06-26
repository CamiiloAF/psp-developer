import 'package:psp_developer/src/blocs/Validators.dart';
import 'package:psp_developer/src/models/new_parts_model.dart';

class NewPartsBloc with Validators {
  final List<NewPartModel> addedNewParts = [];

  void dispose() {
    addedNewParts.clear();
  }
}
