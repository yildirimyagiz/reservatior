
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ContractStatus {
    DRAFT,
	REVIEW,
	APPROVED,
	SIGNING,
	ACTIVE,
	EXPIRING,
	RENEWED,
	TERMINATED,
	ARCHIVED;
   
    String toJson() => toString().split('.').last;

    factory ContractStatus.fromJson(String name) => values.byName(name);
  
}
