
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum HeatingType {
    FORCED_AIR,
	RADIANT,
	ELECTRIC,
	GAS,
	OIL,
	HEAT_PUMP,
	GEOTHERMAL;
   
    String toJson() => toString().split('.').last;

    factory HeatingType.fromJson(String name) => values.byName(name);
  
}
