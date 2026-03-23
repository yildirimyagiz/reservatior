
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum MarkerIcon {
    HOME,
	BUILDING,
	APARTMENT,
	COMMERCIAL,
	LAND,
	VACANT,
	UNDER_CONSTRUCTION,
	FOR_SALE,
	FOR_RENT,
	SOLD,
	PENDING,
	SCHOOL,
	HOSPITAL,
	PARK,
	TRANSIT,
	SHOPPING,
	RESTAURANT,
	BANK,
	GOVERNMENT,
	CUSTOM;
   
    String toJson() => toString().split('.').last;

    factory MarkerIcon.fromJson(String name) => values.byName(name);
  
}
