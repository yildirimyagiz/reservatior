
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum VideoLoraStrategy {
    PERMANENT_MERGE,
	RUNTIME_PEFT;
   
    String toJson() => toString().split('.').last;

    factory VideoLoraStrategy.fromJson(String name) => values.byName(name);
  
}
