
class CampaignModel {
  final int campaignId;
  final String? campaignName;
  final String? clientName;
  final String? campaignType;
  final String? source;
  final double? budget;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? descriptions;
  final String? status;

  const CampaignModel({
    required this.campaignId,
    this.campaignName,
    this.clientName,
    this.campaignType,
    this.source,
    this.budget,
    this.startDate,
    this.endDate,
    this.descriptions,
    this.status,
  });

  factory CampaignModel.fromJson(Map<String,dynamic>json){
    return CampaignModel(
      campaignId: json["campaign_id"],
      campaignName: json["campaign_name"],
      clientName: json["client_name"],
      campaignType: json["campaign_type"],
      source: json["source"],
      budget: json["budget"],
      startDate: json["start_date"]!=null
      ?DateTime.parse(json["start_date"])
      :null,
      endDate:json["end_date"]!=null
      ? DateTime.parse(json["end_date"])
      :null,
      descriptions: json["descriptions"],
      status: json["status"]
      );
  }

  Map<String,dynamic> toJson(){
    return{
      "campaign_id":campaignId,
      "campaign_name":campaignName,
      "client_name":clientName,
      "campaign_type":campaignType,
      "source":source,
      "budget":budget,
      "start_date":startDate?.toIso8601String(),
      "end_date":endDate?.toIso8601String(),
      "descriptions":descriptions,
      "status":status
    };
  }
}