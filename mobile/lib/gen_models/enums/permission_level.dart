
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PermissionLevel {
    READ,
	WRITE,
	ADMIN;
   
    String toJson() => toString().split('.').last;

    factory PermissionLevel.fromJson(String name) => values.byName(name);
  
}
