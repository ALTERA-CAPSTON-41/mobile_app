import 'package:capston_project/common/enum_state.dart';
import 'package:flutter/material.dart';

class BaseViewModels extends ChangeNotifier {
  RequestState _requestState = RequestState.EMPTY;
  RequestState get requestState => _requestState;
  set requestStateChnage(RequestState value) {
    _requestState = value;
    notifyListeners();
  }

  String _errMsg = "";
  String get errMsg => _errMsg;
  set errMsgChange(String value) {
    _errMsg = value;
    notifyListeners();
  }
}
