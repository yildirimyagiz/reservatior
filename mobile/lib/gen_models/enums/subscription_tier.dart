
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum SubscriptionTier {
    TRIAL,
	SILVER,
	STARTER,
	GOLD,
	PROFESSIONAL,
	PRO,
	DIAMOND,
	BASIC,
	ENTERPRISE;
   
    String toJson() => toString().split('.').last;

    factory SubscriptionTier.fromJson(String name) => values.byName(name);
  
}
