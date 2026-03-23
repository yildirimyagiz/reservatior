
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum InspectionStatus {
    SCHEDULED,
	IN_PROGRESS,
	COMPLETED,
	FAILED,
	CANCELLED,
	RESCHEDULED;
   
    String toJson() => toString().split('.').last;

    factory InspectionStatus.fromJson(String name) => values.byName(name);
  
}
