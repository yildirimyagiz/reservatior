
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum SubscriptionStatus {
    ACTIVE,
	INACTIVE,
	CANCELLED,
	EXPIRED;
   
    String toJson() => toString().split('.').last;

    factory SubscriptionStatus.fromJson(String name) => values.byName(name);
  
}
