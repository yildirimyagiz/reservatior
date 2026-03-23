
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ModelType {
    OCCUPANCY_FORECAST,
	RENT_PRICE_PREDICTION,
	MARKET_VALUE_ESTIMATE,
	CASH_FLOW_PROJECTION;
   
    String toJson() => toString().split('.').last;

    factory ModelType.fromJson(String name) => values.byName(name);
  
}
