import { PrismaClient } from '@prisma/client';
import { Client, LocalAuth, MessageMedia } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';

// TR Veritabanını kullanıyoruz
const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';
const prisma = new PrismaClient({
  datasources: {
    db: { url: trDatabaseUrl }
  }
});

// Güvenli mesajlaşma için rastgele bekleme süresi (Milisaniye)
// WhatsApp'ın ban atmasını önlemek için 15 ile 30 saniye arası beklenir
const randomDelay = () => Math.floor(Math.random() * (30000 - 15000 + 1) + 15000);
const sleep = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

// Davetiye Mesajı Şablonu
const getMessageTemplate = (name: string) => `Değerli Meslektaşımız ${name}, 👋

Türkiye'nin en yenilikçi B2B Gayrimenkul ve Portföy Yönetim Platformu *Reservatior* kapılarını açıyor! Sektördeki uzmanlığınız ve tecrübenizden dolayı sizi VIP üyelerimiz arasında görmekten büyük mutluluk duyarız.

🌟 *Neden Reservatior?*
• Kendi portföyünüzü tek bir akıllı panelden yönetin.
• Sizin gibi seçkin profesyonellerle doğrudan işbirliği yapın (Global ve Yerel Ağ).
• Yapay zeka destekli değerleme, otomatik sözleşme ve CRM özellikleriyle zaman kazanın.
• Portföyünüzü MLS standartlarında, kurumsal bir güvenle sunun.

Tamamen ücretsiz erken erişim (Early Bird) hesabınızı oluşturmak ve platformu deneyimlemek için aşağıdaki özel davet bağlantınızı kullanabilirsiniz:
🔗 https://app.reservatior.com/invite/vip-tr

Güçlü bir gayrimenkul ağı için birlikte büyümek dileğiyle. 🚀

Saygılarımızla,
*Reservatior Türkiye Ekibi*
www.reservatior.com`;


async function startInvitationProcess() {
  console.log("🟢 WhatsApp Davetiye Gönderme Süreci Başlatılıyor...");

  // 1. Marketing Organizasyonunu Bul
  const org = await prisma.organization.findFirst({
    where: { name: 'Reservatior Marketing TR' }
  });

  if (!org) {
    console.error("❌ Marketing organizasyonu bulunamadı! Lütfen önce import-whatsapp-leads.ts betiğini çalıştırın.");
    process.exit(1);
  }

  // 2. Davet edilmemiş (NEW) potansiyel üyeleri (Lead) bul
  const pendingLeads = await prisma.lead.findMany({
    where: {
      orgId: org.id,
      status: 'NEW',
    },
    take: 100 // Her çalışmada 100 kişiye göndersin ki kısıtlamaya (ban) takılmayalım.
  });

  if (pendingLeads.length === 0) {
    console.log("🎉 Harika! Tüm davetiyeler gönderilmiş, 'NEW' statüsünde kimse kalmamış.");
    process.exit(0);
  }

  console.log(`📬 Gönderilecek ${pendingLeads.length} davetiye var. WhatsApp bağlantısı kuruluyor...`);

  // 3. WhatsApp'a Bağlan
  const client = new Client({
    authStrategy: new LocalAuth({ 
        clientId: 'reservatior-whatsapp',
        dataPath: './.wwebjs_auth' // Varolan oturumu kullan
    }),
    puppeteer: {
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    }
  });

  client.on('qr', (qr) => {
    qrcode.generate(qr, { small: true });
    console.log("📱 WhatsApp uygulamanızdan bu QR kodu okutun.");
  });

  client.on('ready', async () => {
    console.log('✅ WhatsApp hesabına başarıyla bağlanıldı! Davetiyeler gönderilmeye başlanıyor...\n');

    let successCount = 0;
    let failCount = 0;

    for (let i = 0; i < pendingLeads.length; i++) {
      const lead = pendingLeads[i];
      const whatsappNumber = `${lead.phone}@c.us`; 
      const message = getMessageTemplate(lead.firstName || 'Değerli Meslektaşımız');

      try {
        // Numarayı kontrol et
        const isRegistered = await client.isRegisteredUser(whatsappNumber);
        
        if (isRegistered) {
          await client.sendMessage(whatsappNumber, message);
          
          // Veritabanında durumunu "CONTACTED" (İletişime Geçildi) olarak güncelle
          await prisma.lead.update({
            where: { id: lead.id },
            data: { status: 'CONTACTED' }
          });
          
          successCount++;
          console.log(`[${i + 1}/${pendingLeads.length}] ✅ Davetiye Gönderildi: ${lead.firstName} (${lead.phone})`);
        } else {
          // Numara WhatsApp kullanmıyor, UNQUALIFIED (Uygun Değil) yap
          await prisma.lead.update({
            where: { id: lead.id },
            data: { status: 'UNQUALIFIED', notes: 'WhatsApp kullanmıyor.' }
          });
          console.log(`[${i + 1}/${pendingLeads.length}] ❌ WhatsApp Kullanmıyor: ${lead.phone}`);
          failCount++;
        }

      } catch (error: any) {
        console.error(`[${i + 1}/${pendingLeads.length}] ⚠️ Hata (${lead.phone}):`, error.message);
        failCount++;
      }

      // Son kişi değilse rastgele bekleme süresi uygula (SPAM engelleyici)
      if (i < pendingLeads.length - 1) {
        const delay = randomDelay();
        console.log(`⏳ Spam koruması: Sonraki mesaja kadar ${Math.round(delay/1000)} saniye bekleniyor...`);
        await sleep(delay);
      }
    }

    console.log(`\n==========================================`);
    console.log(`🎉 Davetiye turu tamamlandı!`);
    console.log(`✅ Başarılı Gönderim: ${successCount}`);
    console.log(`❌ Başarısız/WhatsApp Yok: ${failCount}`);
    console.log(`==========================================`);
    console.log(`Not: Bir sonraki 100 kişilik parti için betiği tekrar çalıştırabilirsiniz.`);
    
    process.exit(0);
  });

  client.initialize();
}

startInvitationProcess().catch(console.error);
