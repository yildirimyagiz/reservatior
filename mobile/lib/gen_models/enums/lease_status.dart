
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum LeaseStatus {
    DRAFT,
	ACTIVE,
	LATE,
	ENDED,
	TERMINATED,
	ARCHIVED;
   
    String toJson() => toString().split('.').last;

    factory LeaseStatus.fromJson(String name) => values.byName(name);
  
}
