import { promises as fs } from 'fs';
import path from 'path';

// MUST USE ABSOLUTE PATH to run reliably when imported from anywhere
const LOCALES_DIR = '/Users/os2026/Downloads/Reservatior/client/src/locales';
const EN_FILE = path.join(LOCALES_DIR, 'en.json');

async function translateBatch(texts: string[], targetLang: string): Promise<string[]> {
    if (texts.length === 0) return [];
    
    let googleLang = targetLang;
    if (targetLang === 'se') googleLang = 'sv'; // Swedish
    if (targetLang === 'gr') googleLang = 'el'; // Greek

    const delimiter = ' ⬢ ';
    const textToTranslate = texts.join(delimiter);
    
    const url = `https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=${googleLang}&dt=t&q=${encodeURIComponent(textToTranslate)}`;
    
    try {
        const response = await fetch(url);
        if (!response.ok) throw new Error(`HTTP Error: ${response.status}`);
        const data = await response.json();
        
        const translatedParts = data[0].map((part: any) => part[0]).join('');
        const results = translatedParts.split(' ⬢ ').map((s: string) => s.trim());
        
        if (results.length !== texts.length) {
            return await translateOneByOne(texts, googleLang);
        }
        
        return results;
    } catch (e) {
        return await translateOneByOne(texts, googleLang);
    }
}

async function translateOneByOne(texts: string[], targetLang: string): Promise<string[]> {
    const results: string[] = [];
    for (const text of texts) {
        try {
            const url = `https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=${targetLang}&dt=t&q=${encodeURIComponent(text)}`;
            const response = await fetch(url);
            const data = await response.json();
            const translated = data[0].map((part: any) => part[0]).join('');
            results.push(translated);
            await Bun.sleep(100);
        } catch (e) {
            results.push(text);
        }
    }
    return results;
}

export async function runTranslation() {
  const enObj = JSON.parse(await fs.readFile(EN_FILE, 'utf-8'));
  const enKeys = Object.keys(enObj);

  const files = (await fs.readdir(LOCALES_DIR)).filter(f => f.endsWith('.json') && f !== 'en.json');
  console.log(`\n\n==============================================`);
  console.log(`🤖 AI: Starting universal batched translation...`);
  console.log(`==============================================\n`);

  for (const file of files) {
    const langCode = file.split('.')[0];
    const filePath = path.join(LOCALES_DIR, file);
    const localeObj = JSON.parse(await fs.readFile(filePath, 'utf-8'));

    const toTranslate: { key: string, text: string }[] = [];
    
    for (const key of enKeys) {
      // Check if it's identical to English and needs translation
      if (localeObj[key] === enObj[key]) {
        // Skip short symbols, numbers, and JSON objects
        if (enObj[key].length > 1 && !enObj[key].startsWith('{') && !/^[\d.\-%+]+$/.test(enObj[key])) {
            toTranslate.push({ key, text: enObj[key] });
        }
      }
    }

    if (toTranslate.length === 0) {
        // console.log(`⚡ [${langCode.toUpperCase()}] No translation needed.`);
        continue;
    }

    console.log(`⏳ [${langCode.toUpperCase()}] Translating ${toTranslate.length} keys...`);
    let translatedCount = 0;
    const BATCH_SIZE = 25;

    for (let i = 0; i < toTranslate.length; i += BATCH_SIZE) {
        const batch = toTranslate.slice(i, i + BATCH_SIZE);
        const texts = batch.map(b => b.text);
        
        const translatedTexts = await translateBatch(texts, langCode);
        
        for (let j = 0; j < batch.length; j++) {
            const item = batch[j];
            const rawTranslated = translatedTexts[j] || item.text;
            if (rawTranslated !== item.text) {
                localeObj[item.key] = rawTranslated;
                translatedCount++;
            }
        }
        await Bun.sleep(300); // Prevent rate limits
    }

    if (translatedCount > 0) {
      const sortedObj: Record<string, string> = {};
      Object.keys(localeObj).sort().forEach(k => {
        sortedObj[k] = localeObj[k];
      });
      await fs.writeFile(filePath, JSON.stringify(sortedObj, null, 2) + '\n');
      console.log(`✅ [${langCode.toUpperCase()}] Translated ${translatedCount} keys.`);
    }
  }
  console.log('\n🎉 ALL LANGUAGES TRANSLATED SUCCESSFULLY!\n');
}

// Auto-run if executed directly or imported
runTranslation().catch(console.error);
