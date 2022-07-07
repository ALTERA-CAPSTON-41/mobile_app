class UserModel {
  final String? id;
  final String? name;
  final String? nip;
  final String? role;

  UserModel({
    this.id,
    this.name,
    this.nip,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['jti'] ?? '',
      name: json['name'] ?? '',
      nip: json['nip'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
