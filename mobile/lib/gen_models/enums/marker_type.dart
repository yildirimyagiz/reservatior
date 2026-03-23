
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum MarkerType {
    PROPERTY_PIN,
	LISTING_PIN,
	DEAL_PIN,
	LEAD_PIN,
	VENDOR_PIN,
	SCHOOL_PIN,
	TRANSIT_PIN,
	SHOPPING_PIN,
	PARK_PIN,
	MEDICAL_PIN,
	RESTAURANT_PIN,
	BANK_PIN,
	GOVERNMENT_PIN,
	CUSTOM_PIN;
   
    String toJson() => toString().split('.').last;

    factory MarkerType.fromJson(String name) => values.byName(name);
  
}
