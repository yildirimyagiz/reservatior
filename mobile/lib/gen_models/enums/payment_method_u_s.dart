
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PaymentMethodUS {
    ACH_TRANSFER,
	WIRE_TRANSFER,
	CHECK,
	CASHIERS_CHECK,
	CERTIFIED_CHECK,
	MONEY_ORDER,
	DEBIT_CARD,
	CREDIT_CARD,
	PAYPAL,
	VENMO,
	ZELLE,
	APPLE_PAY,
	GOOGLE_PAY,
	CRYPTOCURRENCY,
	ESCROW_ACCOUNT,
	TITLE_COMPANY_HOLD;
   
    String toJson() => toString().split('.').last;

    factory PaymentMethodUS.fromJson(String name) => values.byName(name);
  
}
