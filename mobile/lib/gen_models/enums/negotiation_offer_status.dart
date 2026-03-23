
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum NegotiationOfferStatus {
    PENDING,
	ACCEPTED,
	REJECTED,
	COUNTERED,
	EXPIRED,
	WITHDRAWN;
   
    String toJson() => toString().split('.').last;

    factory NegotiationOfferStatus.fromJson(String name) => values.byName(name);
  
}
