// To parse this JSON data, do
//
//     final expensesModel = expensesModelFromJson(jsonString);

import 'dart:convert';

ExpensesModel expensesModelFromJson(String str) =>
    ExpensesModel.fromJson(json.decode(str));

String expensesModelToJson(ExpensesModel data) => json.encode(data.toJson());

class ExpensesModel {
  ExpensesModel({
    required this.id,
    required this.installationId,
    required this.userId,
    required this.expensesDate,
    required this.categoryId,
    required this.fromPlace,
    required this.toPlace,
    required this.distance,
    required this.amount,
    this.attachment,
    this.notes,
    required this.status,
    required this.addedBy,
    required this.lastUpdatedBy,
    this.createdBy,
    this.updatedBy,
    required this.category,
    required this.employee,
  });

  int? id;
  int? installationId;
  int? userId;
  DateTime? expensesDate;
  int? categoryId;
  String? fromPlace;
  String? toPlace;
  String? distance;
  String? amount;
  dynamic attachment;
  dynamic notes;
  String? status;
  int? addedBy;
  int? lastUpdatedBy;
  dynamic createdBy;
  dynamic updatedBy;
  Category? category;
  Employee? employee;

  factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
        id: json["id"],
        installationId: json["installation_id"],
        userId: json["user_id"],
        expensesDate: DateTime.parse(json["expenses_date"]),
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
        category: Category.fromJson(json["category"]),
        employee: Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "installation_id": installationId!,
        "user_id": userId!,
        "expenses_date": expensesDate!.toString(),
        "category_id": categoryId!,
        "from_place": fromPlace!,
        "to_place": toPlace!,
        "distance": distance!,
        "amount": amount!,
        "attachment": attachment!,
        "notes": notes!,
        "status": status!,
        "added_by": addedBy!,
        "last_updated_by": lastUpdatedBy!,
        "created_by": createdBy!,
        "updated_by": updatedBy!,
        "category": category!.toJson(),
        "employee": employee!.toJson()
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  int? id;
  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "name": name!,
      };
}

class Employee {
  Employee({
    required this.name,
  });

  String? name;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name!,
      };
}
