import 'package:capston_project/common/enum_state.dart';
import 'package:flutter/material.dart';

class BaseViewModels extends ChangeNotifier {
  RequestState _state = RequestState.EMPTY;
  RequestState get state => _state;
  void setState(RequestState value) {
    _state = value;
    notifyListeners();
  }

  String _errMsg = "";
  String get errMsg => _errMsg;
  set errMsgChange(String value) {
    _errMsg = value;
    notifyListeners();
  }
}
