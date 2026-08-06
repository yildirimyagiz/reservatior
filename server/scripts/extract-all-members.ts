import whatsappPkg from 'whatsapp-web.js';
const { Client, LocalAuth } = whatsappPkg;
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
        executablePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    },
    webVersionCache: {
        type: 'remote',
        remotePath: 'https://raw.githubusercontent.com/wppconnect-team/wa-version/main/html/2.2412.54.html',
    }
});

client.on('qr', (qr) => {
    qrcode.generate(qr, { small: true });
});

client.on('ready', async () => {
    console.log('\n✅ WhatsApp hesabınıza bağlandı!\n');

    const membersPath = path.join(process.cwd(), 'data', 'all_members.csv');
    const uniqueMembers = new Set<string>();
    
    // Eğer dosya yoksa başlık ekle
    if (!fs.existsSync(membersPath)) {
        fs.writeFileSync(membersPath, "İsim,Telefon,Grup\n", 'utf-8');
    } else {
        const existingMembers = fs.readFileSync(membersPath, 'utf-8').split('\n');
        for (const m of existingMembers) {
            if (m.trim()) uniqueMembers.add(m.split(',')[1]?.replace(/"/g, '').trim() || "");
        }
    }
    
    const writeStream = fs.createWriteStream(membersPath, { flags: 'a' });

    try {
        console.log("Sohbetler alınıyor (Arka Kapı Bypass Yöntemi)...");
        
        // Kütüphanenin bozuk getChats() fonksiyonunu atlayıp doğrudan tarayıcı belleğindeki WAWebCollections'a sızıyoruz
        const groupsData = await client.pupPage.evaluate(() => {
            // @ts-ignore
            const chats = window.require('WAWebCollections').Chat.getModelsArray();
            return chats.filter((c: any) => c.isGroup).map((c: any) => {
                let parts = [];
                if (c.groupMetadata && c.groupMetadata.participants) {
                    parts = c.groupMetadata.participants.map((p: any) => {
                        const idStr = p.id ? (p.id._serialized || p.id.toString()) : '';
                        const userRaw = p.id ? (p.id.user || idStr.split('@')[0]) : '';
                        return {
                            id: { _serialized: idStr, user: userRaw }
                        };
                    });
                }
                return {
                    name: c.name,
                    isGroup: true,
                    participants: parts
                };
            });
        });

        let newMemberCount = 0;
        
        console.log(`\n🔍 Tarayıcı belleğinden ${groupsData.length} adet toplam grup bulundu.`);
        console.log(`Bulunan bazı gruplar (Filtreleme öncesi):`);
        groupsData.slice(0, 20).forEach((g: any) => console.log(`  - ${g.name}`));
        console.log(`...\n`);

        const targetChats = groupsData.filter((chat: any) => {
            const chatName = (chat.name || '').toLowerCase();
            const hasInclude = includeKeywords.some(keyword => chatName.includes(keyword));
            const hasExclude = excludeKeywords.some(keyword => chatName.includes(keyword));
            return hasInclude && !hasExclude;
        });

        console.log(`Filtrelere uyan toplam ${targetChats.length} grup bulundu. Çıkarılıyor...`);

        for (const chat of targetChats) {
            console.log(`⏳ İşleniyor: ${chat.name}`);
            
            if (!chat.participants || chat.participants.length === 0) {
                console.log(`   Katılımcı listesi alınamadı, atlanıyor.`);
                continue;
            }

            for (const participant of chat.participants) {
                const serializedId = participant.id._serialized;
                const rawUser = participant.id.user;
                if (!rawUser) continue;
                
                const number = rawUser.split(':')[0]; // Çoklu cihaz id'sini temizle
                const finalJid = `${number}@c.us`;

                if (!uniqueMembers.has(number)) {
                    uniqueMembers.add(number);
                    // Sadece numara ve jid kaydediyoruz (İsim bilgisi gruplardan çekildiğinde rehberde yoksa undefined gelir)
                    writeStream.write(`"${chat.name}","${number}","${chat.name}"\n`);
                    newMemberCount++;
                }
            }
        }

        console.log(`\n🎉 İşlem Tamamlandı! Veritabanına ${newMemberCount} YENİ üye eklendi.`);
        console.log(`📂 Dosya yolu: ${membersPath}`);
        writeStream.end();
        process.exit(0);

    } catch (error) {
        console.error("Grupları alırken hata oluştu:", error);
        process.exit(1);
    }
});

client.initialize();
