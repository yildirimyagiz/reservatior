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
