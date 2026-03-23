
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum SyncDirection {
    IMPORT,
	EXPORT,
	BIDIRECTIONAL;
   
    String toJson() => toString().split('.').last;

    factory SyncDirection.fromJson(String name) => values.byName(name);
  
}
