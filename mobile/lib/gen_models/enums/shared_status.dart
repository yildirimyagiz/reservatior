
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum SharedStatus {
    PENDING,
	ACTIVE,
	SUSPENDED;
   
    String toJson() => toString().split('.').last;

    factory SharedStatus.fromJson(String name) => values.byName(name);
  
}
