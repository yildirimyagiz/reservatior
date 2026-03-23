
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PricingRuleType {
    SEASONAL,
	LONG_TERM,
	EARLY_BOOKING,
	LAST_MINUTE,
	SPECIAL_EVENT;
   
    String toJson() => toString().split('.').last;

    factory PricingRuleType.fromJson(String name) => values.byName(name);
  
}
