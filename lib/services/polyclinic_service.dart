import 'dart:convert';

import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/polyclinic.dart';
import 'package:capston_project/services/api.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

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
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
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

  Future<int> createPolyclinic(Polyclinic polyclinic) async {
    if (kDebugMode) {
      logging("RUNNING CREATE POLYCLINIC SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await post(
        Uri.parse("${API().serviceURL}/polyclinics"),
        headers: headers,
        body: json.encode(polyclinic.toJson()),
      );

      if (ress.statusCode != 201) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data polyclinic is null!");
      }

      return json.decode(ress.body)["data"]["id"] as int;
    } catch (e) {
      if (kDebugMode) {
        loggingErr("createPolyclinic() :: $e");
      }

      return Future.error("Fail to create polyclinic!");
    }
  }

  Future<void> updatePolyclinic(Polyclinic polyclinic) async {
    if (kDebugMode) {
      logging("RUNNING UPDATE POLYCLINIC SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await put(
        Uri.parse("${API().serviceURL}/polyclinics/${polyclinic.id}"),
        headers: headers,
        body: json.encode(polyclinic.toJson()),
      );

      Logger().d(headers);
      logging(
          "URL :: ${API().serviceURL}/polyclinics/${polyclinic.id.toString()}");
      logging("ID POLY :: ${polyclinic.id}");
      logging("DATA :: ${ress.statusCode}");
      logging("BODY :: ${ress.body}");

      if (ress.statusCode != 204) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }
    } catch (e) {
      if (kDebugMode) {
        loggingErr("updatePolyclinic() :: $e");
      }

      return Future.error("Fail to update polyclinic!");
    }
  }

  Future<void> deletePolyclinic(String id) async {
    if (kDebugMode) {
      logging("RUNNING DELETE POLYCLINIC SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await delete(
        Uri.parse("${API().serviceURL}/polyclinics/$id"),
        headers: headers,
      );

      if (ress.statusCode != 204) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }
    } catch (e) {
      if (kDebugMode) {
        loggingErr("deletePolyclinic() :: $e");
      }

      return Future.error("Fail to delete polyclinics!");
    }
  }
}

PolicyService policyService = PolicyService();
