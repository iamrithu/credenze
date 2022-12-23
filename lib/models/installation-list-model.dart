// To parse this JSON data, do
//
//     final InstallationModel = InstallationModelFromJson(jsonString);

import 'dart:convert';

InstallationModel InstallationModelFromJson(String str) =>
    InstallationModel.fromJson(json.decode(str));

String InstallationModelToJson(InstallationModel data) =>
    json.encode(data.toJson());

class InstallationModel {
  InstallationModel({
    required this.id,
    required this.branchId,
    required this.installationPrefix,
    required this.installationNos,
    required this.installationName,
    required this.customerId,
    required this.addressId,
    required this.siteLatitude,
    required this.siteLongitude,
    required this.customerName,
    required this.customerAddress,
    required this.branchState,
    required this.customerState,
    required this.startDate,
    required this.completionDate,
    required this.installationStatus,
    required this.addedBy,
    required this.lastUpdatedBy,
    required this.siteIncharge,
    required this.installationSummary,
    required this.quoteId,
    required this.userId,
    required this.installationId,
    required this.assignDate,
    required this.installationCode,
  });

  int? id;
  int? branchId;
  String? installationPrefix;
  String? installationNos;
  String? installationName;
  int? customerId;
  int? addressId;
  String? siteLatitude;
  String? siteLongitude;
  String? customerName;
  String? customerAddress;
  int? branchState;
  int? customerState;
  DateTime? startDate;
  dynamic completionDate;
  int? installationStatus;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  dynamic siteIncharge;
  dynamic installationSummary;
  int? quoteId;
  int? userId;
  int? installationId;
  DateTime? assignDate;
  String? installationCode;

  factory InstallationModel.fromJson(Map<String, dynamic> json) =>
      InstallationModel(
        id: json["id"] == null ? null : json["id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        installationPrefix: json["installation_prefix"] == null
            ? null
            : json["installation_prefix"],
        installationNos:
            json["installation_nos"] == null ? null : json["installation_nos"],
        installationName: json["installation_name"] == null
            ? null
            : json["installation_name"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        addressId: json["address_id"] == null ? null : json["address_id"],
        siteLatitude:
            json["site_latitude"] == null ? null : json["site_latitude"],
        siteLongitude:
            json["site_longitude"] == null ? null : json["site_longitude"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        customerAddress:
            json["customer_address"] == null ? null : json["customer_address"],
        branchState: json["branch_state"] == null ? null : json["branch_state"],
        customerState:
            json["customer_state"] == null ? null : json["customer_state"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        completionDate: json["completion_date"],
        installationStatus: json["installation_status"] == null
            ? null
            : json["installation_status"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        siteIncharge: json["site_incharge"],
        installationSummary: json["installation_summary"],
        quoteId: json["quote_id"] == null ? null : json["quote_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        installationId:
            json["installation_id"] == null ? null : json["installation_id"],
        assignDate: json["assign_date"] == null
            ? null
            : DateTime.parse(json["assign_date"]),
        installationCode: json["installation_code"] == null
            ? null
            : json["installation_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "branch_id": branchId == null ? null : branchId,
        "installation_prefix":
            installationPrefix == null ? null : installationPrefix,
        "installation_nos": installationNos == null ? null : installationNos,
        "installation_name": installationName == null ? null : installationName,
        "customer_id": customerId == null ? null : customerId,
        "address_id": addressId == null ? null : addressId,
        "site_latitude": siteLatitude == null ? null : siteLatitude,
        "site_longitude": siteLongitude == null ? null : siteLongitude,
        "customer_name": customerName == null ? null : customerName,
        "customer_address": customerAddress == null ? null : customerAddress,
        "branch_state": branchState == null ? null : branchState,
        "customer_state": customerState == null ? null : customerState,
        "start_date": startDate == null ? null : startDate.toString(),
        "completion_date": completionDate,
        "installation_status":
            installationStatus == null ? null : installationStatus,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "site_incharge": siteIncharge,
        "installation_summary": installationSummary,
        "quote_id": quoteId == null ? null : quoteId,
        "user_id": userId == null ? null : userId,
        "installation_id": installationId == null ? null : installationId,
        "assign_date": assignDate == null
            ? null
            : "${assignDate!.year.toString().padLeft(4, '0')}-${assignDate!.month.toString().padLeft(2, '0')}-${assignDate!.day.toString().padLeft(2, '0')}",
        "installation_code": installationCode == null ? null : installationCode,
      };
}
