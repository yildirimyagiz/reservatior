import * as xlsx from 'xlsx';
const filePath = '/Users/os2026/Downloads/ROTANA-BOMONTİ son.xlsx';

try {
  const workbook = xlsx.readFile(filePath);
  console.log("Sheet names:", workbook.SheetNames);
  const sheetName = workbook.SheetNames[0];
  const data: any[] = xlsx.utils.sheet_to_json(workbook.Sheets[sheetName]);
  console.log("Total rows:", data.length);
  if (data.length > 0) {
    console.log("Keys (Headers):", Object.keys(data[0]));
    console.log("First row:", data[0]);
    console.log("Second row:", data[1]);
    console.log("Third row:", data[2]);
  }
} catch (e: any) {
  console.error("Error reading Excel:", e.message);
}
