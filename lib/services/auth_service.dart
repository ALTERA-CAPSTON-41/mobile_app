import 'dart:convert';
import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/user.dart';
import 'package:capston_project/services/api.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    if (kDebugMode) {
      logging("RUNNING SIGNIN SERVICES");
    }

    Response ress;
    try {
      ress = await post(
        Uri.parse("${API().serviceURL}/login"),
        headers: headers,
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      if (ress.statusCode != 201) {
        return Future.error(
          json.decode(ress.body)["data"]["reason"].toString().toUpperCase(),
        );
      }
      logging(json.decode(ress.body)["data"]["token"]);
      await Prefs().setAuthToken(json.decode(ress.body)["data"]["token"]);

      Map<String, dynamic> decodeToken = JwtDecoder.decode(
        json.decode(ress.body)["data"]["token"],
      );

      return UserModel.fromJson(decodeToken);
    } catch (e) {
      if (kDebugMode) {
        loggingErr("signIn() :: $e");
      }

      return Future.error("Fail to sign in!");
    }
  }
}

final AuthService authService = AuthService();
