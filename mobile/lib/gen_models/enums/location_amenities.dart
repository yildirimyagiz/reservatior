
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum LocationAmenities {
    CITY_CENTER,
	BEACH,
	PARK,
	SHOPPING_MALL,
	HOSPITAL,
	SCHOOL,
	UNIVERSITY,
	POLICE_STATION,
	FIRE_STATION,
	PUBLIC_TRANSPORT,
	SUBWAY_STATION,
	BUS_STOP,
	AIRPORT,
	RESTAURANT_DISTRICT,
	ENTERTAINMENT_ZONE,
	BUSINESS_DISTRICT,
	CULTURAL_CENTER,
	MUSEUM,
	LIBRARY,
	SPORTS_COMPLEX;
   
    String toJson() => toString().split('.').last;

    factory LocationAmenities.fromJson(String name) => values.byName(name);
  
}
