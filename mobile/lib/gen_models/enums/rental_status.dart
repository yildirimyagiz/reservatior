
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum RentalStatus {
    DRAFT,
	PENDING_REVIEW,
	ACTIVE,
	PAUSED,
	SUSPENDED,
	EXPIRED,
	DELETED;
   
    String toJson() => toString().split('.').last;

    factory RentalStatus.fromJson(String name) => values.byName(name);
  
}
