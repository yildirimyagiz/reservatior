
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum Gender {
    MALE,
	FEMALE;
   
    String toJson() => toString().split('.').last;

    factory Gender.fromJson(String name) => values.byName(name);
  
}
