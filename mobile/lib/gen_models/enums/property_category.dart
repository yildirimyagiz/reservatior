
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum PropertyCategory {
    RESIDENTIAL,
	COMMERCIAL,
	INDUSTRIAL,
	MIXED_USE,
	AGRICULTURAL,
	SPECIAL_PURPOSE;
   
    String toJson() => toString().split('.').last;

    factory PropertyCategory.fromJson(String name) => values.byName(name);
  
}
