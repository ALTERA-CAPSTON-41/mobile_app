import 'dart:convert';

import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/icd_model.dart';
import 'package:capston_project/models/medical_record.dart';
import 'package:capston_project/services/api.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class MedicalRecordService {
  Future<List<IcdModel>> getAllIcd(String? code) async {
    if (kDebugMode) {
      logging("RUNNING GET ALL ICD SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();
      logging("CODE :: $code");
      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await get(
        Uri.parse("${API().serviceURL}/icd10/$code"),
        headers: headers,
      );

      if (ress.statusCode != 200) {
        return Future.error("Data Tidak Tersedia");
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data getAllIcd is null!");
      }

      return IcdResponse.fromJson(json.decode(ress.body)).data;
    } catch (e) {
      if (kDebugMode) {
        loggingErr("getAllIcd() :: $e");
      }

      return Future.error("Fail to get icd!");
    }
  }

  Future<List<MedicalRecordModel>> getMedicalRecord({String? nik}) async {
    if (kDebugMode) {
      logging("RUNNING GET MEDDICAL RECORD BY NIK SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await get(
        Uri.parse("${API().serviceURL}/medical-records/patient/nik/$nik"),
        headers: headers,
      );

      if (ress.statusCode != 200) {
        return Future.error("Fail to get medical record by nik!");
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data medical record by nik is null!");
      }

      return (json.decode(ress.body)["data"] as List).map((e) {
        Logger().d(e);
        return MedicalRecordModel.fromJson(e);
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        loggingErr("getMedicalRecord() :: $e");
      }

      return Future.error("Fail to get medical record by nik!");
    }
  }

  Future<String> createMeidcalRecord(MedicalRecordModel model) async {
    if (kDebugMode) {
      logging("RUNNING CREATE MEDICAL RECORD SERVICES");
    }

    try {
      Response? ress;
      final String authToken = await Prefs().getAuthToken();

      headers?.addAll({'Authorization': 'Bearer $authToken'});
      ress = await post(
        Uri.parse("${API().serviceURL}/medical-records"),
        headers: headers,
        body: json.encode(model.toJson()),
      );

      Logger().d(model.toJson());
      Logger().d(headers);
      logging("STATUS CODE :: ${ress.statusCode}");
      logging("BODY :: ${ress.body}");
      logging("URI ::${API().serviceURL}/medical-records");

      if (ress.statusCode != 201 || json.decode(ress.body)["data"] == null) {
        return Future.error("Fail to create medical record!");
      }

      return json.decode(ress.body)["data"]["id"];
    } catch (e) {
      if (kDebugMode) {
        loggingErr("createMeidcalRecord() :: $e");
      }

      return Future.error("Fail to create medical record!");
    }
  }
  //
  // Future<void> updatePatient(PatientModel patient) async {
  //   if (kDebugMode) {
  //     logging("RUNNING UPDATE PATIENT SERVICES");
  //   }
  //
  //   try {
  //     Response? ress;
  //     final String authToken = await Prefs().getAuthToken();
  //
  //     headers?.addAll({'Authorization': 'Bearer $authToken'});
  //     ress = await put(
  //       Uri.parse("${API().serviceURL}/patients/${patient.id}"),
  //       headers: headers,
  //       body: json.encode(patient.toJson()),
  //     );
  //
  //     if (ress.statusCode != 204) {
  //       return Future.error("Fail to update patient!");
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       loggingErr("updatePatient() :: $e");
  //     }
  //
  //     return Future.error("Fail to update patient!");
  //   }
  // }
  //
  // Future<void> deletePatient(String id) async {
  //   if (kDebugMode) {
  //     logging("RUNNING DELETE PATIENT SERVICES");
  //   }
  //
  //   try {
  //     Response? ress;
  //     final String authToken = await Prefs().getAuthToken();
  //
  //     headers?.addAll({'Authorization': 'Bearer $authToken'});
  //     ress = await delete(
  //       Uri.parse("${API().serviceURL}/patients/$id"),
  //       headers: headers,
  //     );
  //
  //     if (ress.statusCode != 204) {
  //       return Future.error("Fail to delete patient!");
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       loggingErr("deletePatient() :: $e");
  //     }
  //
  //     return Future.error("Fail to delete patient!");
  //   }
  // }
}

MedicalRecordService medicalRecordService = MedicalRecordService();
