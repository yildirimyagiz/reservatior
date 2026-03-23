
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum RiskTolerance {
    LOW,
	MEDIUM,
	HIGH;
   
    String toJson() => toString().split('.').last;

    factory RiskTolerance.fromJson(String name) => values.byName(name);
  
}
