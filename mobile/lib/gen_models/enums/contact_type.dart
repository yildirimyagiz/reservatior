
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ContactType {
    TENANT,
	GUEST,
	OWNER_CONTACT,
	VENDOR_CONTACT,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory ContactType.fromJson(String name) => values.byName(name);
  
}
