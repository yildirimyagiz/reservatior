
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum CommunicationType {
    PROBLEM,
	REQUEST,
	ADVICE,
	INFORMATION,
	FEEDBACK;
   
    String toJson() => toString().split('.').last;

    factory CommunicationType.fromJson(String name) => values.byName(name);
  
}
