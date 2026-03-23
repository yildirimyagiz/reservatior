
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum VideoCampaignType {
    SALES_ASSISTANT,
	PRICE_OPTIMIZATION,
	MARKET_REPORT,
	SOCIAL_PROOF,
	SEASONAL,
	RETARGETING,
	AMBASSADOR,
	SOCIAL_IMPACT,
	PROPERTY_SHOWCASE,
	ONBOARDING;
   
    String toJson() => toString().split('.').last;

    factory VideoCampaignType.fromJson(String name) => values.byName(name);
  
}
