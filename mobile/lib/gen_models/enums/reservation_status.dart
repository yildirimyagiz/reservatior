
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ReservationStatus {
    PENDING,
	CONFIRMED,
	CANCELLED,
	COMPLETED,
	REFUNDED;
   
    String toJson() => toString().split('.').last;

    factory ReservationStatus.fromJson(String name) => values.byName(name);
  
}
