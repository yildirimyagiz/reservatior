
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum MessageParticipantType {
    USER,
	CONTACT;
   
    String toJson() => toString().split('.').last;

    factory MessageParticipantType.fromJson(String name) => values.byName(name);
  
}
