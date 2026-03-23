
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum InspectionType {
    MOVE_IN,
	MOVE_OUT,
	ROUTINE,
	EMERGENCY,
	HEALTH_SAFETY,
	PEST_CONTROL,
	STRUCTURAL,
	ELECTRICAL,
	PLUMBING,
	HVAC;
   
    String toJson() => toString().split('.').last;

    factory InspectionType.fromJson(String name) => values.byName(name);
  
}
