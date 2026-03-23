
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EscrowReleaseStatus {
    PENDING,
	SCHEDULED,
	PROCESSING,
	COMPLETED,
	FAILED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory EscrowReleaseStatus.fromJson(String name) => values.byName(name);
  
}
