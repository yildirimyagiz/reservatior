
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum CommissionRuleType {
    SEASONAL,
	VOLUME,
	PROPERTY_TYPE,
	LOCATION_BASED,
	BOOKING_VALUE,
	LOYALTY,
	SPECIAL_PROMOTION,
	PACKAGE_DEAL,
	PRICE_COMPARISON,
	COMMISSION_SUMMARY,
	BOOKING_VOLUME,
	REVENUE,
	PERFORMANCE;
   
    String toJson() => toString().split('.').last;

    factory CommissionRuleType.fromJson(String name) => values.byName(name);
  
}
