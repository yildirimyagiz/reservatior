const fs = require('fs');
const path = require('path');

// Country-specific suggestions covering:
// 1. Rental / Accommodation
// 2. Property Sale / Investment
// 3. Legal advisory (eviction, tenant rights, rental law, debts)
// 4. Citizenship by investment / Golden Visa / Residency
const suggestions = {
  tr: {
    "client.src.suggestion_1": "Kadıköy'de aylık 35.000 TL'ye kadar kiralık 2+1 daire",
    "client.src.suggestion_2": "Antalya'da yatırımlık deniz manzaralı satılık daire",
    "client.src.suggestion_3": "Kiracı tahliye süreci ve yasal haklarım nelerdir?",
    "client.src.suggestion_4": "Türkiye'de gayrimenkul yatırımıyla vatandaşlık şartları neler?"
  },
  en: {
    "client.src.suggestion_1": "2-bed apartment in Manhattan under $4,000/month",
    "client.src.suggestion_2": "Investment property in Miami with ocean view for sale",
    "client.src.suggestion_3": "What are tenant eviction laws and my rights in New York?",
    "client.src.suggestion_4": "EB-5 investor visa requirements through real estate in the US"
  },
  de: {
    "client.src.suggestion_1": "2-Zimmer-Wohnung in Berlin-Mitte bis 1.500 €/Monat zur Miete",
    "client.src.suggestion_2": "Anlageimmobilie in München mit guter Rendite zu verkaufen",
    "client.src.suggestion_3": "Kündigungsschutz und Mieterrechte in Deutschland – was gilt?",
    "client.src.suggestion_4": "Golden Visa durch Immobilieninvestition in Portugal oder Griechenland"
  },
  es: {
    "client.src.suggestion_1": "Piso de 2 habitaciones en Madrid centro por menos de 1.200 €/mes",
    "client.src.suggestion_2": "Apartamento en venta con vistas al mar en Marbella para inversión",
    "client.src.suggestion_3": "¿Cuáles son mis derechos como inquilino y el proceso de desahucio en España?",
    "client.src.suggestion_4": "Golden Visa en España: requisitos de inversión inmobiliaria para residencia"
  },
  fr: {
    "client.src.suggestion_1": "Appartement 3 pièces à Paris 11e à louer pour moins de 1 800 €/mois",
    "client.src.suggestion_2": "Bien immobilier à vendre à Nice en bord de mer pour investissement",
    "client.src.suggestion_3": "Droits du locataire et procédure d'expulsion en France – que dit la loi?",
    "client.src.suggestion_4": "Visa investisseur et résidence par achat immobilier au Portugal"
  },
  it: {
    "client.src.suggestion_1": "Bilocale in affitto zona Navigli a Milano sotto i 1.500 €/mese",
    "client.src.suggestion_2": "Appartamento vista mare in vendita a Positano per investimento",
    "client.src.suggestion_3": "Diritti dell'inquilino e procedura di sfratto in Italia – cosa prevede la legge?",
    "client.src.suggestion_4": "Visto investitore Italia: requisiti per residenza tramite acquisto immobiliare"
  },
  pt: {
    "client.src.suggestion_1": "Apartamento T2 para alugar em Lisboa por menos de 1.200 €/mês",
    "client.src.suggestion_2": "Moradia à venda no Algarve com vista mar para investimento",
    "client.src.suggestion_3": "Direitos do inquilino e processo de despejo em Portugal – o que diz a lei?",
    "client.src.suggestion_4": "Golden Visa Portugal: requisitos de investimento imobiliário para residência"
  },
  nl: {
    "client.src.suggestion_1": "2-kamer appartement te huur in Amsterdam-Zuid tot €1.800/maand",
    "client.src.suggestion_2": "Beleggingspand te koop in Rotterdam met goed rendement",
    "client.src.suggestion_3": "Huurdersrechten en uitzettingsprocedure in Nederland – wat zegt de wet?",
    "client.src.suggestion_4": "Verblijfsvergunning via vastgoedinvestering in de EU – opties en vereisten"
  },
  da: {
    "client.src.suggestion_1": "2-værelses lejlighed til leje i København centrum under 12.000 kr/md",
    "client.src.suggestion_2": "Investeringsejendom til salg i Aarhus med godt afkast",
    "client.src.suggestion_3": "Lejerrettigheder og udsættelsesproces i Danmark – hvad siger loven?",
    "client.src.suggestion_4": "Opholdstilladelse via ejendomsinvestering i EU – muligheder og krav"
  },
  no: {
    "client.src.suggestion_1": "2-roms leilighet til leie i Oslo sentrum under 15.000 kr/mnd",
    "client.src.suggestion_2": "Investeringseiendom til salgs i Bergen med god avkastning",
    "client.src.suggestion_3": "Leietakers rettigheter og utkastelsesprosess i Norge – hva sier loven?",
    "client.src.suggestion_4": "Oppholdstillatelse gjennom eiendomsinvestering i EU – alternativer og krav"
  },
  se: {
    "client.src.suggestion_1": "2:a att hyra i Stockholm Södermalm under 15 000 kr/mån",
    "client.src.suggestion_2": "Investeringsfastighet till salu i Göteborg med god avkastning",
    "client.src.suggestion_3": "Hyresgästers rättigheter och avhysningsprocess i Sverige – vad säger lagen?",
    "client.src.suggestion_4": "Uppehållstillstånd genom fastighetsinvestering i EU – alternativ och krav"
  },
  fi: {
    "client.src.suggestion_1": "Kaksio vuokralle Helsingin keskustassa alle 1 200 €/kk",
    "client.src.suggestion_2": "Sijoitusasunto myytävänä Tampereella hyvällä tuotolla",
    "client.src.suggestion_3": "Vuokralaisen oikeudet ja häätöprosessi Suomessa – mitä laki sanoo?",
    "client.src.suggestion_4": "Oleskelulupa kiinteistösijoituksen kautta EU:ssa – vaihtoehdot ja vaatimukset"
  },
  pl: {
    "client.src.suggestion_1": "Mieszkanie 2-pokojowe do wynajęcia w Warszawie do 4 000 zł/mies.",
    "client.src.suggestion_2": "Mieszkanie inwestycyjne na sprzedaż w Krakowie z dobrą stopą zwrotu",
    "client.src.suggestion_3": "Prawa najemcy i procedura eksmisji w Polsce – co mówi prawo?",
    "client.src.suggestion_4": "Zezwolenie na pobyt przez inwestycję w nieruchomości w UE – opcje i wymagania"
  },
  ru: {
    "client.src.suggestion_1": "2-комнатная квартира в аренду в центре Москвы до 120 000 ₽/мес",
    "client.src.suggestion_2": "Инвестиционная недвижимость на продажу в Сочи с видом на море",
    "client.src.suggestion_3": "Права арендатора и процедура выселения в России – что говорит закон?",
    "client.src.suggestion_4": "Гражданство Турции через покупку недвижимости – условия и порядок оформления"
  },
  ar: {
    "client.src.suggestion_1": "شقة غرفتين للإيجار في دبي مارينا بأقل من 8,000 درهم/شهرياً",
    "client.src.suggestion_2": "شقة للبيع بإطلالة بحرية في جدة للاستثمار العقاري",
    "client.src.suggestion_3": "ما هي حقوق المستأجر وإجراءات الإخلاء في الإمارات؟",
    "client.src.suggestion_4": "الحصول على الإقامة الذهبية في الإمارات عبر الاستثمار العقاري"
  },
  hi: {
    "client.src.suggestion_1": "दिल्ली में ₹30,000/माह से कम में 2BHK किराए पर",
    "client.src.suggestion_2": "गोवा में समुद्र के पास निवेश के लिए विला बिक्री पर",
    "client.src.suggestion_3": "भारत में किराएदार के अधिकार और बेदखली की कानूनी प्रक्रिया क्या है?",
    "client.src.suggestion_4": "पुर्तगाल या ग्रीस में रियल एस्टेट निवेश से गोल्डन वीज़ा कैसे प्राप्त करें?"
  },
  ja: {
    "client.src.suggestion_1": "東京・渋谷で家賃20万円以下の1LDK賃貸マンション",
    "client.src.suggestion_2": "大阪・心斎橋エリアの投資用マンション（利回り重視）",
    "client.src.suggestion_3": "日本の借地借家法における借主の権利と立退き手続きについて",
    "client.src.suggestion_4": "不動産投資によるポルトガルやギリシャのゴールデンビザ取得方法"
  },
  ko: {
    "client.src.suggestion_1": "강남구 월세 200만 원 이하 투룸 전세/월세 아파트",
    "client.src.suggestion_2": "제주도 오션뷰 투자용 매매 빌라",
    "client.src.suggestion_3": "한국 임차인의 권리와 퇴거 절차 – 주택임대차보호법이란?",
    "client.src.suggestion_4": "부동산 투자를 통한 포르투갈·그리스 골든비자 취득 방법"
  },
  zh: {
    "client.src.suggestion_1": "上海浦东月租8000元以内的两居室公寓出租",
    "client.src.suggestion_2": "深圳南山区海景投资房产出售",
    "client.src.suggestion_3": "中国租户的权利和驱逐程序——法律如何规定？",
    "client.src.suggestion_4": "通过房地产投资获得葡萄牙或希腊黄金签证的条件和流程"
  },
  gr: {
    "client.src.suggestion_1": "Διαμέρισμα 2 δωματίων προς ενοικίαση στο κέντρο Αθήνας έως 800 €/μήνα",
    "client.src.suggestion_2": "Ακίνητο προς πώληση με θέα θάλασσα στη Μύκονο για επένδυση",
    "client.src.suggestion_3": "Δικαιώματα ενοικιαστή και διαδικασία έξωσης στην Ελλάδα – τι λέει ο νόμος;",
    "client.src.suggestion_4": "Golden Visa Ελλάδας: απαιτήσεις επένδυσης σε ακίνητα για άδεια παραμονής"
  }
};

const dir = __dirname;
const files = fs.readdirSync(dir).filter(f => f.endsWith('.json'));

for (const file of files) {
  const filePath = path.join(dir, file);
  const lang = path.basename(file, '.json');
  
  if (!suggestions[lang]) continue;
  
  let content = {};
  try {
    content = JSON.parse(fs.readFileSync(filePath, 'utf8'));
  } catch (e) {
    console.error(`Error parsing ${file}`);
    continue;
  }
  
  for (const [key, value] of Object.entries(suggestions[lang])) {
    content[key] = value;
  }
  
  fs.writeFileSync(filePath, JSON.stringify(content, null, 2) + '\n');
  
  const vals = Object.values(suggestions[lang]);
  console.log(`✅ ${lang.toUpperCase()}:`);
  console.log(`   🏠 ${vals[0].substring(0, 60)}`);
  console.log(`   💰 ${vals[1].substring(0, 60)}`);
  console.log(`   ⚖️  ${vals[2].substring(0, 60)}`);
  console.log(`   🛂 ${vals[3].substring(0, 60)}`);
  console.log('');
}

console.log('🎯 Done! All suggestions updated with country-specific rental, sale, legal & citizenship advisory.');
