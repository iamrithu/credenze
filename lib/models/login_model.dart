// To parse this JSON data, do
//
//     final LoginModel = LoginModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class LoginModel {
  LoginModel({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool success;
  final Data data;
  final String message;

  LoginModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      LoginModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory LoginModel.fromJson(String str) =>
      LoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        data: Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data.toMap(),
        "message": message,
      };
}

class Data {
  Data({
    required this.token,
    required this.expiresIn,
    required this.user,
  });

  final String token;
  final DateTime expiresIn;
  final User user;

  Data copyWith({
    String? token,
    DateTime? expiresIn,
    User? user,
  }) =>
      Data(
        token: token ?? this.token,
        expiresIn: expiresIn ?? this.expiresIn,
        user: user ?? this.user,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        token: json["token"],
        expiresIn: DateTime.parse(json["expires_in"]),
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "expires_in": expiresIn.toIso8601String(),
        "user": user.toMap(),
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
    required this.LoginModel,
    required this.onesignalPlayerId,
    required this.lastLoginModel,
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

  final int id;
  final String name;
  final String email;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final int twoFactorConfirmed;
  final int twoFactorEmailConfirmed;
  final dynamic image;
  final String mobile;
  final String gender;
  final dynamic salutation;
  final String locale;
  final String status;
  final String LoginModel;
  final dynamic onesignalPlayerId;
  final DateTime lastLoginModel;
  final int emailNotifications;
  final dynamic countryId;
  final int darkTheme;
  final int rtl;
  final dynamic twoFaVerifyVia;
  final dynamic twoFactorCode;
  final dynamic twoFactorExpiresAt;
  final int adminApproval;
  final int permissionSync;
  final int googleCalendarStatus;
  final String imageUrl;
  final dynamic modules;
  final bool userOtherRole;
  final List<Role> role;
  final dynamic clientDetails;
  final dynamic session;
  final EmployeeDetail employeeDetail;

  User copyWith({
    int? id,
    String? name,
    String? email,
    dynamic twoFactorSecret,
    dynamic twoFactorRecoveryCodes,
    int? twoFactorConfirmed,
    int? twoFactorEmailConfirmed,
    dynamic image,
    String? mobile,
    String? gender,
    dynamic? salutation,
    String? locale,
    String? status,
    String? LoginModel,
    dynamic? onesignalPlayerId,
    DateTime? lastLoginModel,
    int? emailNotifications,
    dynamic? countryId,
    int? darkTheme,
    int? rtl,
    dynamic twoFaVerifyVia,
    dynamic twoFactorCode,
    dynamic twoFactorExpiresAt,
    int? adminApproval,
    int? permissionSync,
    int? googleCalendarStatus,
    String? imageUrl,
    dynamic modules,
    bool? userOtherRole,
    List<Role>? role,
    dynamic clientDetails,
    dynamic session,
    EmployeeDetail? employeeDetail,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        twoFactorSecret: twoFactorSecret ?? this.twoFactorSecret,
        twoFactorRecoveryCodes:
            twoFactorRecoveryCodes ?? this.twoFactorRecoveryCodes,
        twoFactorConfirmed: twoFactorConfirmed ?? this.twoFactorConfirmed,
        twoFactorEmailConfirmed:
            twoFactorEmailConfirmed ?? this.twoFactorEmailConfirmed,
        image: image ?? this.image,
        mobile: mobile ?? this.mobile,
        gender: gender ?? this.gender,
        salutation: salutation ?? this.salutation,
        locale: locale ?? this.locale,
        status: status ?? this.status,
        LoginModel: LoginModel ?? this.LoginModel,
        onesignalPlayerId: onesignalPlayerId ?? this.onesignalPlayerId,
        lastLoginModel: lastLoginModel ?? this.lastLoginModel,
        emailNotifications: emailNotifications ?? this.emailNotifications,
        countryId: countryId ?? this.countryId,
        darkTheme: darkTheme ?? this.darkTheme,
        rtl: rtl ?? this.rtl,
        twoFaVerifyVia: twoFaVerifyVia ?? this.twoFaVerifyVia,
        twoFactorCode: twoFactorCode ?? this.twoFactorCode,
        twoFactorExpiresAt: twoFactorExpiresAt ?? this.twoFactorExpiresAt,
        adminApproval: adminApproval ?? this.adminApproval,
        permissionSync: permissionSync ?? this.permissionSync,
        googleCalendarStatus: googleCalendarStatus ?? this.googleCalendarStatus,
        imageUrl: imageUrl ?? this.imageUrl,
        modules: modules ?? this.modules,
        userOtherRole: userOtherRole ?? this.userOtherRole,
        role: role ?? this.role,
        clientDetails: clientDetails ?? this.clientDetails,
        session: session ?? this.session,
        employeeDetail: employeeDetail ?? this.employeeDetail,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmed: json["two_factor_confirmed"],
        twoFactorEmailConfirmed: json["two_factor_email_confirmed"],
        image: json["image"],
        mobile: json["mobile"],
        gender: json["gender"],
        salutation: json["salutation"],
        locale: json["locale"],
        status: json["status"],
        LoginModel: json["LoginModel"],
        onesignalPlayerId: json["onesignal_player_id"],
        lastLoginModel: DateTime.parse(json["last_LoginModel"]),
        emailNotifications: json["email_notifications"],
        countryId: json["country_id"],
        darkTheme: json["dark_theme"],
        rtl: json["rtl"],
        twoFaVerifyVia: json["two_fa_verify_via"],
        twoFactorCode: json["two_factor_code"],
        twoFactorExpiresAt: json["two_factor_expires_at"],
        adminApproval: json["admin_approval"],
        permissionSync: json["permission_sync"],
        googleCalendarStatus: json["google_calendar_status"],
        imageUrl: json["image_url"],
        modules: json["modules"],
        userOtherRole: json["user_other_role"],
        role: List<Role>.from(json["role"].map((x) => Role.fromMap(x))),
        clientDetails: json["client_details"],
        session: json["session"],
        employeeDetail: EmployeeDetail.fromMap(json["employee_detail"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed": twoFactorConfirmed,
        "two_factor_email_confirmed": twoFactorEmailConfirmed,
        "image": image,
        "mobile": mobile,
        "gender": gender,
        "salutation": salutation,
        "locale": locale,
        "status": status,
        "LoginModel": LoginModel,
        "onesignal_player_id": onesignalPlayerId,
        "last_LoginModel": lastLoginModel.toIso8601String(),
        "email_notifications": emailNotifications,
        "country_id": countryId,
        "dark_theme": darkTheme,
        "rtl": rtl,
        "two_fa_verify_via": twoFaVerifyVia,
        "two_factor_code": twoFactorCode,
        "two_factor_expires_at": twoFactorExpiresAt,
        "admin_approval": adminApproval,
        "permission_sync": permissionSync,
        "google_calendar_status": googleCalendarStatus,
        "image_url": imageUrl,
        "modules": modules,
        "user_other_role": userOtherRole,
        "role": List<dynamic>.from(role.map((x) => x.toMap())),
        "client_details": clientDetails,
        "session": session,
        "employee_detail": employeeDetail.toMap(),
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

  final int id;
  final int userId;
  final String employeeId;
  final dynamic address;
  final dynamic hourlyRate;
  final dynamic slackUsername;
  final int departmentId;
  final int designationId;
  final DateTime joiningDate;
  final dynamic lastDate;
  final dynamic addedBy;
  final int lastUpdatedBy;
  final dynamic attendanceReminder;
  final DateTime dateOfBirth;
  final String calendarView;
  final dynamic aboutMe;
  final dynamic reportingTo;
  final String employeeName;
  final dynamic employeeCode;
  final dynamic branchOffice;
  final int employeeType;
  final int employeeStatus;
  final dynamic dateOfExit;
  final dynamic reasonForExit;
  final int approvalStatus;
  final String fatherName;
  final String presentAddress;
  final String presentAddCity;
  final String presentAddPincode;
  final int presentAddDistrict;
  final String presentAddState;
  final String permanentAddress;
  final String permanentAddCity;
  final String permanentAddPincode;
  final int permanentAddDistrict;
  final String permanentAddState;
  final int bloodGroup;
  final dynamic aadharNo;
  final dynamic aadharFile;
  final dynamic poaNo;
  final dynamic poaFile;
  final String mobileOne;
  final dynamic mobileTwo;
  final dynamic personalEmail;
  final String whatsappNo;
  final dynamic presentSameAsPermanent;
  final DateTime upcomingBirthday;
  final String formatedPresentAddress;
  final String formatedPermanentAddress;
  final Designation designation;
  final Designation permanentdistrict;
  final dynamic permanentstate;
  final Designation presentdistrict;
  final dynamic presentstate;

  EmployeeDetail copyWith({
    int? id,
    int? userId,
    String? employeeId,
    dynamic address,
    dynamic hourlyRate,
    dynamic slackUsername,
    int? departmentId,
    int? designationId,
    DateTime? joiningDate,
    dynamic lastDate,
    dynamic addedBy,
    int? lastUpdatedBy,
    dynamic attendanceReminder,
    DateTime? dateOfBirth,
    String? calendarView,
    dynamic aboutMe,
    dynamic reportingTo,
    String? employeeName,
    dynamic employeeCode,
    dynamic branchOffice,
    int? employeeType,
    int? employeeStatus,
    dynamic dateOfExit,
    dynamic reasonForExit,
    int? approvalStatus,
    String? fatherName,
    String? presentAddress,
    String? presentAddCity,
    String? presentAddPincode,
    int? presentAddDistrict,
    String? presentAddState,
    String? permanentAddress,
    String? permanentAddCity,
    String? permanentAddPincode,
    int? permanentAddDistrict,
    String? permanentAddState,
    int? bloodGroup,
    dynamic aadharNo,
    dynamic aadharFile,
    dynamic poaNo,
    dynamic poaFile,
    String? mobileOne,
    dynamic mobileTwo,
    dynamic personalEmail,
    String? whatsappNo,
    dynamic presentSameAsPermanent,
    DateTime? upcomingBirthday,
    String? formatedPresentAddress,
    String? formatedPermanentAddress,
    Designation? designation,
    Designation? permanentdistrict,
    dynamic permanentstate,
    Designation? presentdistrict,
    dynamic presentstate,
  }) =>
      EmployeeDetail(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        employeeId: employeeId ?? this.employeeId,
        address: address ?? this.address,
        hourlyRate: hourlyRate ?? this.hourlyRate,
        slackUsername: slackUsername ?? this.slackUsername,
        departmentId: departmentId ?? this.departmentId,
        designationId: designationId ?? this.designationId,
        joiningDate: joiningDate ?? this.joiningDate,
        lastDate: lastDate ?? this.lastDate,
        addedBy: addedBy ?? this.addedBy,
        lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
        attendanceReminder: attendanceReminder ?? this.attendanceReminder,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        calendarView: calendarView ?? this.calendarView,
        aboutMe: aboutMe ?? this.aboutMe,
        reportingTo: reportingTo ?? this.reportingTo,
        employeeName: employeeName ?? this.employeeName,
        employeeCode: employeeCode ?? this.employeeCode,
        branchOffice: branchOffice ?? this.branchOffice,
        employeeType: employeeType ?? this.employeeType,
        employeeStatus: employeeStatus ?? this.employeeStatus,
        dateOfExit: dateOfExit ?? this.dateOfExit,
        reasonForExit: reasonForExit ?? this.reasonForExit,
        approvalStatus: approvalStatus ?? this.approvalStatus,
        fatherName: fatherName ?? this.fatherName,
        presentAddress: presentAddress ?? this.presentAddress,
        presentAddCity: presentAddCity ?? this.presentAddCity,
        presentAddPincode: presentAddPincode ?? this.presentAddPincode,
        presentAddDistrict: presentAddDistrict ?? this.presentAddDistrict,
        presentAddState: presentAddState ?? this.presentAddState,
        permanentAddress: permanentAddress ?? this.permanentAddress,
        permanentAddCity: permanentAddCity ?? this.permanentAddCity,
        permanentAddPincode: permanentAddPincode ?? this.permanentAddPincode,
        permanentAddDistrict: permanentAddDistrict ?? this.permanentAddDistrict,
        permanentAddState: permanentAddState ?? this.permanentAddState,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        aadharNo: aadharNo ?? this.aadharNo,
        aadharFile: aadharFile ?? this.aadharFile,
        poaNo: poaNo ?? this.poaNo,
        poaFile: poaFile ?? this.poaFile,
        mobileOne: mobileOne ?? this.mobileOne,
        mobileTwo: mobileTwo ?? this.mobileTwo,
        personalEmail: personalEmail ?? this.personalEmail,
        whatsappNo: whatsappNo ?? this.whatsappNo,
        presentSameAsPermanent:
            presentSameAsPermanent ?? this.presentSameAsPermanent,
        upcomingBirthday: upcomingBirthday ?? this.upcomingBirthday,
        formatedPresentAddress:
            formatedPresentAddress ?? this.formatedPresentAddress,
        formatedPermanentAddress:
            formatedPermanentAddress ?? this.formatedPermanentAddress,
        designation: designation ?? this.designation,
        permanentdistrict: permanentdistrict ?? this.permanentdistrict,
        permanentstate: permanentstate ?? this.permanentstate,
        presentdistrict: presentdistrict ?? this.presentdistrict,
        presentstate: presentstate ?? this.presentstate,
      );

  factory EmployeeDetail.fromJson(String str) =>
      EmployeeDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeeDetail.fromMap(Map<String, dynamic> json) => EmployeeDetail(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        address: json["address"],
        hourlyRate: json["hourly_rate"],
        slackUsername: json["slack_username"],
        departmentId: json["department_id"],
        designationId: json["designation_id"],
        joiningDate: DateTime.parse(json["joining_date"]),
        lastDate: json["last_date"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        attendanceReminder: json["attendance_reminder"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        calendarView: json["calendar_view"],
        aboutMe: json["about_me"],
        reportingTo: json["reporting_to"],
        employeeName: json["employee_name"],
        employeeCode: json["employee_code"],
        branchOffice: json["branch_office"],
        employeeType: json["employee_type"],
        employeeStatus: json["employee_status"],
        dateOfExit: json["date_of_exit"],
        reasonForExit: json["reason_for_exit"],
        approvalStatus: json["approval_status"],
        fatherName: json["father_name"],
        presentAddress: json["present_address"],
        presentAddCity: json["present_add_city"],
        presentAddPincode: json["present_add_pincode"],
        presentAddDistrict: json["present_add_district"],
        presentAddState: json["present_add_state"],
        permanentAddress: json["permanent_address"],
        permanentAddCity: json["permanent_add_city"],
        permanentAddPincode: json["permanent_add_pincode"],
        permanentAddDistrict: json["permanent_add_district"],
        permanentAddState: json["permanent_add_state"],
        bloodGroup: json["blood_group"],
        aadharNo: json["aadhar_no"],
        aadharFile: json["aadhar_file"],
        poaNo: json["poa_no"],
        poaFile: json["poa_file"],
        mobileOne: json["mobile_one"],
        mobileTwo: json["mobile_two"],
        personalEmail: json["personal_email"],
        whatsappNo: json["whatsapp_no"],
        presentSameAsPermanent: json["present_same_as_permanent"],
        upcomingBirthday: DateTime.parse(json["upcoming_birthday"]),
        formatedPresentAddress: json["formated_present_address"],
        formatedPermanentAddress: json["formated_permanent_address"],
        designation: Designation.fromMap(json["designation"]),
        permanentdistrict: Designation.fromMap(json["permanentdistrict"]),
        permanentstate: json["permanentstate"],
        presentdistrict: Designation.fromMap(json["presentdistrict"]),
        presentstate: json["presentstate"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "employee_id": employeeId,
        "address": address,
        "hourly_rate": hourlyRate,
        "slack_username": slackUsername,
        "department_id": departmentId,
        "designation_id": designationId,
        "joining_date": joiningDate.toIso8601String(),
        "last_date": lastDate,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "attendance_reminder": attendanceReminder,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "calendar_view": calendarView,
        "about_me": aboutMe,
        "reporting_to": reportingTo,
        "employee_name": employeeName,
        "employee_code": employeeCode,
        "branch_office": branchOffice,
        "employee_type": employeeType,
        "employee_status": employeeStatus,
        "date_of_exit": dateOfExit,
        "reason_for_exit": reasonForExit,
        "approval_status": approvalStatus,
        "father_name": fatherName,
        "present_address": presentAddress,
        "present_add_city": presentAddCity,
        "present_add_pincode": presentAddPincode,
        "present_add_district": presentAddDistrict,
        "present_add_state": presentAddState,
        "permanent_address": permanentAddress,
        "permanent_add_city": permanentAddCity,
        "permanent_add_pincode": permanentAddPincode,
        "permanent_add_district": permanentAddDistrict,
        "permanent_add_state": permanentAddState,
        "blood_group": bloodGroup,
        "aadhar_no": aadharNo,
        "aadhar_file": aadharFile,
        "poa_no": poaNo,
        "poa_file": poaFile,
        "mobile_one": mobileOne,
        "mobile_two": mobileTwo,
        "personal_email": personalEmail,
        "whatsapp_no": whatsappNo,
        "present_same_as_permanent": presentSameAsPermanent,
        "upcoming_birthday":
            "${upcomingBirthday.year.toString().padLeft(4, '0')}-${upcomingBirthday.month.toString().padLeft(2, '0')}-${upcomingBirthday.day.toString().padLeft(2, '0')}",
        "formated_present_address": formatedPresentAddress,
        "formated_permanent_address": formatedPermanentAddress,
        "designation": designation.toMap(),
        "permanentdistrict": permanentdistrict.toMap(),
        "permanentstate": permanentstate,
        "presentdistrict": presentdistrict.toMap(),
        "presentstate": presentstate,
      };
}

class Designation {
  Designation({
    required this.id,
    required this.name,
    required this.parentId,
    required this.addedBy,
    required this.lastUpdatedBy,
    required this.stateId,
  });

  final int id;
  final String name;
  final dynamic parentId;
  final int addedBy;
  final int lastUpdatedBy;
  final int stateId;

  Designation copyWith({
    int? id,
    String? name,
    dynamic parentId,
    int? addedBy,
    int? lastUpdatedBy,
    int? stateId,
  }) =>
      Designation(
        id: id ?? this.id,
        name: name ?? this.name,
        parentId: parentId ?? this.parentId,
        addedBy: addedBy ?? this.addedBy,
        lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
        stateId: stateId ?? this.stateId,
      );

  factory Designation.fromJson(String str) =>
      Designation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Designation.fromMap(Map<String, dynamic> json) => Designation(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        addedBy: json["added_by"] == null ? null : json["added_by"],
        lastUpdatedBy:
            json["last_updated_by"] == null ? null : json["last_updated_by"],
        stateId: json["state_id"] == null ? null : json["state_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "added_by": addedBy == null ? null : addedBy,
        "last_updated_by": lastUpdatedBy == null ? null : lastUpdatedBy,
        "state_id": stateId == null ? null : stateId,
      };
}

class Role {
  Role({
    required this.userId,
    required this.roleId,
  });

  final int userId;
  final int roleId;

  Role copyWith({
    int? userId,
    int? roleId,
  }) =>
      Role(
        userId: userId ?? this.userId,
        roleId: roleId ?? this.roleId,
      );

  factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        userId: json["user_id"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "role_id": roleId,
      };
}
