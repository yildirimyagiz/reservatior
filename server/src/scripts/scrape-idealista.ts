import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';
import fs from 'fs';
import * as readline from 'readline';

puppeteer.use(StealthPlugin());

const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
const ask = (q: string): Promise<string> => new Promise(r => rl.question(q, r));
const delay = (min = 2000, max = 5000) => new Promise(r => setTimeout(r, Math.floor(Math.random() * (max - min + 1)) + min));

// Milanuncios Madrid Kiralık İlanları - Geo-block yok, DataDome yok
const TARGET_URL = 'https://www.milanuncios.com/alquiler-de-pisos-en-madrid-madrid/';

async function main() {
  console.log('🤖 Milanuncios Scraper - İspanya\'nın Sahibinden.com\'u');
  console.log('🌍 Geo-block YOK, DataDome YOK - Direkt erişim!\n');

  const browser = await puppeteer.launch({
    headless: false,
    executablePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    userDataDir: './milanuncios-chrome-profile',
    args: [
      '--no-sandbox',
      '--disable-setuid-sandbox',
      '--disable-blink-features=AutomationControlled',
      '--window-size=1366,900'
    ],
  });

  const page = await browser.newPage();
  await page.setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
  await page.setViewport({ width: 1366, height: 900 });

  try {
    console.log(`🌍 Milanuncios açılıyor: ${TARGET_URL}`);
    await page.goto(TARGET_URL, { waitUntil: 'networkidle2', timeout: 60000 });
    await delay(3000, 5000);

    // Çerez onayı
    try {
      await page.evaluate(() => {
        const btns = document.querySelectorAll('button');
        btns.forEach(b => {
          const txt = b.innerText.toLowerCase();
          if (txt.includes('aceptar') || txt.includes('accept') || txt.includes('agree') || txt.includes('entendido')) {
            b.click();
          }
        });
      });
      console.log('🍪 Çerez onayı geçildi.');
      await delay(2000, 3000);
    } catch (e) { /* skip */ }

    // Scroll ile daha fazla ilan yükle
    console.log('📜 Sayfa aşağı kaydırılıyor (daha fazla ilan yüklemek için)...');
    for (let i = 0; i < 5; i++) {
      await page.evaluate(() => window.scrollBy(0, window.innerHeight));
      await delay(1500, 2500);
    }

    // AŞAMA 1: DOM yapısını keşfet
    console.log('\n🔬 AŞAMA 1: Milanuncios DOM yapısı analiz ediliyor...\n');

    const domInfo = await page.evaluate(() => {
      const info: any = {
        url: window.location.href,
        title: document.title,
        articleCount: document.querySelectorAll('article').length,
        aWithTitle: document.querySelectorAll('a[title]').length,
        allClassSamples: [] as string[],
        firstCardsHTML: [] as string[],
        bodyTextSample: document.body.innerText.substring(0, 2000),
      };

      // Olası ilan konteynerleri
      const selectors = [
        'article',
        'div[class*="Ad"]',
        'div[class*="ad-"]',
        'div[class*="listing"]',
        'div[class*="Listing"]',
        'div[class*="card"]',
        'div[class*="Card"]',
        'div[class*="result"]',
        'div[class*="Result"]',
        'li[class*="ad"]',
        'li[class*="Ad"]',
        'section[class*="list"]',
      ];

      for (const sel of selectors) {
        const els = document.querySelectorAll(sel);
        if (els.length > 0) {
          info[`selector_${sel}_count`] = els.length;
          // İlk 3'ünün HTML'ini al
          for (let i = 0; i < Math.min(2, els.length); i++) {
            info.firstCardsHTML.push({
              selector: sel,
              html: els[i].outerHTML.substring(0, 1500),
              text: (els[i] as HTMLElement).innerText.substring(0, 300)
            });
          }
        }
      }

      // "particular" veya "profesional" etiketlerini ara
      const allEls = document.body.querySelectorAll('*');
      info.particularElements = [];
      info.profesionalElements = [];
      allEls.forEach(el => {
        const text = (el as HTMLElement).innerText || '';
        if (text.length < 100) {
          if (text.toLowerCase().includes('particular')) {
            info.particularElements.push({ tag: el.tagName, class: (el as HTMLElement).className, text });
          }
          if (text.toLowerCase().includes('profesional') || text.toLowerCase().includes('professional')) {
            info.profesionalElements.push({ tag: el.tagName, class: (el as HTMLElement).className, text });
          }
        }
      });

      return info;
    });

    console.log(`📍 URL: ${domInfo.url}`);
    console.log(`📄 Sayfa Başlığı: ${domInfo.title}`);
    console.log(`📦 <article> sayısı: ${domInfo.articleCount}`);
    console.log(`🔗 a[title] sayısı: ${domInfo.aWithTitle}`);
    console.log(`🏷️  "particular" etiketli: ${domInfo.particularElements?.length || 0}`);
    console.log(`🏢 "profesional" etiketli: ${domInfo.profesionalElements?.length || 0}`);

    // DOM analizini kaydet
    fs.writeFileSync('milanuncios-dom-analysis.json', JSON.stringify(domInfo, null, 2));
    console.log('\n💾 DOM analizi -> milanuncios-dom-analysis.json');

    // AŞAMA 2: Tüm ilanları çek
    console.log('\n🔬 AŞAMA 2: TÜM İLANLAR ÇEKİLİYOR...\n');

    const allListings = await page.evaluate(() => {
      const results: any[] = [];
      const seenLinks = new Set<string>();

      // Milanuncios'ta ilanlar genellikle article içinde veya a linklerinde
      // Tüm olası yöntemleri dene:

      // Yöntem 1: Article elementleri
      const articles = document.querySelectorAll('article');
      articles.forEach(article => {
        const link = article.querySelector('a[href*="/alquiler"]') || article.querySelector('a[href*="/piso"]') || article.querySelector('a');
        if (!link) return;
        
        const href = (link as HTMLAnchorElement).href;
        if (seenLinks.has(href)) return;
        seenLinks.add(href);

        const text = (article as HTMLElement).innerText;
        const priceMatch = text.match(/[\d.,]+\s*€/);
        const isParticular = text.toLowerCase().includes('particular');
        const isProfessional = text.toLowerCase().includes('profesional') || text.toLowerCase().includes('professional');

        results.push({
          title: link.getAttribute('title') || (link as HTMLElement).innerText.trim().substring(0, 120),
          price: priceMatch ? priceMatch[0] : '',
          link: href,
          isParticular,
          isProfessional,
          type: isParticular ? '✅ SAHİBİNDEN' : isProfessional ? '🏢 EMLAKÇI' : '❓ BELİRSİZ',
          fullText: text.substring(0, 200)
        });
      });

      // Yöntem 2: Eğer article bulunamadıysa, tüm alquiler linklerini tara
      if (results.length === 0) {
        const allLinks = document.querySelectorAll('a[href]');
        allLinks.forEach(link => {
          const href = (link as HTMLAnchorElement).href;
          if (seenLinks.has(href)) return;
          if (!href.includes('milanuncios.com') || href === window.location.href) return;
          // İlan detay sayfası linkleri genellikle uzun ve benzersiz
          if (href.split('/').length < 5) return;
          if (href.includes('/alquiler-de-pisos') && href !== window.location.href && href.length > 60) {
            seenLinks.add(href);

            const card = link.closest('div') || link.parentElement;
            const cardText = card ? (card as HTMLElement).innerText : '';
            const priceMatch = cardText.match(/[\d.,]+\s*€/);

            results.push({
              title: link.getAttribute('title') || (link as HTMLElement).innerText.trim().substring(0, 120),
              price: priceMatch ? priceMatch[0] : '',
              link: href,
              isParticular: cardText.toLowerCase().includes('particular'),
              isProfessional: cardText.toLowerCase().includes('profesional'),
              type: '📋 LINK',
              fullText: cardText.substring(0, 200)
            });
          }
        });
      }

      return results;
    });

    const particulars = allListings.filter(l => l.isParticular);
    const professionals = allListings.filter(l => l.isProfessional);
    const unknown = allListings.filter(l => !l.isParticular && !l.isProfessional);

    console.log('==================================================');
    console.log(`🚀 SONUÇLAR`);
    console.log('==================================================');
    console.log(`📊 Toplam İlan     : ${allListings.length}`);
    console.log(`✅ Sahibinden      : ${particulars.length}`);
    console.log(`🏢 Profesyonel     : ${professionals.length}`);
    console.log(`❓ Belirsiz        : ${unknown.length}`);
    console.log('==================================================\n');

    if (allListings.length > 0) {
      console.log('--- İLK 10 İLAN ---');
      allListings.slice(0, 10).forEach((item, i) => {
        console.log(`[${i + 1}] ${item.type} | ${item.price || 'Fiyat ?'}`);
        console.log(`   ${item.title}`);
        console.log(`   🔗 ${item.link}`);
        console.log('');
      });
    }

    // Kaydet
    fs.writeFileSync('milanuncios-tum-ilanlar.json', JSON.stringify(allListings, null, 2));
    fs.writeFileSync('milanuncios-sahibinden.json', JSON.stringify(particulars, null, 2));
    console.log('💾 Tüm ilanlar    -> milanuncios-tum-ilanlar.json');
    console.log('💾 Sahibinden     -> milanuncios-sahibinden.json');

  } catch (error) {
    console.error('❌ HATA:', error);
  } finally {
    console.log('\n🛑 Tarayıcı açık. Ctrl+C ile kapatabilirsiniz.');
    rl.close();
  }
}

main();
