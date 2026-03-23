
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum MembershipType {
    BASIC,
	PREMIUM,
	ENTERPRISE,
	VIP;
   
    String toJson() => toString().split('.').last;

    factory MembershipType.fromJson(String name) => values.byName(name);
  
}
