
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum AlertSeverity {
    LOW,
	MEDIUM,
	HIGH,
	CRITICAL;
   
    String toJson() => toString().split('.').last;

    factory AlertSeverity.fromJson(String name) => values.byName(name);
  
}
