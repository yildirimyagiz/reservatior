
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ListingChannelType {
    DIRECT,
	MLS,
	AIRBNB,
	BOOKING_COM,
	EXPEDIA,
	VRBO,
	OTHER_PLATFORM;
   
    String toJson() => toString().split('.').last;

    factory ListingChannelType.fromJson(String name) => values.byName(name);
  
}
