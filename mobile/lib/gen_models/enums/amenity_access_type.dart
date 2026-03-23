
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum AmenityAccessType {
    FREE,
	PAID,
	MEMBERSHIP;
   
    String toJson() => toString().split('.').last;

    factory AmenityAccessType.fromJson(String name) => values.byName(name);
  
}
