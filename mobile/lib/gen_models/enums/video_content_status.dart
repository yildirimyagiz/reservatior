
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum VideoContentStatus {
    DRAFT,
	GENERATING,
	READY,
	PUBLISHED,
	ARCHIVED,
	FAILED;
   
    String toJson() => toString().split('.').last;

    factory VideoContentStatus.fromJson(String name) => values.byName(name);
  
}
