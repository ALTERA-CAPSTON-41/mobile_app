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

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        nip: json["nip"],
        sip: json["sip"],
        polyclinic: Polyclinic.fromJson(json["polyclinic"]),
        address: json["address"],
        dob: json["dob"],
        gender: json["gender"],
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
