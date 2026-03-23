
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ExportStatus {
    QUEUED,
	RUNNING,
	DONE,
	FAILED;
   
    String toJson() => toString().split('.').last;

    factory ExportStatus.fromJson(String name) => values.byName(name);
  
}
