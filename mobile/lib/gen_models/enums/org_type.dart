
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum OrgType {
    OWNER_PORTFOLIO,
	VENDOR_PM,
	AGENCY,
	ACCOUNTING_FIRM,
	PUBLIC_ENTITY;
   
    String toJson() => toString().split('.').last;

    factory OrgType.fromJson(String name) => values.byName(name);
  
}
