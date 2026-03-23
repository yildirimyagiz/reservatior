
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 
enum ExportType {
    LEDGER_CSV,
	TAX_SUMMARY_CSV,
	EVIDENCE_PACK_ZIP,
	GOV_STANDARD_JSON,
	REPORT_PDF_READY_JSON;
   
    String toJson() => toString().split('.').last;

    factory ExportType.fromJson(String name) => values.byName(name);
  
}
