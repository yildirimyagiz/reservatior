
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum DeviceType {
    MOBILE,
	DESKTOP,
	TABLET,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory DeviceType.fromJson(String name) => values.byName(name);
  
}
