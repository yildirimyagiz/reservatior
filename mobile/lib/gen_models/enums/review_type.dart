
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ReviewType {
    PROPERTY,
	AGENT,
	AGENCY,
	SERVICE;
   
    String toJson() => toString().split('.').last;

    factory ReviewType.fromJson(String name) => values.byName(name);
  
}
