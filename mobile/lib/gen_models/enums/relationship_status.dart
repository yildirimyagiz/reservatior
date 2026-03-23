
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum RelationshipStatus {
    PROSPECT,
	CLIENT,
	PAST_CLIENT;
   
    String toJson() => toString().split('.').last;

    factory RelationshipStatus.fromJson(String name) => values.byName(name);
  
}
