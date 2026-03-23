
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum FacilityAmenities {
    COMMUNITY_CENTER,
	CO_WORKING_SPACE,
	BIKE_STORAGE,
	PARKING_GARAGE,
	EV_CHARGING,
	SECURITY_DESK,
	PACKAGE_ROOM,
	BBQ_AREA,
	ROOFTOP_TERRACE;
   
    String toJson() => toString().split('.').last;

    factory FacilityAmenities.fromJson(String name) => values.byName(name);
  
}
