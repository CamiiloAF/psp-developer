import 'package:flutter/cupertino.dart';
import 'package:psp_developer/src/models/new_parts_model.dart';
import 'package:psp_developer/src/utils/constants.dart';

class AddedNewPartsModel with ChangeNotifier {
  final List<NewPartModel> _addedNewParts = [];

  List<NewPartModel> get addedNewParts => _addedNewParts;

  NewPartModel _currentNewPart = NewPartModel();

  String _newPartType = Constants.NEW_PART_TYPE[0];
  String _newPartSize = Constants.NEW_PART_SIZE[0];

  void addNewParts(NewPartModel value) {
    _addedNewParts.add(value);
    notifyListeners();
  }

  void removeNewPart(NewPartModel value) {
    _addedNewParts.remove(value);
    notifyListeners();
  }

  NewPartModel get currentNewPart => _currentNewPart;
  set currentNewPart(value) {
    _currentNewPart = value;
    notifyListeners();
  }

  String get newPartType => _newPartType;
  String get newPartSize => _newPartSize;

  set newPartType(String value) {
    _newPartType = value;
    notifyListeners();
  }

  set newPartSize(String value) {
    _newPartSize = value;
    notifyListeners();
  }

  void setNewPartTypeAndSizeById(int partTypesSizeId) {
    String partTypes;
    String partSize;

    Constants.NEW_PART_TYPES_SIZE.forEach((key, value) {
      if (value == partTypesSizeId) {
        final partTypesSize = key.split('-');
        partTypes = partTypesSize[0];
        partSize = partTypesSize[1];
      }
    });
    _newPartType = partTypes;
    _newPartSize = partSize;
    notifyListeners();
  }

  void resetValues() {
    _newPartType = Constants.NEW_PART_TYPE[0];
    _newPartSize = Constants.NEW_PART_SIZE[0];
    _currentNewPart = NewPartModel();
    notifyListeners();
  }
}
