
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum GoalType {
    LISTINGS_CREATED,
	DEALS_CLOSED,
	REFERRALS_MADE,
	REVIEWS_RECEIVED,
	COMMISSION_EARNED;
   
    String toJson() => toString().split('.').last;

    factory GoalType.fromJson(String name) => values.byName(name);
  
}
