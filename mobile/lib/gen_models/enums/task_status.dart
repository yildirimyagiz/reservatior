
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TaskStatus {
    OPEN,
	IN_PROGRESS,
	DONE,
	CANCELLED,
	BLOCKED;
   
    String toJson() => toString().split('.').last;

    factory TaskStatus.fromJson(String name) => values.byName(name);
  
}
