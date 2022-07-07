import 'package:capston_project/models/polyclinic.dart';

class DoctorModel {
  DoctorModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.nip,
    this.sip,
    this.polyclinic,
    this.address,
    this.dob,
    this.gender,
  });

  String? id;
  String? email;
  String? password;
  String? name;
  String? nip;
  String? sip;
  Polyclinic? polyclinic;
  String? address;
  String? dob;
  String? gender;

  factory DoctorModel.fromJsonByNIK(Map<String, dynamic> json) => DoctorModel(
        id: json["id"],
        name: json["name"],
        nip: json["nip"],
        sip: json["sip"],
        gender: json["gender"],
      );

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json["id"] ?? null,
        email: json["email"] ?? null,
        password: json["password"] ?? null,
        name: json["name"] ?? null,
        nip: json["nip"] ?? null,
        sip: json["sip"] ?? null,
        polyclinic: Polyclinic.fromJson(json["polyclinic"]) ?? null,
        address: json["address"] ?? null,
        dob: json["dob"] ?? null,
        gender: json["gender"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "nip": nip,
        "sip": sip,
        "polyclinic_id": polyclinic?.id,
        "address": address,
        "dob": dob,
        "gender": gender,
      };
}
