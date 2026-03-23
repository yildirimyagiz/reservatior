
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum EnergyRating {
    A,
	B,
	C,
	D,
	E,
	F,
	G;
   
    String toJson() => toString().split('.').last;

    factory EnergyRating.fromJson(String name) => values.byName(name);
  
}
