import makeWASocket, { DisconnectReason, useMultiFileAuthState, fetchLatestBaileysVersion } from '@whiskeysockets/baileys';
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

async function main() {
    console.log("🚀 Baileys (WebSocket) WhatsApp Üye Çıkarma Aracı Başlatılıyor...");
    console.log("   (Tarayıcı kullanmaz — doğrudan WhatsApp sunucularına bağlanır)\n");

    const dataDir = path.join(process.cwd(), 'data');
    if (!fs.existsSync(dataDir)) fs.mkdirSync(dataDir, { recursive: true });

    const authDir = path.join(process.cwd(), '.baileys_auth');
    const { state, saveCreds } = await useMultiFileAuthState(authDir);
    const { version } = await fetchLatestBaileysVersion();

    const sock = makeWASocket({
        version,
        auth: state,
        printQRInTerminal: false, // Biz kendimiz basacağız
        browser: ['Reservatior', 'Chrome', '120.0'],
    });

    sock.ev.on('creds.update', saveCreds);

    sock.ev.on('connection.update', async (update) => {
        const { connection, lastDisconnect, qr } = update;

        if (qr) {
            console.log("📱 QR Kodu aşağıda — telefonunuzdan WhatsApp > Bağlı Cihazlar > Cihaz Bağla ile okutun:\n");
            qrcode.generate(qr, { small: true });
        }

        if (connection === 'close') {
            const statusCode = (lastDisconnect?.error as any)?.output?.statusCode;
            // Eger 1000 ise biz bilerek kapattik demektir
            if (statusCode !== DisconnectReason.loggedOut && statusCode !== 1000) {
                console.log("🔄 Bağlantı koptu, yeniden deneniyor...");
                main();
            } else {
                console.log("❌ Oturum sonlandırıldı veya işlem bitti.");
                process.exit(0);
            }
        }

        if (connection === 'open') {
            console.log("\n✅ WhatsApp hesabınıza başarıyla bağlandı!\n");
            
            // Sohbetlerin senkronize olması için biraz bekle
            console.log("⏳ Gruplar senkronize ediliyor (15 saniye)...");
            await new Promise(r => setTimeout(r, 15000));

            try {
                // Tüm grupları çek
                const groups = await sock.groupFetchAllParticipating();
                const groupList = Object.values(groups);

                console.log(`📋 Toplam ${groupList.length} grup bulundu.\n`);
                
                // Filtreleme
                const targetGroups = groupList.filter((g: any) => {
                    const name = (g.subject || '').toLowerCase();
                    const hasInclude = includeKeywords.some(kw => name.includes(kw));
                    const hasExclude = excludeKeywords.some(kw => name.includes(kw));
                    return hasInclude && !hasExclude;
                });

                console.log(`🎯 Filtrelere uyan ${targetGroups.length} emlak grubu bulundu.\n`);

                if (targetGroups.length === 0) {
                    console.log("Bulunan tüm gruplar (Filtreleme öncesi - ilk 30):");
                    groupList.slice(0, 30).forEach((g: any) => console.log(`  - ${g.subject}`));
                    console.log("\n⚠️ Filtrelere uyan grup bulunamadı. Anahtar kelimeleri kontrol edin.");
                }

                const membersPath = path.join(dataDir, 'all_members.csv');
                
                const uniqueMembers = new Set<string>();
                let count = 0;
                let csvRows = ["İsim,Telefon,Grup"]; // Header

                for (const group of targetGroups) {
                    const groupName = (group as any).subject || 'Bilinmeyen';
                    const participants = (group as any).participants || [];
                    console.log(`⏳ İşleniyor: ${groupName} (${participants.length} üye)`);

                    for (const p of participants) {
                        const jid = p.id || '';
                        
                        // WhatsApp artık ID'leri gizleyip @lid olarak veriyor. Eğer @lid ise gerçek numarayı barındıran pn veya participantPn alanlarını kontrol et.
                        let realJid = '';
                        if (jid.endsWith('@s.whatsapp.net')) {
                            realJid = jid;
                        } else if ((p as any).participantPn || (p as any).pn || (p as any).phone) {
                            realJid = (p as any).participantPn || (p as any).pn || (p as any).phone;
                        }

                        if (!realJid || !realJid.endsWith('@s.whatsapp.net')) continue;
                        
                        const number = realJid.split('@')[0];
                        if (!number) continue;

                        if (!uniqueMembers.has(number)) {
                            uniqueMembers.add(number);
                            // Baileys grup listesinde isim bilgisini direkt vermediği için "Bilinmeyen" yazıyoruz.
                            // Eğer bir mesaj atarlarsa pushName alınabiliyor.
                            csvRows.push(`"Bilinmeyen Üye","${number}","${groupName}"`);
                            count++;
                        }
                    }
                }

                fs.writeFileSync(membersPath, csvRows.join('\n') + '\n', 'utf-8');
                console.log(`\n🎉 İşlem Tamamlandı! ${count} benzersiz üye CSV dosyasına kaydedildi.`);
                console.log(`📂 Dosya yolu: ${membersPath}`);
                
                sock.ws.close(); // Force sync close to avoid loop
                setTimeout(() => process.exit(0), 100);

            } catch (error) {
                console.error("Grupları alırken hata oluştu:", error);
                await sock.end(undefined);
                process.exit(1);
            }
        }
    });
}

main();
