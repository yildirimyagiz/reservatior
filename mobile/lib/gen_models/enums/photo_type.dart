
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PhotoType {
    COVER,
	GALLERY,
	PROFILE,
	DOCUMENT,
	INTERIOR,
	EXTERIOR,
	AERIAL,
	FLOOR_PLAN;
   
    String toJson() => toString().split('.').last;

    factory PhotoType.fromJson(String name) => values.byName(name);
  
}
