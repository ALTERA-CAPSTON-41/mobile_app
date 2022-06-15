class Polyclinic {
  Polyclinic({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Polyclinic.fromJson(Map<String, dynamic> json) =>
      Polyclinic(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};

  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  bool isEqual(Polyclinic? model) {
    return name == model?.name;
  }

  @override
  String toString() => name ?? "";
}
