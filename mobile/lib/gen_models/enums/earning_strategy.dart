
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EarningStrategy {
    LONG_TERM_STABLE,
	SHORT_TERM_YIELD,
	FLIP_SALE,
	MIXED;
   
    String toJson() => toString().split('.').last;

    factory EarningStrategy.fromJson(String name) => values.byName(name);
  
}
