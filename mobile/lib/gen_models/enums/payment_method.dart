
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PaymentMethod {
    CASH,
	BANK_TRANSFER,
	CREDIT_CARD,
	DEBIT_CARD,
	PAYPAL,
	STRIPE,
	CHECK,
	MONEY_ORDER,
	CRYPTO,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory PaymentMethod.fromJson(String name) => values.byName(name);
  
}
