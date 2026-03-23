
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ProjectStatus {
    ACTIVE,
	INACTIVE,
	DEVELOPMENT,
	RENOVATION,
	COMPLETED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory ProjectStatus.fromJson(String name) => values.byName(name);
  
}
