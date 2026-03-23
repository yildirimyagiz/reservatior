
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum IncreaseStatus {
    PENDING,
	ACCEPTED,
	REJECTED,
	WITHDRAWN;
   
    String toJson() => toString().split('.').last;

    factory IncreaseStatus.fromJson(String name) => values.byName(name);
  
}
