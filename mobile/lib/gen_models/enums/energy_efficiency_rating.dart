
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EnergyEfficiencyRating {
    ENERGY_STAR,
	LEED_CERTIFIED,
	LEED_SILVER,
	LEED_GOLD,
	LEED_PLATINUM,
	NET_ZERO;
   
    String toJson() => toString().split('.').last;

    factory EnergyEfficiencyRating.fromJson(String name) => values.byName(name);
  
}
