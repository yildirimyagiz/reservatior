
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TaxType {
    PROPERTY_TAX,
	INCOME_TAX,
	SALES_TAX,
	OCCUPANCY_TAX,
	CITY_TAX,
	STATE_TAX,
	FEDERAL_TAX,
	UTILITY_TAX,
	MAINTENANCE_TAX,
	LUXURY_TAX,
	TRANSFER_TAX,
	STAMP_DUTY,
	VAT,
	MUNICIPALITY_TAX,
	COMMISSION_TAX,
	AGENCY_TAX,
	AGENT_TAX,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory TaxType.fromJson(String name) => values.byName(name);
  
}
