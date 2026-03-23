
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ComplianceType {
    FAIR_HOUSING_ACT,
	ADA_COMPLIANCE,
	ENERGY_EFFICIENCY,
	BUILDING_CODE,
	ELECTRICAL_SAFETY,
	FIRE_SAFETY,
	IMMIGRATION_CHECK,
	LEAD_PAINT_DISCLOSURE,
	MOLD_DISCLOSURE,
	FLOOD_INSURANCE,
	PROPERTY_TAXES,
	HOA_RULES;
   
    String toJson() => toString().split('.').last;

    factory ComplianceType.fromJson(String name) => values.byName(name);
  
}
