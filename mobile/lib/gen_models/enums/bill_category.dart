
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum BillCategory {
    ELECTRICITY,
	WATER,
	GAS,
	INTERNET,
	HOA,
	INSURANCE,
	TAX,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory BillCategory.fromJson(String name) => values.byName(name);
  
}
