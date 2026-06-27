import * as xlsx from 'xlsx';
import * as fs from 'fs';

const EXCEL_PATH = '/Users/os2026/Downloads/ROTANA-BOMONTİ son.xlsx';

function analyze() {
  const workbook = xlsx.readFile(EXCEL_PATH);
  const sheetName = workbook.SheetNames[0];
  const rows: any[] = xlsx.utils.sheet_to_json(workbook.Sheets[sheetName]);
  
  const kapiNoCounts: Record<string, number> = {};
  const kapiNoOwners: Record<string, string[]> = {};
  
  rows.forEach((row, idx) => {
    const kapiNo = String(row["Kapı No"]).trim();
    if (!kapiNo || kapiNo === 'undefined') return;
    
    kapiNoCounts[kapiNo] = (kapiNoCounts[kapiNo] || 0) + 1;
    if (!kapiNoOwners[kapiNo]) kapiNoOwners[kapiNo] = [];
    kapiNoOwners[kapiNo].push(`${row["Müşteri Adı"]} (TC: ${row["T.C. Kimlik/Vergi No"]})`);
  });

  let duplicateKapiNos = 0;
  for (const [kapiNo, count] of Object.entries(kapiNoCounts)) {
    if (count > 1) {
      duplicateKapiNos++;
      if (duplicateKapiNos <= 5) {
        console.log(`Kapı No ${kapiNo} has ${count} records:`);
        kapiNoOwners[kapiNo].forEach(owner => console.log(`  - ${owner}`));
      }
    }
  }
  
  console.log(`\nTotal rows: ${rows.length}`);
  console.log(`Unique Kapı Nos: ${Object.keys(kapiNoCounts).length}`);
  console.log(`Kapı Nos with multiple records: ${duplicateKapiNos}`);
}

analyze();
