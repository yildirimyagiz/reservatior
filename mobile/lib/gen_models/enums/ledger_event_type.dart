
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum LedgerEventType {
    INCOME,
	EXPENSE,
	BILL,
	BOOKING_CREATED,
	BOOKING_UPDATED,
	LEASE_STARTED,
	LEASE_ENDED,
	CONTRACT_CREATED,
	CONTRACT_VERSIONED,
	CONTRACT_RENEWED,
	STATUS_CHANGED,
	MAINTENANCE_BLOCKED,
	OWNERSHIP_CHANGED,
	NOTE;
   
    String toJson() => toString().split('.').last;

    factory LedgerEventType.fromJson(String name) => values.byName(name);
  
}
