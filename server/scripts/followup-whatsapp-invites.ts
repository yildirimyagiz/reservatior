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

// Güvenli mesajlaşma için rastgele bekleme süresi
const randomDelay = () => Math.floor(Math.random() * (30000 - 15000 + 1) + 15000);
const sleep = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

// 2. Davetiye (VIP Promosyon) Mesajı Şablonu
const getFollowUpTemplate = (name: string) => `Merhaba ${name}, 👋

Geçtiğimiz hafta size *Reservatior* platformumuzdan bahsetmiştik. Sizi hala aramızda göremedik! 

Türkiye'nin en gelişmiş yeni nesil B2B gayrimenkul ağı olan Reservatior'da yerinizi almanız için size **özel ve reddedilemez bir teklifimiz** var:

🎁 *VIP Emlakçı Kampanyası (Sadece Size Özel)*
1. Platformu **İlk 2 Ay Boyunca Tamamen ÜCRETSİZ** deneyin.
2. 3. Ay üyeliğinizde **%50 İndirim** fırsatından yararlanın (4. aydan itibaren standart ücretlendirme başlar).

Bu fırsatla kendi portföyünüzü yönetebilir, diğer VIP emlakçılarla işbirliği yapabilir ve yapay zeka araçlarımızı ücretsiz kullanabilirsiniz.

Kayıt esnasında veya fiyatlandırma sayfasında otomatik olarak bu indirim yansıyacaktır. Hemen denemek için tıklayın:
🔗 https://app.reservatior.com/invite/vip-tr?promo=VIPTR

Güçlü bir gayrimenkul ağı için birlikte büyümek dileğiyle. 🚀

Saygılarımızla,
*Reservatior Türkiye Ekibi*
www.reservatior.com`;

async function startFollowUpProcess() {
  console.log("🟢 WhatsApp Takip (Follow-up) Süreci Başlatılıyor...");

  const org = await prisma.organization.findFirst({
    where: { name: 'Reservatior Marketing TR' }
  });

  if (!org) {
    console.error("❌ Marketing organizasyonu bulunamadı!");
    process.exit(1);
  }

  // Sadece ilk davetiyeyi almış ama henüz 2. aşamaya geçmemiş olanlar
  const contactedLeads = await prisma.lead.findMany({
    where: {
      orgId: org.id,
      status: 'CONTACTED',
      notes: null // Daha önce follow-up atılanlara not düşeceğiz
    }
  });

  console.log(`📬 Kontrol edilecek toplam ${contactedLeads.length} 'CONTACTED' durumunda potansiyel var.`);

  const leadsToInvite = [];

  for (const lead of contactedLeads) {
    // Kişi gerçekten kayıt olmuş mu? (Telefon numarasından kontrol et)
    // Numarayı normalize et
    let checkPhone = lead.phone || "";
    if (checkPhone.startsWith('90')) checkPhone = '+' + checkPhone;
    
    // User tablosunda ara
    const existingUser = await prisma.user.findFirst({
      where: {
        OR: [
          { phone: lead.phone },
          { phone: checkPhone }
        ]
      }
    });

    if (existingUser) {
      // Kayıt olmuş! Durumunu CONVERTED yapalım
      console.log(`🎉 [KAYIT OLMUŞ] ${lead.firstName} (${lead.phone}) sistemi kullanmaya başlamış. Durumu CONVERTED yapılıyor.`);
      await prisma.lead.update({
        where: { id: lead.id },
        data: { status: 'CONVERTED' }
      });
    } else {
      // Hala kayıt olmamış, davetiye listesine ekle
      leadsToInvite.push(lead);
    }
  }

  if (leadsToInvite.length === 0) {
    console.log("✅ Gönderilecek takip davetiyesi kalmadı (Herkes kayıt olmuş veya hepsi işlenmiş).");
    process.exit(0);
  }

  // İlk 100 kişiyi alalım ki ban yemeyelim
  const batch = leadsToInvite.slice(0, 100);
  console.log(`\n🚀 ${batch.length} kişiye VIP Takip Davetiyesi gönderiliyor...`);

  // WhatsApp'a Bağlan
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
    console.log("📱 WhatsApp uygulamanızdan bu QR kodu okutun.");
  });

  client.on('ready', async () => {
    console.log('✅ WhatsApp hesabına başarıyla bağlanıldı! 2. Davetiyeler gönderilmeye başlanıyor...\n');

    let successCount = 0;
    let failCount = 0;

    for (let i = 0; i < batch.length; i++) {
      const lead = batch[i];
      const whatsappNumber = `${lead.phone}@c.us`; 
      const message = getFollowUpTemplate(lead.firstName || 'Değerli Meslektaşımız');

      try {
        const isRegistered = await client.isRegisteredUser(whatsappNumber);
        
        if (isRegistered) {
          await client.sendMessage(whatsappNumber, message);
          
          // Veritabanında durumunu follow-up atıldı olarak işaretle
          await prisma.lead.update({
            where: { id: lead.id },
            data: { notes: 'FOLLOWUP_1_SENT' }
          });
          
          successCount++;
          console.log(`[${i + 1}/${batch.length}] ✅ VIP Teklif Gönderildi: ${lead.firstName} (${lead.phone})`);
        } else {
          await prisma.lead.update({
            where: { id: lead.id },
            data: { status: 'UNQUALIFIED', notes: 'WhatsApp kullanmıyor.' }
          });
          console.log(`[${i + 1}/${batch.length}] ❌ WhatsApp Kullanmıyor: ${lead.phone}`);
          failCount++;
        }

      } catch (error: any) {
        console.error(`[${i + 1}/${batch.length}] ⚠️ Hata (${lead.phone}):`, error.message);
        failCount++;
      }

      if (i < batch.length - 1) {
        const delay = randomDelay();
        console.log(`⏳ Spam koruması: Sonraki mesaja kadar ${Math.round(delay/1000)} saniye bekleniyor...`);
        await sleep(delay);
      }
    }

    console.log(`\n==========================================`);
    console.log(`🎉 Takip (Follow-up) turu tamamlandı!`);
    console.log(`✅ Başarılı Gönderim: ${successCount}`);
    console.log(`❌ Başarısız: ${failCount}`);
    console.log(`==========================================`);
    
    process.exit(0);
  });

  client.initialize();
}

startFollowUpProcess().catch(console.error);
