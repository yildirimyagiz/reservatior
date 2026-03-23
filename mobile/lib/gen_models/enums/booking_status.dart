
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum BookingStatus {
    DRAFT,
	CONFIRMED,
	CHECKED_IN,
	CHECKED_OUT,
	CANCELLED,
	NO_SHOW;
   
    String toJson() => toString().split('.').last;

    factory BookingStatus.fromJson(String name) => values.byName(name);
  
}
