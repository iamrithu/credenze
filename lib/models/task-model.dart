class TaskModel {
  TaskModel({
    required this.id,
    required this.installationId,
    required this.category,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.addedBy,
    required this.lastUpdatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryName,
  });

  int? id;
  int? installationId;
  String? category;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  int? addedBy;
  dynamic lastUpdatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryName;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"] == null ? null : json["id"],
        installationId:
            json["installation_id"] == null ? null : json["installation_id"],
        category: json["category"] == null ? null : json["category"],
        description: json["description"] == null ? null : json["description"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        addedBy: json["added_by"] == null ? null : json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "installation_id": installationId == null ? null : installationId,
        "category": category == null ? null : category,
        "description": description == null ? null : description,
        "start_date": startDate == null
            ? null
            : "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": endDate == null
            ? null
            : "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "added_by": addedBy == null ? null : addedBy,
        "last_updated_by": lastUpdatedBy,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "category_name": categoryName == null ? null : categoryName,
      };
}
