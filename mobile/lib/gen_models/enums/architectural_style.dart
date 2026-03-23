
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ArchitecturalStyle {
    MODERN,
	CONTEMPORARY,
	TRADITIONAL,
	COLONIAL,
	VICTORIAN,
	CRAFTSMAN,
	MID_CENTURY,
	MEDITERRANEAN,
	FARMHOUSE,
	RANCH,
	SPANISH,
	TUDOR;
   
    String toJson() => toString().split('.').last;

    factory ArchitecturalStyle.fromJson(String name) => values.byName(name);
  
}
