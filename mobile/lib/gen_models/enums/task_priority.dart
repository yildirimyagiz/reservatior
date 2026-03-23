
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TaskPriority {
    LOW,
	MEDIUM,
	HIGH,
	URGENT;
   
    String toJson() => toString().split('.').last;

    factory TaskPriority.fromJson(String name) => values.byName(name);
  
}
