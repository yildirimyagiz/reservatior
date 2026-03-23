
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EarningType {
    COMMISSION,
	REFERRAL_BONUS,
	LOYALTY_REWARD,
	SUBSCRIPTION_BONUS,
	FEATURE_FEE;
   
    String toJson() => toString().split('.').last;

    factory EarningType.fromJson(String name) => values.byName(name);
  
}
