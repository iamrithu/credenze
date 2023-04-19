



class LeaveListModel {
    LeaveListModel({
        required this.id,
        required this.userId,
        required this.leaveTypeId,
        required this.duration,
        required this.leaveDate,
        required this.reason,
        required this.status,
        this.rejectReason,
        required this.paid,
        required this.addedBy,
        required this.lastUpdatedBy,
        this.eventId,
        this.approvedBy,
        this.approvedAt,
        this.halfDayType,
        required this.date,
        required this.recordDate,
    });

    int id;
    int userId;
    int leaveTypeId;
    String duration;
    DateTime leaveDate;
    String reason;
    String status;
    dynamic rejectReason;
    int paid;
    int addedBy;
    int lastUpdatedBy;
    dynamic eventId;
    dynamic approvedBy;
    dynamic approvedAt;
    dynamic halfDayType;
    DateTime date;
    DateTime recordDate;

    factory LeaveListModel.fromJson(Map<String, dynamic> json) => LeaveListModel(
        id: json["id"],
        userId: json["user_id"],
        leaveTypeId: json["leave_type_id"],
        duration: json["duration"],
        leaveDate: DateTime.parse(json["leave_date"]),
        reason: json["reason"],
        status: json["status"],
        rejectReason: json["reject_reason"],
        paid: json["paid"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        eventId: json["event_id"],
        approvedBy: json["approved_by"],
        approvedAt: json["approved_at"],
        halfDayType: json["half_day_type"],
        date: DateTime.parse(json["date"]),
        recordDate: DateTime.parse(json["record_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "leave_type_id": leaveTypeId,
        "duration": duration,
        "leave_date": leaveDate.toIso8601String(),
        "reason": reason,
        "status": status,
        "reject_reason": rejectReason,
        "paid": paid,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "event_id": eventId,
        "approved_by": approvedBy,
        "approved_at": approvedAt,
        "half_day_type": halfDayType,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "record_date": "${recordDate.year.toString().padLeft(4, '0')}-${recordDate.month.toString().padLeft(2, '0')}-${recordDate.day.toString().padLeft(2, '0')}",
    };
}
