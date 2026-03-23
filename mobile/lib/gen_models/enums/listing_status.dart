
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ListingStatus {
    DRAFT,
	VACANT,
	AVAILABLE,
	RESERVED,
	RENTED,
	BOOKED,
	WILL_BE_AVAILABLE,
	MAINTENANCE,
	SOLD,
	ARCHIVED;
   
    String toJson() => toString().split('.').last;

    factory ListingStatus.fromJson(String name) => values.byName(name);
  
}
