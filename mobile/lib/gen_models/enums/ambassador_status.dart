
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum AmbassadorStatus {
    PROSPECT,
	PITCHED,
	NEGOTIATING,
	SIGNED,
	ACTIVE,
	PAUSED,
	ENDED;
   
    String toJson() => toString().split('.').last;

    factory AmbassadorStatus.fromJson(String name) => values.byName(name);
  
}
