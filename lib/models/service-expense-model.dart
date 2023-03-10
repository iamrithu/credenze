// To parse this JSON data, do
//
//     final SeviceExpenseModel = SeviceExpenseModelFromJson(jsonString);

import 'dart:convert';

SeviceExpenseModel SeviceExpenseModelFromJson(String str) =>
    SeviceExpenseModel.fromJson(json.decode(str));

String SeviceExpenseModelToJson(SeviceExpenseModel data) =>
    json.encode(data.toJson());

class SeviceExpenseModel {
  SeviceExpenseModel({
    this.id,
    this.serviceId,
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
    this.category,
    this.employee,
  });

  int? id;
  int? serviceId;
  int? userId;
  DateTime? expensesDate;
  int? categoryId;
  dynamic fromPlace;
  dynamic toPlace;
  dynamic distance;
  String? amount;
  dynamic attachment;
  dynamic notes;
  String? status;
  int? addedBy;
  int? lastUpdatedBy;
  Category? category;
  Employee? employee;

  factory SeviceExpenseModel.fromJson(Map<String, dynamic> json) =>
      SeviceExpenseModel(
        id: json["id"],
        serviceId: json["service_id"],
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
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
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
        "category": category?.toJson(),
        "employee": employee?.toJson(),
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

class Employee {
  Employee({
    this.id,
    this.name,
    this.email,
  });

  int? id;
  String? name;
  String? email;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
