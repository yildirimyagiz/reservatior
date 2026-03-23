
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ProjectReportType {
    DAILY,
	WEEKLY,
	MONTHLY,
	QUARTERLY,
	YEARLY,
	CUSTOM;
   
    String toJson() => toString().split('.').last;

    factory ProjectReportType.fromJson(String name) => values.byName(name);
  
}
