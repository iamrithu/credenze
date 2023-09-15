class ServiceListModel {
  ServiceListModel({
    this.id,
    this.servicePrefix,
    this.serviceNos,
    this.branchId,
    this.categoryId,
    this.customerId,
    this.addressId,
    this.siteLatitude,
    this.siteLongitude,
    this.customerName,
    this.customerAddress,
    this.branchState,
    this.customerState,
    this.startDate,
    this.completionDate,
    this.serviceStatus,
    this.installationId,
    this.addedBy,
    this.lastUpdatedBy,
    this.serviceSummary,
    this.serviceCode,
    this.customer,
    this.category,
    this.customeraddress,
    this.branch,
    this.status,
  });

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
  String? serviceCode;
  Customer? customer;
  Category? category;
  Customeraddress? customeraddress;
  Branch? branch;
  Status? status;

  factory ServiceListModel.fromJson(Map<String, dynamic> json) =>
      ServiceListModel(
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
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        completionDate: json["completion_date"],
        serviceStatus: json["service_status"],
        installationId: json["installation_id"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        serviceSummary: json["service_summary"],
        serviceCode: json["service_code"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        customeraddress: json["customeraddress"] == null
            ? null
            : Customeraddress.fromJson(json["customeraddress"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_prefix": servicePrefix,
        "service_nos": serviceNos,
        "branch_id": branchId,
        "category_id": categoryId,
        "customer_id": customerId,
        "address_id": addressId,
        "site_latitude": siteLatitude,
        "site_longitude": siteLongitude,
        "customer_name": customerName,
        "customer_address": customerAddress,
        "branch_state": branchState,
        "customer_state": customerState,
        "start_date": startDate?.toIso8601String(),
        "completion_date": completionDate,
        "service_status": serviceStatus,
        "installation_id": installationId,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "service_summary": serviceSummary,
        "service_code": serviceCode,
        "customer": customer?.toJson(),
        "category": category?.toJson(),
        "customeraddress": customeraddress?.toJson(),
        "branch": branch?.toJson(),
        "status": status?.toJson(),
      };
}

class Branch {
  Branch({
    this.id,
    this.location,
    this.displayAddress,
  });

  int? id;
  String? location;
  String? displayAddress;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        location: json["location"],
        displayAddress: json["display_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "display_address": displayAddress,
      };
}

class Category {
  Category({
    this.id,
    this.categoryName,
  });

  int? id;
  String? categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
      };
}

class Customer {
  Customer({
    this.id,
    this.customerName,
    this.businessCompanyName,
    this.alias,
    this.printName,
  });

  int? id;
  String? customerName;
  String? businessCompanyName;
  String? alias;
  String? printName;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        customerName: json["customer_name"],
        businessCompanyName: json["business_company_name"],
        alias: json["alias"],
        printName: json["print_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "business_company_name": businessCompanyName,
        "alias": alias,
        "print_name": printName,
      };
}

class Customeraddress {
  Customeraddress({
    this.id,
    this.customerId,
    this.landmark,
    this.address,
    this.city,
    this.district,
    this.stateId,
    this.pincode,
    this.addressDetails,
    this.districtinfo,
    this.stateinfo,
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

  factory Customeraddress.fromJson(Map<String, dynamic> json) =>
      Customeraddress(
        id: json["id"],
        customerId: json["customer_id"],
        landmark: json["landmark"],
        address: json["address"],
        city: json["city"],
        district: json["district"],
        stateId: json["state_id"],
        pincode: json["pincode"],
        addressDetails: json["address_details"],
        districtinfo: json["districtinfo"] == null
            ? null
            : Districtinfo.fromJson(json["districtinfo"]),
        stateinfo: json["stateinfo"] == null
            ? null
            : Stateinfo.fromJson(json["stateinfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "landmark": landmark,
        "address": address,
        "city": city,
        "district": district,
        "state_id": stateId,
        "pincode": pincode,
        "address_details": addressDetails,
        "districtinfo": districtinfo?.toJson(),
        "stateinfo": stateinfo?.toJson(),
      };
}

class Districtinfo {
  Districtinfo({
    this.id,
    this.name,
    this.stateId,
    this.addedBy,
    this.lastUpdatedBy,
  });

  int? id;
  String? name;
  int? stateId;
  int? addedBy;
  int? lastUpdatedBy;

  factory Districtinfo.fromJson(Map<String, dynamic> json) => Districtinfo(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
      };
}

class Stateinfo {
  Stateinfo({
    this.id,
    this.stateName,
  });

  int? id;
  String? stateName;

  factory Stateinfo.fromJson(Map<String, dynamic> json) => Stateinfo(
        id: json["id"],
        stateName: json["state_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_name": stateName,
      };
}

class Status {
  Status({
    this.id,
    this.statusName,
  });

  int? id;
  String? statusName;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        statusName: json["status_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_name": statusName,
      };
}
