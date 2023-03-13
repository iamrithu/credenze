// To parse this JSON data, do
//
//     final serviceWorkupdateListModel = serviceWorkupdateListModelFromJson(jsonString);

import 'dart:convert';

ServiceWorkupdateListModel serviceWorkupdateListModelFromJson(String str) =>
    ServiceWorkupdateListModel.fromJson(json.decode(str));

String serviceWorkupdateListModelToJson(ServiceWorkupdateListModel data) =>
    json.encode(data.toJson());

class ServiceWorkupdateListModel {
  ServiceWorkupdateListModel({
    this.id,
    this.serviceId,
    this.customerId,
    this.branchId,
    this.taskId,
    this.categoryId,
    this.workupdateDate,
    this.participantsId,
    this.description,
    this.siteIncharge,
    this.removedQuantity,
    this.isRemovableTask,
    this.chargeableQty,
    this.addedBy,
    this.lastUpdatedBy,
    this.participantsName,
    this.category,
    this.siteincharge,
    this.createBy,
  });

  int? id;
  int? serviceId;
  int? customerId;
  int? branchId;
  int? taskId;
  int? categoryId;
  DateTime? workupdateDate;
  String? participantsId;
  dynamic description;
  int? siteIncharge;
  int? removedQuantity;
  int? isRemovableTask;
  int? chargeableQty;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  String? participantsName;
  Category? category;
  Siteincharge? siteincharge;
  dynamic createBy;

  factory ServiceWorkupdateListModel.fromJson(Map<String, dynamic> json) =>
      ServiceWorkupdateListModel(
        id: json["id"],
        serviceId: json["service_id"],
        customerId: json["customer_id"],
        branchId: json["branch_id"],
        taskId: json["task_id"],
        categoryId: json["category_id"],
        workupdateDate: json["workupdate_date"] == null
            ? null
            : DateTime.parse(json["workupdate_date"]),
        participantsId: json["participants_id"],
        description: json["description"],
        siteIncharge: json["site_incharge"],
        removedQuantity: json["removed_quantity"],
        isRemovableTask: json["is_removable_task"],
        chargeableQty: json["chargeable_qty"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        participantsName: json["participants_name"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        siteincharge: json["siteincharge"] == null
            ? null
            : Siteincharge.fromJson(json["siteincharge"]),
        createBy: json["create_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "customer_id": customerId,
        "branch_id": branchId,
        "task_id": taskId,
        "category_id": categoryId,
        "workupdate_date": workupdateDate?.toIso8601String(),
        "participants_id": participantsId,
        "description": description,
        "site_incharge": siteIncharge,
        "removed_quantity": removedQuantity,
        "is_removable_task": isRemovableTask,
        "chargeable_qty": chargeableQty,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "participants_name": participantsName,
        "category": category?.toJson(),
        "siteincharge": siteincharge?.toJson(),
        "create_by": createBy,
      };
}

class Category {
  Category({
    this.id,
    this.productPrefix,
    this.productNos,
    this.name,
    this.alias,
    this.printName,
    this.unitId,
    this.productCode,
    this.tax,
  });

  int? id;
  String? productPrefix;
  String? productNos;
  String? name;
  String? alias;
  String? printName;
  int? unitId;
  String? productCode;
  dynamic tax;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        productPrefix: json["product_prefix"],
        productNos: json["product_nos"],
        name: json["name"],
        alias: json["alias"],
        printName: json["print_name"],
        unitId: json["unit_id"],
        productCode: json["product_code"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_prefix": productPrefix,
        "product_nos": productNos,
        "name": name,
        "alias": alias,
        "print_name": printName,
        "unit_id": unitId,
        "product_code": productCode,
        "tax": tax,
      };
}

class Siteincharge {
  Siteincharge({
    this.id,
    this.name,
    this.email,
  });

  int? id;
  String? name;
  String? email;

  factory Siteincharge.fromJson(Map<String, dynamic> json) => Siteincharge(
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
