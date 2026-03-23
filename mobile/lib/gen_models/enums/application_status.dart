
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ApplicationStatus {
    PENDING,
	APPROVED,
	DENIED,
	WITHDRAWN;
   
    String toJson() => toString().split('.').last;

    factory ApplicationStatus.fromJson(String name) => values.byName(name);
  
}
