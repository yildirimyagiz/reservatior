
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum MortgageStatus {
    ACTIVE,
	PAID,
	DEFAULTED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory MortgageStatus.fromJson(String name) => values.byName(name);
  
}
