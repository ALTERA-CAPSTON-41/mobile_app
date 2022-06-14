import 'dart:convert';

class PatientModel {
  PatientModel({
    this.id,
    this.name,
    this.nik,
    this.phone,
    this.address,
    this.dob,
    this.gender,
    this.bloodType,
  });

  String? id;
  String? name;
  String? nik;
  String? phone;
  String? address;
  String? dob;
  String? gender;
  String? bloodType;

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        phone: json["phone"],
        address: json["address"],
        dob: json["dob"],
        gender: json["gender"],
        bloodType: json["blood_type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "nik": nik,
        "phone": phone,
        "address": address,
        "dob": dob,
        "gender": gender,
        "blood_type": bloodType,
      };
}
