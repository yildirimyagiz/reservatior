
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum MLSProviderKey {
    RIGHTMOVE,
	ZOOPLA,
	ONTHEMARKET,
	SAVILLS,
	STRATFORD_GRAHAM,
	GENERIC_RETS,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory MLSProviderKey.fromJson(String name) => values.byName(name);
  
}
