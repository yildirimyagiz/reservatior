import fs from 'fs/promises';
import path from 'path';

const localesDir = path.resolve(__dirname, '../src/locales');

async function main() {
  const enPath = path.join(localesDir, 'en.json');
  const enObj = JSON.parse(await fs.readFile(enPath, 'utf-8'));
  
  const files = await fs.readdir(localesDir);
  const locales = files.filter(f => f.endsWith('.json') && f !== 'en.json');
  
  for (const locale of locales) {
    const localePath = path.join(localesDir, locale);
    let localeObj = {};
    try {
      localeObj = JSON.parse(await fs.readFile(localePath, 'utf-8'));
    } catch (e) {
      console.log(`Could not parse ${locale}, starting fresh.`);
    }

    let kept = 0, added = 0;

    function processNode(enNode: any, targetNode: any): any {
      if (typeof enNode === 'string') {
        const cur = typeof targetNode === 'string' ? targetNode : undefined;
        // Purge specific known cyberpunk/spanglish garbage placeholders
        const isGarbage = cur && (
           cur.includes('HYPE_SYNC') || 
           cur.includes('NEURAL_NET') || 
           cur.includes('CYBERPUNK') || 
           cur.includes('LEAK') || 
           cur.includes('ADMIN_SYNC') ||
           cur.match(/^[A-Z_]+$/)
        );
        
        if (cur && cur.trim() !== '' && !isGarbage) {
          kept++;
          return cur; // Keep existing translation
        }
        
        added++;
        return enNode; // Fallback to English
      }
      
      if (typeof enNode === 'object' && enNode !== null && !Array.isArray(enNode)) {
        const result: any = {};
        for (const key of Object.keys(enNode)) {
          result[key] = processNode(enNode[key], targetNode?.[key]);
        }
        return result;
      }
      
      if (Array.isArray(enNode)) {
        return enNode.map((item: any, i: number) => processNode(item, targetNode?.[i]));
      }
      
      return enNode;
    }

    const final = processNode(enObj, localeObj);
    await fs.writeFile(localePath, JSON.stringify(final, null, 2) + '\n');
    console.log(`Processed ${locale}: Kept ${kept} existing valid entries, Applied fallback to ${added} entries.`);
  }
}

main().catch(console.error);
