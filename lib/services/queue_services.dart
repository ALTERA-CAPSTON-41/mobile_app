import 'dart:convert';

import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/queue.dart';
import 'package:capston_project/services/api.dart';
import 'package:capston_project/services/pref_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class QueueServices {
  Future<void> createQueue(QueueModel queue) async {
    if (kDebugMode) {
      print("RUNNING CREATE QUEUE");
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
}

QueueServices queueServices = QueueServices();
