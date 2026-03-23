
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EscrowDisputeParty {
    TENANT,
	OWNER,
	PLATFORM;
   
    String toJson() => toString().split('.').last;

    factory EscrowDisputeParty.fromJson(String name) => values.byName(name);
  
}
