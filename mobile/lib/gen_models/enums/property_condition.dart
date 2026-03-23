
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PropertyCondition {
    EXCELLENT,
	GOOD,
	FAIR,
	NEEDS_RENOVATION,
	UNDER_CONSTRUCTION;
   
    String toJson() => toString().split('.').last;

    factory PropertyCondition.fromJson(String name) => values.byName(name);
  
}
