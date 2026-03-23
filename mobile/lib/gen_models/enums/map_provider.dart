
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum MapProvider {
    GOOGLE_MAPS,
	MAPBOX,
	OPENSTREETMAP,
	HERE_MAPS,
	BING_MAPS,
	ESRI,
	TOMTOM;
   
    String toJson() => toString().split('.').last;

    factory MapProvider.fromJson(String name) => values.byName(name);
  
}
