import 'package:capston_project/models/patient.dart';
import 'package:capston_project/models/polyclinic.dart';

class QueueModel {
  QueueModel({
    this.id,
    this.patient,
    this.polyclinic,
    this.dailyQueueNumber,
    this.patientStatus,
    this.dailyQueueDate,
    this.serviceDoneAt,
  });

  String? id;
  PatientModel? patient;
  Polyclinic? polyclinic;
  int? dailyQueueNumber;
  String? patientStatus;
  String? dailyQueueDate;
  String? serviceDoneAt;

  factory QueueModel.fromJson(Map<String, dynamic> json) => QueueModel(
        id: json["id"],
        patient: PatientModel.fromJson(json["patient"]),
        polyclinic: Polyclinic.fromJson(json["polyclinic"]),
        dailyQueueNumber: json["daily_queue_number"],
        patientStatus: json["patient_status"],
        dailyQueueDate: json["daily_queue_date"],
        serviceDoneAt: json["service_done_at"],
      );

  Map<String, dynamic> toJson() => {
        "patient_id": patient?.id,
        "polyclinic_id": polyclinic?.id,
        "patient_status": patientStatus,
        "daily_queue_date": dailyQueueDate,
        "service_done_at": serviceDoneAt,
      };
}
