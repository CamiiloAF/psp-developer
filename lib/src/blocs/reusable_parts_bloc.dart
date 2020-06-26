import 'package:psp_developer/src/blocs/Validators.dart';
import 'package:psp_developer/src/models/reusable_parts_model.dart';

class ReusablePartsBloc with Validators {
  final List<ReusablePartModel> addedReusableParts = [];

  void dispose() {
    addedReusableParts.clear();
  }
}
