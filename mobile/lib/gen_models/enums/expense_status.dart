
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ExpenseStatus {
    PENDING,
	PAID,
	OVERDUE,
	CANCELLED;
   
    String toJson() => toString().split('.').last;

    factory ExpenseStatus.fromJson(String name) => values.byName(name);
  
}
