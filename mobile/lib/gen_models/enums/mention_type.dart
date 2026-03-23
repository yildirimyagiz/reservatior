
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum MentionType {
    USER,
	PROPERTY,
	TASK;
   
    String toJson() => toString().split('.').last;

    factory MentionType.fromJson(String name) => values.byName(name);
  
}
