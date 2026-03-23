
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum FacilityStatus {
    ACTIVE,
	INACTIVE,
	DEVELOPMENT,
	RENOVATION;
   
    String toJson() => toString().split('.').last;

    factory FacilityStatus.fromJson(String name) => values.byName(name);
  
}
