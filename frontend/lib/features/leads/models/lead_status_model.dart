class LeadStatusModel {
  final String status;
  final int count;

  const LeadStatusModel({
    required this.status,
    required this.count
  });

  factory LeadStatusModel.fromJson(Map<String, dynamic> json){
    return LeadStatusModel(
      status: json["lead_status"], 
      count: json["count"]
      );
  }
}
