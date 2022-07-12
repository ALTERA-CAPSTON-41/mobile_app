import 'package:capston_project/models/polyclinic.dart';

class NurseModel {
  NurseModel({
    this.id,
    this.name,
    this.nip,
    this.sip,
    this.polyclinic,
    this.address,
    this.dob,
    this.gender,
    this.email,
    this.password,
  });

  String? id;
  String? name;
  String? nip;
  String? sip;
  Polyclinic? polyclinic;
  String? address;
  String? dob;
  String? gender;
  String? email;
  String? password;

  factory NurseModel.fromJson(Map<String, dynamic> json) => NurseModel(
        id: json["id"],
        name: json["name"],
        nip: json["nip"],
        sip: json["sip"],
        polyclinic: Polyclinic.fromJson(json["polyclinic"]),
        address: json["address"],
        dob: json["dob"],
        gender: json["gender"],
        email: json["email"],
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
