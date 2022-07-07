class IcdResponse {
  IcdResponse({required this.data});

  final List<IcdModel> data;

  factory IcdResponse.fromJson(Map<String, dynamic> json) => IcdResponse(
        data: List<IcdModel>.from(
          json["data"].map((x) => IcdModel.fromJson(x)),
        ),
      );
}

class IcdModel {
  IcdModel({
    required this.name,
  });

  final String name;

  factory IcdModel.fromJson(Map<String, dynamic> json) => IcdModel(
        name: json["name"],
      );

  String userAsString() {
    return '#$name ';
  }

  bool isEqual(IcdModel? model) {
    return name == model?.name;
  }

  @override
  String toString() => name ?? "";
}
