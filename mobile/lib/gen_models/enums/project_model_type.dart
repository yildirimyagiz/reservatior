
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ProjectModelType {
    INVESTMENT_SCORE,
	LOCATION_SCORE,
	PRICE_PREDICTION,
	AMENITIES_SCORE,
	MARKET_ANALYSIS,
	TREND_PREDICTION;
   
    String toJson() => toString().split('.').last;

    factory ProjectModelType.fromJson(String name) => values.byName(name);
  
}
