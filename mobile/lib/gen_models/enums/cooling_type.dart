
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum CoolingType {
    CENTRAL_AC,
	WINDOW_UNIT,
	DUCTLESS_MINI_SPLIT,
	EVAPORATIVE_COOLER;
   
    String toJson() => toString().split('.').last;

    factory CoolingType.fromJson(String name) => values.byName(name);
  
}
