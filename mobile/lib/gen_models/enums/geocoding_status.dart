
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum GeocodingStatus {
    PENDING,
	VERIFIED,
	FAILED,
	NEEDS_REVIEW,
	MANUAL_OVERRIDE;
   
    String toJson() => toString().split('.').last;

    factory GeocodingStatus.fromJson(String name) => values.byName(name);
  
}
