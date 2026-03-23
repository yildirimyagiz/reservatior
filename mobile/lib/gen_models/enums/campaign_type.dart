
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum CampaignType {
    EMAIL,
	SOCIAL_MEDIA,
	SEARCH_ENGINE,
	DISPLAY_ADS,
	PRINT,
	EVENT,
	REFERRAL,
	DIRECT_MAIL;
   
    String toJson() => toString().split('.').last;

    factory CampaignType.fromJson(String name) => values.byName(name);
  
}
