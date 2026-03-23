
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum NotificationChannel {
    IN_APP,
	EMAIL,
	SMS,
	PUSH,
	WEBHOOK;
   
    String toJson() => toString().split('.').last;

    factory NotificationChannel.fromJson(String name) => values.byName(name);
  
}
