// To parse this JSON data, do
//
//     final InstallationOverViewModel = InstallationOverViewModelFromJson(jsonString);

class InstallationOverViewModel {
  InstallationOverViewModel({
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
    required this.installationCode,
    required this.customerAddressinfo,
  });

  int id;
  int branchId;
  String installationPrefix;
  String installationNos;
  String installationName;
  int customerId;
  int addressId;
  String siteLatitude;
  String siteLongitude;
  String customerName;
  String customerAddress;
  int branchState;
  int customerState;
  DateTime startDate;
  DateTime completionDate;
  int installationStatus;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  int siteIncharge;
  String installationSummary;
  int quoteId;
  String installationCode;
  CustomerAddressinfo customerAddressinfo;

  factory InstallationOverViewModel.fromJson(Map<String, dynamic> json) =>
      InstallationOverViewModel(
        id: json["id"],
        branchId: json["branch_id"],
        installationPrefix: json["installation_prefix"],
        installationNos: json["installation_nos"],
        installationName: json["installation_name"],
        customerId: json["customer_id"],
        addressId: json["address_id"],
        siteLatitude: json["site_latitude"],
        siteLongitude: json["site_longitude"],
        customerName: json["customer_name"],
        customerAddress: json["customer_address"],
        branchState: json["branch_state"],
        customerState: json["customer_state"],
        startDate: DateTime.parse(json["start_date"]),
        completionDate: DateTime.parse(json["completion_date"]),
        installationStatus: json["installation_status"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        siteIncharge: json["site_incharge"],
        installationSummary: json["installation_summary"],
        quoteId: json["quote_id"],
        installationCode: json["installation_code"],
        customerAddressinfo:
            CustomerAddressinfo.fromJson(json["customer_addressinfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_id": branchId,
        "installation_prefix": installationPrefix,
        "installation_nos": installationNos,
        "installation_name": installationName,
        "customer_id": customerId,
        "address_id": addressId,
        "site_latitude": siteLatitude,
        "site_longitude": siteLongitude,
        "customer_name": customerName,
        "customer_address": customerAddress,
        "branch_state": branchState,
        "customer_state": customerState,
        "start_date": startDate.toIso8601String(),
        "completion_date": completionDate.toIso8601String(),
        "installation_status": installationStatus,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "site_incharge": siteIncharge,
        "installation_summary": installationSummary,
        "quote_id": quoteId,
        "installation_code": installationCode,
        "customer_addressinfo": customerAddressinfo.toJson(),
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

  int id;
  int customerId;
  dynamic landmark;
  String address;
  String city;
  int district;
  int stateId;
  String pincode;
  String addressDetails;
  Districtinfo districtinfo;
  Stateinfo stateinfo;

  factory CustomerAddressinfo.fromJson(Map<String, dynamic> json) =>
      CustomerAddressinfo(
        id: json["id"],
        customerId: json["customer_id"],
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
        "id": id,
        "customer_id": customerId,
        "landmark": landmark,
        "address": address,
        "city": city,
        "district": district,
        "state_id": stateId,
        "pincode": pincode,
        "address_details": addressDetails,
        "districtinfo": districtinfo.toJson(),
        "stateinfo": stateinfo.toJson(),
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

  int id;
  String name;
  int stateId;
  int addedBy;
  int lastUpdatedBy;

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
    required this.id,
    required this.stateName,
  });

  int id;
  String stateName;

  factory Stateinfo.fromJson(Map<String, dynamic> json) => Stateinfo(
        id: json["id"],
        stateName: json["state_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_name": stateName,
      };
}
