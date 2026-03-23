
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ParkingType {
    STREET,
	DRIVEWAY,
	GARAGE,
	CARPORT,
	UNDERGROUND,
	ASSIGNED_PARKING;
   
    String toJson() => toString().split('.').last;

    factory ParkingType.fromJson(String name) => values.byName(name);
  
}
