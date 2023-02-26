// To parse this JSON data, do
//
//     final expensesModel = expensesModelFromJson(jsonString);

class ExpensesModel {
  ExpensesModel({
    required this.id,
    required this.installationId,
    required this.date,
    required this.categoryId,
    required this.fromPlace,
    required this.toPlace,
    required this.distance,
    required this.amount,
    required this.attachment,
    required this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? installationId;
  DateTime? date;
  int? categoryId;
  String? fromPlace;
  String? toPlace;
  int? distance;
  String? amount;
  dynamic attachment;
  dynamic notes;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
        id: json["id"] == null ? null : json["id"],
        installationId:
            json["installation_id"] == null ? null : json["installation_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        categoryId: json["category_id"] == null ? null : json["category_id"],
        fromPlace: json["from_place"] == null ? null : json["from_place"],
        toPlace: json["to_place"] == null ? null : json["to_place"],
        distance: json["distance"] == null ? null : json["distance"],
        amount: json["amount"] == null ? null : json["amount"],
        attachment: json["attachment"] ?? null,
        notes: json["notes"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "installation_id": installationId == null ? null : installationId,
        "date": date == null ? null : date.toString(),
        "category_id": categoryId == null ? null : categoryId,
        "from_place": fromPlace == null ? null : fromPlace,
        "to_place": toPlace == null ? null : toPlace,
        "distance": distance == null ? null : distance,
        "amount": amount == null ? null : amount,
        "attachment": attachment,
        "notes": notes,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toString(),
        "updated_at": updatedAt == null ? null : updatedAt.toString(),
      };
}
