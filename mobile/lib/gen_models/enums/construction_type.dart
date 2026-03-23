
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ConstructionType {
    WOOD_FRAME,
	BRICK,
	CONCRETE,
	STEEL,
	STONE,
	LOG,
	PREFAB,
	MODULAR;
   
    String toJson() => toString().split('.').last;

    factory ConstructionType.fromJson(String name) => values.byName(name);
  
}
