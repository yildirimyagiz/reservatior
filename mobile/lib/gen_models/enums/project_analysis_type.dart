
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ProjectAnalysisType {
    ARCHITECT,
	DATA_SCIENTIST,
	BUSINESS_ANALYST,
	SECURITY_EXPERT,
	PERFORMANCE_EXPERT,
	QA_SPECIALIST,
	UX_DESIGNER,
	MOBILE_DEVELOPER,
	DEVOPS_ENGINEER;
   
    String toJson() => toString().split('.').last;

    factory ProjectAnalysisType.fromJson(String name) => values.byName(name);
  
}
