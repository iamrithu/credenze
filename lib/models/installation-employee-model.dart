// To parse this JSON data, do
//
//     final installationEmployeeModel = installationEmployeeModelFromJson(jsonString);

import 'dart:convert';

InstallationEmployeeModel installationEmployeeModelFromJson(String str) =>
    InstallationEmployeeModel.fromJson(json.decode(str));

String installationEmployeeModelToJson(InstallationEmployeeModel data) =>
    json.encode(data.toJson());

class InstallationEmployeeModel {
  InstallationEmployeeModel({
    this.userid,
    this.name,
  });

  int? userid;
  String? name;

  factory InstallationEmployeeModel.fromJson(Map<String, dynamic> json) =>
      InstallationEmployeeModel(
        userid: json["userid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "name": name,
      };
}
