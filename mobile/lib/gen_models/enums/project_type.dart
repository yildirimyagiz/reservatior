
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ProjectType {
    RESIDENTIAL,
	COMMERCIAL,
	APARTMENT_BUILDING,
	MIXED_USE_COMPLEX;
   
    String toJson() => toString().split('.').last;

    factory ProjectType.fromJson(String name) => values.byName(name);
  
}
