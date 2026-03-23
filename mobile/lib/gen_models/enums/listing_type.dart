
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ListingType {
    SALE,
	RENT,
	BOOKING;
   
    String toJson() => toString().split('.').last;

    factory ListingType.fromJson(String name) => values.byName(name);
  
}
