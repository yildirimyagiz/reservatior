
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EscrowDisputeStatus {
    OPEN,
	EVIDENCE_COLLECTION,
	UNDER_REVIEW,
	RESOLVED,
	ESCALATED,
	CLOSED;
   
    String toJson() => toString().split('.').last;

    factory EscrowDisputeStatus.fromJson(String name) => values.byName(name);
  
}
