class QueueModel {
  QueueModel({
    this.patientId,
    this.polyclinicId,
    this.patientStatus,
    this.dailyQueueDate,
  });

  String? patientId;
  int? polyclinicId;
  String? doctorId;
  String? patientStatus;
  String? dailyQueueDate;

  factory QueueModel.fromJson(Map<String, dynamic> json) => QueueModel(
        patientId: json["patient_id"],
        polyclinicId: json["polyclinic_id"],
        patientStatus: json["patient_status"],
        dailyQueueDate: json["daily_queue_date"],
      );

  Map<String, dynamic> toJson() => {
        "patient_id": patientId,
        "polyclinic_id": polyclinicId,
        "patient_status": patientStatus,
        "daily_queue_date": dailyQueueDate,
      };
}
