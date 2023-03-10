// To parse this JSON data, do
//
//     final ServiceMemberModel = ServiceMemberModelFromJson(jsonString);

import 'dart:convert';

ServiceMemberModel ServiceMemberModelFromJson(String str) =>
    ServiceMemberModel.fromJson(json.decode(str));

String ServiceMemberModelToJson(ServiceMemberModel data) =>
    json.encode(data.toJson());

class ServiceMemberModel {
  ServiceMemberModel({
    this.id,
    this.assignDate,
    this.siteIncharge,
    this.addedBy,
    this.lastUpdatedBy,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  DateTime? assignDate;
  int? siteIncharge;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory ServiceMemberModel.fromJson(Map<String, dynamic> json) =>
      ServiceMemberModel(
        id: json["id"],
        assignDate: json["assign_date"] == null
            ? null
            : DateTime.parse(json["assign_date"]),
        siteIncharge: json["site_incharge"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assign_date": assignDate?.toIso8601String(),
        "site_incharge": siteIncharge,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.imageUrl,
    this.clientDetails,
    this.session,
    this.employeeDetail,
  });

  int? id;
  String? name;
  String? email;
  String? imageUrl;
  dynamic clientDetails;
  dynamic session;
  EmployeeDetail? employeeDetail;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        imageUrl: json["image_url"],
        clientDetails: json["client_details"],
        session: json["session"],
        employeeDetail: json["employee_detail"] == null
            ? null
            : EmployeeDetail.fromJson(json["employee_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image_url": imageUrl,
        "client_details": clientDetails,
        "session": session,
        "employee_detail": employeeDetail?.toJson(),
      };
}

class EmployeeDetail {
  EmployeeDetail({
    this.id,
    this.userId,
    this.employeeId,
    this.designation,
  });

  int? id;
  int? userId;
  String? employeeId;
  Designation? designation;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        designation: json["designation"] == null
            ? null
            : Designation.fromJson(json["designation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_id": employeeId,
        "designation": designation?.toJson(),
      };
}

class Designation {
  Designation({
    this.id,
    this.name,
    this.parentId,
    this.addedBy,
    this.lastUpdatedBy,
  });

  int? id;
  String? name;
  dynamic parentId;
  dynamic addedBy;
  dynamic lastUpdatedBy;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
      };
}
