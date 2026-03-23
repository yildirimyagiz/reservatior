
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum VideoTargetPlatform {
    INSTAGRAM_REELS,
	TIKTOK,
	YOUTUBE_SHORTS,
	LINKEDIN,
	FACEBOOK,
	TWITTER_X,
	PLATFORM_INTERNAL,
	ALL_PLATFORMS;
   
    String toJson() => toString().split('.').last;

    factory VideoTargetPlatform.fromJson(String name) => values.byName(name);
  
}
