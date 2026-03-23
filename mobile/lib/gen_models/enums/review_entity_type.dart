
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ReviewEntityType {
    PROPERTY,
	LISTING,
	AGENT,
	AGENCY,
	VENDOR;
   
    String toJson() => toString().split('.').last;

    factory ReviewEntityType.fromJson(String name) => values.byName(name);
  
}
