
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TaxCategoryType {
    RENTAL_INCOME,
	ACCOMMODATION_TAX,
	CAPITAL_GAINS,
	LOCAL_TAX,
	VAT,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory TaxCategoryType.fromJson(String name) => values.byName(name);
  
}
