
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum CampaignStatus {
    DRAFT,
	ACTIVE,
	PAUSED,
	COMPLETED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory CampaignStatus.fromJson(String name) => values.byName(name);
  
}
