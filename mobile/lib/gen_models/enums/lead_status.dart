
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum LeadStatus {
    NEW,
	CONTACTED,
	QUALIFIED,
	CONVERTED,
	LOST,
	UNQUALIFIED,
	NURTURE;
   
    String toJson() => toString().split('.').last;

    factory LeadStatus.fromJson(String name) => values.byName(name);
  
}
