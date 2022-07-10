import 'dart:convert';

import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/doctor.dart';
import 'package:capston_project/services/api.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class DoctorService {
  Future<List<DoctorModel>> getAllDoctor() async {
    if (kDebugMode) {
      logging("RUNNING GET ALL DOCTOR SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await get(
        Uri.parse("${API().serviceURL}/doctors"),
        headers: headers,
      );

      if (ress.statusCode != 200) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data doctor is null!");
      }

      return (json.decode(ress.body)["data"] as List)
          .map((e) => DoctorModel.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        loggingErr("getAllDoctor() :: $e");
      }

      return Future.error("Fail to get all doctor!");
    }
  }

  Future<DoctorModel> getDoctorByID({required String doctorId}) async {
    if (kDebugMode) {
      logging("RUNNING GET ALL DOCTOR BY ID SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await get(
        Uri.parse("${API().serviceURL}/doctors/$doctorId"),
        headers: headers,
      );

      Logger().w("DOCTOR ID :: $doctorId");
      Logger().w(json.decode(ress.body)["data"]);

      if (ress.statusCode != 200) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data doctor is null!");
      }
      return DoctorModel.fromJson(json.decode(ress.body)["data"]);
    } catch (e) {
      if (kDebugMode) {
        loggingErr("getDoctorByID() :: $e");
      }

      return Future.error("Fail to get all doctor!");
    }
  }

  Future<String> createDoctor(DoctorModel doctor) async {
    if (kDebugMode) {
      logging("RUNNING CREATE DOCTOR SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await post(
        Uri.parse("${API().serviceURL}/doctors"),
        headers: headers,
        body: json.encode(doctor.toJson()),
      );

      logging(ress.body);
      logging("${API().serviceURL}/doctors");

      if (ress.statusCode != 201) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data doctor is null!");
      }

      return json.decode(ress.body)["data"]["id"];
    } catch (e) {
      if (kDebugMode) {
        loggingErr("createDoctor() :: $e");
      }

      return Future.error("Fail to create doctor!");
    }
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    if (kDebugMode) {
      logging("RUNNING UPDATE DOCTOR SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await put(
        Uri.parse("${API().serviceURL}/doctors/${doctor.id}"),
        headers: headers,
        body: json.encode(doctor.toJson()),
      );

      if (ress.statusCode != 204) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }
    } catch (e) {
      if (kDebugMode) {
        loggingErr("updateDoctor() :: $e");
      }

      return Future.error("Fail to update doctor!");
    }
  }

  Future<void> deleteDoctor(String id) async {
    if (kDebugMode) {
      logging("RUNNING DELETE DOCTOR SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await delete(
        Uri.parse("${API().serviceURL}/doctors/$id"),
        headers: headers,
      );

      if (ress.statusCode != 204) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }
    } catch (e) {
      if (kDebugMode) {
        loggingErr("deleteDoctor() :: $e");
      }

      return Future.error("Fail to delete doctor!");
    }
  }
}

DoctorService doctorService = DoctorService();
