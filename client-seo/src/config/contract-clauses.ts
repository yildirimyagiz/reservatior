// Country-aware service agreement clauses for checkout flow
export interface ContractClause {
  title: string;
  body: string;
}

export interface RegionContract {
  heading: string;
  intro: string;
  clauses: ContractClause[];
  acceptanceText: string;
  flag: string;
  jurisdiction: string;
}

export const REGION_CONTRACTS: Record<string, RegionContract> = {
  TR: {
    heading: "RESERVATIOR PLATFORM HİZMET SÖZLEŞMESİ",
    intro: "Bu Hizmet Sözleşmesi (\"Sözleşme\"), Reservatior Dijital Gayrimenkul Platformu (\"Platform\") ile Platform'a abone olan kullanıcı (\"Abone\") arasında akdedilmiştir.",
    flag: "🇹🇷",
    jurisdiction: "Türkiye Cumhuriyeti",
    acceptanceText: "Reservatior Platform Hizmet Sözleşmesi'ni, KVKK Aydınlatma Metni'ni ve Kullanım Koşulları'nı okudum, anladım ve kabul ediyorum.",
    clauses: [
      { title: "1. HİZMETİN KAPSAMI", body: "Platform, Abone'ye gayrimenkul portföy yönetimi, ilan oluşturma ve yayınlama, kiracı/misafir iletişimi, finansal raporlama ve yapay zeka destekli analiz hizmetleri sunar. Seçilen paket kapsamındaki özellikler, Abone'nin tercih ettiği lisans türüne göre belirlenir." },
      { title: "2. ÜCRET VE ÖDEME", body: "Abone, seçtiği pakete ilişkin aylık abonelik ücretini, her fatura döneminin başında ödemekle yükümlüdür. Ödemeler kredi kartı, banka kartı veya havale/EFT yoluyla gerçekleştirilebilir. Geciken ödemelerde Platform, hizmeti askıya alma hakkını saklı tutar." },
      { title: "3. SÜRESİ VE FESİH", body: "Sözleşme, aboneliğin başladığı tarihten itibaren geçerli olup, taraflardan herhangi birinin 30 gün önceden yazılı bildirimde bulunarak feshetmesine kadar yürürlükte kalır. Fesih halinde, cari fatura dönemi sonuna kadar hizmet devam eder." },
      { title: "4. VERİ GİZLİLİĞİ (KVKK)", body: "Platform, Abone'ye ait tüm kişisel verileri 6698 sayılı Kişisel Verilerin Korunması Kanunu (KVKK) kapsamında işler ve korur. Veri Sorumlusu sıfatıyla Platform, verileri AES-256 şifreleme standardıyla saklar, açık rıza olmaksızın üçüncü taraflarla paylaşmaz ve Abone'nin KVKK kapsamındaki tüm haklarını (erişim, düzeltme, silme, itiraz) garanti eder." },
      { title: "5. TÜKETİCİ HAKLARI", body: "6502 sayılı Tüketicinin Korunması Hakkında Kanun uyarınca, Abone dijital hizmet aboneliğini 14 gün içinde cayma hakkını kullanarak iptal edebilir. Cayma halinde, kullanılmayan süreye ilişkin ücret iade edilir." },
      { title: "6. SORUMLULUK SINIRI", body: "Platform, teknik arıza, doğal afet veya mücbir sebeplerden kaynaklanan hizmet kesintilerinden dolayı sorumluluk kabul etmez. Platform'un toplam sorumluluğu, Abone'nin son 12 ayda ödediği toplam abonelik ücreti ile sınırlıdır." },
      { title: "7. FİKRİ MÜLKİYET", body: "5846 sayılı Fikir ve Sanat Eserleri Kanunu kapsamında, Platform'a ait tüm yazılım, tasarım ve içerikler Reservatior'un fikri mülkiyetindedir. Abone, Platform'u yalnızca kendi ticari faaliyetleri kapsamında kullanabilir." },
      { title: "8. ELEKTRONİK TİCARET", body: "6563 sayılı Elektronik Ticaretin Düzenlenmesi Hakkında Kanun ve ilgili yönetmelikler çerçevesinde, Platform ticari elektronik ileti göndermeden önce Abone'nin onayını alır." },
      { title: "9. UYUŞMAZLIK ÇÖZÜMÜ", body: "Bu Sözleşme'den doğan uyuşmazlıklarda İstanbul Tahkim Merkezi (ISTAC) yetkilidir. Sözleşme, Türkiye Cumhuriyeti kanunlarına tabidir." },
    ],
  },

  USA: {
    heading: "RESERVATIOR PLATFORM SERVICE AGREEMENT",
    intro: "This Service Agreement (\"Agreement\") is entered into between Reservatior Digital Real Estate Platform (\"Platform\") and the subscribing user (\"Subscriber\").",
    flag: "🇺🇸",
    jurisdiction: "United States of America",
    acceptanceText: "I have read, understood, and agree to the Reservatior Platform Service Agreement, Privacy Policy, and Terms of Use.",
    clauses: [
      { title: "1. SCOPE OF SERVICE", body: "The Platform provides Subscriber with property portfolio management, listing creation and syndication, tenant/guest communication, financial reporting, and AI-powered analytics services. Features are determined by the Subscriber's selected license tier." },
      { title: "2. FEES AND PAYMENT", body: "Subscriber agrees to pay the monthly subscription fee at the beginning of each billing cycle. Payments may be made via credit card, debit card, or ACH transfer. The Platform reserves the right to suspend service for overdue payments." },
      { title: "3. TERM AND TERMINATION", body: "This Agreement is effective from the subscription start date and continues until terminated by either party with 30 days' written notice. Upon termination, service continues until the end of the current billing period." },
      { title: "4. DATA PRIVACY (CCPA/STATE LAWS)", body: "The Platform processes all personal data in compliance with the California Consumer Privacy Act (CCPA), Virginia CDPA, and applicable state privacy laws. Data is encrypted using AES-256 standard. Subscriber retains rights to access, delete, and opt-out of data sale." },
      { title: "5. LIMITATION OF LIABILITY", body: "The Platform shall not be liable for service interruptions caused by technical failures, natural disasters, or force majeure events. Total Platform liability is limited to fees paid by the Subscriber in the preceding 12 months." },
      { title: "6. INTELLECTUAL PROPERTY", body: "All software, designs, and content belonging to the Platform are the intellectual property of Reservatior under U.S. Copyright Law (Title 17 USC). Subscriber may not reproduce, distribute, or reverse-engineer the Platform." },
      { title: "7. FAIR HOUSING COMPLIANCE", body: "Subscriber agrees to use the Platform in compliance with the Fair Housing Act (42 USC §3601-3619). Discriminatory listing practices based on race, color, religion, sex, national origin, familial status, or disability are strictly prohibited." },
      { title: "8. DISPUTE RESOLUTION", body: "Any disputes arising from this Agreement shall be resolved through binding arbitration administered by the American Arbitration Association (AAA) in New York, NY. This Agreement is governed by the laws of the State of Delaware." },
    ],
  },

  UK: {
    heading: "RESERVATIOR PLATFORM SERVICE AGREEMENT",
    intro: "This Service Agreement (\"Agreement\") is entered into between Reservatior Digital Real Estate Platform (\"Platform\") and the subscribing user (\"Subscriber\").",
    flag: "🇬🇧",
    jurisdiction: "United Kingdom",
    acceptanceText: "I have read, understood, and agree to the Reservatior Platform Service Agreement, Privacy Policy (UK GDPR), and Terms of Use.",
    clauses: [
      { title: "1. SCOPE OF SERVICE", body: "The Platform provides property portfolio management, listing syndication via Rightmove/Zoopla integrations, tenant referencing, financial reporting, and AI-powered analytics." },
      { title: "2. FEES AND PAYMENT", body: "Subscriber agrees to pay the monthly subscription fee (exclusive of VAT at 20%) at the start of each billing cycle via credit/debit card or Direct Debit. Late payments may result in service suspension." },
      { title: "3. TERM AND TERMINATION", body: "This Agreement runs from subscription start date. Either party may terminate with 30 days' written notice. The Consumer Rights Act 2015 provides a 14-day cooling-off period for digital content." },
      { title: "4. DATA PROTECTION (UK GDPR)", body: "The Platform processes personal data in compliance with the UK General Data Protection Regulation (UK GDPR) and the Data Protection Act 2018. The ICO (Information Commissioner's Office) is the supervisory authority. Data subjects retain all rights under Article 15-22." },
      { title: "5. LETTING AGENT COMPLIANCE", body: "Subscriber using the Platform as a letting agent must comply with the Tenant Fees Act 2019, Client Money Protection (CMP) scheme requirements, and hold membership with a Property Redress Scheme." },
      { title: "6. LIMITATION OF LIABILITY", body: "Platform liability is limited to fees paid in the preceding 12 months. Nothing in this Agreement excludes liability for fraud, death, or personal injury caused by negligence under English law." },
      { title: "7. INTELLECTUAL PROPERTY", body: "All Platform IP is protected under the Copyright, Designs and Patents Act 1988. Subscriber receives a non-exclusive, non-transferable license for commercial use only." },
      { title: "8. GOVERNING LAW", body: "This Agreement is governed by the laws of England and Wales. Disputes shall be subject to the exclusive jurisdiction of the courts of England and Wales, with reference to the RICS Dispute Resolution Service where applicable." },
    ],
  },

  NL: {
    heading: "RESERVATIOR PLATFORM SERVICEOVEREENKOMST",
    intro: "Deze Serviceovereenkomst (\"Overeenkomst\") wordt aangegaan tussen Reservatior Digital Real Estate Platform (\"Platform\") en de abonnerende gebruiker (\"Abonnee\").",
    flag: "🇳🇱",
    jurisdiction: "Koninkrijk der Nederlanden",
    acceptanceText: "Ik heb de Reservatior Platform Serviceovereenkomst, het Privacybeleid (AVG) en de Gebruiksvoorwaarden gelezen, begrepen en ga ermee akkoord.",
    clauses: [
      { title: "1. OMVANG VAN DE DIENST", body: "Het Platform biedt vastgoedportfoliobeheer, advertentiecreatie via Funda/Pararius-integraties, huurders-/gastcommunicatie, financiële rapportage en AI-analyse." },
      { title: "2. VERGOEDINGEN EN BETALING", body: "Abonnee betaalt de maandelijkse abonnementskosten (exclusief 21% BTW) aan het begin van elke facturatieperiode. Conform de Wet Goed Verhuurderschap mogen bemiddelingskosten niet aan huurders worden doorberekend wanneer de verhuurder opdracht geeft." },
      { title: "3. LOOPTIJD EN BEËINDIGING", body: "Deze Overeenkomst loopt vanaf de startdatum. Beide partijen kunnen opzeggen met 30 dagen schriftelijke kennisgeving. Conform de Wet Koop op Afstand geldt een 14-daagse bedenktijd voor digitale diensten." },
      { title: "4. GEGEVENSBESCHERMING (AVG/GDPR)", body: "Het Platform verwerkt persoonsgegevens conform de Algemene Verordening Gegevensbescherming (AVG/GDPR). De Autoriteit Persoonsgegevens (AP) is de toezichthoudende autoriteit. Betrokkenen behouden alle rechten onder Artikel 15-22 AVG." },
      { title: "5. WET GOED VERHUURDERSCHAP", body: "Het Platform ondersteunt naleving van de Wet Goed Verhuurderschap (2023), inclusief transparante selectieprocedures, anti-discriminatiebeleid en het verbod op sleutelgeld (key money)." },
      { title: "6. AANSPRAKELIJKHEIDSBEPERKING", body: "De totale aansprakelijkheid van het Platform is beperkt tot het bedrag dat de Abonnee in de voorafgaande 12 maanden heeft betaald, behoudens opzet of grove schuld." },
      { title: "7. INTELLECTUEEL EIGENDOM", body: "Alle IE-rechten van het Platform worden beschermd onder de Nederlandse Auteurswet. De Abonnee ontvangt een niet-exclusieve, niet-overdraagbare licentie." },
      { title: "8. GESCHILLENBESLECHTING", body: "Op deze Overeenkomst is Nederlands recht van toepassing. Geschillen worden voorgelegd aan de bevoegde rechtbank te Amsterdam." },
    ],
  },

  DE: {
    heading: "RESERVATIOR PLATTFORM-DIENSTLEISTUNGSVERTRAG",
    intro: "Dieser Dienstleistungsvertrag (\"Vertrag\") wird zwischen der Reservatior Digital Real Estate Platform (\"Plattform\") und dem abonnierenden Nutzer (\"Abonnent\") geschlossen.",
    flag: "🇩🇪",
    jurisdiction: "Bundesrepublik Deutschland",
    acceptanceText: "Ich habe die Reservatior Plattform-Dienstleistungsvereinbarung, die Datenschutzerklärung (DSGVO) und die Nutzungsbedingungen gelesen, verstanden und stimme ihnen zu.",
    clauses: [
      { title: "1. LEISTUNGSUMFANG", body: "Die Plattform bietet Immobilienportfoliomanagement, Anzeigenerstellung über ImmobilienScout24-Integration, Mieter-/Gästekommunikation, Finanzberichterstattung und KI-gestützte Analysen." },
      { title: "2. GEBÜHREN UND ZAHLUNG", body: "Der Abonnent zahlt die monatliche Abonnementgebühr (zzgl. 19% MwSt.) zu Beginn jedes Abrechnungszeitraums. Das Bestellerprinzip gemäß §2 Abs. 1a WoVermRG gilt für Maklerprovisionen." },
      { title: "3. LAUFZEIT UND KÜNDIGUNG", body: "Dieser Vertrag gilt ab dem Abonnementbeginn. Beide Parteien können mit 30 Tagen schriftlicher Kündigungsfrist kündigen. Es gilt ein 14-tägiges Widerrufsrecht gemäß §§ 312g, 355 BGB." },
      { title: "4. DATENSCHUTZ (DSGVO)", body: "Die Plattform verarbeitet personenbezogene Daten gemäß der Datenschutz-Grundverordnung (DSGVO) und dem Bundesdatenschutzgesetz (BDSG). Aufsichtsbehörde ist der BfDI. Betroffene behalten alle Rechte nach Art. 15-22 DSGVO." },
      { title: "5. MIETPREISBREMSE", body: "Die Plattform unterstützt die Einhaltung der Mietpreisbremse (§§ 556d-556g BGB) und der Kappungsgrenze für Mieterhöhungen." },
      { title: "6. HAFTUNGSBESCHRÄNKUNG", body: "Die Gesamthaftung der Plattform ist auf die vom Abonnenten in den letzten 12 Monaten gezahlten Gebühren beschränkt, soweit gesetzlich zulässig." },
      { title: "7. GEISTIGES EIGENTUM", body: "Alle IP-Rechte der Plattform sind nach dem Urheberrechtsgesetz (UrhG) geschützt." },
      { title: "8. GERICHTSSTAND", body: "Es gilt deutsches Recht. Gerichtsstand ist Berlin." },
    ],
  },

  AE: {
    heading: "RESERVATIOR PLATFORM SERVICE AGREEMENT",
    intro: "This Service Agreement (\"Agreement\") is entered into between Reservatior Digital Real Estate Platform (\"Platform\") and the subscribing user (\"Subscriber\").",
    flag: "🇦🇪",
    jurisdiction: "United Arab Emirates",
    acceptanceText: "I have read, understood, and agree to the Reservatior Platform Service Agreement, Privacy Policy (PDPL), and Terms of Use.",
    clauses: [
      { title: "1. SCOPE OF SERVICE", body: "The Platform provides property portfolio management, listing syndication via Bayut/Property Finder integrations, tenant communication, financial reporting, and AI-powered analytics for the UAE real estate market." },
      { title: "2. FEES AND PAYMENT", body: "Subscriber agrees to pay the subscription fee (exclusive of 5% VAT) at the start of each billing cycle. All agency activities must comply with RERA (Real Estate Regulatory Authority) licensing requirements." },
      { title: "3. TERM AND TERMINATION", body: "This Agreement runs from subscription start date. Either party may terminate with 30 days' written notice. Ejari registration requirements for tenancy contracts remain the Subscriber's responsibility." },
      { title: "4. DATA PROTECTION (PDPL)", body: "The Platform processes personal data in compliance with UAE Federal Decree-Law No. 45 of 2021 on Personal Data Protection (PDPL) and DIFC/ADGM data protection regulations where applicable." },
      { title: "5. RERA COMPLIANCE", body: "Subscriber using the Platform as a real estate agent must hold a valid RERA broker license. All listing prices must comply with RERA Smart Rental Index guidelines." },
      { title: "6. LIMITATION OF LIABILITY", body: "Platform liability is limited to fees paid in the preceding 12 months. The Platform is not liable for losses arising from Tawtheeq/Ejari registration delays." },
      { title: "7. INTELLECTUAL PROPERTY", body: "All Platform IP is protected under UAE Federal Law No. 38 of 2021 on Copyrights and Neighboring Rights." },
      { title: "8. GOVERNING LAW", body: "This Agreement is governed by the laws of the United Arab Emirates. Disputes shall be resolved through the Dubai International Arbitration Centre (DIAC)." },
    ],
  },
};

// Fallback to USA for unknown regions
export function getContractForRegion(countryCode: string | undefined): RegionContract {
  if (!countryCode) return REGION_CONTRACTS["USA"];
  const upper = countryCode.toUpperCase();
  // Map prisma config codes to our contract codes
  const mapping: Record<string, string> = {
    TR: "TR", USA: "USA", US: "USA", UK: "UK", GB: "UK",
    NL: "NL", DE: "DE", AE: "AE",
    FR: "USA", ES: "USA", IT: "USA", // fallback to generic English
  };
  return REGION_CONTRACTS[mapping[upper] || "USA"] || REGION_CONTRACTS["USA"];
}
