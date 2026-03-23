
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PaymentNegotiationStatus {
    NEGOTIATING,
	TENANT_PROPOSED,
	OWNER_COUNTERED,
	AGREED,
	REJECTED,
	EXPIRED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory PaymentNegotiationStatus.fromJson(String name) => values.byName(name);
  
}
