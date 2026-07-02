const fs = require('fs');
const path = require('path');

const keys = {
  "client.src.connection_error_please_try_again": { en: "Connection error occurred. Please try again.", tr: "Bağlantı hatası oluştu. Lütfen tekrar deneyin." },
  "client.src.credit": { en: "credit", tr: "kredi" },
  "client.src.return_to_home": { en: "Return to Home", tr: "Ana Sayfaya Dön" },
  "client.src.what_kind_of_place_are_you_looking_for": { en: "What kind of place are you looking for?", tr: "Nasıl bir yer arıyorsunuz?" },
  "client.src.dont_bother_with_filters_describe_your_dream_home": { en: "Don't bother with filters. Just describe your dream home or investment in your own words.", tr: "Filtrelerle uğraşmayın. Hayalinizdeki evi veya yatırımı sadece kendi cümlelerinizle tarif edin." },
  "client.src.tell_ai_what_you_are_looking_for": { en: "Tell AI what you are looking for...", tr: "Yapay zekaya ne aradığınızı anlatın..." },
  "client.src.reservatior_ai_can_make_mistakes_verify_information": { en: "Reservatior AI can make mistakes • Verify information", tr: "Reservatior AI Hata Yapabilir • Bilgileri Doğrulayın" },
  "client.src.accommodation_pre_application": { en: "Accommodation Pre-Application", tr: "Konaklama Ön Başvurusu" },
  "client.src.let_us_prepare_your_request_for": { en: "let us prepare your request for", tr: "için talebinizi hazırlayalım" },
  "client.src.number_of_guests": { en: "Number of Guests", tr: "Konaklayacak Kişi Sayısı" },
  "client.src.person": { en: "Person", tr: "Kişi" },
  "client.src.smoking": { en: "Smoking", tr: "Sigara Kullanımı" },
  "client.src.indoors_on_balcony": { en: "Indoors / On Balcony", tr: "Ev içinde / Balkonda" },
  "client.src.bbq_grill": { en: "BBQ / Grill", tr: "Mangal / Barbekü" },
  "client.src.in_garden_or_terrace": { en: "In Garden or Terrace", tr: "Bahçe veya Terasta" },
  "client.src.guest_profile_visit_purpose": { en: "Guest Profile & Visit Purpose", tr: "Misafir Profili & Ziyaret Amacı" },
  "client.src.guest_profile_placeholder": { en: "e.g., We are 2 families coming for vacation. We have 2 children. We are looking for a quiet, peaceful stay...", tr: "Örn: 2 aile tatil için geliyoruz. 2 çocuğumuz var. Sessiz, sakin bir konaklama arıyoruz..." },
  "client.src.cancel": { en: "Cancel", tr: "İptal" },
  "client.src.submit_request": { en: "Submit Request", tr: "Talebi Gönder" },
  "client.src.complete_rental_application_for_person": { en: "complete rental application for. Guests:", tr: "için kiralama başvurusunu tamamla. Kişi:" },
  "client.src.smoking_label": { en: "Smoking:", tr: "Sigara:" },
  "client.src.yes": { en: "Yes", tr: "Var" },
  "client.src.no": { en: "No", tr: "Yok" },
  "client.src.bbq_label": { en: "BBQ:", tr: "Mangal:" },
  "client.src.i_want": { en: "Yes", tr: "İstiyorum" },
  "client.src.i_dont_want": { en: "No", tr: "İstemiyorum" },
  "client.src.details_label": { en: "Details:", tr: "Detaylar:" },
  "client.src.not_specified": { en: "Not specified", tr: "Belirtilmedi" },
  "client.src.suggestion_1": { en: "2+1 for rent in Kadikoy up to 35,000 TL", tr: "Kadıköy'de 35.000 TL'ye kadar kiralık 2+1" },
  "client.src.suggestion_2": { en: "Daily rental villa for 10 people with BBQ", tr: "10 kişilik, mangal yapılabilen günlük kiralık villa" },
  "client.src.suggestion_3": { en: "Seaside house in Bodrum, smoking allowed", tr: "Bodrum'da denize sıfır, sigara içilebilen ev" },
  "client.src.suggestion_4": { en: "3+1 apartment with pool in a complex", tr: "Site içerisinde, havuzlu 3+1 daire" }
};

const dir = __dirname;
const files = fs.readdirSync(dir).filter(f => f.endsWith('.json'));

for (const file of files) {
  const filePath = path.join(dir, file);
  const lang = path.basename(file, '.json');
  let content = {};
  try {
    content = JSON.parse(fs.readFileSync(filePath, 'utf8'));
  } catch (e) {
    console.error(`Error parsing ${file}`);
    continue;
  }
  
  for (const [key, trans] of Object.entries(keys)) {
    if (!content[key]) {
      content[key] = trans[lang] || trans['en'];
    }
  }
  
  fs.writeFileSync(filePath, JSON.stringify(content, null, 2) + '\n');
  console.log(`Updated ${file}`);
}
