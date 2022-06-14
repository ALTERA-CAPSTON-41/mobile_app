import 'dart:convert';

import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/patient.dart';
import 'package:capston_project/services/api.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class PatientService {
  Future<List<PatientModel>> getAllPatient() async {
    if (kDebugMode) {
      logging("RUNNING GET ALL PATIENT SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await get(
        Uri.parse("${API().serviceURL}/patients"),
        headers: headers,
      );

      if (ress.statusCode != 200) {
        return Future.error("Fail to get all patient!");
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data patient is null!");
      }

      return (json.decode(ress.body)["data"] as List)
          .map((e) => PatientModel.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        loggingErr("getAllPatient() :: $e");
      }

      return Future.error("Fail to get all patient!");
    }
  }

  Future<String> createPatient(PatientModel patient) async {
    if (kDebugMode) {
      logging("RUNNING CREATE PATIENT SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await post(
        Uri.parse("${API().serviceURL}/patients"),
        headers: headers,
        body: json.encode(patient.toJson()),
      );

      if (ress.statusCode != 201 || json.decode(ress.body)["data"] == null) {
        return Future.error("Fail to create patient!");
      }

      return json.decode(ress.body)["data"]["id"];
    } catch (e) {
      if (kDebugMode) {
        loggingErr("createPatient() :: $e");
      }

      return Future.error("Fail to create patient!");
    }
  }

  Future<void> updatePatient(PatientModel patient) async {
    if (kDebugMode) {
      logging("RUNNING UPDATE PATIENT SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await put(
        Uri.parse("${API().serviceURL}/patients/${patient.id}"),
        headers: headers,
        body: json.encode(patient.toJson()),
      );

      if (ress.statusCode != 204) {
        return Future.error("Fail to update patient!");
      }
    } catch (e) {
      if (kDebugMode) {
        loggingErr("updatePatient() :: $e");
      }

      return Future.error("Fail to update patient!");
    }
  }
}

PatientService patientService = PatientService();
