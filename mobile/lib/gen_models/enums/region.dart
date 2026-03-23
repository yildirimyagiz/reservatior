
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum Region {
    USA_NORTHEAST,
	USA_SOUTH,
	USA_MIDWEST,
	USA_WEST,
	USA_SOUTHWEST;
   
    String toJson() => toString().split('.').last;

    factory Region.fromJson(String name) => values.byName(name);
  
}
