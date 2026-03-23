
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum MemberRoleKey {
    OWNER,
	VENDOR_MANAGER,
	AGENCY_ADMIN,
	AGENT,
	ACCOUNTANT,
	MAINTENANCE,
	TENANT_GUEST,
	ORG_ADMIN,
	READ_ONLY;
   
    String toJson() => toString().split('.').last;

    factory MemberRoleKey.fromJson(String name) => values.byName(name);
  
}
