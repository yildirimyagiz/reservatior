
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TaskType {
    CLEANING,
	INSPECTION,
	REPAIR,
	ADMIN,
	LEGAL,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory TaskType.fromJson(String name) => values.byName(name);
  
}
