
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EventType {
    VIEWING,
	OPEN_HOUSE,
	VIRTUAL_TOUR,
	INSPECTION,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory EventType.fromJson(String name) => values.byName(name);
  
}
