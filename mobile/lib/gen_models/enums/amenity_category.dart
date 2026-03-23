
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum AmenityCategory {
    OUTDOOR,
	INDOOR,
	KITCHEN,
	BATHROOM,
	SECURITY,
	PARKING,
	FITNESS,
	ENTERTAINMENT,
	LAUNDRY,
	STORAGE,
	UTILITY,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory AmenityCategory.fromJson(String name) => values.byName(name);
  
}
