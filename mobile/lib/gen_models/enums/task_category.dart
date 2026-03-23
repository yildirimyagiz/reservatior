
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TaskCategory {
    CLEANING,
	REPAIR,
	DECORATION,
	SERVICE,
	MOVING;
   
    String toJson() => toString().split('.').last;

    factory TaskCategory.fromJson(String name) => values.byName(name);
  
}
