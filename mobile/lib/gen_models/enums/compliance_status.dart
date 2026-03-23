
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ComplianceStatus {
    PENDING,
	APPROVED,
	REJECTED;
   
    String toJson() => toString().split('.').last;

    factory ComplianceStatus.fromJson(String name) => values.byName(name);
  
}
