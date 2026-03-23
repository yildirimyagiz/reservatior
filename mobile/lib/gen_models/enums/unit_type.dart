
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum UnitType {
    STUDIO,
	ONE_PLUS_ONE,
	TWO_PLUS_ONE,
	THREE_PLUS_ONE,
	FOUR_PLUS_ONE,
	FIVE_PLUS_ONE,
	PENTHOUSE,
	DUPLEX,
	TRIPLEX,
	VILLA,
	COMMERCIAL_UNIT,
	OFFICE_UNIT,
	RETAIL_UNIT;
   
    String toJson() => toString().split('.').last;

    factory UnitType.fromJson(String name) => values.byName(name);
  
}
