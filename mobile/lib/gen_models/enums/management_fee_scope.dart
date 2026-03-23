
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ManagementFeeScope {
    PROPERTY_MANAGEMENT,
	LEASING_ONLY,
	MAINTENANCE_ONLY,
	FULL_SERVICE,
	FINANCIAL_ONLY,
	COMPLIANCE_ONLY;
   
    String toJson() => toString().split('.').last;

    factory ManagementFeeScope.fromJson(String name) => values.byName(name);
  
}
