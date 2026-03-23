
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum VideoPipeline {
    STREAM_DIFFUSION_V2,
	LONGLIVE,
	REWARD_FORCING,
	MEMFLOW,
	KREA_REALTIME;
   
    String toJson() => toString().split('.').last;

    factory VideoPipeline.fromJson(String name) => values.byName(name);
  
}
