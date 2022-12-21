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
  DateTime? completionDate;
  int? installationStatus;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  int? siteIncharge;
  String? installationSummary;
  int? quoteId;
  int? userId;
  int? installationId;
  DateTime? assignDate;
  String? installationCode;

  factory InstallationModel.fromJson(Map<String, dynamic> json) =>
      InstallationModel(
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
        userId: json["user_id"],
        installationId: json["installation_id"],
        assignDate: DateTime.parse(json["assign_date"]),
        installationCode: json["installation_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "branch_id": branchId!,
        "installation_prefix": installationPrefix!,
        "installation_nos": installationNos!,
        "installation_name": installationName!,
        "customer_id": customerId!,
        "address_id": addressId!,
        "site_latitude": siteLatitude!,
        "site_longitude": siteLongitude!,
        "customer_name": customerName!,
        "customer_address": customerAddress!,
        "branch_state": branchState!,
        "customer_state": customerState!,
        "start_date": startDate!.toString(),
        "completion_date": completionDate!.toString(),
        "installation_status": installationStatus!,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy!,
        "site_incharge": siteIncharge!,
        "installation_summary": installationSummary!,
        "quote_id": quoteId!,
        "user_id": userId!,
        "installation_id": installationId!,
        "assign_date":
            "${assignDate!.year.toString().padLeft(4, '0')}-${assignDate!.month.toString().padLeft(2, '0')}-${assignDate!.day.toString().padLeft(2, '0')}",
        "installation_code": installationCode!,
      };
}
