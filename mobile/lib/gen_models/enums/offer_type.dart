
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum OfferType {
    STANDARD,
	PROMOTIONAL,
	LAST_MINUTE,
	GROUP,
	EXTENDED_STAY;
   
    String toJson() => toString().split('.').last;

    factory OfferType.fromJson(String name) => values.byName(name);
  
}
