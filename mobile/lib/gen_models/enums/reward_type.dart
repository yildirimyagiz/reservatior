
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum RewardType {
    DISCOUNT,
	CASH_BACK,
	FREE_SERVICE,
	PRIORITY_SUPPORT,
	FEATURED_LISTING;
   
    String toJson() => toString().split('.').last;

    factory RewardType.fromJson(String name) => values.byName(name);
  
}
