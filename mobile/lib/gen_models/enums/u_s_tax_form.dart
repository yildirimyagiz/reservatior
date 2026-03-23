
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum USTaxForm {
    FORM_1040,
	FORM_1099,
	FORM_1065,
	FORM_1120,
	FORM_1120S,
	FORM_4797,
	FORM_6251,
	FORM_8606,
	FORM_8824,
	FORM_8867,
	SCHEDULE_E,
	SCHEDULE_EIC;
   
    String toJson() => toString().split('.').last;

    factory USTaxForm.fromJson(String name) => values.byName(name);
  
}
