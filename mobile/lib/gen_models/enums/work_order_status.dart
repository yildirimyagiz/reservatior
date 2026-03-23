
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum WorkOrderStatus {
    OPEN,
	ASSIGNED,
	IN_PROGRESS,
	COMPLETED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory WorkOrderStatus.fromJson(String name) => values.byName(name);
  
}
