
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum VideoLoraStyle {
    FILM_NOIR,
	PIXAR,
	ORIGAMI,
	ARCANE,
	GENSHIN_TCG,
	REALISTIC,
	CUSTOM;
   
    String toJson() => toString().split('.').last;

    factory VideoLoraStyle.fromJson(String name) => values.byName(name);
  
}
