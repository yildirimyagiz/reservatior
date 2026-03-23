
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum AssetType {
    BUILDING,
	LAND_IMPROVEMENT,
	PERSONAL_PROPERTY;
   
    String toJson() => toString().split('.').last;

    factory AssetType.fromJson(String name) => values.byName(name);
  
}
