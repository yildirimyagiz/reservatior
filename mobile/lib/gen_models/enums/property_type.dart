
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PropertyType {
    DETACHED_HOUSE,
	SEMI_DETACHED_HOUSE,
	TERRACED_HOUSE,
	FLAT_MAISONETTE,
	BUNGALOW,
	COTTAGE,
	TOWNHOUSE,
	APARTMENT,
	STUDIO,
	PENTHOUSE;
   
    String toJson() => toString().split('.').last;

    factory PropertyType.fromJson(String name) => values.byName(name);
  
}
