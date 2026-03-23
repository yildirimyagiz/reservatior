
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum TransactionType {
    INCOME,
	EXPENSE;
   
    String toJson() => toString().split('.').last;

    factory TransactionType.fromJson(String name) => values.byName(name);
  
}
