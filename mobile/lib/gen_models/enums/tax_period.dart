
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TaxPeriod {
    MONTHLY,
	QUARTERLY,
	ANNUAL;
   
    String toJson() => toString().split('.').last;

    factory TaxPeriod.fromJson(String name) => values.byName(name);
  
}
