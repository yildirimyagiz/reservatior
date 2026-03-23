
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum UserStatus {
    ACTIVE,
	INACTIVE,
	SUSPENDED;
   
    String toJson() => toString().split('.').last;

    factory UserStatus.fromJson(String name) => values.byName(name);
  
}
