
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PropertyPromotionType {
    FEATURED,
	URGENT,
	PRICE_REDUCED,
	BEST_DEAL;
   
    String toJson() => toString().split('.').last;

    factory PropertyPromotionType.fromJson(String name) => values.byName(name);
  
}
