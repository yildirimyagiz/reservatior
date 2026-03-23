
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum AgentSpecialities {
    RESIDENTIAL,
	COMMERCIAL,
	LUXURY,
	RENTAL,
	INVESTMENT,
	OTHER;
   
    String toJson() => toString().split('.').last;

    factory AgentSpecialities.fromJson(String name) => values.byName(name);
  
}
