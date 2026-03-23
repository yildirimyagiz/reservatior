
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum NotificationStatus {
    QUEUED,
	SENT,
	FAILED,
	READ;
   
    String toJson() => toString().split('.').last;

    factory NotificationStatus.fromJson(String name) => values.byName(name);
  
}
