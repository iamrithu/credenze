// To parse this JSON data, do
//
//     final expensesModel = expensesModelFromJson(jsonString);

import 'dart:convert';

ExpensesModel expensesModelFromJson(String str) =>
    ExpensesModel.fromJson(json.decode(str));

String expensesModelToJson(ExpensesModel data) => json.encode(data.toJson());

class ExpensesModel {
  ExpensesModel({
    this.id,
    this.installationId,
    this.userId,
    this.expensesDate,
    this.categoryId,
    this.fromPlace,
    this.toPlace,
    this.distance,
    this.amount,
    this.attachment,
    this.notes,
    this.status,
    this.addedBy,
    this.lastUpdatedBy,
    this.createdBy,
    this.updatedBy,
    this.category,
  });

  int? id;
  int? installationId;
  int? userId;
  DateTime? expensesDate;
  int? categoryId;
  String? fromPlace;
  String? toPlace;
  int? distance;
  String? amount;
  dynamic attachment;
  dynamic notes;
  String? status;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  dynamic createdBy;
  dynamic updatedBy;
  Category? category;

  factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
        id: json["id"],
        installationId: json["installation_id"],
        userId: json["user_id"],
        expensesDate: json["expenses_date"] == null
            ? null
            : DateTime.parse(json["expenses_date"]),
        categoryId: json["category_id"],
        fromPlace: json["from_place"],
        toPlace: json["to_place"],
        distance: json["distance"],
        amount: json["amount"],
        attachment: json["attachment"],
        notes: json["notes"],
        status: json["status"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "installation_id": installationId,
        "user_id": userId,
        "expenses_date": expensesDate?.toIso8601String(),
        "category_id": categoryId,
        "from_place": fromPlace,
        "to_place": toPlace,
        "distance": distance,
        "amount": amount,
        "attachment": attachment,
        "notes": notes,
        "status": status,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "category": category?.toJson(),
      };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
