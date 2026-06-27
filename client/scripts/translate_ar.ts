import fs from 'fs/promises';
import path from 'path';

const LOCALES_DIR = path.resolve('src/locales');
const EN_PATH = path.join(LOCALES_DIR, 'en.json');
const AR_PATH = path.join(LOCALES_DIR, 'ar.json');
const TR_PATH = path.join(LOCALES_DIR, 'tr.json');

// Free Google Translate API
async function translateBatch(texts: string[], targetLang: string = 'ar'): Promise<string[]> {
    if (texts.length === 0) return [];
    
    // We join texts with a delimiter that Google Translate usually preserves
    const delimiter = ' ⬢ ';
    const textToTranslate = texts.join(delimiter);
    
    const url = `https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=${targetLang}&dt=t&q=${encodeURIComponent(textToTranslate)}`;
    
    try {
        const response = await fetch(url);
        if (!response.ok) {
            throw new Error(`HTTP Error: ${response.status}`);
        }
        const data = await response.json();
        
        // Data format: [ [ [ "translated part 1", "original part 1", null, null, 1 ], ... ], ... ]
        const translatedParts = data[0].map((part: any) => part[0]).join('');
        
        // Split back
        const results = translatedParts.split(' ⬢ ').map((s: string) => s.trim());
        
        // Fallback if splitting fails due to translation weirdness
        if (results.length !== texts.length) {
            console.log(`Delimiter mismatch! Expected ${texts.length}, got ${results.length}. Retrying one by one...`);
            return await translateOneByOne(texts, targetLang);
        }
        
        return results;
    } catch (e) {
        console.error("Translation batch error:", e);
        // Fallback to one-by-one or return originals if network fails
        return texts;
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
            await Bun.sleep(100); // Prevent rate limits
        } catch (e) {
            console.error("Error translating:", text, e);
            results.push(text);
        }
    }
    return results;
}

// Check if a string is English/Spanglish but NOT just a variable
function needsTranslation(val: string): boolean {
    // If it's empty, yes
    if (!val) return true;
    
    // Check if it's identical to the cyberpunk/Spanglish terms like ADMIN_SYNC
    if (val === 'ADMIN_SYNC' || val === 'HYPE_SYNC' || val === 'LEAK' || val === 'UPGRADE' || val === 'RECONSTRUCTION' || val === 'COMPLIANCE' || val === 'ABORT') return true;
    
    // If it contains Arabic characters, it's mostly translated.
    const hasArabic = /[\u0600-\u06FF]/.test(val);
    if (!hasArabic) {
        // No arabic characters! Needs translation.
        return true;
    }
    
    return false;
}

function processInterpolationsBefore(text: string): { processed: string, vars: string[] } {
    const vars: string[] = [];
    let processed = text;
    // Extract {{varName}} and replace with placeholders that won't be translated
    const regex = /\{\{[^}]+\}\}/g;
    let match;
    let index = 0;
    while ((match = regex.exec(text)) !== null) {
        vars.push(match[0]);
        processed = processed.replace(match[0], `__VAR${index}__`);
        index++;
    }
    return { processed, vars };
}

function processInterpolationsAfter(text: string, vars: string[]): string {
    let result = text;
    for (let i = 0; i < vars.length; i++) {
        // Sometimes translator adds spaces around the placeholder
        result = result.replace(new RegExp(`__VAR${i}__`, 'gi'), vars[i]);
        result = result.replace(new RegExp(`__ VAR${i} __`, 'gi'), vars[i]);
    }
    return result;
}

async function main() {
    console.log("Loading translation files...");
    const enContent = await fs.readFile(EN_PATH, 'utf-8');
    let arContent = "{}";
    try {
        arContent = await fs.readFile(AR_PATH, 'utf-8');
    } catch (e) {
        console.log("ar.json not found or empty, creating new");
    }
    
    const enObj = JSON.parse(enContent);
    let arObj: any = {};
    try {
        arObj = JSON.parse(arContent);
    } catch (e) {
        console.error("Invalid ar.json. Rebuilding from scratch.");
    }
    
    // Flatten keys to compare easily
    function flatten(obj: any, prefix = ''): Record<string, string> {
        let result: Record<string, string> = {};
        for (const [k, v] of Object.entries(obj)) {
            const key = prefix ? `${prefix}.${k}` : k;
            if (typeof v === 'object' && v !== null && !Array.isArray(v)) {
                Object.assign(result, flatten(v, key));
            } else {
                result[key] = String(v);
            }
        }
        return result;
    }
    
    function unflatten(flat: Record<string, string>): any {
        const result: any = {};
        for (const [key, val] of Object.entries(flat)) {
            const parts = key.split('.');
            let current = result;
            for (let i = 0; i < parts.length - 1; i++) {
                if (!current[parts[i]]) current[parts[i]] = {};
                current = current[parts[i]];
            }
            current[parts[parts.length - 1]] = val;
        }
        return result;
    }
    
    const flatEn = flatten(enObj);
    const flatAr = flatten(arObj);
    
    const toTranslate: { key: string, text: string, vars: string[] }[] = [];
    
    for (const [key, enVal] of Object.entries(flatEn)) {
        const arVal = flatAr[key];
        if (!arVal || needsTranslation(arVal)) {
            const { processed, vars } = processInterpolationsBefore(enVal);
            toTranslate.push({ key, text: processed, vars });
        }
    }
    
    console.log(`Found ${toTranslate.length} keys needing translation out of ${Object.keys(flatEn).length}.`);
    
    // Batch translation
    const BATCH_SIZE = 20;
    let completed = 0;
    
    for (let i = 0; i < toTranslate.length; i += BATCH_SIZE) {
        const batch = toTranslate.slice(i, i + BATCH_SIZE);
        const texts = batch.map(b => b.text);
        
        try {
            const translatedTexts = await translateBatch(texts, 'ar');
            
            for (let j = 0; j < batch.length; j++) {
                const item = batch[j];
                const rawTranslated = translatedTexts[j] || item.text; // fallback to English if missing
                const finalTranslated = processInterpolationsAfter(rawTranslated, item.vars);
                flatAr[item.key] = finalTranslated;
            }
        } catch (e) {
            console.error(`Error in batch ${i} to ${i + BATCH_SIZE}:`, e);
        }
        
        completed += batch.length;
        if (completed % 100 === 0) {
            console.log(`Translated ${completed} / ${toTranslate.length}...`);
            // Save progress periodically
            const newArObj = unflatten(flatAr);
            await fs.writeFile(AR_PATH, JSON.stringify(newArObj, null, 2));
        }
        
        // Small delay
        await Bun.sleep(200);
    }
    
    const finalArObj = unflatten(flatAr);
    await fs.writeFile(AR_PATH, JSON.stringify(finalArObj, null, 2));
    console.log("Translation complete!");
}

main().catch(console.error);
