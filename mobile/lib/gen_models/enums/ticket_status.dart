
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TicketStatus {
    OPEN,
	IN_PROGRESS,
	RESOLVED,
	CLOSED,
	ARCHIVED;
   
    String toJson() => toString().split('.').last;

    factory TicketStatus.fromJson(String name) => values.byName(name);
  
}
