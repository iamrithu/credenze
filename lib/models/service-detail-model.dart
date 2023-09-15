// To parse this JSON data, do
//
//     final serviceDetailsModel = serviceDetailsModelFromJson(jsonString);

import 'dart:convert';

ServiceDetailsModel serviceDetailsModelFromJson(String str) =>
    ServiceDetailsModel.fromJson(json.decode(str));

String serviceDetailsModelToJson(ServiceDetailsModel data) =>
    json.encode(data.toJson());

class ServiceDetailsModel {
  int? id;
  String? servicePrefix;
  String? serviceNos;
  int? branchId;
  int? categoryId;
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
  String? serviceStatus;
  dynamic installationId;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  dynamic serviceSummary;
  dynamic isCalculated;
  String? serviceCode;
  Customer? customer;
  Category? category;
  Customeraddress? customeraddress;
  Branch? branch;
  dynamic status;

  ServiceDetailsModel({
    required this.id,
    required this.servicePrefix,
    required this.serviceNos,
    required this.branchId,
    required this.categoryId,
    required this.customerId,
    required this.addressId,
    this.siteLatitude,
    this.siteLongitude,
    required this.customerName,
    required this.customerAddress,
    required this.branchState,
    required this.customerState,
    required this.startDate,
    this.completionDate,
    required this.serviceStatus,
    this.installationId,
    this.addedBy,
    this.lastUpdatedBy,
    this.serviceSummary,
    this.isCalculated,
    required this.serviceCode,
    required this.customer,
    required this.category,
    required this.customeraddress,
    required this.branch,
    this.status,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      ServiceDetailsModel(
        id: json["id"],
        servicePrefix: json["service_prefix"],
        serviceNos: json["service_nos"],
        branchId: json["branch_id"],
        categoryId: json["category_id"],
        customerId: json["customer_id"],
        addressId: json["address_id"],
        siteLatitude: json["site_latitude"],
        siteLongitude: json["site_longitude"],
        customerName: json["customer_name"],
        customerAddress: json["customer_address"],
        branchState: json["branch_state"],
        customerState: json["customer_state"],
        startDate: DateTime.parse(json["start_date"]),
        completionDate: json["completion_date"],
        serviceStatus: json["service_status"],
        installationId: json["installation_id"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        serviceSummary: json["service_summary"],
        isCalculated: json["is_calculated"],
        serviceCode: json["service_code"],
        customer: Customer.fromJson(json["customer"]),
        category: Category.fromJson(json["category"]),
        customeraddress: Customeraddress.fromJson(json["customeraddress"]),
        branch: Branch.fromJson(json["branch"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_prefix": servicePrefix!,
        "service_nos": serviceNos!,
        "branch_id": branchId!,
        "category_id": categoryId!,
        "customer_id": customerId!,
        "address_id": addressId!,
        "site_latitude": siteLatitude!,
        "site_longitude": siteLongitude!,
        "customer_name": customerName!,
        "customer_address": customerAddress!,
        "branch_state": branchState!,
        "customer_state": customerState!,
        "start_date": startDate!.toIso8601String(),
        "completion_date": completionDate!,
        "service_status": serviceStatus!,
        "installation_id": installationId!,
        "added_by": addedBy!,
        "last_updated_by": lastUpdatedBy!,
        "service_summary": serviceSummary,
        "is_calculated": isCalculated,
        "service_code": serviceCode,
        "customer": customer!.toJson(),
        "category": category!.toJson(),
        "customeraddress": customeraddress!.toJson(),
        "branch": branch!.toJson(),
        "status": status!,
      };
}

class Branch {
  int? id;
  String? location;
  String? displayAddress;

  Branch({
    required this.id,
    required this.location,
    required this.displayAddress,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        location: json["location"],
        displayAddress: json["display_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "location": location!,
        "display_address": displayAddress!,
      };
}

class Category {
  int? id;
  String? categoryName;

  Category({
    required this.id,
    required this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "category_name": categoryName!,
      };
}

class Customer {
  int? id;
  String? customerName;
  String? businessCompanyName;
  String? alias;
  String? printName;

  Customer({
    required this.id,
    required this.customerName,
    required this.businessCompanyName,
    required this.alias,
    required this.printName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        customerName: json["customer_name"],
        businessCompanyName: json["business_company_name"],
        alias: json["alias"],
        printName: json["print_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "customer_name": customerName!,
        "business_company_name": businessCompanyName!,
        "alias": alias!,
        "print_name": printName!,
      };
}

class Customeraddress {
  int? id;
  int? customerId;
  dynamic billingName;
  String? landmark;
  String? address;
  String? city;
  int? district;
  int? stateId;
  String? pincode;
  String? addressDetails;
  Districtinfo? districtinfo;
  Stateinfo? stateinfo;

  Customeraddress({
    required this.id,
    required this.customerId,
    this.billingName,
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

  factory Customeraddress.fromJson(Map<String, dynamic> json) =>
      Customeraddress(
        id: json["id"],
        customerId: json["customer_id"],
        billingName: json["billing_name"],
        landmark: json["landmark"],
        address: json["address"],
        city: json["city"],
        district: json["district"],
        stateId: json["state_id"],
        pincode: json["pincode"],
        addressDetails: json["address_details"],
        districtinfo: Districtinfo.fromJson(json["districtinfo"]),
        stateinfo: Stateinfo.fromJson(json["stateinfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "customer_id": customerId!,
        "billing_name": billingName!,
        "landmark": landmark!,
        "address": address!,
        "city": city!,
        "district": district!,
        "state_id": stateId!,
        "pincode": pincode!,
        "address_details": addressDetails!,
        "districtinfo": districtinfo!.toJson(),
        "stateinfo": stateinfo!.toJson(),
      };
}

class Districtinfo {
  int? id;
  String? name;
  int? stateId;
  int? addedBy;
  int? lastUpdatedBy;

  Districtinfo({
    required this.id,
    required this.name,
    required this.stateId,
    required this.addedBy,
    required this.lastUpdatedBy,
  });

  factory Districtinfo.fromJson(Map<String, dynamic> json) => Districtinfo(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "name": name!,
        "state_id": stateId!,
        "added_by": addedBy!,
        "last_updated_by": lastUpdatedBy!,
      };
}

class Stateinfo {
  int? id;
  String? stateName;

  Stateinfo({
    required this.id,
    required this.stateName,
  });

  factory Stateinfo.fromJson(Map<String, dynamic> json) => Stateinfo(
        id: json["id"],
        stateName: json["state_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "state_name": stateName!,
      };
}
