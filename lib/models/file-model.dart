// To parse this JSON data, do
//
//     final fileModel = fileModelFromJson(jsonString);

import 'dart:convert';

FileModel fileModelFromJson(String str) => FileModel.fromJson(json.decode(str));

String fileModelToJson(FileModel data) => json.encode(data.toJson());

class FileModel {
  FileModel({
    required this.id,
    required this.userId,
    required this.installationId,
    required this.filename,
    required this.hashname,
    required this.size,
    required this.description,
    required this.googleUrl,
    required this.dropboxLink,
    required this.externalLinkName,
    required this.externalLink,
    required this.addedBy,
    required this.lastUpdatedBy,
    required this.fileUrl,
    required this.icon,
  });

  int? id;
  int? userId;
  int? installationId;
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

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        installationId:
            json["installation_id"] == null ? null : json["installation_id"],
        filename: json["filename"] == null ? null : json["filename"],
        hashname: json["hashname"] == null ? null : json["hashname"],
        size: json["size"] == null ? null : json["size"],
        description: json["description"],
        googleUrl: json["google_url"],
        dropboxLink: json["dropbox_link"],
        externalLinkName: json["external_link_name"],
        externalLink: json["external_link"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        fileUrl: json["file_url"] == null ? null : json["file_url"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "installation_id": installationId == null ? null : installationId,
        "filename": filename == null ? null : filename,
        "hashname": hashname == null ? null : hashname,
        "size": size == null ? null : size,
        "description": description,
        "google_url": googleUrl,
        "dropbox_link": dropboxLink,
        "external_link_name": externalLinkName,
        "external_link": externalLink,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "file_url": fileUrl == null ? null : fileUrl,
        "icon": icon == null ? null : icon,
      };
}
