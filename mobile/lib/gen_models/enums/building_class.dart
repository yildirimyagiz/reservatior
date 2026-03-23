
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum BuildingClass {
    CLASS_A,
	CLASS_B,
	CLASS_C,
	CLASS_D,
	LUXURY,
	HISTORIC;
   
    String toJson() => toString().split('.').last;

    factory BuildingClass.fromJson(String name) => values.byName(name);
  
}
