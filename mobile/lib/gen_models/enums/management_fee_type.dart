
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ManagementFeeType {
    PERCENTAGE_RENT,
	PERCENTAGE_INCOME,
	FLAT_MONTHLY,
	FLAT_ANNUAL,
	PER_UNIT_MONTHLY,
	TIERED_PERCENTAGE,
	PERFORMANCE_BASED,
	HYBRID;
   
    String toJson() => toString().split('.').last;

    factory ManagementFeeType.fromJson(String name) => values.byName(name);
  
}
