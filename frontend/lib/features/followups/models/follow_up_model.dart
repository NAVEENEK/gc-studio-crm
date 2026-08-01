class FollowUpModel {
  final int followId;
  final String leadName;
  final String? employeeName;
  final DateTime followUpDate;
  final String status;
  final String task;
  final DateTime? createdAt;

  const FollowUpModel({
    required this.followId,
    required this.leadName,
    this.employeeName,
    required this.followUpDate,
    required this.status,
    required this.task,
    this.createdAt,
  });

  factory FollowUpModel.fromJson(Map<String, dynamic> json) {
    return FollowUpModel(
      followId: json["follow_id"],
      leadName: json["lead_name"],
      employeeName: json["employee_name"],
      followUpDate: DateTime.parse(json["follow_up_date"]),
      status: json["follow_up_status"],
      task: json["task"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "follow_id": followId,
      "lead_name": leadName,
      "employee_name": employeeName,
      "follow_up_date": followUpDate.toIso8601String(),
      "follow_up_status": status,
      "task": task,
      "created_at": createdAt?.toIso8601String(),
    };
  }

  FollowUpModel copyWith({
    int? followId,
    String? leadName,
    String? employeeName,
    DateTime? followUpDate,
    String? status,
    String? task,
    DateTime? createdAt,
  }) {
    return FollowUpModel(
      followId: followId ?? this.followId,
      leadName: leadName ?? this.leadName,
      employeeName: employeeName ?? this.employeeName,
      followUpDate: followUpDate ?? this.followUpDate,
      status: status ?? this.status,
      task: task ?? this.task,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
