// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

class MemberModel {
  MemberModel({
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
  dynamic siteIncharge;
  User? user;

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
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
        siteIncharge: json["site_incharge"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "assign_date": assignDate == null ? null : assignDate.toString(),
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "created_at": createdAt == null ? null : createdAt.toString(),
        "updated_at": updatedAt == null ? null : updatedAt.toString(),
        "site_incharge": siteIncharge,
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
  String? mobile;
  String? gender;
  dynamic salutation;
  String? locale;
  String? status;
  String? login;
  dynamic onesignalPlayerId;
  DateTime? lastLogin;
  int? emailNotifications;
  dynamic countryId;
  int? darkTheme;
  int? rtl;
  dynamic twoFaVerifyVia;
  dynamic twoFactorCode;
  dynamic twoFactorExpiresAt;
  int? adminApproval;
  int? permissionSync;
  int? googleCalendarStatus;
  String? imageUrl;
  List<String>? modules;
  bool? userOtherRole;
  List<Role>? role;
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
        mobile: json["mobile"] == null ? null : json["mobile"],
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
        countryId: json["country_id"],
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
        "mobile": mobile == null ? null : mobile,
        "gender": gender == null ? null : gender,
        "salutation": salutation,
        "locale": locale == null ? null : locale,
        "status": status == null ? null : status,
        "login": login == null ? null : login,
        "onesignal_player_id": onesignalPlayerId,
        "last_login": lastLogin == null ? null : lastLogin.toString(),
        "email_notifications":
            emailNotifications == null ? null : emailNotifications,
        "country_id": countryId,
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
            : List<dynamic>.from(role!.map((x) => x.toJson())),
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
  String? employeeId;
  dynamic address;
  dynamic hourlyRate;
  dynamic slackUsername;
  int? departmentId;
  int? designationId;
  DateTime? joiningDate;
  dynamic lastDate;
  dynamic addedBy;
  int? lastUpdatedBy;
  dynamic attendanceReminder;
  DateTime? dateOfBirth;
  String? calendarView;
  dynamic aboutMe;
  dynamic reportingTo;
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
  dynamic mobileTwo;
  dynamic personalEmail;
  String? whatsappNo;
  dynamic presentSameAsPermanent;
  DateTime? upcomingBirthday;
  String? formatedPresentAddress;
  String? formatedPermanentAddress;
  Designation? designation;
  Designation? permanentdistrict;
  dynamic permanentstate;
  Designation? presentdistrict;
  dynamic presentstate;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
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
        addedBy: json["added_by"],
        lastUpdatedBy:
            json["last_updated_by"] == null ? null : json["last_updated_by"],
        attendanceReminder: json["attendance_reminder"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        calendarView:
            json["calendar_view"] == null ? null : json["calendar_view"],
        aboutMe: json["about_me"],
        reportingTo: json["reporting_to"],
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
        mobileTwo: json["mobile_two"],
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
            : Designation.fromJson(json["designation"]),
        permanentdistrict: json["permanentdistrict"] == null
            ? null
            : Designation.fromJson(json["permanentdistrict"]),
        permanentstate: json["permanentstate"],
        presentdistrict: json["presentdistrict"] == null
            ? null
            : Designation.fromJson(json["presentdistrict"]),
        presentstate: json["presentstate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "employee_id": employeeId == null ? null : employeeId,
        "address": address,
        "hourly_rate": hourlyRate,
        "slack_username": slackUsername,
        "department_id": departmentId == null ? null : departmentId,
        "designation_id": designationId == null ? null : designationId,
        "joining_date": joiningDate == null ? null : joiningDate.toString(),
        "last_date": lastDate,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy == null ? null : lastUpdatedBy,
        "attendance_reminder": attendanceReminder,
        "date_of_birth": dateOfBirth == null ? null : dateOfBirth.toString(),
        "calendar_view": calendarView == null ? null : calendarView,
        "about_me": aboutMe,
        "reporting_to": reportingTo,
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
        "mobile_two": mobileTwo,
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

class Designation {
  Designation({
    required this.id,
    required this.name,
    required this.parentId,
    required this.addedBy,
    required this.lastUpdatedBy,
    required this.stateId,
  });

  int? id;
  String? name;
  dynamic parentId;
  int? addedBy;
  int? lastUpdatedBy;
  int? stateId;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        parentId: json["parent_id"],
        addedBy: json["added_by"] == null ? null : json["added_by"],
        lastUpdatedBy:
            json["last_updated_by"] == null ? null : json["last_updated_by"],
        stateId: json["state_id"] == null ? null : json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
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
