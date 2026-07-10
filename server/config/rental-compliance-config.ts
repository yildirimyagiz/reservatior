/**
 * Reservatior Global Rental Compliance Configuration
 * 
 * Bu konfigürasyon dosyası, Avrupa ve Dünya pazarlarındaki ülkelere göre 
 * geçerli olan yasal kiralama mevzuatlarını (Maksimum depozito, 
 * yasal komisyon payları, açık bankacılık taksit izinleri) tutar.
 */

export interface RegionalComplianceRule {
  countryCode: string;
  laws: string[]; // Geçerli yasalar (örn: Ley 12/2023, Tenant Fees Act)
  maxDepositMonths: number | null; // Null ise hesaplamaya bağlıdır (örn: UK)
  landlordCommissionFixedPct: number; // Ev sahibine yansıtılacak baz komisyon
  tenantCommissionFixedPct: number; // Kiracıdan alınacak klasik komisyon
  allowsTenantServiceFee: boolean; // Kiracıdan 'Premium Paket / Açık Bankacılık' vb. adla hizmet bedeli alınabilir mi?
  maxTenantServiceFeePct: number | null; // Varsa tavan limit (örn: Fransa ALUR)
  openBanking: {
    enabled: boolean;
    maxInstallments: number;
    requiresMandate: boolean; // VRP (Variable Recurring Payment) zorunluluğu
  };
  preferredCreditCardProcessor: 'LEMONWAY' | 'IYZICO' | 'CHECKOUT' | 'STRIPE'; // Lisans geçerliliğine göre
}

export const GLOBAL_COMPLIANCE_RULES: Record<string, RegionalComplianceRule> = {
  'ES': {
    countryCode: 'ES',
    laws: ['Ley 12/2023 (Nueva Ley de Vivienda)', 'LAU (Ley de Arrendamientos Urbanos)'],
    maxDepositMonths: 3, // 1 ay yasal + 2 ay ek garanti (fianza adicional)
    landlordCommissionFixedPct: 3.5,
    tenantCommissionFixedPct: 0.0, // Uzun dönem kiralarda yasaktır
    allowsTenantServiceFee: true, // Ancak opsiyonel (zorunlu olmayan) hizmet paketi satılabilir
    maxTenantServiceFeePct: 3.5,
    openBanking: {
      enabled: true,
      maxInstallments: 6,
      requiresMandate: true
    },
    preferredCreditCardProcessor: 'LEMONWAY' // Avrupa Birliği içi tam uyumlu
  },
  'UK': {
    countryCode: 'UK',
    laws: ['Tenant Fees Act 2019'],
    maxDepositMonths: null, // Kira £50k altındaysa 5 hafta, üstündeyse 6 hafta (Dinamik hesaplanır)
    landlordCommissionFixedPct: 7.0, // Kiracıdan para alınamadığı için maliyet ev sahibinde
    tenantCommissionFixedPct: 0.0,
    allowsTenantServiceFee: false, // İngiltere'de kiracıdan hizmet bedeli (admin fee vs) almak YASAKTIR
    maxTenantServiceFeePct: 0.0,
    openBanking: {
      enabled: true,
      maxInstallments: 3,
      requiresMandate: true
    },
    preferredCreditCardProcessor: 'LEMONWAY'
  },
  'DE': {
    countryCode: 'DE',
    laws: ['Bestellerprinzip (2015)', 'BGB (Bürgerliches Gesetzbuch)'],
    maxDepositMonths: 3, // Maksimum 3 aylık soğuk kira (Kaltmiete)
    landlordCommissionFixedPct: 7.0,
    tenantCommissionFixedPct: 0.0,
    allowsTenantServiceFee: false, // "Siparişi veren öder" kuralı gereği kiracıdan ücret alınamaz
    maxTenantServiceFeePct: 0.0,
    openBanking: {
      enabled: true,
      maxInstallments: 3, // Yasa gereği depozito 3 taksitte ödenebilir
      requiresMandate: true
    },
    preferredCreditCardProcessor: 'LEMONWAY' // Almanya BaFin pasaportlaması var
  },
  'NL': {
    countryCode: 'NL',
    laws: ['Dienen van twee heren (Çıkar Çatışması Yasağı)'],
    maxDepositMonths: 2,
    landlordCommissionFixedPct: 7.0,
    tenantCommissionFixedPct: 0.0, // Bir işlemde hem ev sahibi hem kiracıdan para alınamaz
    allowsTenantServiceFee: false,
    maxTenantServiceFeePct: 0.0,
    openBanking: {
      enabled: true,
      maxInstallments: 2,
      requiresMandate: true
    },
    preferredCreditCardProcessor: 'LEMONWAY'
  },
  'FR': {
    countryCode: 'FR',
    laws: ['Loi ALUR (2014)'],
    maxDepositMonths: 1, // Eşyasız 1 ay, Eşyalı 2 ay olabilir. Biz default 1 alıyoruz.
    landlordCommissionFixedPct: 3.5,
    tenantCommissionFixedPct: 3.5, 
    allowsTenantServiceFee: true, // Yasal, ancak metrekareye göre tavan (cap) var.
    maxTenantServiceFeePct: null, // Dinamik tavan (Bkz: 12-15€/m2 kuralı)
    openBanking: {
      enabled: true,
      maxInstallments: 3,
      requiresMandate: true
    },
    preferredCreditCardProcessor: 'LEMONWAY'
  },
  'IT': {
    countryCode: 'IT',
    laws: ['Codice Civile (Provvigione)'],
    maxDepositMonths: 3, // Caparra
    landlordCommissionFixedPct: 3.5, // İtalya'da her iki taraftan komisyon almak standarttır.
    tenantCommissionFixedPct: 3.5,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null, // Sınır yok
    openBanking: {
      enabled: true,
      maxInstallments: 3,
      requiresMandate: true
    },
    preferredCreditCardProcessor: 'LEMONWAY'
  },
  'TR': {
    countryCode: 'TR',
    laws: ['Borçlar Kanunu (TBK)'],
    maxDepositMonths: 3,
    landlordCommissionFixedPct: 3.5, // Serbest piyasa, genelde kiracı öder ama modelimiz 3.5-3.5
    tenantCommissionFixedPct: 3.5,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: {
      enabled: false, // Türkiye'de Open Banking taksit modeli VRP tam oturmadığı için şimdilik kapalı
      maxInstallments: 0,
      requiresMandate: false
    },
    preferredCreditCardProcessor: 'IYZICO' // TCMB yasaları gereği Lemonway Türkiye'de kullanılamaz
  },
  'AE': {
    countryCode: 'AE',
    laws: ['RERA Regulations'],
    maxDepositMonths: 1, // Genelde %5 (Eşyasız) veya %10 (Eşyalı) alınır. Ortalama 1 aya denk gelir.
    landlordCommissionFixedPct: 0.0, // Dubai'de komisyonu genelde SADECE kiracı öder (%5).
    tenantCommissionFixedPct: 5.0, 
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: {
      enabled: false,
      maxInstallments: 0,
      requiresMandate: false
    },
    preferredCreditCardProcessor: 'CHECKOUT' // BAE regülasyonlarına Checkout.com veya Stripe AE uygundur
  }
};

// ─── Ek 15 Ülke Kuralları ────────────────────────────────────────────────────
// (TR, ES, UK, DE, NL, FR, IT, AE yukarıda mevcut)

export const ADDITIONAL_COMPLIANCE_RULES: Record<string, RegionalComplianceRule> = {
  'US': {
    countryCode: 'US',
    laws: ['State-by-state (CA/NY/TX)', 'TRID (RESPA)', 'Fair Housing Act'],
    maxDepositMonths: 2,
    landlordCommissionFixedPct: 3.0,
    tenantCommissionFixedPct: 0.0, // Buyer commission post-NAR settlement (Aug 2024) must be negotiated separately
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: { enabled: true, maxInstallments: 12, requiresMandate: false },
    preferredCreditCardProcessor: 'STRIPE',
  },
  'CA': {
    countryCode: 'CA',
    laws: ['REBBA (Ontario)', 'RESA (BC)', 'DPA (Alberta)'],
    maxDepositMonths: 1,
    landlordCommissionFixedPct: 2.5,
    tenantCommissionFixedPct: 2.5,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: { enabled: true, maxInstallments: 6, requiresMandate: false },
    preferredCreditCardProcessor: 'STRIPE',
  },
  'AU': {
    countryCode: 'AU',
    laws: ['Property, Stock and Business Agents Act (NSW)', 'Estate Agents Act (VIC)'],
    maxDepositMonths: 1,
    landlordCommissionFixedPct: 2.75,
    tenantCommissionFixedPct: 0.0, // AU'da kiracıdan komisyon almak yasaklanma eğiliminde
    allowsTenantServiceFee: false,
    maxTenantServiceFeePct: 0.0,
    openBanking: { enabled: true, maxInstallments: 4, requiresMandate: true },
    preferredCreditCardProcessor: 'STRIPE',
  },
  'NZ': {
    countryCode: 'NZ',
    laws: ['Real Estate Agents Act 2008'],
    maxDepositMonths: 2,
    landlordCommissionFixedPct: 3.0,
    tenantCommissionFixedPct: 0.0,
    allowsTenantServiceFee: false,
    maxTenantServiceFeePct: 0.0,
    openBanking: { enabled: false, maxInstallments: 0, requiresMandate: false },
    preferredCreditCardProcessor: 'STRIPE',
  },
  'JP': {
    countryCode: 'JP',
    laws: ['Real Estate Transaction Act (宅建業法)', 'Civil Code (民法)'],
    maxDepositMonths: 2, // Shikikin (敷金)
    landlordCommissionFixedPct: 3.0,
    tenantCommissionFixedPct: 3.0, // Her iki taraftan alınabilir; toplamı 1 ay kira bedeli
    allowsTenantServiceFee: true, // Reikin (礼金) sisteminde geleneksel
    maxTenantServiceFeePct: null,
    openBanking: { enabled: false, maxInstallments: 0, requiresMandate: false },
    preferredCreditCardProcessor: 'STRIPE',
  },
  'KR': {
    countryCode: 'KR',
    laws: ['Housing Lease Protection Act (주택임대차보호법)'],
    maxDepositMonths: null, // Jeonse sistemi (전세): yüklü depozito modeli
    landlordCommissionFixedPct: 0.4, // Yasal sınır (bölgeye göre 0.4-0.9%)
    tenantCommissionFixedPct: 0.4,
    allowsTenantServiceFee: false,
    maxTenantServiceFeePct: 0.0,
    openBanking: { enabled: false, maxInstallments: 0, requiresMandate: false },
    preferredCreditCardProcessor: 'CHECKOUT',
  },
  'SG': {
    countryCode: 'SG',
    laws: ['Estate Agents Act', 'Council for Estate Agencies (CEA) Rules'],
    maxDepositMonths: 2,
    landlordCommissionFixedPct: 1.0, // HDB: 1 ay / Private: müzakere
    tenantCommissionFixedPct: 1.0,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: { enabled: false, maxInstallments: 0, requiresMandate: false },
    preferredCreditCardProcessor: 'STRIPE',
  },
  'MY': {
    countryCode: 'MY',
    laws: ['Valuers, Appraisers and Estate Agents Act 1981'],
    maxDepositMonths: 2,
    landlordCommissionFixedPct: 3.0, // LHDN standart
    tenantCommissionFixedPct: 0.0,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: { enabled: false, maxInstallments: 0, requiresMandate: false },
    preferredCreditCardProcessor: 'CHECKOUT',
  },
  'TH': {
    countryCode: 'TH',
    laws: ['Civil and Commercial Code', 'Land Department Regulations'],
    maxDepositMonths: 3,
    landlordCommissionFixedPct: 2.5,
    tenantCommissionFixedPct: 2.5,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: { enabled: true, maxInstallments: 6, requiresMandate: false }, // PromptPay A2A
    preferredCreditCardProcessor: 'CHECKOUT',
  },
  'SA': {
    countryCode: 'SA',
    laws: ['Real Estate General Authority (REGA)', 'Vision 2030 Housing Initiatives'],
    maxDepositMonths: 1,
    landlordCommissionFixedPct: 2.0,
    tenantCommissionFixedPct: 0.0,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: { enabled: false, maxInstallments: 0, requiresMandate: false },
    preferredCreditCardProcessor: 'CHECKOUT',
  },
  'BR': {
    countryCode: 'BR',
    laws: ['Lei do Inquilinato (Lei 8.245/91)', 'CRECI Regulations'],
    maxDepositMonths: 3,
    landlordCommissionFixedPct: 6.0, // CRECI standart 6%
    tenantCommissionFixedPct: 0.0,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: { enabled: true, maxInstallments: 12, requiresMandate: false }, // Pix instant payment
    preferredCreditCardProcessor: 'CHECKOUT',
  },
  'AR': {
    countryCode: 'AR',
    laws: ['Ley 27.551 (Ley de Alquileres)', 'CUCICBA Regulations'],
    maxDepositMonths: 1,
    landlordCommissionFixedPct: 4.0,
    tenantCommissionFixedPct: 4.0,
    allowsTenantServiceFee: false, // 2020 reformu sonrası kısıtlandı
    maxTenantServiceFeePct: 0.0,
    openBanking: { enabled: false, maxInstallments: 0, requiresMandate: false },
    preferredCreditCardProcessor: 'CHECKOUT',
  },
  'MX': {
    countryCode: 'MX',
    laws: ['Código Civil Federal', 'NOM-247-SE-2021'],
    maxDepositMonths: 2,
    landlordCommissionFixedPct: 5.0, // Meksika standart
    tenantCommissionFixedPct: 0.0,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: { enabled: false, maxInstallments: 0, requiresMandate: false },
    preferredCreditCardProcessor: 'STRIPE', // Stripe Mexico mevcut
  },
  'IN': {
    countryCode: 'IN',
    laws: ['Model Tenancy Act 2021', 'RERA (Real Estate Regulation Act)'],
    maxDepositMonths: 3, // Model law cap; states vary
    landlordCommissionFixedPct: 1.0,
    tenantCommissionFixedPct: 1.0,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: null,
    openBanking: { enabled: true, maxInstallments: 6, requiresMandate: false }, // UPI A2A
    preferredCreditCardProcessor: 'CHECKOUT',
  },
  'CN': {
    countryCode: 'CN',
    laws: ['Urban Real Estate Administration Law', 'Ministry of Housing (住建部) Regulations'],
    maxDepositMonths: 1, // '押一付三' modeli yaygın (1 depozito + 3 ay ön ödeme)
    landlordCommissionFixedPct: 3.0,
    tenantCommissionFixedPct: 0.0,
    allowsTenantServiceFee: false, // 2022 düzenlemesiyle kısıtlandı
    maxTenantServiceFeePct: 0.0,
    openBanking: { enabled: false, maxInstallments: 0, requiresMandate: false },
    preferredCreditCardProcessor: 'CHECKOUT', // WeChat Pay/Alipay entegrasyonu ayrıca
  },
  'ES': {
    // Zaten mevcut ama üzerine yaz (daha geniş kural seti)
    countryCode: 'ES',
    laws: ['Ley 12/2023', 'LAU'],
    maxDepositMonths: 3,
    landlordCommissionFixedPct: 3.5,
    tenantCommissionFixedPct: 0.0,
    allowsTenantServiceFee: true,
    maxTenantServiceFeePct: 3.5,
    openBanking: { enabled: true, maxInstallments: 6, requiresMandate: true },
    preferredCreditCardProcessor: 'LEMONWAY',
  },
};

// Birleşik kural haritası (tüm 23 ülke)
export const ALL_COMPLIANCE_RULES: Record<string, RegionalComplianceRule> = {
  ...GLOBAL_COMPLIANCE_RULES,
  ...ADDITIONAL_COMPLIANCE_RULES,
};
