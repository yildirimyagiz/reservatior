
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ExpenseType {
    MAINTENANCE,
	CLEANING,
	UTILITIES,
	MANAGEMENT_FEE,
	TAX,
	INSURANCE,
	REPAIR,
	SECURITY,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory ExpenseType.fromJson(String name) => values.byName(name);
  
}
