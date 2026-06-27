import { readFileSync, writeFileSync } from 'fs';
import { join } from 'path';

// Çevrilecek dillerin listesi (se -> sv, gr -> el olarak Google Translate uyumlu hale getirildi)
const TARGET_LANGS = [
  { file: 'da', api: 'da' },
  { file: 'de', api: 'de' },
  { file: 'es', api: 'es' },
  { file: 'fi', api: 'fi' },
  { file: 'fr', api: 'fr' },
  { file: 'gr', api: 'el' }, // Greek
  { file: 'hi', api: 'hi' },
  { file: 'it', api: 'it' },
  { file: 'ja', api: 'ja' },
  { file: 'ko', api: 'ko' },
  { file: 'nl', api: 'nl' },
  { file: 'no', api: 'no' },
  { file: 'pl', api: 'pl' },
  { file: 'pt', api: 'pt' },
  { file: 'se', api: 'sv' }, // Swedish
  { file: 'ru', api: 'ru' },
  { file: 'zh', api: 'zh-CN' }
];

const LOCALES_DIR = join(import.meta.dir, 'src', 'locales');
const BATCH_SIZE = 50; // Google API'yi yormamak için 50'şer kelime grupları halinde gönderiyoruz
const DELIMITER = ' ||| ';

async function translateBatch(texts: string[], targetLang: string): Promise<string[]> {
  const combinedText = texts.join(DELIMITER);
  const url = `https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=${targetLang}&dt=t&q=${encodeURIComponent(combinedText)}`;
  
  try {
    const res = await fetch(url);
    if (!res.ok) throw new Error(`HTTP Error: ${res.status}`);
    
    const data = await res.json();
    // Google API bazen yanıtı parçalar, hepsini birleştiriyoruz
    const translatedString = data[0].map((item: any) => item[0]).join('');
    
    // Ayırıcıya göre bölüp geri döndürüyoruz
    return translatedString.split(DELIMITER).map((s: string) => s.trim());
  } catch (e) {
    console.error(`Çeviri hatası (${targetLang}):`, e);
    return [];
  }
}

async function processLanguage(langConfig: { file: string, api: string }) {
  console.log(`\n🌐 Başlatılıyor: ${langConfig.file.toUpperCase()} (${langConfig.api})`);
  
  const targetFile = join(LOCALES_DIR, `${langConfig.file}.json`);
  const enFile = join(LOCALES_DIR, 'en.json');
  
  const targetData = JSON.parse(readFileSync(targetFile, 'utf8'));
  const enData = JSON.parse(readFileSync(enFile, 'utf8'));

  // Sadece İngilizce değeriyle aynı kalmış (henüz çevrilmemiş) olanları filtreliyoruz
  const keysToTranslate = Object.keys(enData).filter(key => {
    // Sistem değişkenlerini, URL'leri ve kısa kodları çevirmemek için atlıyoruz
    if (typeof enData[key] !== 'string') return false;
    if (enData[key].startsWith('http') || enData[key].includes('_')) return false;
    return targetData[key] === enData[key];
  });

  console.log(`Bulunan eksik/çevrilecek kelime sayısı: ${keysToTranslate.length}`);

  for (let i = 0; i < keysToTranslate.length; i += BATCH_SIZE) {
    const batchKeys = keysToTranslate.slice(i, i + BATCH_SIZE);
    const batchValues = batchKeys.map(k => enData[k]);

    const translatedValues = await translateBatch(batchValues, langConfig.api);

    // Eğer Google ayırıcıyı bozmadıysa ve dizi uzunluğu eşleşiyorsa kaydet
    if (translatedValues.length === batchValues.length) {
      batchKeys.forEach((key, index) => {
         targetData[key] = translatedValues[index] || enData[key];
      });
      
      console.log(`[${langConfig.file}] İlerleme: ${Math.min(i + BATCH_SIZE, keysToTranslate.length)} / ${keysToTranslate.length}`);
      
      // Her batch sonrası dosyayı kaydediyoruz (olası bir hatada kalınan yerden devam etmesi için)
      writeFileSync(targetFile, JSON.stringify(targetData, null, 2));
    } else {
      console.log(`[${langConfig.file}] Cümle yapısı bozuldu, bu blok tek tek çevriliyor...`);
      for (const key of batchKeys) {
        try {
          const singleTranslate = await translateBatch([enData[key]], langConfig.api);
          targetData[key] = singleTranslate[0] || enData[key];
        } catch (e) {
          console.log(`[${langConfig.file}] '${key}' çevrilemedi, atlanıyor.`);
          targetData[key] = enData[key];
        }
      }
      writeFileSync(targetFile, JSON.stringify(targetData, null, 2));
    }

    // Google bizi engellemesin diye her istek arasına 1.5 saniye bekleme koyuyoruz
    await new Promise(resolve => setTimeout(resolve, 1500));
  }
  
  console.log(`✅ Tamamlandı: ${langConfig.file}`);
}

async function main() {
  console.log("🚀 Reservatior Otomatik Çeviri Sistemi Başlıyor...");
  for (const lang of TARGET_LANGS) {
    await processLanguage(lang);
  }
  console.log('\n🎉 Tüm dillerin çevirisi başarıyla tamamlandı!');
}

main();
