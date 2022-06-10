import 'package:capston_project/extensions/ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  final String _authToken = "AUTH_TOKEN";
  final String _userId = "USER_ID";

  Future<void> setAuthToken(String token) async {
    logging("RUNNING SET AUTH TOKEN");
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_authToken, token);
    });
  }

  Future<void> setUserId(String id) async {
    logging("RUNNING SET USER ID");
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_userId, id);
    });
  }

  Future<String> getAuthToken() async {
    logging("RUNNING GET AUTH TOKEN");
    return await SharedPreferences.getInstance().then((prefs) {
      return prefs.getString(_authToken) ?? "";
    });
  }

  Future<void> clearAll() async {
    logging("RUNNING CLEAR ALL");
    await SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
    });
  }
}

final Prefs prefs = Prefs();
