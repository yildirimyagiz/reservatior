
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum NegotiationParty {
    TENANT,
	OWNER,
	PLATFORM;
   
    String toJson() => toString().split('.').last;

    factory NegotiationParty.fromJson(String name) => values.byName(name);
  
}
