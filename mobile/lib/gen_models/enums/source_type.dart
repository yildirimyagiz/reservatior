
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum SourceType {
    WEBSITE,
	PHONE,
	EMAIL,
	SOCIAL_MEDIA,
	REFERRAL,
	ADVERTISEMENT,
	OPEN_HOUSE,
	MLS,
	WALK_IN,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory SourceType.fromJson(String name) => values.byName(name);
  
}
