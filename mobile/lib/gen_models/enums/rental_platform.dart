
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum RentalPlatform {
    AIRBNB,
	BOOKING_COM,
	EXPEDIA,
	VRBO,
	HOMEAWAY,
	TRIPADVISOR,
	GOOGLE_VACATION_RENTALS,
	FACEBOOK_MARKETPLACE,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory RentalPlatform.fromJson(String name) => values.byName(name);
  
}
