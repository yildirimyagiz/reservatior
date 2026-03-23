
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TaskLabel {
    CLEANING,
	DOOR,
	WINDOW,
	ELECTRICITY,
	PLUMPING,
	ROOF,
	GATES,
	FURNITURE,
	WARDROBE;
   
    String toJson() => toString().split('.').last;

    factory TaskLabel.fromJson(String name) => values.byName(name);
  
}
