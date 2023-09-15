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
    required this.siteInchargeToday,
    required this.customerAddressinfo,
    required this.statusinfo,
    required this.branchinfo,
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
  String? installationStatus;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  dynamic siteIncharge;
  dynamic installationSummary;
  int? quoteId;
  int? userId;
  int? installationId;
  DateTime? assignDate;
  String? installationCode;
  SiteInchargeToday? siteInchargeToday;
  CustomerAddressinfo? customerAddressinfo;
  Statusinfo? statusinfo;
  Branchinfo? branchinfo;

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
        siteInchargeToday: json["site_incharge_today"] == null
            ? null
            : SiteInchargeToday.fromJson(json["site_incharge_today"]),
        customerAddressinfo: json["customer_addressinfo"] == null
            ? null
            : CustomerAddressinfo.fromJson(json["customer_addressinfo"]),
        statusinfo: json["statusinfo"] == null
            ? null
            : Statusinfo.fromJson(json["statusinfo"]),
        branchinfo: json["branchinfo"] == null
            ? null
            : Branchinfo.fromJson(json["branchinfo"]),
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
        "site_incharge_today":
            siteInchargeToday == null ? null : siteInchargeToday!.toJson(),
        "customer_addressinfo":
            customerAddressinfo == null ? null : customerAddressinfo!.toJson(),
        "statusinfo": statusinfo == null ? null : statusinfo!.toJson(),
        "branchinfo": branchinfo == null ? null : branchinfo!.toJson(),
      };
}

class Branchinfo {
  Branchinfo({
    required this.id,
    required this.address,
    required this.isDefault,
    required this.taxNumber,
    required this.taxName,
    required this.branchPhone,
    required this.branchEmail,
    required this.branchCode,
    required this.branchGstin,
    required this.location,
    required this.stateId,
    required this.displayAddress,
  });

  int? id;
  String? address;
  int? isDefault;
  dynamic taxNumber;
  dynamic taxName;
  String? branchPhone;
  String? branchEmail;
  String? branchCode;
  String? branchGstin;
  String? location;
  int? stateId;
  String? displayAddress;

  factory Branchinfo.fromJson(Map<String, dynamic> json) => Branchinfo(
        id: json["id"] == null ? null : json["id"],
        address: json["address"] == null ? null : json["address"],
        isDefault: json["is_default"] == null ? null : json["is_default"],
        taxNumber: json["tax_number"],
        taxName: json["tax_name"],
        branchPhone: json["branch_phone"] == null ? null : json["branch_phone"],
        branchEmail: json["branch_email"] == null ? null : json["branch_email"],
        branchCode: json["branch_code"] == null ? null : json["branch_code"],
        branchGstin: json["branch_gstin"] == null ? null : json["branch_gstin"],
        location: json["location"] == null ? null : json["location"],
        stateId: json["state_id"] == null ? null : json["state_id"],
        displayAddress:
            json["display_address"] == null ? null : json["display_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "address": address == null ? null : address,
        "is_default": isDefault == null ? null : isDefault,
        "tax_number": taxNumber,
        "tax_name": taxName,
        "branch_phone": branchPhone == null ? null : branchPhone,
        "branch_email": branchEmail == null ? null : branchEmail,
        "branch_code": branchCode == null ? null : branchCode,
        "branch_gstin": branchGstin == null ? null : branchGstin,
        "location": location == null ? null : location,
        "state_id": stateId == null ? null : stateId,
        "display_address": displayAddress == null ? null : displayAddress,
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
        "districtinfo": districtinfo == null ? null : districtinfo!.toJson(),
        "stateinfo": stateinfo == null ? null : stateinfo!.toJson(),
      };
}

class Districtinfo {
  Districtinfo({
    required this.id,
    required this.name,
    required this.stateId,
    required this.addedBy,
    required this.lastUpdatedBy,
    required this.parentId,
  });

  int? id;
  String? name;
  int? stateId;
  int? addedBy;
  int? lastUpdatedBy;
  dynamic parentId;

  factory Districtinfo.fromJson(Map<String, dynamic> json) => Districtinfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        stateId: json["state_id"] == null ? null : json["state_id"],
        addedBy: json["added_by"] == null ? null : json["added_by"],
        lastUpdatedBy:
            json["last_updated_by"] == null ? null : json["last_updated_by"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "state_id": stateId == null ? null : stateId,
        "added_by": addedBy == null ? null : addedBy,
        "last_updated_by": lastUpdatedBy == null ? null : lastUpdatedBy,
        "parent_id": parentId,
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

class SiteInchargeToday {
  SiteInchargeToday({
    required this.id,
    required this.assignDate,
    required this.addedBy,
    required this.lastUpdatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.siteIncharge,
    required this.user,
  });

  int? id;
  DateTime? assignDate;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? siteIncharge;
  User? user;

  factory SiteInchargeToday.fromJson(Map<String, dynamic> json) =>
      SiteInchargeToday(
        id: json["id"] == null ? null : json["id"],
        assignDate: json["assign_date"] == null
            ? null
            : DateTime.parse(json["assign_date"]),
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        siteIncharge:
            json["site_incharge"] == null ? null : json["site_incharge"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "assign_date": assignDate == null ? null : assignDate.toString(),
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "created_at": createdAt == null ? null : createdAt.toString(),
        "updated_at": updatedAt == null ? null : updatedAt.toString(),
        "site_incharge": siteIncharge == null ? null : siteIncharge,
        "user": user == null ? null : user!.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.twoFactorSecret,
    required this.twoFactorRecoveryCodes,
    required this.twoFactorConfirmed,
    required this.twoFactorEmailConfirmed,
    required this.image,
    required this.mobile,
    required this.gender,
    required this.salutation,
    required this.locale,
    required this.status,
    required this.login,
    required this.onesignalPlayerId,
    required this.lastLogin,
    required this.emailNotifications,
    required this.countryId,
    required this.darkTheme,
    required this.rtl,
    required this.twoFaVerifyVia,
    required this.twoFactorCode,
    required this.twoFactorExpiresAt,
    required this.adminApproval,
    required this.permissionSync,
    required this.googleCalendarStatus,
    required this.imageUrl,
    required this.modules,
    required this.userOtherRole,
    required this.role,
    required this.clientDetails,
    required this.session,
    required this.employeeDetail,
  });

  int? id;
  String? name;
  String? email;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  int? twoFactorConfirmed;
  int? twoFactorEmailConfirmed;
  dynamic image;
  dynamic mobile;
  String? gender;
  dynamic salutation;
  String? locale;
  String? status;
  String? login;
  dynamic onesignalPlayerId;
  DateTime? lastLogin;
  int? emailNotifications;
  int? countryId;
  int? darkTheme;
  int? rtl;
  dynamic twoFaVerifyVia;
  dynamic twoFactorCode;
  dynamic twoFactorExpiresAt;
  int? adminApproval;
  int? permissionSync;
  int? googleCalendarStatus;
  String? imageUrl;
  List<String?>? modules;
  bool? userOtherRole;
  List<Role?>? role;
  dynamic clientDetails;
  dynamic session;
  EmployeeDetail? employeeDetail;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmed: json["two_factor_confirmed"] == null
            ? null
            : json["two_factor_confirmed"],
        twoFactorEmailConfirmed: json["two_factor_email_confirmed"] == null
            ? null
            : json["two_factor_email_confirmed"],
        image: json["image"],
        mobile: json["mobile"],
        gender: json["gender"] == null ? null : json["gender"],
        salutation: json["salutation"],
        locale: json["locale"] == null ? null : json["locale"],
        status: json["status"] == null ? null : json["status"],
        login: json["login"] == null ? null : json["login"],
        onesignalPlayerId: json["onesignal_player_id"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        emailNotifications: json["email_notifications"] == null
            ? null
            : json["email_notifications"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        darkTheme: json["dark_theme"] == null ? null : json["dark_theme"],
        rtl: json["rtl"] == null ? null : json["rtl"],
        twoFaVerifyVia: json["two_fa_verify_via"],
        twoFactorCode: json["two_factor_code"],
        twoFactorExpiresAt: json["two_factor_expires_at"],
        adminApproval:
            json["admin_approval"] == null ? null : json["admin_approval"],
        permissionSync:
            json["permission_sync"] == null ? null : json["permission_sync"],
        googleCalendarStatus: json["google_calendar_status"] == null
            ? null
            : json["google_calendar_status"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        modules: json["modules"] == null
            ? null
            : List<String>.from(json["modules"].map((x) => x)),
        userOtherRole:
            json["user_other_role"] == null ? null : json["user_other_role"],
        role: json["role"] == null
            ? null
            : List<Role>.from(json["role"].map((x) => Role.fromJson(x))),
        clientDetails: json["client_details"],
        session: json["session"],
        employeeDetail: json["employee_detail"] == null
            ? null
            : EmployeeDetail.fromJson(json["employee_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed":
            twoFactorConfirmed == null ? null : twoFactorConfirmed,
        "two_factor_email_confirmed":
            twoFactorEmailConfirmed == null ? null : twoFactorEmailConfirmed,
        "image": image,
        "mobile": mobile,
        "gender": gender == null ? null : gender,
        "salutation": salutation,
        "locale": locale == null ? null : locale,
        "status": status == null ? null : status,
        "login": login == null ? null : login,
        "onesignal_player_id": onesignalPlayerId,
        "last_login": lastLogin == null ? null : lastLogin.toString(),
        "email_notifications":
            emailNotifications == null ? null : emailNotifications,
        "country_id": countryId == null ? null : countryId,
        "dark_theme": darkTheme == null ? null : darkTheme,
        "rtl": rtl == null ? null : rtl,
        "two_fa_verify_via": twoFaVerifyVia,
        "two_factor_code": twoFactorCode,
        "two_factor_expires_at": twoFactorExpiresAt,
        "admin_approval": adminApproval == null ? null : adminApproval,
        "permission_sync": permissionSync == null ? null : permissionSync,
        "google_calendar_status":
            googleCalendarStatus == null ? null : googleCalendarStatus,
        "image_url": imageUrl == null ? null : imageUrl,
        "modules":
            modules == null ? null : List<dynamic>.from(modules!.map((x) => x)),
        "user_other_role": userOtherRole == null ? null : userOtherRole,
        "role": role == null
            ? null
            : List<dynamic>.from(role!.map((x) => x!.toJson())),
        "client_details": clientDetails,
        "session": session,
        "employee_detail":
            employeeDetail == null ? null : employeeDetail!.toJson(),
      };
}

class EmployeeDetail {
  EmployeeDetail({
    required this.id,
    required this.userId,
    required this.employeeId,
    required this.address,
    required this.hourlyRate,
    required this.slackUsername,
    required this.departmentId,
    required this.designationId,
    required this.joiningDate,
    required this.lastDate,
    required this.addedBy,
    required this.lastUpdatedBy,
    required this.attendanceReminder,
    required this.dateOfBirth,
    required this.calendarView,
    required this.aboutMe,
    required this.reportingTo,
    required this.employeeName,
    required this.employeeCode,
    required this.branchOffice,
    required this.employeeType,
    required this.employeeStatus,
    required this.dateOfExit,
    required this.reasonForExit,
    required this.approvalStatus,
    required this.fatherName,
    required this.presentAddress,
    required this.presentAddCity,
    required this.presentAddPincode,
    required this.presentAddDistrict,
    required this.presentAddState,
    required this.permanentAddress,
    required this.permanentAddCity,
    required this.permanentAddPincode,
    required this.permanentAddDistrict,
    required this.permanentAddState,
    required this.bloodGroup,
    required this.aadharNo,
    required this.aadharFile,
    required this.poaNo,
    required this.poaFile,
    required this.mobileOne,
    required this.mobileTwo,
    required this.personalEmail,
    required this.whatsappNo,
    required this.presentSameAsPermanent,
    required this.upcomingBirthday,
    required this.formatedPresentAddress,
    required this.formatedPermanentAddress,
    required this.designation,
    required this.permanentdistrict,
    required this.permanentstate,
    required this.presentdistrict,
    required this.presentstate,
  });

  int? id;
  int? userId;
  dynamic employeeId;
  dynamic address;
  dynamic hourlyRate;
  dynamic slackUsername;
  int? departmentId;
  int? designationId;
  DateTime? joiningDate;
  dynamic lastDate;
  int? addedBy;
  int? lastUpdatedBy;
  dynamic attendanceReminder;
  DateTime? dateOfBirth;
  String? calendarView;
  dynamic aboutMe;
  int? reportingTo;
  String? employeeName;
  dynamic employeeCode;
  dynamic branchOffice;
  int? employeeType;
  int? employeeStatus;
  dynamic dateOfExit;
  dynamic reasonForExit;
  int? approvalStatus;
  String? fatherName;
  String? presentAddress;
  String? presentAddCity;
  String? presentAddPincode;
  int? presentAddDistrict;
  String? presentAddState;
  String? permanentAddress;
  String? permanentAddCity;
  String? permanentAddPincode;
  int? permanentAddDistrict;
  String? permanentAddState;
  int? bloodGroup;
  dynamic aadharNo;
  dynamic aadharFile;
  dynamic poaNo;
  dynamic poaFile;
  String? mobileOne;
  String? mobileTwo;
  dynamic personalEmail;
  String? whatsappNo;
  dynamic presentSameAsPermanent;
  DateTime? upcomingBirthday;
  String? formatedPresentAddress;
  String? formatedPermanentAddress;
  Districtinfo? designation;
  Districtinfo? permanentdistrict;
  dynamic permanentstate;
  Districtinfo? presentdistrict;
  dynamic presentstate;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        employeeId: json["employee_id"],
        address: json["address"],
        hourlyRate: json["hourly_rate"],
        slackUsername: json["slack_username"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        designationId:
            json["designation_id"] == null ? null : json["designation_id"],
        joiningDate: json["joining_date"] == null
            ? null
            : DateTime.parse(json["joining_date"]),
        lastDate: json["last_date"],
        addedBy: json["added_by"] == null ? null : json["added_by"],
        lastUpdatedBy:
            json["last_updated_by"] == null ? null : json["last_updated_by"],
        attendanceReminder: json["attendance_reminder"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        calendarView:
            json["calendar_view"] == null ? null : json["calendar_view"],
        aboutMe: json["about_me"],
        reportingTo: json["reporting_to"] == null ? null : json["reporting_to"],
        employeeName:
            json["employee_name"] == null ? null : json["employee_name"],
        employeeCode: json["employee_code"],
        branchOffice: json["branch_office"],
        employeeType:
            json["employee_type"] == null ? null : json["employee_type"],
        employeeStatus:
            json["employee_status"] == null ? null : json["employee_status"],
        dateOfExit: json["date_of_exit"],
        reasonForExit: json["reason_for_exit"],
        approvalStatus:
            json["approval_status"] == null ? null : json["approval_status"],
        fatherName: json["father_name"] == null ? null : json["father_name"],
        presentAddress:
            json["present_address"] == null ? null : json["present_address"],
        presentAddCity:
            json["present_add_city"] == null ? null : json["present_add_city"],
        presentAddPincode: json["present_add_pincode"] == null
            ? null
            : json["present_add_pincode"],
        presentAddDistrict: json["present_add_district"] == null
            ? null
            : json["present_add_district"],
        presentAddState: json["present_add_state"] == null
            ? null
            : json["present_add_state"],
        permanentAddress: json["permanent_address"] == null
            ? null
            : json["permanent_address"],
        permanentAddCity: json["permanent_add_city"] == null
            ? null
            : json["permanent_add_city"],
        permanentAddPincode: json["permanent_add_pincode"] == null
            ? null
            : json["permanent_add_pincode"],
        permanentAddDistrict: json["permanent_add_district"] == null
            ? null
            : json["permanent_add_district"],
        permanentAddState: json["permanent_add_state"] == null
            ? null
            : json["permanent_add_state"],
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
        aadharNo: json["aadhar_no"],
        aadharFile: json["aadhar_file"],
        poaNo: json["poa_no"],
        poaFile: json["poa_file"],
        mobileOne: json["mobile_one"] == null ? null : json["mobile_one"],
        mobileTwo: json["mobile_two"] == null ? null : json["mobile_two"],
        personalEmail: json["personal_email"],
        whatsappNo: json["whatsapp_no"] == null ? null : json["whatsapp_no"],
        presentSameAsPermanent: json["present_same_as_permanent"],
        upcomingBirthday: json["upcoming_birthday"] == null
            ? null
            : DateTime.parse(json["upcoming_birthday"]),
        formatedPresentAddress: json["formated_present_address"] == null
            ? null
            : json["formated_present_address"],
        formatedPermanentAddress: json["formated_permanent_address"] == null
            ? null
            : json["formated_permanent_address"],
        designation: json["designation"] == null
            ? null
            : Districtinfo.fromJson(json["designation"]),
        permanentdistrict: json["permanentdistrict"] == null
            ? null
            : Districtinfo.fromJson(json["permanentdistrict"]),
        permanentstate: json["permanentstate"],
        presentdistrict: json["presentdistrict"] == null
            ? null
            : Districtinfo.fromJson(json["presentdistrict"]),
        presentstate: json["presentstate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "employee_id": employeeId,
        "address": address,
        "hourly_rate": hourlyRate,
        "slack_username": slackUsername,
        "department_id": departmentId == null ? null : departmentId,
        "designation_id": designationId == null ? null : designationId,
        "joining_date": joiningDate == null ? null : joiningDate.toString(),
        "last_date": lastDate,
        "added_by": addedBy == null ? null : addedBy,
        "last_updated_by": lastUpdatedBy == null ? null : lastUpdatedBy,
        "attendance_reminder": attendanceReminder,
        "date_of_birth": dateOfBirth == null ? null : dateOfBirth.toString(),
        "calendar_view": calendarView == null ? null : calendarView,
        "about_me": aboutMe,
        "reporting_to": reportingTo == null ? null : reportingTo,
        "employee_name": employeeName == null ? null : employeeName,
        "employee_code": employeeCode,
        "branch_office": branchOffice,
        "employee_type": employeeType == null ? null : employeeType,
        "employee_status": employeeStatus == null ? null : employeeStatus,
        "date_of_exit": dateOfExit,
        "reason_for_exit": reasonForExit,
        "approval_status": approvalStatus == null ? null : approvalStatus,
        "father_name": fatherName == null ? null : fatherName,
        "present_address": presentAddress == null ? null : presentAddress,
        "present_add_city": presentAddCity == null ? null : presentAddCity,
        "present_add_pincode":
            presentAddPincode == null ? null : presentAddPincode,
        "present_add_district":
            presentAddDistrict == null ? null : presentAddDistrict,
        "present_add_state": presentAddState == null ? null : presentAddState,
        "permanent_address": permanentAddress == null ? null : permanentAddress,
        "permanent_add_city":
            permanentAddCity == null ? null : permanentAddCity,
        "permanent_add_pincode":
            permanentAddPincode == null ? null : permanentAddPincode,
        "permanent_add_district":
            permanentAddDistrict == null ? null : permanentAddDistrict,
        "permanent_add_state":
            permanentAddState == null ? null : permanentAddState,
        "blood_group": bloodGroup == null ? null : bloodGroup,
        "aadhar_no": aadharNo,
        "aadhar_file": aadharFile,
        "poa_no": poaNo,
        "poa_file": poaFile,
        "mobile_one": mobileOne == null ? null : mobileOne,
        "mobile_two": mobileTwo == null ? null : mobileTwo,
        "personal_email": personalEmail,
        "whatsapp_no": whatsappNo == null ? null : whatsappNo,
        "present_same_as_permanent": presentSameAsPermanent,
        "upcoming_birthday": upcomingBirthday == null
            ? null
            : "${upcomingBirthday!.year.toString().padLeft(4, '0')}-${upcomingBirthday!.month.toString().padLeft(2, '0')}-${upcomingBirthday!.day.toString().padLeft(2, '0')}",
        "formated_present_address":
            formatedPresentAddress == null ? null : formatedPresentAddress,
        "formated_permanent_address":
            formatedPermanentAddress == null ? null : formatedPermanentAddress,
        "designation": designation == null ? null : designation!.toJson(),
        "permanentdistrict":
            permanentdistrict == null ? null : permanentdistrict!.toJson(),
        "permanentstate": permanentstate,
        "presentdistrict":
            presentdistrict == null ? null : presentdistrict!.toJson(),
        "presentstate": presentstate,
      };
}

class Role {
  Role({
    required this.userId,
    required this.roleId,
  });

  int? userId;
  int? roleId;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        userId: json["user_id"] == null ? null : json["user_id"],
        roleId: json["role_id"] == null ? null : json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "role_id": roleId == null ? null : roleId,
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
