
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum DepreciationMethod {
    STRAIGHT_LINE,
	DECLINING_BALANCE;
   
    String toJson() => toString().split('.').last;

    factory DepreciationMethod.fromJson(String name) => values.byName(name);
  
}
