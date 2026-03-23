
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum SyncStatus {
    IDLE,
	RUNNING,
	SUCCESS,
	FAILED;
   
    String toJson() => toString().split('.').last;

    factory SyncStatus.fromJson(String name) => values.byName(name);
  
}
