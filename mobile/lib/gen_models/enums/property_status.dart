
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PropertyStatus {
    AVAILABLE,
	UNDER_CONTRACT,
	SOLD,
	RENTED,
	PENDING_APPROVAL,
	OFF_MARKET,
	MAINTENANCE,
	FORECLOSURE;
   
    String toJson() => toString().split('.').last;

    factory PropertyStatus.fromJson(String name) => values.byName(name);
  
}
