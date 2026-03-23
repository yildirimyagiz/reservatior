
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum AlertType {
    WARNING,
	CRITICAL,
	INFO,
	SUCCESS;
   
    String toJson() => toString().split('.').last;

    factory AlertType.fromJson(String name) => values.byName(name);
  
}
