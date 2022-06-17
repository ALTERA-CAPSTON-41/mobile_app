class AdminModel {
  String? id;
  String? name;
  String? nip;
  String? email;
  String? password;

  AdminModel({
    this.id,
    this.name,
    this.nip,
    this.email,
    this.password,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nip: json['nip'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nip': nip,
      'email': email,
      'password': password,
    };
  }
}
