
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum JobStatus {
    PENDING,
	RUNNING,
	COMPLETED,
	FAILED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory JobStatus.fromJson(String name) => values.byName(name);
  
}
