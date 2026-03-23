
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum OfferStatus {
    PENDING,
	ACCEPTED,
	REJECTED,
	EXPIRED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory OfferStatus.fromJson(String name) => values.byName(name);
  
}
