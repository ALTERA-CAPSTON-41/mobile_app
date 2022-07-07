import 'dart:convert';

import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/queue.dart';
import 'package:capston_project/services/api.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class QueueServices {
  Future<List<QueueModel>> getAllQueue() async {
    if (kDebugMode) {
      logging("RUNNING IN GET ALL QUEUE SERVICES");
    }

    try {
      Response ress;
      final String authToken = await Prefs().getAuthToken();
      headers?.addAll({'Authorization': 'Bearer $authToken'});

      ress = await get(
        Uri.parse("${API().serviceURL}/queues"),
        headers: headers,
      );

      if (ress.statusCode != 200) {
        Future.error("Failed to get all queue");
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data queue is null");
      }

      return (json.decode(ress.body)["data"] as List)
          .map((e) => QueueModel.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        logging("getAllQueue() :: $e");
      }
      return Future.error("Failed to get all queue");
    }
  }

  Future<List<QueueModel>> getAllQueueByPoli({required int polyId}) async {
    if (kDebugMode) {
      logging("RUNNING IN GET ALL QUEUE BY POLI SERVICES");
    }

    try {
      Response ress;
      final String authToken = await Prefs().getAuthToken();
      headers?.addAll({'Authorization': 'Bearer $authToken'});

      ress = await get(
        Uri.parse("${API().serviceURL}/queues?polyclinic=$polyId"),
        headers: headers,
      );

      Logger().d("POLY ID :: $polyId");
      Logger().d(json.decode(ress.body)["data"]);

      if (ress.statusCode != 200) {
        Future.error("Failed to get all queue by poli id");
      }

      if (json.decode(ress.body)["data"] == null) {
        return Future.error("Data queue is null");
      }

      return (json.decode(ress.body)["data"] as List)
          .map((e) => QueueModel.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        logging("getAllQueueByPoli() :: $e");
      }
      return Future.error("Failed to get all queue by poli");
    }
  }

  Future<void> createQueue(QueueModel queue) async {
    if (kDebugMode) {
      print("RUNNING CREATE QUEUE SERVICES");
    }

    try {
      Response ress;
      final String authToken = await Prefs().getAuthToken();
      headers?.addAll({'Authorization': 'Bearer $authToken'});

      ress = await post(
        Uri.parse("${API().serviceURL}/queues"),
        headers: headers,
        body: json.encode(queue.toJson()),
      );
      logging("STATUS CODE :: ${ress.statusCode}");
      logging("STATUS BODY :: ${ress.body}");
      if (ress.statusCode != 201) {
        return Future.error("Fail to create queue!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("createQueue() :: $e");
      }

      return Future.error("Fail to create queue!");
    }
  }

  Future<void> doneQueue(QueueModel queue) async {
    if (kDebugMode) {
      print("RUNNING DONE QUEUE SERVICES");
    }

    try {
      Response ress;
      final String authToken = await Prefs().getAuthToken();
      headers?.addAll({'Authorization': 'Bearer $authToken'});

      ress = await put(
        Uri.parse("${API().serviceURL}/queues/${queue.id}"),
        headers: headers,
        body: json.encode(queue.toJson()),
      );

      if (ress.statusCode != 204) {
        return Future.error("Fail to done queue!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("doneQueue() :: $e");
      }

      return Future.error("Fail to done queue!");
    }
  }
}

QueueServices queueServices = QueueServices();
