
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum SignatureStatus {
    PENDING,
	SIGNED,
	DECLINED,
	EXPIRED,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory SignatureStatus.fromJson(String name) => values.byName(name);
  
}
