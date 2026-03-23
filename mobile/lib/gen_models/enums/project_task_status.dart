
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ProjectTaskStatus {
    PENDING,
	RUNNING,
	COMPLETED,
	FAILED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory ProjectTaskStatus.fromJson(String name) => values.byName(name);
  
}
