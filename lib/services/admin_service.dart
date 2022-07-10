import 'dart:convert';

import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/admin.dart';
import 'package:capston_project/services/api.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class AdminServices {
  Future<List<AdminModel>> getAllAdmin() async {
    if (kDebugMode) {
      logging("RUNNING IN GET ALL ADMIN SERVICES");
    }

    try {
      Response ress;
      final String authToken = await Prefs().getAuthToken();
      headers?.addAll({'Authorization': 'Bearer $authToken'});

      ress = await get(
        Uri.parse("${API().serviceURL}/admins"),
        headers: headers,
      );

      if (ress.statusCode != 200) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data admin is null");
      }

      return (json.decode(ress.body)["data"] as List)
          .map((e) => AdminModel.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        logging("getAllAdmin() :: $e");
      }
      return Future.error("Failed to get all admin");
    }
  }

  Future<void> createAdmin(AdminModel admin) async {
    if (kDebugMode) {
      print("RUNNING CREATE ADMIN SERVICES");
    }

    try {
      Response ress;
      final String authToken = await Prefs().getAuthToken();
      headers?.addAll({'Authorization': 'Bearer $authToken'});

      ress = await post(
        Uri.parse("${API().serviceURL}/admins"),
        headers: headers,
        body: json.encode(admin.toJson()),
      );

      logging("createAdmin() :: ${ress.body}");
      logging("createAdmin() :: ${ress.statusCode}");

      if (ress.statusCode != 201) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }
    } catch (e) {
      if (kDebugMode) {
        logging("createAdmin() :: $e");
      }
      return Future.error("Failed to create admin");
    }
  }

  Future<void> updateAdmin(AdminModel admin) async {
    if (kDebugMode) {
      print("RUNNING UPDATE ADMIN SERVICES");
    }

    try {
      Response ress;
      final String authToken = await Prefs().getAuthToken();
      headers?.addAll({'Authorization': 'Bearer $authToken'});

      ress = await put(
        Uri.parse("${API().serviceURL}/admins/${admin.id}"),
        headers: headers,
        body: json.encode(admin.toJson()),
      );

      if (ress.statusCode != 204) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }
    } catch (e) {
      if (kDebugMode) {
        logging("updateAdmin() :: $e");
      }
      return Future.error("Failed to update admin");
    }
  }

  Future<void> deleteAdmin(String id) async {
    if (kDebugMode) {
      print("RUNNING DELETE ADMIN SERVICES");
    }

    try {
      Response ress;
      final String authToken = await Prefs().getAuthToken();
      headers?.addAll({'Authorization': 'Bearer $authToken'});

      ress = await delete(
        Uri.parse("${API().serviceURL}/admins/$id"),
        headers: headers,
      );

      if (ress.statusCode != 204) {
        return Future.error(
            json.decode(ress.body)["data"]["reason"].toString().toUpperCase());
      }
    } catch (e) {
      if (kDebugMode) {
        logging("deleteAdmin() :: $e");
      }
      return Future.error("Failed to delete admin");
    }
  }
}

AdminServices adminServices = AdminServices();
