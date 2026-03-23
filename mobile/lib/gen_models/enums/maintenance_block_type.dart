
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum MaintenanceBlockType {
    MAINTENANCE,
	OWNER_BLOCK,
	CLEANING_BUFFER,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory MaintenanceBlockType.fromJson(String name) => values.byName(name);
  
}
