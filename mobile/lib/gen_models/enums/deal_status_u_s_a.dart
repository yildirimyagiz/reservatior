
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum DealStatusUSA {
    LEAD,
	PROSPECT,
	QUALIFIED,
	UNDER_CONTRACT,
	CONTINGENT,
	PENDING_CLOSING,
	CLOSED,
	FALLEN_THROUGH,
	CANCELLED,
	ON_HOLD,
	REACTIVATED;
   
    String toJson() => toString().split('.').last;

    factory DealStatusUSA.fromJson(String name) => values.byName(name);
  
}
