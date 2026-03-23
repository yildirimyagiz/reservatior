
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum Priority {
    LOW,
	MEDIUM,
	HIGH,
	URGENT;
   
    String toJson() => toString().split('.').last;

    factory Priority.fromJson(String name) => values.byName(name);
  
}
