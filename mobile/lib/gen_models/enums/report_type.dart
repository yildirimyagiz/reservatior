
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ReportType {
    FINANCIAL,
	PERFORMANCE,
	COMPLIANCE,
	MARKET_ANALYSIS,
	REVENUE,
	OCCUPANCY,
	GUEST_ANALYSIS,
	OFFER_PERFORMANCE,
	RESERVATION_SUMMARY,
	EXPENSE_TRACKING,
	TASK_MANAGEMENT,
	PROPERTY_PERFORMANCE;
   
    String toJson() => toString().split('.').last;

    factory ReportType.fromJson(String name) => values.byName(name);
  
}
