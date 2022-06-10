import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/user.dart';
import 'package:capston_project/services/auth_service.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:capston_project/viewModels/base_view_model.dart';

class AuthViewModel extends BaseViewModels {
  UserModel? _userModel;
  get userModel => _userModel;

  Future<void> signIn(String email, String password) async {
    logging("RUNNING SIGNIN VIEW MODEL");
    try {
      setState(RequestState.LOADING);

      _userModel = await authService.signIn(
        email: email,
        password: password,
      );

      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<String> getAuthToken() async {
    logging("RUNNING GET AUTH TOKEN VIEW MODEL");
    return await prefs.getAuthToken();
  }
}
