
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum WidgetType {
    OCCUPANCY_RATE,
	REVENUE_CHART,
	MAINTENANCE_COSTS,
	CASH_FLOW,
	PROPERTY_PERFORMANCE,
	MARKET_TRENDS;
   
    String toJson() => toString().split('.').last;

    factory WidgetType.fromJson(String name) => values.byName(name);
  
}
