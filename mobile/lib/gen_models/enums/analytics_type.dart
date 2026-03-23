
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum AnalyticsType {
    LISTING_VIEW,
	BOOKING_CONVERSION,
	ML_PROPERTY_SCORE,
	USER_ENGAGEMENT,
	REVENUE,
	PERFORMANCE,
	AGENT_PERFORMANCE,
	AGENCY_PERFORMANCE,
	TAX_PAYMENT,
	TAX_OVERDUE,
	TAX_COMPLIANCE,
	TAX_REVENUE,
	TAX_PERFORMANCE,
	TAX_REMINDER,
	TAX_AUDIT,
	TAX_REPORT;
   
    String toJson() => toString().split('.').last;

    factory AnalyticsType.fromJson(String name) => values.byName(name);
  
}
