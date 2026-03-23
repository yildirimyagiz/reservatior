
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PayoutStatusUSA {
    PENDING,
	APPROVED,
	PROCESSING,
	COMPLETED,
	FAILED,
	CANCELLED,
	REVERSED,
	ESCROW,
	HELD,
	RELEASED;
   
    String toJson() => toString().split('.').last;

    factory PayoutStatusUSA.fromJson(String name) => values.byName(name);
  
}
