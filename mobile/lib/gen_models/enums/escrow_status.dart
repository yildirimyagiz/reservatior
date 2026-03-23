
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EscrowStatus {
    HOLDING,
	PARTIALLY_RELEASED,
	FULLY_RELEASED,
	DISPUTED,
	REFUNDED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory EscrowStatus.fromJson(String name) => values.byName(name);
  
}
