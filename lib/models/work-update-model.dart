// To parse this JSON data, do
//
//     final workUpdateMode = workUpdateModeFromJson(jsonString);

class WorkUpdateMode {
  WorkUpdateMode({
    this.id,
    this.branchId,
    this.installationId,
    this.reportDate,
    this.categoryIds,
    this.participantsId,
    this.description,
    this.reportBy,
    this.usedProducts,
    this.usedQuantity,
    this.addedBy,
    this.lastUpdatedBy,
    this.participantsName,
    this.items,
    this.siteincharge,
    this.taskcategory,
  });

  int? id;
  int? branchId;
  int? installationId;
  String? reportDate;
  String? categoryIds;
  String? participantsId;
  String? description;
  int? reportBy;
  int? usedProducts;
  int? usedQuantity;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  String? participantsName;
  List<Item?>? items;
  Siteincharge? siteincharge;
  Taskcategory? taskcategory;

  factory WorkUpdateMode.fromJson(Map<String, dynamic> json) => WorkUpdateMode(
        id: json["id"],
        branchId: json["branch_id"],
        installationId: json["installation_id"],
        reportDate: json["report_date"],
        categoryIds: json["category_ids"],
        participantsId: json["participants_id"],
        description: json["description"],
        reportBy: json["report_by"],
        usedProducts: json["used_products"],
        usedQuantity: json["used_quantity"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        participantsName: json["participants_name"],
        items: json["items"] == null
            ? []
            : json["items"] == null
                ? []
                : List<Item?>.from(json["items"]!.map((x) => Item.fromJson(x))),
        siteincharge: json["siteincharge"] == null
            ? null
            : Siteincharge.fromJson(json["siteincharge"]),
        taskcategory: json["taskcategory"] == null
            ? null
            : Taskcategory.fromJson(json["taskcategory"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_id": branchId,
        "installation_id": installationId,
        "report_date": reportDate,
        "category_ids": categoryIds,
        "participants_id": participantsId,
        "description": description,
        "report_by": reportBy,
        "used_products": usedProducts,
        "used_quantity": usedQuantity,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "participants_name": participantsName,
        "items": items == null
            ? []
            : items == null
                ? []
                : List<dynamic>.from(items!.map((x) => x!.toJson())),
        "siteincharge": siteincharge!.toJson(),
        "taskcategory": taskcategory!.toJson(),
      };
}

class Item {
  Item({
    required this.id,
    required this.activityId,
    required this.branchId,
    required this.installationId,
    required this.productId,
    required this.unitId,
    required this.quantity,
    required this.product,
    required this.unit,
  });

  int? id;
  int? activityId;
  int? branchId;
  int? installationId;
  int? productId;
  int? unitId;
  String? quantity;
  Product? product;
  Unit? unit;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        activityId: json["activity_id"],
        branchId: json["branch_id"],
        installationId: json["installation_id"],
        productId: json["product_id"],
        unitId: json["unit_id"],
        quantity: json["quantity"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activity_id": activityId,
        "branch_id": branchId,
        "installation_id": installationId,
        "product_id": productId,
        "unit_id": unitId,
        "quantity": quantity,
        "product": product!.toJson(),
        "unit": unit!.toJson(),
      };
}

class Product {
  Product({
    required this.id,
    required this.productPrefix,
    required this.productNos,
    required this.name,
    required this.alias,
    required this.printName,
    required this.unitId,
    required this.taxes,
    required this.allowPurchase,
    required this.downloadable,
    required this.downloadableFile,
    required this.description,
    required this.categoryId,
    required this.basePrice,
    required this.modelName,
    required this.subCategoryId,
    required this.addedBy,
    required this.lastUpdatedBy,
    required this.hsnSacCode,
    required this.defaultImage,
    required this.enableConversion,
    required this.secondaryUnit,
    required this.conversionRadio,
    required this.specificationGroupId,
    required this.enableSerialNo,
    required this.saleWarranty,
    required this.purchaseWarranty,
    required this.imageUrl,
    required this.productCode,
    required this.tax,
  });

  int? id;
  String? productPrefix;
  String? productNos;
  String? name;
  String? alias;
  String? printName;
  int? unitId;
  String? taxes;
  int? allowPurchase;
  int? downloadable;
  dynamic downloadableFile;
  dynamic description;
  int? categoryId;
  String? basePrice;
  String? modelName;
  dynamic subCategoryId;
  int? addedBy;
  int? lastUpdatedBy;
  String? hsnSacCode;
  String? defaultImage;
  dynamic enableConversion;
  dynamic secondaryUnit;
  String? conversionRadio;
  int? specificationGroupId;
  dynamic enableSerialNo;
  dynamic saleWarranty;
  dynamic purchaseWarranty;
  String? imageUrl;
  String? productCode;
  dynamic tax;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productPrefix: json["product_prefix"],
        productNos: json["product_nos"],
        name: json["name"],
        alias: json["alias"],
        printName: json["print_name"],
        unitId: json["unit_id"],
        taxes: json["taxes"],
        allowPurchase: json["allow_purchase"],
        downloadable: json["downloadable"],
        downloadableFile: json["downloadable_file"],
        description: json["description"],
        categoryId: json["category_id"],
        basePrice: json["base_price"],
        modelName: json["model_name"],
        subCategoryId: json["sub_category_id"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        hsnSacCode: json["hsn_sac_code"],
        defaultImage: json["default_image"],
        enableConversion: json["enable_conversion"],
        secondaryUnit: json["secondary_unit"],
        conversionRadio: json["conversion_radio"],
        specificationGroupId: json["specification_group_id"],
        enableSerialNo: json["enable_serial_no"],
        saleWarranty: json["sale_warranty"],
        purchaseWarranty: json["purchase_warranty"],
        imageUrl: json["image_url"],
        productCode: json["product_code"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_prefix": productPrefix,
        "product_nos": productNos,
        "name": name,
        "alias": alias,
        "print_name": printName,
        "unit_id": unitId,
        "taxes": taxes,
        "allow_purchase": allowPurchase,
        "downloadable": downloadable,
        "downloadable_file": downloadableFile,
        "description": description,
        "category_id": categoryId,
        "base_price": basePrice,
        "model_name": modelName,
        "sub_category_id": subCategoryId,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "hsn_sac_code": hsnSacCode,
        "default_image": defaultImage,
        "enable_conversion": enableConversion,
        "secondary_unit": secondaryUnit,
        "conversion_radio": conversionRadio,
        "specification_group_id": specificationGroupId,
        "enable_serial_no": enableSerialNo,
        "sale_warranty": saleWarranty,
        "purchase_warranty": purchaseWarranty,
        "image_url": imageUrl,
        "product_code": productCode,
        "tax": tax,
      };
}

class Unit {
  Unit({
    required this.id,
    required this.unitName,
    required this.shortName,
  });

  int? id;
  String? unitName;
  String? shortName;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        unitName: json["unit_name"],
        shortName: json["short_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit_name": unitName,
        "short_name": shortName,
      };
}

class Siteincharge {
  Siteincharge({
    this.id,
    this.name,
    this.email,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmed,
    this.twoFactorEmailConfirmed,
    this.image,
    this.mobile,
    this.gender,
    this.salutation,
    this.locale,
    this.status,
    this.login,
    this.onesignalPlayerId,
    this.lastLogin,
    this.emailNotifications,
    this.countryId,
    this.darkTheme,
    this.rtl,
    this.twoFaVerifyVia,
    this.twoFactorCode,
    this.twoFactorExpiresAt,
    this.adminApproval,
    this.permissionSync,
    this.googleCalendarStatus,
    this.imageUrl,
    this.modules,
    this.userOtherRole,
    this.role,
    this.clientDetails,
    this.session,
    this.employeeDetail,
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
  String? lastLogin;
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
  List<String?>? modules;
  bool? userOtherRole;
  List<Role?>? role;
  dynamic clientDetails;
  dynamic session;
  EmployeeDetail? employeeDetail;

  factory Siteincharge.fromJson(Map<String, dynamic> json) => Siteincharge(
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
        login: json["login"],
        onesignalPlayerId: json["onesignal_player_id"],
        lastLogin: json["last_login"],
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
        modules: json["modules"] == null
            ? []
            : json["modules"] == null
                ? []
                : List<String?>.from(json["modules"]!.map((x) => x)),
        userOtherRole: json["user_other_role"],
        role: json["role"] == null
            ? []
            : json["role"] == null
                ? []
                : List<Role?>.from(json["role"]!.map((x) => Role.fromJson(x))),
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
        "login": login,
        "onesignal_player_id": onesignalPlayerId,
        "last_login": lastLogin,
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
        "modules": modules == null
            ? []
            : modules == null
                ? []
                : List<dynamic>.from(modules!.map((x) => x)),
        "user_other_role": userOtherRole,
        "role": role == null
            ? []
            : role == null
                ? []
                : List<dynamic>.from(role!.map((x) => x!.toJson())),
        "client_details": clientDetails,
        "session": session,
        "employee_detail": employeeDetail!.toJson(),
      };
}

class EmployeeDetail {
  EmployeeDetail({
    this.id,
    this.userId,
    this.employeeId,
    this.address,
    this.hourlyRate,
    this.slackUsername,
    this.departmentId,
    this.designationId,
    this.joiningDate,
    this.lastDate,
    this.addedBy,
    this.lastUpdatedBy,
    this.attendanceReminder,
    this.dateOfBirth,
    this.calendarView,
    this.aboutMe,
    this.reportingTo,
    this.employeeName,
    this.employeeCode,
    this.branchOffice,
    this.employeeType,
    this.employeeStatus,
    this.dateOfExit,
    this.reasonForExit,
    this.approvalStatus,
    this.fatherName,
    this.presentAddress,
    this.presentAddCity,
    this.presentAddPincode,
    this.presentAddDistrict,
    this.presentAddState,
    this.permanentAddress,
    this.permanentAddCity,
    this.permanentAddPincode,
    this.permanentAddDistrict,
    this.permanentAddState,
    this.bloodGroup,
    this.aadharNo,
    this.aadharFile,
    this.poaNo,
    this.poaFile,
    this.mobileOne,
    this.mobileTwo,
    this.personalEmail,
    this.whatsappNo,
    this.presentSameAsPermanent,
    this.upcomingBirthday,
    this.formatedPresentAddress,
    this.formatedPermanentAddress,
    this.designation,
    this.permanentdistrict,
    this.permanentstate,
    this.presentdistrict,
    this.presentstate,
  });

  int? id;
  int? userId;
  String? employeeId;
  dynamic address;
  dynamic hourlyRate;
  dynamic slackUsername;
  int? departmentId;
  int? designationId;
  String? joiningDate;
  dynamic lastDate;
  dynamic addedBy;
  int? lastUpdatedBy;
  dynamic attendanceReminder;
  String? dateOfBirth;
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
  Entdistrict? permanentdistrict;
  dynamic permanentstate;
  Entdistrict? presentdistrict;
  dynamic presentstate;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        address: json["address"],
        hourlyRate: json["hourly_rate"],
        slackUsername: json["slack_username"],
        departmentId: json["department_id"],
        designationId: json["designation_id"],
        joiningDate: json["joining_date"],
        lastDate: json["last_date"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        attendanceReminder: json["attendance_reminder"],
        dateOfBirth: json["date_of_birth"],
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
        designation: json["designation"] == null
            ? null
            : Designation.fromJson(json["designation"]),
        permanentdistrict: json["permanentdistrict"] == null
            ? null
            : Entdistrict.fromJson(json["permanentdistrict"]),
        permanentstate: json["permanentstate"],
        presentdistrict: json["presentdistrict"] == null
            ? null
            : Entdistrict.fromJson(json["presentdistrict"]),
        presentstate: json["presentstate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_id": employeeId,
        "address": address,
        "hourly_rate": hourlyRate,
        "slack_username": slackUsername,
        "department_id": departmentId,
        "designation_id": designationId,
        "joining_date": joiningDate,
        "last_date": lastDate,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "attendance_reminder": attendanceReminder,
        "date_of_birth": dateOfBirth,
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
        "upcoming_birthday": upcomingBirthday.toString(),
        "formated_present_address": formatedPresentAddress,
        "formated_permanent_address": formatedPermanentAddress,
        "designation": designation!.toJson(),
        "permanentdistrict": permanentdistrict,
        "permanentstate": permanentstate,
        "presentdistrict": presentdistrict,
        "presentstate": presentstate,
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

class Entdistrict {
  Entdistrict({
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

  factory Entdistrict.fromJson(Map<String, dynamic> json) => Entdistrict(
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

class Role {
  Role({
    this.userId,
    this.roleId,
  });

  int? userId;
  int? roleId;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        userId: json["user_id"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "role_id": roleId,
      };
}

class Taskcategory {
  Taskcategory({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  factory Taskcategory.fromJson(Map<String, dynamic> json) => Taskcategory(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
