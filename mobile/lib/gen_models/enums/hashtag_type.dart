
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum HashtagType {
    GENERAL,
	PROPERTY,
	AGENT;
   
    String toJson() => toString().split('.').last;

    factory HashtagType.fromJson(String name) => values.byName(name);
  
}
