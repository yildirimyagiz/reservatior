
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum BookingSource {
    Direct,
	Airbnb,
	Booking,
	Expedia,
	Other,
	Agency,
	ReferenceSource;
   
    String toJson() => toString().split('.').last;

    factory BookingSource.fromJson(String name) => values.byName(name);
  
}
