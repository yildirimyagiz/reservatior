
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum OwnershipType {
    FREEHOLD,
	LEASEHOLD,
	COMMONHOLD,
	COOPERATIVE,
	TIMESHARE,
	FRACTIONAL;
   
    String toJson() => toString().split('.').last;

    factory OwnershipType.fromJson(String name) => values.byName(name);
  
}
