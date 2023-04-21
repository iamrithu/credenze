// To parse this JSON data, do
//
//     final permissionListModel = permissionListModelFromJson(jsonString);

import 'dart:convert';

PermissionListModel permissionListModelFromJson(String str) => PermissionListModel.fromJson(json.decode(str));

String permissionListModelToJson(PermissionListModel data) => json.encode(data.toJson());

class PermissionListModel {
    PermissionListModel({
        required this.id,
        required this.date,
        required this.userId,
        required this.fromTime,
        required this.toTime,
        required this.duration,
        required this.reason,
        required this.status,
        required this.approvedBy,
        required this.approvedAt,
         required this.rejectReason,
        required this.addedBy,
        required this.lastUpdatedBy,
    });

    int? id;
    DateTime? date;
    int? userId;
    DateTime? fromTime;
    DateTime? toTime;
    String? duration;
    String? reason;
    String? status;
    int? approvedBy;
    dynamic approvedAt;
    dynamic rejectReason;
    dynamic addedBy;
    dynamic lastUpdatedBy;

    factory PermissionListModel.fromJson(Map<String, dynamic> json) => PermissionListModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        userId: json["user_id"],
        fromTime: DateTime.parse(json["from_time"]),
        toTime: DateTime.parse(json["to_time"]),
        duration: json["duration"],
        reason: json["reason"],
        status: json["status"],
        approvedBy: json["approved_by"],
        approvedAt: json["approved_at"],
        rejectReason: json["reject_reason"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
    );

    Map<String, dynamic> toJson() => {
        "id": id!,
        "date": date!.toIso8601String(),
        "user_id": userId!,
        "from_time": fromTime!.toString(),
        "to_time": toTime!.toString(),
        "duration": duration!,
        "reason": reason!,
        "status": status!,
        "approved_by": approvedBy!,
        "approved_at": approvedAt,
        "reject_reason": rejectReason,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
    };
}
