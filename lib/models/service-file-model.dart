// To parse this JSON data, do
//
//     final serviceFileModel = serviceFileModelFromJson(jsonString);

class ServiceFileModel {
  ServiceFileModel({
    this.id,
    this.userId,
    this.serviceId,
    this.filename,
    this.hashname,
    this.size,
    this.description,
    this.googleUrl,
    this.dropboxLink,
    this.externalLinkName,
    this.externalLink,
    this.addedBy,
    this.lastUpdatedBy,
    this.fileUrl,
    this.icon,
  });

  int? id;
  int? userId;
  int? serviceId;
  String? filename;
  String? hashname;
  String? size;
  dynamic description;
  dynamic googleUrl;
  dynamic dropboxLink;
  dynamic externalLinkName;
  dynamic externalLink;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  String? fileUrl;
  String? icon;

  factory ServiceFileModel.fromJson(Map<String, dynamic> json) =>
      ServiceFileModel(
        id: json["id"],
        userId: json["user_id"],
        serviceId: json["service_id"],
        filename: json["filename"],
        hashname: json["hashname"],
        size: json["size"],
        description: json["description"],
        googleUrl: json["google_url"],
        dropboxLink: json["dropbox_link"],
        externalLinkName: json["external_link_name"],
        externalLink: json["external_link"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        fileUrl: json["file_url"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "service_id": serviceId,
        "filename": filename,
        "hashname": hashname,
        "size": size,
        "description": description,
        "google_url": googleUrl,
        "dropbox_link": dropboxLink,
        "external_link_name": externalLinkName,
        "external_link": externalLink,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "file_url": fileUrl,
        "icon": icon,
      };
}
