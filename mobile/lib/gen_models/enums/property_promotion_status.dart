
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PropertyPromotionStatus {
    ACTIVE,
	INACTIVE,
	EXPIRED,
	PENDING,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory PropertyPromotionStatus.fromJson(String name) => values.byName(name);
  
}
