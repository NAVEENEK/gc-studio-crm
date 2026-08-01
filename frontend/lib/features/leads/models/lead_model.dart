class LeadModel {
  final int leadId;
  final String? clientName;
  final String? campaignName;
  final String leadName;
  final String? phoneNumber;
  final String? email;
  final String status;
  final String? service;
  final DateTime addedOn;
  final DateTime? updatedOn;
   final String? employeeName;

  const LeadModel({
    required this.leadId,
    this.clientName,
    this.campaignName,
    required this.leadName,
    this.phoneNumber,
    this.email,
    required this.status,
    this.service,
    required this.addedOn,
    this.updatedOn,
    this.employeeName,
  });

  factory LeadModel.fromJson(Map<String,dynamic> json){
    return LeadModel(
      leadId: json["lead_id"],
      clientName: json["client_name"],
      campaignName: json["campaign_name"],
      leadName: json["lead_name"], 
      phoneNumber: json["phone_number"],
      email: json["email"],
      status: json["lead_status"],  
      service: json["interested_service"],
      addedOn:DateTime.parse(json["created_at"]) ,
      updatedOn:json["updated_at"] != null
      ?DateTime.parse(json["updated_at"])
      :null,
      employeeName: json["employee_name"],
      );
  }

  Map<String,dynamic> toJson(){
    return{
      "lead_id":leadId,
      "client_name":clientName,
      "campaign_name":campaignName,
      "lead_name":leadName,
      "phone_number":phoneNumber,
      "email":email,
      "lead_status":status,
      "interested_service":service,
      "created_at":addedOn.toIso8601String(),
      "updated_at":updatedOn?.toIso8601String(),
      "employee_name":employeeName,      
    };
  }

  LeadModel copyWith({
    int? leadId,
    String? clientName,
    String? campaignName,
    String? leadName,
    String? phoneNumber,
    String? email,
    String? status,
    String? service,
    DateTime? addedOn,
    DateTime? updatedOn,
    String? employeeName,
  }){
    return LeadModel(
      leadId: leadId ?? this.leadId,
      clientName: clientName?? this.clientName,
      campaignName: campaignName?? this.campaignName, 
      leadName: leadName?? this.leadName,
      phoneNumber: phoneNumber?? this.phoneNumber,
      email: email?? this.email, 
      status: status?? this.status, 
      service: service?? this.service,
      addedOn: addedOn?? this.addedOn,
      updatedOn: updatedOn?? this.updatedOn,
      employeeName: employeeName?? this.employeeName,       
      );
  }
}
