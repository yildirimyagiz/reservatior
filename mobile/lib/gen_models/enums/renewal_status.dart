
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum RenewalStatus {
    PENDING,
	OFFERED,
	ACCEPTED,
	REJECTED;
   
    String toJson() => toString().split('.').last;

    factory RenewalStatus.fromJson(String name) => values.byName(name);
  
}
