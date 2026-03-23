
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ReportStatus {
    GENERATED,
	IN_PROGRESS,
	COMPLETED,
	FAILED,
	ARCHIVED;
   
    String toJson() => toString().split('.').last;

    factory ReportStatus.fromJson(String name) => values.byName(name);
  
}
