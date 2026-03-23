
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ContactMethod {
    EMAIL,
	PHONE,
	MESSAGE,
	ANY;
   
    String toJson() => toString().split('.').last;

    factory ContactMethod.fromJson(String name) => values.byName(name);
  
}
