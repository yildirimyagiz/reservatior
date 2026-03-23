
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ContractType {
    RENTAL_LEASE,
	BOOKING_AGREEMENT,
	SALE_AGREEMENT,
	MANAGEMENT_AGREEMENT,
	VENDOR_SERVICE,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory ContractType.fromJson(String name) => values.byName(name);
  
}
