// To parse this JSON data, do
//
//     final serviceTaskDetailsModel = serviceTaskDetailsModelFromJson(jsonString);

import 'dart:convert';

ServiceTaskDetailsModel serviceTaskDetailsModelFromJson(String str) =>
    ServiceTaskDetailsModel.fromJson(json.decode(str));

String serviceTaskDetailsModelToJson(ServiceTaskDetailsModel data) =>
    json.encode(data.toJson());

class ServiceTaskDetailsModel {
  ServiceTaskDetailsModel({
    this.id,
    this.serviceId,
    this.categoryId,
    this.taskDescription,
    this.startDate,
    this.endDate,
    this.removeableCount,
    this.isRemovable,
    this.taskStatus,
    this.taskQuantity,
    this.category,
    this.items,
  });

  int? id;
  int? serviceId;
  int? categoryId;
  dynamic taskDescription;
  DateTime? startDate;
  dynamic endDate;
  int? removeableCount;
  int? isRemovable;
  String? taskStatus;
  int? taskQuantity;
  Category? category;
  List<Item>? items;

  factory ServiceTaskDetailsModel.fromJson(Map<String, dynamic> json) =>
      ServiceTaskDetailsModel(
        id: json["id"],
        serviceId: json["service_id"],
        categoryId: json["category_id"],
        taskDescription: json["task_description"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate: json["end_date"],
        removeableCount: json["removeable_count"],
        isRemovable: json["is_removable"],
        taskStatus: json["task_status"],
        taskQuantity: json["task_quantity"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "category_id": categoryId,
        "task_description": taskDescription,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate,
        "removeable_count": removeableCount,
        "is_removable": isRemovable,
        "task_status": taskStatus,
        "task_quantity": taskQuantity,
        "category": category?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.productPrefix,
    this.productNos,
    this.name,
    this.alias,
    this.printName,
    this.unitId,
    this.taxes,
    this.allowPurchase,
    this.downloadable,
    this.downloadableFile,
    this.description,
    this.categoryId,
    this.basePrice,
    this.modelName,
    this.subCategoryId,
    this.addedBy,
    this.lastUpdatedBy,
    this.hsnSacCode,
    this.defaultImage,
    this.enableConversion,
    this.secondaryUnit,
    this.conversionRadio,
    this.specificationGroupId,
    this.enableSerialNo,
    this.isServiceProduct,
    this.saleWarranty,
    this.purchaseWarranty,
    this.removableProduct,
    this.imageUrl,
    this.productCode,
    this.tax,
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
  dynamic defaultImage;
  dynamic enableConversion;
  dynamic secondaryUnit;
  String? conversionRadio;
  dynamic specificationGroupId;
  dynamic enableSerialNo;
  int? isServiceProduct;
  dynamic saleWarranty;
  dynamic purchaseWarranty;
  dynamic removableProduct;
  String? imageUrl;
  String? productCode;
  dynamic tax;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
        isServiceProduct: json["is_service_product"],
        saleWarranty: json["sale_warranty"],
        purchaseWarranty: json["purchase_warranty"],
        removableProduct: json["removable_product"],
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
        "is_service_product": isServiceProduct,
        "sale_warranty": saleWarranty,
        "purchase_warranty": purchaseWarranty,
        "removable_product": removableProduct,
        "image_url": imageUrl,
        "product_code": productCode,
        "tax": tax,
      };
}

class Item {
  Item({
    this.id,
    this.serviceTaskId,
    this.branchId,
    this.serviceId,
    this.spProduct,
    this.productId,
    this.enableSerialno,
    this.serialNo,
    this.unitId,
    this.quantity,
    this.serviceDcId,
    this.serviceDcItemId,
    this.product,
    this.unit,
    this.serialnos,
  });

  int? id;
  int? serviceTaskId;
  int? branchId;
  int? serviceId;
  int? spProduct;
  int? productId;
  int? enableSerialno;
  dynamic serialNo;
  int? unitId;
  int? quantity;
  int? serviceDcId;
  int? serviceDcItemId;
  Product? product;
  Unit? unit;
  List<dynamic>? serialnos;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        serviceTaskId: json["service_task_id"],
        branchId: json["branch_id"],
        serviceId: json["service_id"],
        spProduct: json["sp_product"],
        productId: json["product_id"],
        enableSerialno: json["enable_serialno"],
        serialNo: json["serial_no"],
        unitId: json["unit_id"],
        quantity: json["quantity"],
        serviceDcId: json["service_dc_id"],
        serviceDcItemId: json["service_dc_item_id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        serialnos: json["serialnos"] == null
            ? []
            : List<dynamic>.from(json["serialnos"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_task_id": serviceTaskId,
        "branch_id": branchId,
        "service_id": serviceId,
        "sp_product": spProduct,
        "product_id": productId,
        "enable_serialno": enableSerialno,
        "serial_no": serialNo,
        "unit_id": unitId,
        "quantity": quantity,
        "service_dc_id": serviceDcId,
        "service_dc_item_id": serviceDcItemId,
        "product": product?.toJson(),
        "unit": unit?.toJson(),
        "serialnos": serialnos == null
            ? []
            : List<dynamic>.from(serialnos!.map((x) => x)),
      };
}

class Product {
  Product({
    this.id,
    this.productPrefix,
    this.productNos,
    this.name,
    this.alias,
    this.printName,
    this.unitId,
    this.taxes,
    this.allowPurchase,
    this.downloadable,
    this.downloadableFile,
    this.description,
    this.categoryId,
    this.basePrice,
    this.modelName,
    this.subCategoryId,
    this.addedBy,
    this.lastUpdatedBy,
    this.hsnSacCode,
    this.defaultImage,
    this.enableConversion,
    this.secondaryUnit,
    this.conversionRadio,
    this.specificationGroupId,
    this.enableSerialNo,
    this.isServiceProduct,
    this.saleWarranty,
    this.purchaseWarranty,
    this.removableProduct,
    this.imageUrl,
    this.productCode,
    this.tax,
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
  dynamic isServiceProduct;
  dynamic saleWarranty;
  dynamic purchaseWarranty;
  dynamic removableProduct;
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
        isServiceProduct: json["is_service_product"],
        saleWarranty: json["sale_warranty"],
        purchaseWarranty: json["purchase_warranty"],
        removableProduct: json["removable_product"],
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
        "is_service_product": isServiceProduct,
        "sale_warranty": saleWarranty,
        "purchase_warranty": purchaseWarranty,
        "removable_product": removableProduct,
        "image_url": imageUrl,
        "product_code": productCode,
        "tax": tax,
      };
}

class Serialno {
  Serialno({
    this.id,
    this.installationTaskId,
    this.installationTaskItemId,
    this.productId,
    this.unitId,
    this.serialno,
  });

  int? id;
  int? installationTaskId;
  int? installationTaskItemId;
  int? productId;
  int? unitId;
  String? serialno;

  factory Serialno.fromJson(Map<String, dynamic> json) => Serialno(
        id: json["id"],
        installationTaskId: json["installation_task_id"],
        installationTaskItemId: json["installation_task_item_id"],
        productId: json["product_id"],
        unitId: json["unit_id"],
        serialno: json["serialno"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "installation_task_id": installationTaskId,
        "installation_task_item_id": installationTaskItemId,
        "product_id": productId,
        "unit_id": unitId,
        "serialno": serialno,
      };
}

class Unit {
  Unit({
    this.id,
    this.unitName,
    this.shortName,
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
