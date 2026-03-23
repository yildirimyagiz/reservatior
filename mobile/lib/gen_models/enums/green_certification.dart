
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum GreenCertification {
    ENERGY_STAR,
	LEED,
	WELL,
	BREEAM,
	GREEN_GLOBES;
   
    String toJson() => toString().split('.').last;

    factory GreenCertification.fromJson(String name) => values.byName(name);
  
}
