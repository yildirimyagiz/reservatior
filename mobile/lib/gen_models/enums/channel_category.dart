
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ChannelCategory {
    AGENT,
	AGENCY,
	TENANT,
	PROPERTY,
	PAYMENT,
	SYSTEM,
	REPORT,
	RESERVATION,
	TASK,
	TICKET;
   
    String toJson() => toString().split('.').last;

    factory ChannelCategory.fromJson(String name) => values.byName(name);
  
}
