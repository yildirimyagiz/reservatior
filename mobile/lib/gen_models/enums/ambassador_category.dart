
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum AmbassadorCategory {
    ATHLETE,
	ENTERTAINER,
	REAL_ESTATE_INFLUENCER,
	BUSINESS_LEADER,
	SOCIAL_MEDIA_CREATOR,
	CELEBRITY,
	MICRO_INFLUENCER;
   
    String toJson() => toString().split('.').last;

    factory AmbassadorCategory.fromJson(String name) => values.byName(name);
  
}
