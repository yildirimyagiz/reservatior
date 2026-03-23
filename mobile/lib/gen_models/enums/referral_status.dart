
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ReferralStatus {
    PENDING,
	COMPLETED,
	EXPIRED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory ReferralStatus.fromJson(String name) => values.byName(name);
  
}
