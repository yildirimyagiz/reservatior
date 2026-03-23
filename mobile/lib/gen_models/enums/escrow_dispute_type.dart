
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EscrowDisputeType {
    PROPERTY_DAMAGE,
	LISTING_MISMATCH,
	PAYMENT_DISPUTE,
	EARLY_DEPARTURE,
	CANCELLATION,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory EscrowDisputeType.fromJson(String name) => values.byName(name);
  
}
