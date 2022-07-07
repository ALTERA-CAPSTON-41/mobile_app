import 'package:capston_project/models/doctor.dart';
import 'package:capston_project/models/patient.dart';
import 'package:capston_project/models/polyclinic.dart';

class MedicalRecordModel {
  MedicalRecordModel({
    this.id,
    this.symptoms,
    this.icd10Code,
    this.icd10Description,
    this.suggestions,
    this.patient,
    this.doctor,
    this.polyclinic,
  });

  String? id;
  String? symptoms;
  String? icd10Code;
  String? icd10Description;
  String? suggestions;
  PatientModel? patient;
  DoctorModel? doctor;
  Polyclinic? polyclinic;
  String? patientId;
  int? polyId;

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) =>
      MedicalRecordModel(
        id: json["id"],
        symptoms: json["symptoms"],
        icd10Code: json["icd10_code"],
        icd10Description: json["icd10_description"],
        suggestions: json["suggestions"],
        patient: PatientModel.fromJson(json["patient"]),
        doctor: DoctorModel.fromJsonByNIK(json["doctor"]),
        polyclinic: Polyclinic.fromJson(json["polyclinic"]),
      );

  Map<String, dynamic> toJson() => {
        "symptoms": symptoms,
        "icd10_code": icd10Code,
        "suggestions": suggestions,
        "patient_id": patientId,
        "polyclinic_id": polyId,
      };
}
