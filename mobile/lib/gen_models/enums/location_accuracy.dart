
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum LocationAccuracy {
    EXACT,
	STREET_LEVEL,
	NEIGHBORHOOD_LEVEL,
	CITY_LEVEL,
	APPROXIMATE,
	ESTIMATED;
   
    String toJson() => toString().split('.').last;

    factory LocationAccuracy.fromJson(String name) => values.byName(name);
  
}
