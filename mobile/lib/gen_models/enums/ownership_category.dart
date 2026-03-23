
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum OwnershipCategory {
    PERSONAL,
	COMPANY,
	BANK,
	CONSTRUCTION_COMPANY,
	INVESTMENT_FUND,
	GOVERNMENT,
	TRUST;
   
    String toJson() => toString().split('.').last;

    factory OwnershipCategory.fromJson(String name) => values.byName(name);
  
}
