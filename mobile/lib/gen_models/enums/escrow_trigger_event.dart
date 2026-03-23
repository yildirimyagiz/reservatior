
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EscrowTriggerEvent {
    RESERVATION_CONFIRMED,
	CHECK_IN_COMPLETED,
	MIDSTAY_REACHED,
	CHECK_OUT_COMPLETED,
	SURVEY_COMPLETED,
	DEPOSIT_INSPECTION_DONE,
	DISPUTE_RESOLVED,
	MANUAL_RELEASE;
   
    String toJson() => toString().split('.').last;

    factory EscrowTriggerEvent.fromJson(String name) => values.byName(name);
  
}
