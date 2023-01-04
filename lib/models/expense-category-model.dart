class ExpenseCategoryModel {
  ExpenseCategoryModel({
    required this.id,
    required this.name,
  });

  int? id;
  String? name;

  factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) =>
      ExpenseCategoryModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
