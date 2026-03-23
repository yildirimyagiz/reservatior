
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum RecurringFrequency {
    MONTHLY,
	QUARTERLY,
	YEARLY,
	CUSTOM;
   
    String toJson() => toString().split('.').last;

    factory RecurringFrequency.fromJson(String name) => values.byName(name);
  
}
