import { Client, LocalAuth } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';
import fs from 'fs';
import path from 'path';

const includeKeywords = [
    'gayrimenkul', 'emlak', 'satılık', 'kiralık', 'al-sat', 'al sat', 'al_sat', 'portföy',
    'villa', 'residence', 'konut', 'estate', 'vadi', 'inşaat', 'yapı', 'yapi',
    'bosfor', 'developer', 'yatırım', 'investment', 'arsa', 'dükkan', 'ticari',
    'proje', 'bölgesi', 'topkapı', 'offers', 'champion', 'rom group', 'object 1',
    'amlak', 'rent', 'house', 'abc', 'bahçeşehir', 'beylikdüzü', 'hayal', 'pera',
    'inistanbul', 'torunlar', 'babiller', 'mekan', 'oğuz', 'fonyap', 'dia centro', 'ghurair', 'ercan', 'suryap', 'turunç', 'dky'
];

const excludeKeywords = [
    'genel', 'elifin', 'midpoint', 'hacking', 'medrese', 'anadolu', 'antaş', 'yemek'
];

console.log("🟢 WhatsApp Tüm Üyeleri (Rehber) Çıkarma Aracı Başlatılıyor...");

const client = new Client({
    authStrategy: new LocalAuth({ 
        clientId: 'reservatior-whatsapp',
        dataPath: './.wwebjs_auth'
    }),
    puppeteer: {
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    }
});

client.on('qr', (qr) => {
    qrcode.generate(qr, { small: true });
});

client.on('ready', async () => {
    console.log('\n✅ WhatsApp hesabınıza bağlandı!\n');

    const membersPath = path.join(process.cwd(), 'data', 'all_members.csv');
    const members = new Set<string>();
    
    // Eğer dosya yoksa başlık ekle
    if (!fs.existsSync(membersPath)) {
        fs.writeFileSync(membersPath, "İsim,Telefon,Grup\n", 'utf-8');
    } else {
        const existingMembers = fs.readFileSync(membersPath, 'utf-8').split('\n');
        for (const m of existingMembers) {
            if (m.trim()) members.add(m.split(',')[1]?.replace(/"/g, '').trim() || "");
        }
    }

    try {
        const chats = await client.getChats();
        const targetChats = chats.filter(chat => {
            if (!chat.isGroup) return false;
            const name = chat.name.toLowerCase();
            if (excludeKeywords.some(kw => name.includes(kw))) return false;
            return includeKeywords.some(kw => name.includes(kw));
        });

        console.log(`📋 Toplam ${targetChats.length} emlak grubu taranıyor...\n`);

        let newMemberCount = 0;

        for (const chat of targetChats) {
            console.log(`⏳ İşleniyor: ${chat.name}`);
            
            // Grup katılımcılarını al (bazen chat nesnesinde doğrudan gelmez, fetch etmek gerekebilir)
            // Ama whatsapp-web.js'de GroupChat olarak cast edildiğinde participants dizisi gelir.
            if (!chat.participants) {
                console.log(`   Katılımcı listesi alınamadı, atlanıyor.`);
                continue;
            }

            for (const participant of chat.participants) {
                const serializedId = participant.id._serialized;
                const rawUser = participant.id.user;
                const number = rawUser.split(':')[0]; // Çoklu cihaz id'sini temizle

                if (!members.has(number)) {
                    try {
                        const contact = await client.getContactById(serializedId);
                        const name = contact.pushname || contact.name || "İsimsiz Kullanıcı";
                        
                        members.add(number);
                        fs.appendFileSync(membersPath, `"${name}","${number}","${chat.name}"\n`, 'utf-8');
                        newMemberCount++;
                    } catch (err) {
                        // Contact bulunamadı
                    }
                }
            }
        }

        console.log(`\n🎉 İşlem Tamamlandı! Veritabanına ${newMemberCount} YENİ üye eklendi.`);
        console.log(`📂 Dosya yolu: ${membersPath}`);
        process.exit(0);

    } catch (error) {
        console.error("Grupları alırken hata oluştu:", error);
        process.exit(1);
    }
});

client.initialize();
