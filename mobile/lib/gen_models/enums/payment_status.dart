
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PaymentStatus {
    UNPAID,
	PARTIAL,
	PAID,
	OVERDUE,
	CANCELLED,
	REFUNDED;
   
    String toJson() => toString().split('.').last;

    factory PaymentStatus.fromJson(String name) => values.byName(name);
  
}
