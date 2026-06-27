import 'dotenv/config';
import axios from 'axios';

const MARKETING_TOKEN = process.env.TELEGRAM_BOT_TOKEN;
const CONCIERGE_TOKEN = process.env.TELEGRAM_CONCIERGE_TOKEN;

const MARKETING_COMMANDS = {
  default: [
    { command: 'start', description: 'Start Reservatior & open menu' },
    { command: 'search', description: 'Find properties by criteria' },
    { command: 'projects', description: 'View new & popular projects' },
    { command: 'invest', description: 'View off-market high-yield investments' },
    { command: 'sell', description: 'Submit your property to our AI' }
  ],
  tr: [
    { command: 'start', description: 'Reservatior ağını başlat ve menüyü gör' },
    { command: 'search', description: 'Kriterlerinize uygun emlak bulun' },
    { command: 'projects', description: 'En yeni gayrimenkul projelerini inceleyin' },
    { command: 'invest', description: 'Gizli yüksek getirili yatırımları görün' },
    { command: 'sell', description: 'Mülkünüzü satmak için detayları yazın' }
  ],
  ar: [
    { command: 'start', description: 'ابدأ شبكة ريسيرفاتور وافتح القائمة' },
    { command: 'search', description: 'ابحث عن العقارات حسب المعايير' },
    { command: 'projects', description: 'عرض المشاريع الجديدة والمشهورة' },
    { command: 'invest', description: 'عرض استثمارات عالية العائد' },
    { command: 'sell', description: 'أرسل عقارك إلى الذكاء الاصطناعي لدينا' }
  ]
};

const CONCIERGE_COMMANDS = {
  default: [
    { command: 'start', description: 'Start VIP Concierge service' },
    { command: 'escrow', description: 'Start TrustLink Zero-Risk payment' },
    { command: 'book', description: 'Schedule meeting with wealth advisor' },
    { command: 'concierge', description: 'Request private jet & helicopter tours' },
    { command: 'portfolio', description: 'View your active portfolios & deeds' },
    { command: 'support', description: '24/7 Priority live support' }
  ],
  tr: [
    { command: 'start', description: 'VIP Concierge hizmetini başlat' },
    { command: 'escrow', description: 'TrustLink Sıfır-Risk ödemesini başlat' },
    { command: 'book', description: 'Varlık danışmanınızla toplantı planlayın' },
    { command: 'concierge', description: 'Özel Jet ve Helikopter emlak turları' },
    { command: 'portfolio', description: 'İşlemde olan tapu süreçlerinizi görün' },
    { command: 'support', description: '7/24 Öncelikli canlı destek' }
  ],
  ar: [
    { command: 'start', description: 'ابدأ خدمة VIP كونسيرج' },
    { command: 'escrow', description: 'ابدأ الدفع الآمن مع TrustLink' },
    { command: 'book', description: 'جدولة اجتماع مع مستشار الثروة' },
    { command: 'concierge', description: 'طلب جولات طائرات خاصة وهليكوبتر' },
    { command: 'portfolio', description: 'عرض المحافظ والصكوك النشطة الخاصة بك' },
    { command: 'support', description: 'دعم مباشر على مدار 24/7' }
  ]
};

async function setCommands(token: string | undefined, commandsSet: any, botName: string) {
  if (!token) {
    console.log(`⚠️ ${botName} Token bulunamadı, atlanıyor.`);
    return;
  }

  for (const [langCode, commands] of Object.entries(commandsSet)) {
    const payload: any = { commands };
    if (langCode !== 'default') {
      payload.language_code = langCode;
    }

    try {
      const response = await axios.post(`https://api.telegram.org/bot${token}/setMyCommands`, payload);
      if (response.data.ok) {
        console.log(`✅ [${botName}] [${langCode.toUpperCase()}] komutları API üzerinden başarıyla ayarlandı!`);
      }
    } catch (error) {
      console.error(`❌ [${botName}] [${langCode.toUpperCase()}] Hata:`, (error as Error).message);
    }
  }
}

async function run() {
  console.log('🚀 API üzerinden Bot Komutları Çoklu-Dil (Multi-Local) olarak ayarlanıyor...\n');
  await setCommands(MARKETING_TOKEN, MARKETING_COMMANDS, 'MARKETING BOT');
  await setCommands(CONCIERGE_TOKEN, CONCIERGE_COMMANDS, 'CONCIERGE BOT');
  console.log('\n🎉 Tüm menüler başarıyla localize edildi!');
}

run();
