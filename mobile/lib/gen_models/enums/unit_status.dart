
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum UnitStatus {
    AVAILABLE,
	OCCUPIED,
	MAINTENANCE,
	RENOVATION,
	RESERVED,
	SOLD,
	RENTED;
   
    String toJson() => toString().split('.').last;

    factory UnitStatus.fromJson(String name) => values.byName(name);
  
}
