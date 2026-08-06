import puppeteer from 'puppeteer-core';
import fs from 'fs';
import path from 'path';

const includeKeywords = ['gayrimenkul', 'emlak', 'satılık', 'kiralık', 'al-sat', 'al sat', 'al_sat', 'portföy', 'villa', 'residence', 'konut', 'estate', 'vadi', 'inşaat', 'yapı', 'yapi', 'bosfor', 'developer', 'yatırım', 'investment', 'arsa', 'dükkan', 'ticari', 'proje', 'bölgesi', 'topkapı', 'offers', 'champion', 'rom group', 'object 1', 'amlak', 'rent', 'house', 'abc', 'bahçeşehir', 'beylikdüzü', 'hayal', 'pera', 'inistanbul', 'torunlar', 'babiller', 'mekan', 'oğuz', 'fonyap', 'dia centro', 'ghurair', 'ercan', 'suryap', 'turunç', 'dky'];
const excludeKeywords = ['genel', 'elifin', 'midpoint', 'hacking', 'medrese', 'anadolu', 'antaş', 'yemek'];

(async () => {
    console.log("🚀 Ham Puppeteer başlatılıyor (Kütüphane çöküşlerini engellemek için)...");
    
    // Tarayıcıyı gizli moddan çıkarıyoruz ki çökerse bile ne olduğunu görebilelim
    const browser = await puppeteer.launch({
        executablePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
        headless: false, 
        userDataDir: './.raw_wa_auth',
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();
    console.log("🌐 WhatsApp Web açılıyor...");
    await page.goto('https://web.whatsapp.com', { waitUntil: 'domcontentloaded' });

    console.log("⏳ Lütfen WhatsApp Web'in tamamen yüklenmesini bekleyin (Gerekirse açılan pencereden QR kodu okutun).");
    console.log("Grup listesi yüklendiğinde otomatik çekim başlayacaktır...");

    // Sol panelin (sohbet listesinin) yüklenmesini bekle (login olunduğunun kesin kanıtı)
    await page.waitForSelector('#pane-side', { timeout: 0 }); 
    console.log("✅ Giriş başarılı, sohbetler senkronize ediliyor...");

    // Sohbetlerin tam inmesi için 10 saniye bekle
    await new Promise(r => setTimeout(r, 10000));

    console.log("🔍 Gruplar taranıyor...");
    const groupsData = await page.evaluate(() => {
        // @ts-ignore
        if (!window.require) return [];
        // @ts-ignore
        const chats = window.require('WAWebCollections').Chat.getModelsArray();
        return chats.filter((c: any) => c.isGroup).map((c: any) => {
            let parts = [];
            if (c.groupMetadata && c.groupMetadata.participants) {
                parts = c.groupMetadata.participants.map((p: any) => {
                    const idStr = p.id ? (p.id._serialized || p.id.toString()) : '';
                    const userRaw = p.id ? (p.id.user || idStr.split('@')[0]) : '';
                    return { number: userRaw };
                });
            }
            return { name: c.name, participants: parts };
        });
    });

    if (groupsData.length === 0) {
        console.log("⚠️ Tarayıcıdan hiçbir grup çekilemedi. Lütfen Chrome sayfasını kapatmayın, WhatsApp'ın tam yüklendiğinden emin olun.");
        await browser.close();
        process.exit(1);
    }

    const targetChats = groupsData.filter((chat: any) => {
        const chatName = (chat.name || '').toLowerCase();
        const hasInclude = includeKeywords.some(keyword => chatName.includes(keyword));
        const hasExclude = excludeKeywords.some(keyword => chatName.includes(keyword));
        return hasInclude && !hasExclude;
    });

    console.log(`🎯 Filtrelere uyan toplam ${targetChats.length} emlak grubu bulundu. Üyeler çekiliyor...`);

    const membersPath = path.join(process.cwd(), 'data', 'all_members.csv');
    const writeStream = fs.createWriteStream(membersPath);
    writeStream.write("İsim,Telefon,Grup\n");
    const uniqueMembers = new Set();
    let count = 0;

    for (const chat of targetChats) {
        if (!chat.participants) continue;
        for (const p of chat.participants) {
            if (!p.number) continue;
            if (!uniqueMembers.has(p.number)) {
                uniqueMembers.add(p.number);
                writeStream.write(`"${chat.name}","${p.number}","${chat.name}"\n`);
                count++;
            }
        }
    }
    writeStream.end();

    console.log(`\n🎉 İşlem Tamamlandı! Veritabanına ${count} benzersiz üye eklendi.`);
    console.log(`📂 Dosya yolu: ${membersPath}`);
    
    await browser.close();
    process.exit(0);
})();
