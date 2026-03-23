
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ChannelType {
    PUBLIC,
	PRIVATE,
	GROUP;
   
    String toJson() => toString().split('.').last;

    factory ChannelType.fromJson(String name) => values.byName(name);
  
}
