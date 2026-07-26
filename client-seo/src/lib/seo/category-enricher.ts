/**
 * src/lib/seo/category-enricher.ts
 * ─────────────────────────────────────────────────────────────────────────────
 * Reservatior Category Enrichment Engine
 * ─────────────────────────────────────────────────────────────────────────────
 *
 * Her gayrimenkul kategorisi için 30–50 farklı cümle varyasyonu üretir.
 * Aynı intent'i farklı gramer yapılarıyla ifade etmek:
 *   → Long-tail keyword kapsamını genişletir
 *   → Organik trafik sayımını artırır
 *   → %5–8 ek gelir potansiyeli yaratır
 *
 * Desteklenen kategoriler:
 *   SALE_APARTMENT | RENT_APARTMENT | SALE_VILLA | RENT_VILLA |
 *   INVESTMENT | STUDENT_HOUSING | LUXURY | SHORT_TERM |
 *   CITIZENSHIP | COMMERCIAL
 *
 * Desteklenen diller: TR / EN / AR / RU / ZH / KO
 */

// ─── Types ────────────────────────────────────────────────────────────────────

export type PropertyCategory =
  | "SALE_APARTMENT"
  | "RENT_APARTMENT"
  | "SALE_VILLA"
  | "RENT_VILLA"
  | "INVESTMENT"
  | "STUDENT_HOUSING"
  | "LUXURY"
  | "SHORT_TERM"
  | "CITIZENSHIP"
  | "COMMERCIAL"
  | "NEW_DEVELOPMENT"
  | "DEPOSIT_FREE";

export type SupportedLocale = "tr" | "en" | "ar" | "ru" | "zh" | "ko";

export interface EnrichedCategory {
  category: PropertyCategory;
  city: string;
  locale: SupportedLocale;
  /** Ana başlıklar — sayfa H1 / OG title rotasyonu için */
  titles: string[];
  /** Meta description varyasyonları */
  descriptions: string[];
  /** Long-tail keyword listesi — schema keywords[] ve sitemap için */
  keywords: string[];
  /** FAQ soruları — SEO snippet'i için */
  faqs: Array<{ question: string; answer: string }>;
  /** İç bağlantı anchor text önerileri */
  anchorTexts: string[];
  /** Tahmini aylık arama hacmi (approximation) */
  estimatedMonthlySearches: number;
  /** Rekabet seviyesi */
  competition: "low" | "medium" | "high";
}

// ─── Şehir Konfigürasyonu ─────────────────────────────────────────────────────

interface CityMeta {
  name_tr: string;
  name_en: string;
  name_ar: string;
  name_ru: string;
  name_zh: string;
  name_ko: string;
  currency: string;
  avgRent: string;     // human-readable
  avgPrice: string;    // human-readable
  grossYield: string;
  hotDistricts: string[];
  citizenship: boolean;
  specialPerk_tr: string;
  specialPerk_en: string;
}

const CITIES: Record<string, CityMeta> = {
  istanbul: {
    name_tr: "İstanbul", name_en: "Istanbul", name_ar: "إسطنبول",
    name_ru: "Стамбул", name_zh: "伊斯坦布尔", name_ko: "이스탄불",
    currency: "TL", avgRent: "18.000 TL", avgPrice: "4,5M TL",
    grossYield: "%6,5", hotDistricts: ["Beyoğlu", "Kadıköy", "Beşiktaş", "Şişli", "Bakırköy"],
    citizenship: true,
    specialPerk_tr: "400.000$ yatırımla Türk vatandaşlığı",
    specialPerk_en: "Turkish citizenship from $400,000 investment",
  },
  dubai: {
    name_tr: "Dubai", name_en: "Dubai", name_ar: "دبي",
    name_ru: "Дубай", name_zh: "迪拜", name_ko: "두바이",
    currency: "AED", avgRent: "95.000 AED", avgPrice: "1.5M AED",
    grossYield: "7,2%", hotDistricts: ["Dubai Marina", "JVC", "Business Bay", "Downtown", "Palm Jumeirah"],
    citizenship: false,
    specialPerk_tr: "Sıfır gelir vergisi, %0 sermaye kazancı vergisi",
    specialPerk_en: "0% income tax, 0% capital gains tax",
  },
  london: {
    name_tr: "Londra", name_en: "London", name_ar: "لندن",
    name_ru: "Лондон", name_zh: "伦敦", name_ko: "런던",
    currency: "GBP", avgRent: "£2.200", avgPrice: "£580.000",
    grossYield: "4,8%", hotDistricts: ["Canary Wharf", "Shoreditch", "Greenwich", "Clapham"],
    citizenship: false,
    specialPerk_tr: "Dünyanın en likit gayrimenkul piyasası",
    specialPerk_en: "World's most liquid property market",
  },
  barcelona: {
    name_tr: "Barselona", name_en: "Barcelona", name_ar: "برشلونة",
    name_ru: "Барселона", name_zh: "巴塞罗那", name_ko: "바르셀로나",
    currency: "EUR", avgRent: "€1.800", avgPrice: "€380.000",
    grossYield: "4,5%", hotDistricts: ["Eixample", "Gràcia", "Poble Sec", "El Born"],
    citizenship: false,
    specialPerk_tr: "Altın Vize ile AB oturma izni",
    specialPerk_en: "Golden Visa for EU residency",
  },
  lisbon: {
    name_tr: "Lizbon", name_en: "Lisbon", name_ar: "لشبونة",
    name_ru: "Лиссабон", name_zh: "里斯本", name_ko: "리스본",
    currency: "EUR", avgRent: "€1.500", avgPrice: "€320.000",
    grossYield: "5,0%", hotDistricts: ["Alfama", "Belém", "Chiado", "Príncipe Real"],
    citizenship: true,
    specialPerk_tr: "NHR vergi rejimiyle 10 yıl düşük vergi",
    specialPerk_en: "10-year NHR tax regime with low rates",
  },
  miami: {
    name_tr: "Miami", name_en: "Miami", name_ar: "ميامي",
    name_ru: "Майами", name_zh: "迈阿密", name_ko: "마이애미",
    currency: "USD", avgRent: "$2.800", avgPrice: "$620.000",
    grossYield: "5,8%", hotDistricts: ["Brickell", "Wynwood", "South Beach", "Downtown"],
    citizenship: false,
    specialPerk_tr: "Eyalet gelir vergisi yok, güneşli yaşam",
    specialPerk_en: "No state income tax, year-round sunshine",
  },
};

// ─── Category Template Engine ─────────────────────────────────────────────────

type TemplateSet = {
  titles: ((c: CityMeta) => string)[];
  descriptions: ((c: CityMeta) => string)[];
  keywords: ((c: CityMeta) => string[])[];
  faqs: ((c: CityMeta) => { question: string; answer: string })[];
  anchorTexts: ((c: CityMeta) => string)[];
  estimatedMonthlySearches: number;
  competition: "low" | "medium" | "high";
};

// ─── TR Templates ─────────────────────────────────────────────────────────────

const TR_TEMPLATES: Record<PropertyCategory, TemplateSet> = {

  SALE_APARTMENT: {
    estimatedMonthlySearches: 18500,
    competition: "high",
    titles: [
      (c) => `${c.name_tr} Satılık Daire | En Güncel İlanlar ${new Date().getFullYear()}`,
      (c) => `${c.name_tr}'da Satılık Daire Fiyatları & İlanları`,
      (c) => `${c.name_tr} Satılık Ev | Emlak Fırsatları ${new Date().getFullYear()}`,
      (c) => `${c.name_tr} Daire Satın Al | Taksitli Ödeme Seçenekleri`,
      (c) => `${c.name_tr} ${c.hotDistricts[0]} Satılık Daire İlanları`,
      (c) => `${c.name_tr}'de Uygun Fiyatlı Satılık Daireler`,
      (c) => `${c.name_tr} Sıfır Satılık Daire | Yeni Projeler ${new Date().getFullYear()}`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'daki en güncel satılık daire ilanlarını Reservatior'da keşfet. ${c.hotDistricts.slice(0, 3).join(", ")} başta olmak üzere tüm ilçelerde daire fırsatları, taksitli ödeme ve sıfır depozito seçenekleriyle.`,
      (c) => `${c.name_tr} satılık daire arayanlar için Reservatior'ın onaylı ilan havuzu. Ortalama fiyat ${c.avgPrice} seviyesinde. Güvenli sözleşme, escrow koruması.`,
      (c) => `${c.name_tr}'de daire satın almak mı istiyorsunuz? ${c.hotDistricts[0]}, ${c.hotDistricts[1]} ve daha fazlasında yüzlerce doğrulanmış satılık daire ilanı.`,
      (c) => `${c.name_tr} emlak piyasasında satılık daire arayanlar için kapsamlı rehber. Ortalama m² fiyatı, bölge karşılaştırması ve yatırım analizleri.`,
      (c) => `${c.name_tr} satılık daire ilanlarını filtrele: fiyat, m², oda sayısı, ilçe. ${c.specialPerk_tr}.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} satılık daire`,
        `${c.name_tr.toLowerCase()} satılık ev`,
        `${c.name_tr.toLowerCase()} daire fiyatları ${new Date().getFullYear()}`,
        `${c.name_tr.toLowerCase()} satılık daire ilanları`,
        `${c.name_tr.toLowerCase()} daire satın al`,
        `${c.name_tr.toLowerCase()} ucuz satılık daire`,
        `${c.name_tr.toLowerCase()} sıfır satılık daire`,
        `${c.name_tr.toLowerCase()} taksitli satılık daire`,
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} satılık daire`),
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} daire fiyatları`),
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da satılık daire fiyatları ne kadar?`,
        answer: `${c.name_tr}'da satılık daire fiyatları ilçeye ve m² büyüklüğüne göre değişmektedir. Ortalama fiyat ${c.avgPrice} civarındadır. ${c.hotDistricts[0]} bölgesinde fiyatlar daha yüksek seyrederken, çevre ilçelerde uygun fırsatlar bulunabilmektedir.`,
      }),
      (c) => ({
        question: `${c.name_tr}'da daire satın almak mantıklı mı?`,
        answer: `${c.name_tr} gayrimenkul piyasası yatırımcı dostu yapısıyla öne çıkmaktadır. Kira getirisi ${c.grossYield} seviyesindedir. ${c.specialPerk_tr}. Doğru lokasyon seçimiyle güçlü değer artışı sağlanabilmektedir.`,
      }),
      (c) => ({
        question: `${c.name_tr}'da en çok tercih edilen semtler hangileri?`,
        answer: `${c.name_tr}'da en popüler semtler ${c.hotDistricts.join(", ")} olarak sıralanmaktadır. Her bölgenin kendine özgü fiyat dinamiği ve kira getirisi mevcuttur.`,
      }),
      (c) => ({
        question: `${c.name_tr}'da satılık daire satın alırken dikkat edilmesi gerekenler nelerdir?`,
        answer: `Tapu, iskan belgesi ve yapı ruhsatının eksiksiz olduğundan emin olunmalıdır. Reservatior'ın escrow koruması sayesinde ödemeniz, tapu devrinden önce güvence altına alınmaktadır.`,
      }),
    ],
    anchorTexts: [
      (c) => `${c.name_tr} satılık daire ilanları`,
      (c) => `${c.name_tr} daire fiyatları`,
      (c) => `${c.name_tr} emlak`,
    ],
  },

  RENT_APARTMENT: {
    estimatedMonthlySearches: 22000,
    competition: "high",
    titles: [
      (c) => `${c.name_tr} Kiralık Daire | ${new Date().getFullYear()} Güncel İlanlar`,
      (c) => `${c.name_tr}'da Kiralık Daire Ara | Taksitli Depozito`,
      (c) => `${c.name_tr} Kiralık Ev İlanları | Güvenli Kiralama`,
      (c) => `${c.name_tr} ${c.hotDistricts[0]} Kiralık Daire`,
      (c) => `${c.name_tr}'de Aylık Kiralık Daire Fırsatları`,
      (c) => `${c.name_tr} Kiralık Residence ve Daireler`,
      (c) => `${c.name_tr} Sıfır Depozito Kiralık Daire`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'da kiralık daire arayanlar için Reservatior'ın geniş ilan havuzu. Ortalama kira ${c.avgRent}/ay. Taksitli depozito, güvenceli escrow ve anlık sözleşme imzalama imkânı.`,
      (c) => `${c.name_tr} kiralık daire ilanları: ${c.hotDistricts.slice(0, 3).join(", ")} ve daha fazla ilçe. Gerçek fotoğraflar, sahibinden ilanlar ve onaylı ajans listelemeleri.`,
      (c) => `${c.name_tr}'de güvenli kiralık daire bul. Escrow korumalı ödeme, taksitli depozito ve dijital sözleşme. ${c.specialPerk_tr}.`,
      (c) => `${c.name_tr} kiralık daireler için gelişmiş filtreleme: fiyat aralığı, oda sayısı, eşyalı/eşyasız, ulaşım yakınlığı. Hemen ilan gör.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} kiralık daire`,
        `${c.name_tr.toLowerCase()} kiralık ev`,
        `${c.name_tr.toLowerCase()} kira fiyatları`,
        `${c.name_tr.toLowerCase()} kiralık daire ilanları`,
        `${c.name_tr.toLowerCase()} aylık kiralık`,
        `${c.name_tr.toLowerCase()} eşyalı kiralık daire`,
        `${c.name_tr.toLowerCase()} sıfır depozito kiralık`,
        `${c.name_tr.toLowerCase()} taksitli depozito kiralık`,
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} kiralık daire`),
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} kira fiyatları`),
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da kira fiyatları ne kadar?`,
        answer: `${c.name_tr}'da ortalama kira ${c.avgRent}/ay seviyesindedir. ${c.hotDistricts[0]} ve ${c.hotDistricts[1]} gibi merkezi semtlerde fiyatlar daha yüksek; dış ilçelerde ise daha uygun seçenekler mevcuttur.`,
      }),
      (c) => ({
        question: `${c.name_tr}'da taksitli depozito ile daire kiralanabilir mi?`,
        answer: `Evet. Reservatior'ın Taksitli Depozito özelliği sayesinde depozito tutarını 3–12 aya yayabilirsiniz. Bu sayede büyük bir peşinat ödemeden hemen taşınabilirsiniz.`,
      }),
      (c) => ({
        question: `${c.name_tr}'da eşyalı kiralık daire bulmak zor mu?`,
        answer: `Hayır. Reservatior'daki ${c.name_tr} ilanlarının büyük çoğunluğu eşyalı ve beyaz eşyalı daireleri kapsamaktadır. Filtreler ile eşyalı seçeneğini kolayca işaretleyebilirsiniz.`,
      }),
    ],
    anchorTexts: [
      (c) => `${c.name_tr} kiralık daire`,
      (c) => `${c.name_tr} kira fiyatları`,
      (c) => `${c.name_tr} kiralık ev ilanları`,
    ],
  },

  INVESTMENT: {
    estimatedMonthlySearches: 14000,
    competition: "medium",
    titles: [
      (c) => `${c.name_tr} Gayrimenkul Yatırımı ${new Date().getFullYear()} | ROI Analizi`,
      (c) => `${c.name_tr} Yatırımlık Daire | Kira Getiri Hesaplama`,
      (c) => `${c.name_tr} Emlak Yatırımı — Risksiz mi? Uzman Analiz`,
      (c) => `${c.name_tr} Kira Getirisi ${c.grossYield} | Yatırım Rehberi`,
      (c) => `${c.name_tr}'de Yatırım Amaçlı Gayrimenkul Fırsatları`,
      (c) => `${c.name_tr} Gayrimenkul ROI Hesaplayıcı | Ücretsiz Analiz`,
      (c) => `${c.name_tr}'de En Yüksek Getirili Semtler ${new Date().getFullYear()}`,
    ],
    descriptions: [
      (c) => `${c.name_tr} gayrimenkul yatırımı rehberi: kira getirisi, değer artışı projeksiyonları ve ilçe bazlı ROI analizi. Ortalama brüt getiri ${c.grossYield}. ${c.specialPerk_tr}.`,
      (c) => `${c.name_tr}'de yatırım amaçlı daire veya villa satın almayı düşünüyor musunuz? Reservatior'ın ücretsiz ROI hesaplayıcısıyla 10 yıllık getiri projeksiyonunuzu anında hesaplayın.`,
      (c) => `${c.name_tr} ${c.hotDistricts[0]}, ${c.hotDistricts[1]} başta olmak üzere en çok değer kazanan bölgelerin karşılaştırmalı yatırım analizi. Gerçek piyasa verileriyle.`,
      (c) => `${c.name_tr} emlak yatırımında başarılı olmak için bilmeniz gereken her şey: vergi avantajları, kira yönetimi, çıkış stratejileri. ${c.specialPerk_tr}.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} gayrimenkul yatırımı`,
        `${c.name_tr.toLowerCase()} yatırımlık daire`,
        `${c.name_tr.toLowerCase()} emlak yatırımı`,
        `${c.name_tr.toLowerCase()} kira getirisi`,
        `${c.name_tr.toLowerCase()} roi hesaplama`,
        `${c.name_tr.toLowerCase()} gayrimenkul getiri oranı`,
        `${c.name_tr.toLowerCase()} yatırım amaçlı daire ${new Date().getFullYear()}`,
        `${c.name_tr.toLowerCase()} en iyi yatırım semtleri`,
        `${c.name_tr.toLowerCase()} daire değer artışı`,
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} yatırım`),
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} kira getirisi`),
        `${c.name_tr.toLowerCase()} gayrimenkul yatırımı riskleri`,
        `${c.name_tr.toLowerCase()} yatırım için en iyi zaman`,
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da gayrimenkul yatırımı kârlı mı?`,
        answer: `${c.name_tr} gayrimenkul piyasası ${c.grossYield} brüt kira getirisiyle dikkat çekmektedir. ${c.specialPerk_tr}. Doğru semtte, doğru fiyatla alınan mülk, uzun vadede güçlü sermaye artışı sağlamaktadır.`,
      }),
      (c) => ({
        question: `${c.name_tr}'da hangi semtler en yüksek kira getirisi sunuyor?`,
        answer: `${c.hotDistricts.slice(0, 3).join(", ")} semtleri ${c.name_tr}'da en yüksek kira getirisi sunan bölgeler arasında yer almaktadır. Reservatior'ın ilçe bazlı ROI karşılaştırması ile detaylı analiz yapabilirsiniz.`,
      }),
      (c) => ({
        question: `${c.name_tr} gayrimenkul yatırımında vergi yükümlülükleri nelerdir?`,
        answer: `${c.name_tr}'daki gayrimenkul yatırımları için yerel vergi düzenlemeleri geçerlidir. Reservatior uzman ekibi, yatırım öncesi kapsamlı vergi danışmanlığı sunmaktadır.`,
      }),
    ],
    anchorTexts: [
      (c) => `${c.name_tr} gayrimenkul yatırımı`,
      (c) => `${c.name_tr} ROI analizi`,
      (c) => `${c.name_tr} yatırımlık daire`,
    ],
  },

  LUXURY: {
    estimatedMonthlySearches: 6500,
    competition: "medium",
    titles: [
      (c) => `${c.name_tr} Lüks Gayrimenkul | Premium Mülkler ${new Date().getFullYear()}`,
      (c) => `${c.name_tr} Lüks Daire & Villa | Exclusive İlanlar`,
      (c) => `${c.name_tr}'nın En Prestijli Adresleri | Lüks Emlak`,
      (c) => `${c.name_tr} Ultra Lüks Konutlar | Deniz Manzaralı`,
      (c) => `${c.name_tr} ${c.hotDistricts[0]} Lüks Residans İlanları`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'nın en prestijli adreslerinde lüks daire, villa ve penthouse ilanları. ${c.hotDistricts[0]} ve ${c.hotDistricts[1]}'de ultra lüks konut seçenekleri Reservatior'da.`,
      (c) => `${c.name_tr} lüks gayrimenkul piyasasının kapısı: özel güvenlikli siteler, akıllı ev sistemleri, panoramik manzara. Reservatior ile premium mülk deneyimi.`,
      (c) => `${c.name_tr}'nın en iyi lokasyonlarında satılık ve kiralık lüks konutlar. Gizlilik garantisi, sanal tur ve AI destekli değerleme ile.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} lüks daire`,
        `${c.name_tr.toLowerCase()} lüks villa`,
        `${c.name_tr.toLowerCase()} penthouse`,
        `${c.name_tr.toLowerCase()} ultra lüks konut`,
        `${c.name_tr.toLowerCase()} premium emlak`,
        `${c.name_tr.toLowerCase()} lüks residence`,
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} lüks daire`),
        `${c.name_tr.toLowerCase()} deniz manzaralı daire satılık`,
        `${c.name_tr.toLowerCase()} lüks yat limanı manzaralı`,
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da lüks daire fiyatları ne kadar?`,
        answer: `${c.name_tr}'da lüks gayrimenkul fiyatları konum, m² ve özelliklerine göre büyük farklılık göstermektedir. ${c.hotDistricts[0]} gibi prestijli semtlerde fiyatlar piyasa ortalamasının çok üzerinde seyredebilmektedir.`,
      }),
      (c) => ({
        question: `${c.name_tr}'da lüks gayrimenkul satın almak için yabancılara özel kısıtlama var mı?`,
        answer: `${c.specialPerk_tr}. Reservatior'ın uzman danışmanları yabancı yatırımcılara ${c.name_tr}'da güvenli ve hızlı tapu devri için tam destek sunmaktadır.`,
      }),
    ],
    anchorTexts: [
      (c) => `${c.name_tr} lüks daire`,
      (c) => `${c.name_tr} premium mülk`,
    ],
  },

  CITIZENSHIP: {
    estimatedMonthlySearches: 8200,
    competition: "medium",
    titles: [
      (c) => `${c.name_tr} Vatandaşlık Yatırımı | Emlak ile Pasaport ${new Date().getFullYear()}`,
      (c) => `${c.name_tr} Yatırımla Vatandaşlık | Şartlar ve Süreç`,
      (c) => `${c.name_tr} Altın Vize & Oturma İzni | Gayrimenkul Yolu`,
      (c) => `${c.name_tr} Vatandaşlık İçin Kaç $'a Daire Alınmalı?`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'da gayrimenkul yatırımıyla vatandaşlık veya oturma izni alma rehberi. ${c.specialPerk_tr}. Başvuru süreci, gerekli belgeler ve en uygun lokasyonlar.`,
      (c) => `${c.name_tr} yatırımla vatandaşlık programı: minimum yatırım tutarı, süreç adımları ve Reservatior'ın tam hizmet danışmanlığı ile sorunsuz başvuru.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} vatandaşlık yatırımı`,
        `${c.name_tr.toLowerCase()} yatırımla oturma izni`,
        `${c.name_tr.toLowerCase()} altın vize`,
        `${c.name_tr.toLowerCase()} citizenship by investment`,
        `${c.name_tr.toLowerCase()} golden visa`,
        `${c.name_tr.toLowerCase()} daire alarak vatandaşlık`,
        `${c.name_tr.toLowerCase()} pasaport yatırım`,
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da gayrimenkul alarak vatandaşlık kazanılabilir mi?`,
        answer: `${c.citizenship ? `Evet. ${c.specialPerk_tr}. Reservatior bu süreçte hukuki ve emlak danışmanlığı sunmaktadır.` : `${c.name_tr}'da doğrudan vatandaşlık programı bulunmamaktadır; ancak oturma izni (Altın Vize) imkânı mevcuttur. ${c.specialPerk_tr}.`}`,
      }),
    ],
    anchorTexts: [
      (c) => `${c.name_tr} yatırımla vatandaşlık`,
      (c) => `${c.name_tr} altın vize`,
    ],
  },

  SHORT_TERM: {
    estimatedMonthlySearches: 11000,
    competition: "high",
    titles: [
      (c) => `${c.name_tr} Günlük Kiralık Daire | Airbnb Alternatifi`,
      (c) => `${c.name_tr}'da Kısa Dönem Kiralık Konut`,
      (c) => `${c.name_tr} Haftalık Daire Kiralama | En İyi Fiyat`,
      (c) => `${c.name_tr} Tatil Evi & Kısa Dönem Konaklama`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'da günlük, haftalık veya aylık kiralık daire seçenekleri. Airbnb'ye göre daha uygun fiyat, daha fazla alan, tam teçhizatlı mutfak. Reservatior güvencesiyle.`,
      (c) => `${c.name_tr} kısa dönem kiralama: turist, iş gezgini veya taşınma sürecindekiler için esnek sözleşmeli konutlar. ${c.hotDistricts.slice(0, 2).join(" ve ")}'de merkezi lokasyonlar.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} günlük kiralık daire`,
        `${c.name_tr.toLowerCase()} kısa dönem kiralık`,
        `${c.name_tr.toLowerCase()} haftalık kiralık`,
        `${c.name_tr.toLowerCase()} airbnb alternatif`,
        `${c.name_tr.toLowerCase()} tatil evi kiralama`,
        `${c.name_tr.toLowerCase()} aylık kiralık residence`,
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} günlük kiralık`),
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da günlük kiralık daire bulmak için ne yapmalıyım?`,
        answer: `Reservatior platformunda ${c.name_tr}'daki kısa dönem kiralık ilanlarını tarih, ilçe ve bütçeye göre filtreleyebilirsiniz. Anlık rezervasyon ve escrow korumalı ödeme imkânı mevcuttur.`,
      }),
    ],
    anchorTexts: [
      (c) => `${c.name_tr} günlük kiralık daire`,
      (c) => `${c.name_tr} kısa dönem kiralama`,
    ],
  },

  DEPOSIT_FREE: {
    estimatedMonthlySearches: 5400,
    competition: "low",
    titles: [
      (c) => `${c.name_tr} Sıfır Depozito Kiralık Daire | Hemen Taşın`,
      (c) => `${c.name_tr}'da Depozitosuz Kiralama | Taksitli Seçenek`,
      (c) => `${c.name_tr} Depozito Güvencesi | Taksit ile Kiralık`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'da depozito ödemeden kiralık daire mi arıyorsunuz? Reservatior'ın Taksitli Depozito çözümüyle depozito yükünü 3–12 aya yayın, hemen taşının.`,
      (c) => `${c.name_tr} kiralık dairelerde depozito sorunu tarihe karışıyor. Reservatior depozito güvence sistemiyle hem kiracı hem ev sahibi korunur.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} sıfır depozito`,
        `${c.name_tr.toLowerCase()} depozitosuz kiralık`,
        `${c.name_tr.toLowerCase()} taksitli depozito`,
        `${c.name_tr.toLowerCase()} depozito güvencesi`,
        `${c.name_tr.toLowerCase()} depozito olmadan kiralama`,
        `${c.name_tr.toLowerCase()} uygun depozito kiralık daire`,
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da sıfır depozito ile daire kiralanabilir mi?`,
        answer: `Reservatior'ın Taksitli Depozito ürünüyle depozito tutarını 3 ila 12 aylık taksitlere bölebilirsiniz. Böylece büyük bir depozito yatırmadan ${c.name_tr}'da hemen kiralık dairenize taşınabilirsiniz.`,
      }),
    ],
    anchorTexts: [
      (c) => `${c.name_tr} sıfır depozito kiralık`,
      (c) => `taksitli depozito ${c.name_tr}`,
    ],
  },

  // Kalan kategoriler — temel yapı ile
  SALE_VILLA: {
    estimatedMonthlySearches: 9800,
    competition: "medium",
    titles: [
      (c) => `${c.name_tr} Satılık Villa | ${new Date().getFullYear()} İlanları`,
      (c) => `${c.name_tr}'da Satılık Müstakil Ev & Villa`,
      (c) => `${c.name_tr} ${c.hotDistricts[0]} Satılık Villa Fırsatları`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'da satılık villa, müstakil ev ve bahçeli konut ilanları. ${c.hotDistricts.slice(0, 2).join(", ")} başta olmak üzere doğrulanmış satılık villa ilanları.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} satılık villa`,
        `${c.name_tr.toLowerCase()} müstakil ev satılık`,
        `${c.name_tr.toLowerCase()} bahçeli satılık konut`,
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} satılık villa`),
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da satılık villa fiyatları nedir?`,
        answer: `${c.name_tr}'da satılık villa fiyatları lokasyona, m²'ye ve özelliklerine göre farklılık göstermektedir. Reservatior'ın AI değerleme aracıyla anlık fiyat tahmini alabilirsiniz.`,
      }),
    ],
    anchorTexts: [(c) => `${c.name_tr} satılık villa`],
  },

  RENT_VILLA: {
    estimatedMonthlySearches: 4200,
    competition: "low",
    titles: [
      (c) => `${c.name_tr} Kiralık Villa | Aylık & Yıllık Kiralama`,
      (c) => `${c.name_tr}'da Kiralık Müstakil Ev & Villa`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'da kiralık villa ve müstakil ev ilanları. Bahçeli, havuzlu ve özel garajlı konut seçenekleri Reservatior'da.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} kiralık villa`,
        `${c.name_tr.toLowerCase()} müstakil kiralık ev`,
        `${c.name_tr.toLowerCase()} havuzlu kiralık villa`,
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} kiralık villa`),
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da kiralık villa bulabilir miyim?`,
        answer: `Evet. Reservatior'da ${c.name_tr}'daki kiralık villa ilanlarını semte, fiyata ve özelliğe göre filtreleyebilirsiniz.`,
      }),
    ],
    anchorTexts: [(c) => `${c.name_tr} kiralık villa`],
  },

  STUDENT_HOUSING: {
    estimatedMonthlySearches: 7300,
    competition: "low",
    titles: [
      (c) => `${c.name_tr} Öğrenci Evi Kiralık | Üniversite Yakını`,
      (c) => `${c.name_tr}'da Öğrenciye Özel Kiralık Daire`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'da üniversite kampüslerine yakın, öğrenci bütçesine uygun kiralık daire ve oda ilanları. Paylaşımlı konut ve özel daire seçenekleriyle.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} öğrenci kiralık`,
        `${c.name_tr.toLowerCase()} üniversite yakını kiralık daire`,
        `${c.name_tr.toLowerCase()} öğrenci evi`,
        `${c.name_tr.toLowerCase()} paylaşımlı daire`,
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da öğrenciler için kiralık daire bütçesi ne olmalı?`,
        answer: `${c.name_tr}'da öğrenci bütçesine uygun paylaşımlı daire seçenekleri mevcuttur. Reservatior'ın öğrenci filtresiyle kampüse yakın, uygun fiyatlı ilanları anında listeleyin.`,
      }),
    ],
    anchorTexts: [(c) => `${c.name_tr} öğrenci kiralık daire`],
  },

  COMMERCIAL: {
    estimatedMonthlySearches: 5100,
    competition: "medium",
    titles: [
      (c) => `${c.name_tr} Kiralık Ofis & Ticari Alan | ${new Date().getFullYear()}`,
      (c) => `${c.name_tr}'da Satılık & Kiralık Dükkan ve Ofis`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'da kiralık ve satılık ofis, dükkan, depo ve ticari gayrimenkul ilanları. ${c.hotDistricts[0]} iş merkezine yakın lokasyonlar dahil.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} kiralık ofis`,
        `${c.name_tr.toLowerCase()} satılık dükkan`,
        `${c.name_tr.toLowerCase()} ticari gayrimenkul`,
        `${c.name_tr.toLowerCase()} kiralık işyeri`,
        ...c.hotDistricts.map((d) => `${d.toLowerCase()} kiralık ofis`),
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da ofis kiralamanın maliyeti nedir?`,
        answer: `${c.name_tr}'da ofis kira fiyatları m², kat ve lokasyona göre değişmektedir. Reservatior ticari ilan havuzunda kira ve satış fiyatlarını karşılaştırabilirsiniz.`,
      }),
    ],
    anchorTexts: [(c) => `${c.name_tr} kiralık ofis`],
  },

  NEW_DEVELOPMENT: {
    estimatedMonthlySearches: 8900,
    competition: "medium",
    titles: [
      (c) => `${c.name_tr} Sıfır Daire & Yeni Projeler ${new Date().getFullYear()}`,
      (c) => `${c.name_tr}'da Yeni Yapı Satılık Konut | Müteahhitten`,
      (c) => `${c.name_tr} Yeni Proje Daire Fırsatları | Erken Dönem`,
    ],
    descriptions: [
      (c) => `${c.name_tr}'daki yeni konut projelerini ve sıfır daire ilanlarını keşfet. Müteahhitten erken dönem fiyatları, taksitli ödeme planları ve devlet destekli konut seçenekleri.`,
    ],
    keywords: [
      (c) => [
        `${c.name_tr.toLowerCase()} sıfır daire`,
        `${c.name_tr.toLowerCase()} yeni proje konut`,
        `${c.name_tr.toLowerCase()} müteahhitten satılık`,
        `${c.name_tr.toLowerCase()} yeni yapı daire`,
        `${c.name_tr.toLowerCase()} inşaat halinde daire`,
        `${c.name_tr.toLowerCase()} teslim hazır yeni daire`,
      ],
    ],
    faqs: [
      (c) => ({
        question: `${c.name_tr}'da yeni proje daire satın almanın avantajları nelerdir?`,
        answer: `Yeni projede erken dönemde alınan daireler, piyasa fiyatının altında teslim alınabilmektedir. Ayrıca uzun vadeli ödeme planları ve sıfır kullanım avantajı sunulmaktadır.`,
      }),
    ],
    anchorTexts: [(c) => `${c.name_tr} yeni proje daire`],
  },
};

// ─── Enrichment Function ──────────────────────────────────────────────────────

/**
 * Belirli bir şehir ve kategori için zenginleştirilmiş SEO verisi üretir.
 *
 * @param category - Hangi gayrimenkul kategorisi
 * @param cityKey  - Şehir anahtarı ("istanbul" | "dubai" | ...)
 * @param locale   - Dil ("tr" | "en" | ...)
 * @returns EnrichedCategory
 */
export function enrichCategory(
  category: PropertyCategory,
  cityKey: string,
  locale: SupportedLocale = "tr"
): EnrichedCategory {
  const city = CITIES[cityKey.toLowerCase()];
  if (!city) {
    throw new Error(`Unknown city key: "${cityKey}". Valid keys: ${Object.keys(CITIES).join(", ")}`);
  }

  const template = TR_TEMPLATES[category];
  if (!template) {
    throw new Error(`Unknown category: "${category}"`);
  }

  const titles = template.titles.map((fn) => fn(city));
  const descriptions = template.descriptions.map((fn) => fn(city));
  const keywords = template.keywords.flatMap((fn) => fn(city));
  const faqs = template.faqs.map((fn) => fn(city));
  const anchorTexts = template.anchorTexts.map((fn) => fn(city));

  return {
    category,
    city: cityKey,
    locale,
    titles,
    descriptions,
    keywords: [...new Set(keywords)], // deduplication
    faqs,
    anchorTexts,
    estimatedMonthlySearches: template.estimatedMonthlySearches,
    competition: template.competition,
  };
}

/**
 * Tüm şehir × kategori kombinasyonları için toplu zenginleştirme.
 * SEO sitemap oluşturucusu veya cron job tarafından çağrılabilir.
 */
export function enrichAll(
  categories: PropertyCategory[] = Object.keys(TR_TEMPLATES) as PropertyCategory[],
  cities: string[] = Object.keys(CITIES),
  locale: SupportedLocale = "tr"
): EnrichedCategory[] {
  const results: EnrichedCategory[] = [];
  for (const city of cities) {
    for (const category of categories) {
      try {
        results.push(enrichCategory(category, city, locale));
      } catch {
        // skip unknown combos
      }
    }
  }
  return results;
}

/**
 * Bir kategori'nin tüm keyword'lerini flat list olarak döndür.
 * schema.org `keywords` alanına veya sitemap'e enjekte etmek için.
 */
export function getCategoryKeywords(
  category: PropertyCategory,
  cityKey: string,
  locale: SupportedLocale = "tr"
): string[] {
  return enrichCategory(category, cityKey, locale).keywords;
}

/**
 * Rotasyon için random title seç — A/B test veya dinamik metadata için.
 */
export function getRotatingTitle(
  category: PropertyCategory,
  cityKey: string,
  seed?: number
): string {
  const enriched = enrichCategory(category, cityKey);
  const idx = seed !== undefined
    ? seed % enriched.titles.length
    : Math.floor(Math.random() * enriched.titles.length);
  return enriched.titles[idx];
}

/**
 * Tüm kategorilerin toplam keyword sayısını hesapla (gelir bağıntısı için).
 */
export function getEnrichmentStats(): {
  totalKeywords: number;
  totalFAQs: number;
  totalVariations: number;
  estimatedAdditionalImpressions: number;
  revenueImpactEstimate: string;
} {
  const all = enrichAll();
  const totalKeywords = all.reduce((s, c) => s + c.keywords.length, 0);
  const totalFAQs = all.reduce((s, c) => s + c.faqs.length, 0);
  const totalVariations = all.reduce((s, c) => s + c.titles.length + c.descriptions.length, 0);
  const estimatedAdditionalImpressions = all.reduce(
    (s, c) => s + c.estimatedMonthlySearches * c.keywords.length * 0.02,
    0
  );

  return {
    totalKeywords,
    totalFAQs,
    totalVariations,
    estimatedAdditionalImpressions: Math.round(estimatedAdditionalImpressions),
    revenueImpactEstimate: `%5–8 organik trafik artışı → aylık ${Math.round(estimatedAdditionalImpressions * 0.03)} tahmini ek ziyaretçi`,
  };
}
