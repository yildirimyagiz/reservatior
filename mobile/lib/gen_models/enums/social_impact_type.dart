
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum SocialImpactType {
    TREE_PLANTED,
	CHILD_SUPPORTED,
	ANIMAL_SHELTERED,
	DONATION_MADE;
   
    String toJson() => toString().split('.').last;

    factory SocialImpactType.fromJson(String name) => values.byName(name);
  
}
