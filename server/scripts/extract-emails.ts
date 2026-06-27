import fs from 'fs';
import path from 'path';
import * as xlsx from 'xlsx';

const DATA_DIR = path.join(process.cwd(), 'data', 'TURKİYE');
const OUTPUT_FILE = path.join(process.cwd(), 'data', 'extracted_emails.json');

const emailRegex = /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/g;

function walkDir(dir: string, callback: (filePath: string) => void) {
  if (!fs.existsSync(dir)) return;
  
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);
    if (stat.isDirectory()) {
      walkDir(filePath, callback);
    } else if (file.endsWith('.xlsx') || file.endsWith('.xls')) {
      callback(filePath);
    }
  }
}

async function extractEmails() {
  console.log(`[SCANNER] Başlatılıyor. Dizin taranıyor: ${DATA_DIR}`);
  const uniqueEmails = new Set<string>();
  let filesProcessed = 0;

  walkDir(DATA_DIR, (filePath) => {
    try {
      const workbook = xlsx.readFile(filePath);
      filesProcessed++;
      
      for (const sheetName of workbook.SheetNames) {
        const sheet = workbook.Sheets[sheetName];
        // Convert sheet to raw array of arrays to find any string
        const data = xlsx.utils.sheet_to_json(sheet, { header: 1 });
        
        for (const row of data) {
          if (Array.isArray(row)) {
            for (const cell of row) {
              if (typeof cell === 'string') {
                const matches = cell.match(emailRegex);
                if (matches) {
                  for (const match of matches) {
                    uniqueEmails.add(match.toLowerCase());
                  }
                }
              }
            }
          }
        }
      }
    } catch (err) {
      console.error(`[SCANNER] Hata: Dosya okunamadı -> ${filePath}`, err);
    }
  });

  const emailsArray = Array.from(uniqueEmails).sort();
  fs.writeFileSync(OUTPUT_FILE, JSON.stringify(emailsArray, null, 2));

  console.log(`[SCANNER] Tarama tamamlandı!`);
  console.log(`[SCANNER] Taranan Dosya Sayısı: ${filesProcessed}`);
  console.log(`[SCANNER] Bulunan Benzersiz Email Sayısı: ${emailsArray.length}`);
  console.log(`[SCANNER] Çıktı Kaydedildi: ${OUTPUT_FILE}`);
}

extractEmails();
