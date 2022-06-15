import 'dart:convert';

import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/polyclinic.dart';
import 'package:capston_project/services/api.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class PolicyService {
  Future<List<Polyclinic>> getAllPolyclinic() async {
    if (kDebugMode) {
      logging("RUNNING GET ALL POLYCLINIC SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await get(
        Uri.parse("${API().serviceURL}/polyclinics"),
        headers: headers,
      );

      if (ress.statusCode != 200) {
        return Future.error("Fail to get all polyclinic!");
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data polyclinic is null!");
      }

      return (json.decode(ress.body)["data"] as List)
          .map((e) => Polyclinic.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        loggingErr("getAllPolyclinic() :: $e");
      }

      return Future.error("Fail to get all polyclinic!");
    }
  }
}

PolicyService policyService = PolicyService();
