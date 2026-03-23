
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum LoyaltyTier {
    BRONZE,
	SILVER,
	GOLD,
	PLATINUM,
	DIAMOND;
   
    String toJson() => toString().split('.').last;

    factory LoyaltyTier.fromJson(String name) => values.byName(name);
  
}
