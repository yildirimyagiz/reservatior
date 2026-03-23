
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ProjectTaskType {
    SCRAPING,
	ANALYSIS,
	MONITORING,
	REPORTING,
	OPTIMIZATION,
	VALIDATION,
	BENCHMARKING;
   
    String toJson() => toString().split('.').last;

    factory ProjectTaskType.fromJson(String name) => values.byName(name);
  
}
