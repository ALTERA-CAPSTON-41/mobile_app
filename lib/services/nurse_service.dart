import 'dart:convert';
import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/nurse.dart';
import 'package:capston_project/services/api.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class NurseService {
  Future<List<NurseModel>> getAllNurse() async {
    if (kDebugMode) {
      logging("RUNNING GET ALL NURSE SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await get(
        Uri.parse("${API().serviceURL}/nurses"),
        headers: headers,
      );

      if (kDebugMode) {
        logging("NURSE STATUS CODE :: ${ress.statusCode}");
        logging("NURSE STATUS BODY :: ${ress.body}");
      }

      if (ress.statusCode != 200) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data nurses is null!");
      }

      return (json.decode(ress.body)["data"] as List)
          .map((e) => NurseModel.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        loggingErr("getAllNurse() :: $e");
      }

      return Future.error("Fail to get all nurses!");
    }
  }

  Future<NurseModel> getNurseByID({required String doctorId}) async {
    if (kDebugMode) {
      logging("RUNNING GET ALL NURSE BY ID SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await get(
        Uri.parse("${API().serviceURL}/nurses/$doctorId"),
        headers: headers,
      );

      if (kDebugMode) {
        logging("NURSE STATUS CODE :: ${ress.statusCode}");
        logging("NURSE STATUS BODY :: ${ress.body}");
      }

      if (ress.statusCode != 200) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data nurse is null!");
      }
      return NurseModel.fromJson(json.decode(ress.body)["data"]);
    } catch (e) {
      if (kDebugMode) {
        loggingErr("getNurseByID() :: $e");
      }

      return Future.error("Fail to get nurse by id!");
    }
  }

  Future<String> createNurse(NurseModel doctor) async {
    if (kDebugMode) {
      logging("RUNNING CREATE DOCTOR SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await post(
        Uri.parse("${API().serviceURL}/nurses"),
        headers: headers,
        body: json.encode(doctor.toJson()),
      );

      if (kDebugMode) {
        logging("NURSE STATUS CODE :: ${ress.statusCode}");
        logging("NURSE STATUS BODY :: ${ress.body}");
      }

      if (ress.statusCode != 201) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data nuses is null!");
      }

      return json.decode(ress.body)["data"]["id"];
    } catch (e) {
      if (kDebugMode) {
        loggingErr("createNurse() :: $e");
      }

      return Future.error("Fail to create nurse!");
    }
  }

  Future<void> updateNurse(NurseModel doctor) async {
    if (kDebugMode) {
      logging("RUNNING UPDATE NURSE SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await put(
        Uri.parse("${API().serviceURL}/nurses/${doctor.id}"),
        headers: headers,
        body: json.encode(doctor.toJson()),
      );

      if (kDebugMode) {
        logging("NURSE STATUS CODE :: ${ress.statusCode}");
        logging("NURSE STATUS BODY :: ${ress.body}");
      }

      if (ress.statusCode != 204) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }
    } catch (e) {
      if (kDebugMode) {
        loggingErr("updateNurse() :: $e");
      }

      return Future.error("Fail to update nurse!");
    }
  }

  Future<void> deleteNurse(String id) async {
    if (kDebugMode) {
      logging("RUNNING DELETE NURSE SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await delete(
        Uri.parse("${API().serviceURL}/nurses/$id"),
        headers: headers,
      );

      if (ress.statusCode != 204) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }
    } catch (e) {
      if (kDebugMode) {
        loggingErr("deleteNurse() :: $e");
      }

      return Future.error("Fail to delete nurse!");
    }
  }
}

NurseService nurseService = NurseService();
