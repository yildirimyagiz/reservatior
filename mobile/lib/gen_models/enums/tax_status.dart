
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TaxStatus {
    PENDING,
	PAID,
	OVERDUE,
	CANCELLED,
	DISPUTED,
	PARTIALLY_PAID,
	WAIVED,
	EXTENDED;
   
    String toJson() => toString().split('.').last;

    factory TaxStatus.fromJson(String name) => values.byName(name);
  
}
