
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum DiscountType {
    FIRST_BOOKING,
	LONG_TERM,
	REFERRAL,
	SEASONAL,
	CUSTOM,
	PERCENTAGE,
	FIXED_AMOUNT,
	FREE_NIGHTS;
   
    String toJson() => toString().split('.').last;

    factory DiscountType.fromJson(String name) => values.byName(name);
  
}
