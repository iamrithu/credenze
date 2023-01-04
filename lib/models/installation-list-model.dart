// To parse this JSON data, do
//
//     final installationModel = installationModelFromJson(jsonString);

import 'dart:convert';

InstallationModel installationModelFromJson(String str) =>
    InstallationModel.fromJson(json.decode(str));

String installationModelToJson(InstallationModel data) =>
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
    required this.customerAddressinfo,
    required this.statusinfo,
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
  CustomerAddressinfo? customerAddressinfo;
  Statusinfo? statusinfo;

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
        customerAddressinfo: json["customer_addressinfo"] == null
            ? null
            : CustomerAddressinfo.fromJson(json["customer_addressinfo"]),
        statusinfo: json["statusinfo"] == null
            ? null
            : Statusinfo.fromJson(json["statusinfo"]),
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
        "customer_addressinfo":
            customerAddressinfo == null ? null : customerAddressinfo!.toJson(),
        "statusinfo": statusinfo == null ? null : statusinfo!.toJson(),
      };
}

class CustomerAddressinfo {
  CustomerAddressinfo({
    required this.id,
    required this.customerId,
    required this.landmark,
    required this.address,
    required this.city,
    required this.district,
    required this.stateId,
    required this.pincode,
    required this.addressDetails,
    required this.districtinfo,
    required this.stateinfo,
  });

  int? id;
  int? customerId;
  dynamic landmark;
  String? address;
  String? city;
  int? district;
  int? stateId;
  String? pincode;
  String? addressDetails;
  Districtinfo? districtinfo;
  Stateinfo? stateinfo;

  factory CustomerAddressinfo.fromJson(Map<String, dynamic> json) =>
      CustomerAddressinfo(
        id: json["id"] == null ? null : json["id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        landmark: json["landmark"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        district: json["district"] == null ? null : json["district"],
        stateId: json["state_id"] == null ? null : json["state_id"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        addressDetails:
            json["address_details"] == null ? null : json["address_details"],
        districtinfo: json["districtinfo"] == null
            ? null
            : Districtinfo.fromJson(json["districtinfo"]),
        stateinfo: json["stateinfo"] == null
            ? null
            : Stateinfo.fromJson(json["stateinfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "customer_id": customerId == null ? null : customerId,
        "landmark": landmark,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "district": district == null ? null : district,
        "state_id": stateId == null ? null : stateId,
        "pincode": pincode == null ? null : pincode,
        "address_details": addressDetails == null ? null : addressDetails,
        "districtinfo": districtinfo == null ? null : districtinfo!.toString(),
        "stateinfo": stateinfo == null ? null : stateinfo!.toString(),
      };
}

class Districtinfo {
  Districtinfo({
    required this.id,
    required this.name,
    required this.stateId,
    required this.addedBy,
    required this.lastUpdatedBy,
  });

  int? id;
  String? name;
  int? stateId;
  int? addedBy;
  int? lastUpdatedBy;

  factory Districtinfo.fromJson(Map<String, dynamic> json) => Districtinfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        stateId: json["state_id"] == null ? null : json["state_id"],
        addedBy: json["added_by"] == null ? null : json["added_by"],
        lastUpdatedBy:
            json["last_updated_by"] == null ? null : json["last_updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "state_id": stateId == null ? null : stateId,
        "added_by": addedBy == null ? null : addedBy,
        "last_updated_by": lastUpdatedBy == null ? null : lastUpdatedBy,
      };
}

class Stateinfo {
  Stateinfo({
    required this.id,
    required this.stateName,
  });

  int? id;
  String? stateName;

  factory Stateinfo.fromJson(Map<String, dynamic> json) => Stateinfo(
        id: json["id"] == null ? null : json["id"],
        stateName: json["state_name"] == null ? null : json["state_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "state_name": stateName == null ? null : stateName,
      };
}

class Statusinfo {
  Statusinfo({
    required this.id,
    required this.statusName,
  });

  int? id;
  String? statusName;

  factory Statusinfo.fromJson(Map<String, dynamic> json) => Statusinfo(
        id: json["id"] == null ? null : json["id"],
        statusName: json["status_name"] == null ? null : json["status_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "status_name": statusName == null ? null : statusName,
      };
}
