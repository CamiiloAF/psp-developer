import 'package:flutter/foundation.dart';

class TimelogPendingInterruptionModel with ChangeNotifier {
  bool _isListItemsEnable = true;

  bool get isListItemsEnable => _isListItemsEnable;

  set isListItemsEnable(bool valor) {
    _isListItemsEnable = valor;
    notifyListeners();
  }
}
