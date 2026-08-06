// server/config/country-contract-config.ts
// Reservatior — Country-level legal & contract profiles for ALL supported markets.
// This file is the single source of truth used by:
//   - config/contract-engine.ts   (server-side template compilation)
//   - config/global-compliance-filter.ts (regulatory checks)
//   - ml-services (Python) contract generation
//   - client-seo & mobile template catalogs
//
// 23 markets: TR, US, CA, MX, UK, DE, FR, ES, IT, NL, BR, AR, AU, NZ,
//             JP, KR, CN, IN, SG, MY, TH, AE, SA

import { RegionCode } from './ai-yield-optimization';

// ─── Supported contract languages ───────────────────────────────────────────
export enum ContractLanguage {
  TR = 'tr',
  EN = 'en',
  AR = 'ar',
  DE = 'de',
  FR = 'fr',
  ES = 'es',
  IT = 'it',
  RU = 'ru',
  PT = 'pt',
  JA = 'ja',
  NL = 'nl',
  KO = 'ko',
  ZH = 'zh',
  HI = 'hi',
  TH = 'th',
  MS = 'ms',
}

export const CONTRACT_LANGUAGE_NAMES: Record<ContractLanguage, string> = {
  [ContractLanguage.TR]: 'Türkçe',
  [ContractLanguage.EN]: 'English',
  [ContractLanguage.AR]: 'العربية',
  [ContractLanguage.DE]: 'Deutsch',
  [ContractLanguage.FR]: 'Français',
  [ContractLanguage.ES]: 'Español',
  [ContractLanguage.IT]: 'Italiano',
  [ContractLanguage.RU]: 'Русский',
  [ContractLanguage.PT]: 'Português',
  [ContractLanguage.JA]: '日本語',
  [ContractLanguage.NL]: 'Nederlands',
  [ContractLanguage.KO]: '한국어',
  [ContractLanguage.ZH]: '中文',
  [ContractLanguage.HI]: 'हिन्दी',
  [ContractLanguage.TH]: 'ไทย',
  [ContractLanguage.MS]: 'Bahasa Melayu',
};

export interface CountryContractProfile {
  countryCode: RegionCode;
  countryNameEn: string;
  countryNameNative: string;
  currency: string;              // ISO 4217
  currencySymbol: string;
  officialLanguages: ContractLanguage[];
  defaultLanguage: ContractLanguage;
  /** Legal basis referenced in generated contracts, keyed by language. */
  legalBasis: Partial<Record<ContractLanguage, string>>;
  /** Max security deposit in months of rent (null → market-based, e.g. UK / KR). */
  maxDepositMonths: number | null;
  /** Default lease term used when no explicit term is provided. */
  defaultTermMonths: number;
  /** Jurisdiction / venue label, keyed by language. */
  jurisdictionLabel: Partial<Record<ContractLanguage, string>>;
  /** Real-estate regulator / licensing body (used in agency contracts). */
  regulator: Partial<Record<ContractLanguage, string>>;
  /** Payment processing configuration for this country. */
  paymentConfig: PaymentConfig;
}

/**
 * Payment processing configuration per country.
 * These parameters control how rent payments are processed, including
 * early capture rules, surcharge permissions, and regulatory compliance.
 */
export interface PaymentConfig {
  /**
   * Primary payment provider for this country.
   * Options: 'stripe', 'adyen', 'checkout', 'local'
   */
  primaryProvider: 'stripe' | 'adyen' | 'checkout' | 'local';
  
  /**
   * Secondary/fallback payment provider (optional).
   * Useful for multi-provider strategy or regional coverage gaps.
   */
  secondaryProvider?: 'stripe' | 'adyen' | 'checkout' | 'local';
  
  /**
   * Whether surcharging (passing transaction fees to customer) is legally allowed.
   * Many countries regulate or prohibit surcharging. Always verify with local counsel.
   * 
   * Legal status by region (approximate):
   * - EU: Generally prohibited for consumer cards
   * - UK: Prohibited for consumer cards
   * - US: Allowed in some states, prohibited in others
   * - Australia: Allowed with disclosure
   * - Canada: Generally prohibited
   * - Turkey: Allowed with disclosure
   * - UAE: Allowed with disclosure
   * - Saudi Arabia: Generally prohibited
   * - Singapore: Allowed with disclosure
   * - Malaysia: Allowed with disclosure
   * - Thailand: Allowed with disclosure
   * - Japan: Generally prohibited
   * - South Korea: Generally prohibited
   * - China: Generally prohibited
   * - India: Generally prohibited
   * - Brazil: Allowed with disclosure
   * - Argentina: Generally prohibited
   * - Mexico: Allowed with disclosure
   */
  surchargeAllowed: boolean;
  
  /**
   * Maximum surcharge percentage allowed (if surchargeAllowed is true).
   * Typically 2-4% depending on card network rules.
   * Set to null if no specific limit or if surcharge is not allowed.
   */
  maxSurchargePercent: number | null;
  
  /**
   * Maximum number of days before rent due date that early capture is allowed.
   * This is NOT a pre-auth hold - it's an actual early capture (early payment).
   * 
   * Legal considerations:
   * - Some countries treat early capture as "advance rent" which may be
   *   subject to deposit limits or additional regulations
   * - Consumer protection laws may restrict early capture
   * - Always verify with local counsel before implementing
   * 
   * Examples:
   * - 0: No early capture allowed (capture only on due date)
   * - 7: Capture allowed up to 7 days before due date
   * - 21: Capture allowed up to 21 days before due date
   * - null: No restriction (use with extreme caution)
   */
  earlyCaptureDays: number | null;
  
  /**
   * Maximum number of months of rent that can be paid in advance.
   * This is separate from security deposit limits.
   * Some countries restrict advance rent payments to prevent landlord abuse.
   * 
   * Examples:
   * - 1: Maximum 1 month advance rent
   * - 3: Maximum 3 months advance rent
   * - 6: Maximum 6 months advance rent
   * - null: No restriction (use with caution)
   */
  maxAdvanceRentMonths: number | null;
  
  /**
   * Whether pre-authorization (hold without capture) is supported.
   * Pre-authorization holds funds on the card without actually charging.
   * Typical hold duration: 7-30 days depending on card network.
   * 
   * Use cases:
   * - Security deposit verification
   * - Temporary hold while processing application
   * - Rent payment verification before due date
   * 
   * Note: Pre-auth is NOT the same as early capture.
   */
  preAuthSupported: boolean;
  
  /**
   * Maximum pre-authorization hold duration in days.
   * Card networks typically limit holds to 7-30 days.
   * This should be set conservatively to avoid hold expiration.
   */
  maxPreAuthDays: number;
  
  /**
   * Local payment methods supported beyond card payments.
   * These are country-specific alternatives to card payments.
   * 
   * Examples by region:
   * - Turkey: BKM Express, Papara
   * - Netherlands: iDEAL
   * - Germany: SEPA, Sofort
   * - Brazil: PIX, Boleto
   * - Mexico: SPEI, OXXO
   * - China: Alipay, WeChat Pay
   * - India: UPI, Paytm
   * - Thailand: PromptPay
   * - Singapore: PayNow
   * - Malaysia: FPX
   * - UAE: Apple Pay, local bank transfers
   * - Saudi Arabia: Mada, Apple Pay
   */
  localPaymentMethods: string[];
  
  /**
   * Whether split payments (platform/landlord/agent split) are supported.
   * This requires payment provider's Connect or equivalent product.
   * 
   * All major providers (Stripe, Adyen, Checkout.com) support this.
   * Local providers may not.
   */
  splitPaymentSupported: boolean;
  
  /**
   * Regulatory compliance notes for payment processing.
   * This is for documentation purposes and should be verified with local counsel.
   */
  regulatoryNotes?: string;
}

// ─── Payment config helper (per country, based on regional regulations) ─────
const PC = {
  stripe: (overrides?: Partial<PaymentConfig>): PaymentConfig => ({
    primaryProvider: 'stripe',
    surchargeAllowed: false,
    maxSurchargePercent: null,
    earlyCaptureDays: 0,
    maxAdvanceRentMonths: 3,
    preAuthSupported: true,
    maxPreAuthDays: 7,
    localPaymentMethods: [],
    splitPaymentSupported: true,
    regulatoryNotes: 'Verify surcharge rules with local counsel. Stripe Connect supports split payments.',
    ...overrides,
  }),
  adyen: (overrides?: Partial<PaymentConfig>): PaymentConfig => ({
    primaryProvider: 'adyen',
    surchargeAllowed: false,
    maxSurchargePercent: null,
    earlyCaptureDays: 0,
    maxAdvanceRentMonths: 3,
    preAuthSupported: true,
    maxPreAuthDays: 7,
    localPaymentMethods: [],
    splitPaymentSupported: true,
    regulatoryNotes: 'Adyen MarketPlace supports split payments. Strong regional coverage in EU/MENA/Asia.',
    ...overrides,
  }),
  checkout: (overrides?: Partial<PaymentConfig>): PaymentConfig => ({
    primaryProvider: 'checkout',
    surchargeAllowed: false,
    maxSurchargePercent: null,
    earlyCaptureDays: 0,
    maxAdvanceRentMonths: 3,
    preAuthSupported: true,
    maxPreAuthDays: 7,
    localPaymentMethods: [],
    splitPaymentSupported: true,
    regulatoryNotes: 'Checkout.com has strong MENA presence, especially UAE/Dubai.',
    ...overrides,
  }),
};

// ─── Legal basis (per country, official language + English) ────────────────
const LB = {
  en: (txt: string) => ({ [ContractLanguage.EN]: txt }),
  tr: (en: string, tr: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.TR]: tr }),
  ar: (en: string, ar: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.AR]: ar }),
  de: (en: string, de: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.DE]: de }),
  fr: (en: string, fr: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.FR]: fr }),
  es: (en: string, es: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.ES]: es }),
  it: (en: string, it: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.IT]: it }),
  pt: (en: string, pt: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.PT]: pt }),
  ja: (en: string, ja: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.JA]: ja }),
  nl: (en: string, nl: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.NL]: nl }),
  ko: (en: string, ko: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.KO]: ko }),
  zh: (en: string, zh: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.ZH]: zh }),
  hi: (en: string, hi: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.HI]: hi }),
  th: (en: string, th: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.TH]: th }),
  ms: (en: string, ms: string) => ({ [ContractLanguage.EN]: en, [ContractLanguage.MS]: ms }),
};

// ─── 23 Country profiles ────────────────────────────────────────────────────
export const COUNTRY_CONTRACT_PROFILES: Partial<Record<RegionCode, CountryContractProfile>> = {
  [RegionCode.TR]: {
    countryCode: RegionCode.TR,
    countryNameEn: 'Türkiye',
    countryNameNative: 'Türkiye',
    currency: 'TRY',
    currencySymbol: '₺',
    officialLanguages: [ContractLanguage.TR],
    defaultLanguage: ContractLanguage.TR,
    legalBasis: LB.tr(
      'in accordance with the Turkish Code of Obligations (Türk Borçlar Kanunu, Law No. 6098) and the Land Registry Law (Tapu Kanunu).',
      '6098 sayılı Türk Borçlar Kanunu ve Tapu Kanunu hükümlerine uygun olarak düzenlenmiştir.'
    ),
    maxDepositMonths: 3,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.tr('Republic of Türkiye', 'Türkiye Cumhuriyeti'),
    regulator: LB.tr('General Directorate of Land Registry and Cadastre (TKGM)', 'Tapu ve Kadastro Genel Müdürlüğü (TKGM)'),
    paymentConfig: PC.stripe({
      surchargeAllowed: true,
      maxSurchargePercent: 3,
      earlyCaptureDays: 7,
      localPaymentMethods: ['BKM Express', 'Papara'],
      regulatoryNotes: 'Surcharge allowed with disclosure. Early capture up to 7 days before due date. Verify with Turkish legal counsel.',
    }),
  },
  [RegionCode.USA]: {
    countryCode: RegionCode.USA,
    countryNameEn: 'United States',
    countryNameNative: 'United States',
    currency: 'USD',
    currencySymbol: '$',
    officialLanguages: [ContractLanguage.EN, ContractLanguage.ES],
    defaultLanguage: ContractLanguage.EN,
    legalBasis: LB.es(
      'in accordance with applicable state and federal law, including the Fair Housing Act and applicable state real-estate statutes.',
      'de conformidad con la ley estatal y federal aplicable, incluyendo la Ley de Vivienda Justa y los estatutos inmobiliarios estatales aplicables.'
    ),
    maxDepositMonths: 2,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.es('United States (state of the property)', 'Estados Unidos (estado de la propiedad)'),
    regulator: LB.es('State Real Estate Commission / NAR standards', 'Comisión Estatal de Bienes Raíces / normas NAR'),
    paymentConfig: PC.stripe({
      surchargeAllowed: null, // State-dependent - verify per state
      earlyCaptureDays: 0,
      regulatoryNotes: 'Surcharge rules vary by state. Some states prohibit, others allow with disclosure. Must verify per state. Early capture not recommended due to state rent regulations.',
    }),
  },
  [RegionCode.CA]: {
    countryCode: RegionCode.CA,
    countryNameEn: 'Canada',
    countryNameNative: 'Canada',
    currency: 'CAD',
    currencySymbol: 'C$',
    officialLanguages: [ContractLanguage.EN, ContractLanguage.FR],
    defaultLanguage: ContractLanguage.EN,
    legalBasis: LB.fr(
      'in accordance with applicable provincial legislation (e.g. Residential Tenancies Act) and the common law.',
      'conformément à la législation provinciale applicable (par ex. Loi sur la location à usage d\'habitation) et au droit commun.'
    ),
    maxDepositMonths: 1,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.fr('Canada (province of the property)', 'Canada (province du bien)'),
    regulator: LB.fr('Provincial real-estate regulator (e.g. RECO Ontario)', 'Autorité immobilière provinciale (p. ex. OACIO Ontario)'),
    paymentConfig: PC.stripe({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      regulatoryNotes: 'Surcharge generally prohibited in Canada. Early capture not recommended due to provincial rent regulations.',
    }),
  },
  [RegionCode.MX]: {
    countryCode: RegionCode.MX,
    countryNameEn: 'Mexico',
    countryNameNative: 'México',
    currency: 'MXN',
    currencySymbol: 'MX$',
    officialLanguages: [ContractLanguage.ES],
    defaultLanguage: ContractLanguage.ES,
    legalBasis: LB.es(
      'in accordance with the Federal Civil Code (Código Civil Federal) and applicable state legislation.',
      'de conformidad con el Código Civil Federal y la legislación estatal aplicable.'
    ),
    maxDepositMonths: 2,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.es('Estados Unidos Mexicanos', 'Estados Unidos Mexicanos'),
    regulator: LB.es('AMPi / local notary requirements', 'AMPi / requisitos notariales locales'),
    paymentConfig: PC.stripe({
      surchargeAllowed: true,
      maxSurchargePercent: 3,
      earlyCaptureDays: 7,
      localPaymentMethods: ['SPEI', 'OXXO'],
      regulatoryNotes: 'Surcharge allowed with disclosure. Early capture up to 7 days before due date. Verify with Mexican legal counsel.',
    }),
  },
  [RegionCode.UK]: {
    countryCode: RegionCode.UK,
    countryNameEn: 'United Kingdom',
    countryNameNative: 'United Kingdom',
    currency: 'GBP',
    currencySymbol: '£',
    officialLanguages: [ContractLanguage.EN],
    defaultLanguage: ContractLanguage.EN,
    legalBasis: LB.en('in accordance with the Law of Property Act 1925, the Landlord and Tenant Act 1985 and the Tenant Fees Act 2019.'),
    maxDepositMonths: null, // 5 weeks under £50k p.a.; 6 weeks above
    defaultTermMonths: 12,
    jurisdictionLabel: LB.en('England & Wales (unless stated otherwise)'),
    regulator: LB.en('Property Ombudsman / National Trading Standards'),
    paymentConfig: PC.stripe({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      regulatoryNotes: 'Surcharge prohibited for consumer cards in UK. Early capture not recommended due to Tenant Fees Act 2019.',
    }),
  },
  [RegionCode.DE]: {
    countryCode: RegionCode.DE,
    countryNameEn: 'Germany',
    countryNameNative: 'Deutschland',
    currency: 'EUR',
    currencySymbol: '€',
    officialLanguages: [ContractLanguage.DE],
    defaultLanguage: ContractLanguage.DE,
    legalBasis: LB.de(
      'in accordance with the German Civil Code (BGB) and the Bestellerprinzip (2015).',
      'gemäß dem Bürgerlichen Gesetzbuch (BGB) und dem Bestellerprinzip (2015).'
    ),
    maxDepositMonths: 3,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.de('Germany (Bundesrepublik Deutschland)', 'Bundesrepublik Deutschland'),
    regulator: LB.de('State real estate associations (Immobilienverband)', 'Immobilienverband Deutschland'),
    paymentConfig: PC.adyen({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      localPaymentMethods: ['SEPA', 'Sofort'],
      regulatoryNotes: 'Surcharge prohibited in EU. Early capture not recommended due to German tenancy laws.',
    }),
  },
  [RegionCode.FR]: {
    countryCode: RegionCode.FR,
    countryNameEn: 'France',
    countryNameNative: 'France',
    currency: 'EUR',
    currencySymbol: '€',
    officialLanguages: [ContractLanguage.FR],
    defaultLanguage: ContractLanguage.FR,
    legalBasis: LB.fr(
      'in accordance with the Civil Code and Loi ALUR (2014).',
      'conformément au Code civil et à la loi ALUR (2014).'
    ),
    maxDepositMonths: 1,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.fr('France', 'France'),
    regulator: LB.fr('Autorité de contrôle (DGALN / local préfecture)', 'Autorité de contrôle (DGALN / préfecture)'),
    paymentConfig: PC.adyen({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      regulatoryNotes: 'Surcharge prohibited in EU. Early capture not recommended due to Loi ALUR (2014).',
    }),
  },
  [RegionCode.ES]: {
    countryCode: RegionCode.ES,
    countryNameEn: 'Spain',
    countryNameNative: 'España',
    currency: 'EUR',
    currencySymbol: '€',
    officialLanguages: [ContractLanguage.ES],
    defaultLanguage: ContractLanguage.ES,
    legalBasis: LB.es(
      'in accordance with Ley 29/1994 (LAU) and Ley 12/2023 on housing.',
      'de conformidad con la Ley 29/1994 (LAU) y la Ley 12/2023 de vivienda.'
    ),
    maxDepositMonths: 3,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.es('Spain', 'España'),
    regulator: LB.es('Colegios de Agentes de la Propiedad Inmobiliaria', 'Colegios de Agentes de la Propiedad Inmobiliaria'),
    paymentConfig: PC.adyen({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      regulatoryNotes: 'Surcharge prohibited in EU. Early capture not recommended due to Ley 29/1994 (LAU).',
    }),
  },
  [RegionCode.IT]: {
    countryCode: RegionCode.IT,
    countryNameEn: 'Italy',
    countryNameNative: 'Italia',
    currency: 'EUR',
    currencySymbol: '€',
    officialLanguages: [ContractLanguage.IT],
    defaultLanguage: ContractLanguage.IT,
    legalBasis: LB.it(
      'in accordance with the Italian Civil Code (Codice Civile), L. 392/1978 and L. 431/1998.',
      'ai sensi del Codice Civile italiano, della L. 392/1978 e della L. 431/1998.'
    ),
    maxDepositMonths: 3,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.it('Italy (Repubblica Italiana)', 'Italia (Repubblica Italiana)'),
    regulator: LB.it('FIMAA / local chamber of commerce', 'FIMAA / camera di commercio locale'),
    paymentConfig: PC.adyen({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      regulatoryNotes: 'Surcharge prohibited in EU. Early capture not recommended due to Italian tenancy laws.',
    }),
  },
  [RegionCode.NL]: {
    countryCode: RegionCode.NL,
    countryNameEn: 'Netherlands',
    countryNameNative: 'Nederland',
    currency: 'EUR',
    currencySymbol: '€',
    officialLanguages: [ContractLanguage.NL],
    defaultLanguage: ContractLanguage.NL,
    legalBasis: LB.nl(
      'in accordance with the Dutch Civil Code (Burgerlijk Wetboek) Book 7 and the Middenhuur regulations.',
      'overeenkomstig het Nederlands Burgerlijk Wetboek Boek 7 en de Middenhuurregeling.'
    ),
    maxDepositMonths: 2,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.nl('Netherlands (Koninkrijk der Nederlanden)', 'Nederland'),
    regulator: LB.nl('NVM / VBO Makelaar', 'NVM / VBO Makelaar'),
    paymentConfig: PC.adyen({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      localPaymentMethods: ['iDEAL'],
      regulatoryNotes: 'Surcharge prohibited in EU. Early capture not recommended due to Dutch tenancy laws.',
    }),
  },
  [RegionCode.BR]: {
    countryCode: RegionCode.BR,
    countryNameEn: 'Brazil',
    countryNameNative: 'Brasil',
    currency: 'BRL',
    currencySymbol: 'R$',
    officialLanguages: [ContractLanguage.PT],
    defaultLanguage: ContractLanguage.PT,
    legalBasis: LB.pt(
      'in accordance with the Lei do Inquilinato (Lei 8.245/91) and the Civil Code (Lei 10.406/2002).',
      'de acordo com a Lei do Inquilinato (Lei 8.245/91) e o Código Civil (Lei 10.406/2002).'
    ),
    maxDepositMonths: 3,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.pt('Brazil (Federative Republic of Brazil)', 'Brasil (República Federativa do Brasil)'),
    regulator: LB.pt('CRECI (Conselho Regional de Corretores)', 'CRECI (Conselho Regional de Corretores)'),
    paymentConfig: PC.stripe({
      surchargeAllowed: true,
      maxSurchargePercent: 3,
      earlyCaptureDays: 7,
      localPaymentMethods: ['PIX', 'Boleto'],
      regulatoryNotes: 'Surcharge allowed with disclosure. Early capture up to 7 days before due date. Verify with Brazilian legal counsel.',
    }),
  },
  [RegionCode.AR]: {
    countryCode: RegionCode.AR,
    countryNameEn: 'Argentina',
    countryNameNative: 'Argentina',
    currency: 'ARS',
    currencySymbol: '$',
    officialLanguages: [ContractLanguage.ES],
    defaultLanguage: ContractLanguage.ES,
    legalBasis: LB.es(
      'in accordance with the National Civil and Commercial Code and Ley 27.551 (Ley de Alquileres).',
      'de conformidad con el Código Civil y Comercial de la Nación y la Ley 27.551 (Ley de Alquileres).'
    ),
    maxDepositMonths: 1,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.es('Argentina (República Argentina)', 'Argentina'),
    regulator: LB.es('CUCICBA / provincial real-estate councils', 'CUCICBA / consejos provinciales'),
    paymentConfig: PC.stripe({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      regulatoryNotes: 'Surcharge generally prohibited in Argentina. Early capture not recommended due to Ley 27.551 (Ley de Alquileres).',
    }),
  },
  [RegionCode.AU]: {
    countryCode: RegionCode.AU,
    countryNameEn: 'Australia',
    countryNameNative: 'Australia',
    currency: 'AUD',
    currencySymbol: 'A$',
    officialLanguages: [ContractLanguage.EN],
    defaultLanguage: ContractLanguage.EN,
    legalBasis: LB.en('in accordance with state residential tenancy legislation (e.g. Residential Tenancies Act, NSW/VIC/QLD).'),
    maxDepositMonths: 1,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.en('Australia (state of the property)'),
    regulator: LB.en('State real-estate agents board (e.g. NSW Fair Trading)'),
    paymentConfig: PC.stripe({
      surchargeAllowed: true,
      maxSurchargePercent: 2,
      earlyCaptureDays: 7,
      regulatoryNotes: 'Surcharge allowed with disclosure in Australia. Early capture up to 7 days before due date. Verify with Australian legal counsel.',
    }),
  },
  [RegionCode.NZ]: {
    countryCode: RegionCode.NZ,
    countryNameEn: 'New Zealand',
    countryNameNative: 'New Zealand',
    currency: 'NZD',
    currencySymbol: 'NZ$',
    officialLanguages: [ContractLanguage.EN],
    defaultLanguage: ContractLanguage.EN,
    legalBasis: LB.en('in accordance with the Residential Tenancies Act 1986 and the Real Estate Agents Act 2008.'),
    maxDepositMonths: 2,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.en('New Zealand (Aotearoa)'),
    regulator: LB.en('Real Estate Authority (REA) / Tenancy Services'),
    paymentConfig: PC.stripe({
      surchargeAllowed: true,
      maxSurchargePercent: 2,
      earlyCaptureDays: 7,
      regulatoryNotes: 'Surcharge allowed with disclosure in New Zealand. Early capture up to 7 days before due date. Verify with NZ legal counsel.',
    }),
  },
  [RegionCode.JP]: {
    countryCode: RegionCode.JP,
    countryNameEn: 'Japan',
    countryNameNative: '日本',
    currency: 'JPY',
    currencySymbol: '¥',
    officialLanguages: [ContractLanguage.JA],
    defaultLanguage: ContractLanguage.JA,
    legalBasis: LB.ja(
      'in accordance with the Japanese Civil Code and the Real Estate Transaction Business Act (宅建業法).',
      '日本の民法および宅地建物取引業法に基づく。'
    ),
    maxDepositMonths: 2,
    defaultTermMonths: 24,
    jurisdictionLabel: LB.ja('Japan (日本国)', '日本'),
    regulator: LB.ja('Ministry of Land, Infrastructure, Transport and Tourism (MLIT)', '国土交通省 (MLIT)'),
    paymentConfig: PC.stripe({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      localPaymentMethods: ['Line Pay', 'PayPay', 'Rakuten Pay'],
      regulatoryNotes: 'Surcharge generally prohibited in Japan. Early capture not recommended due to Japanese tenancy laws.',
    }),
  },
  [RegionCode.KR]: {
    countryCode: RegionCode.KR,
    countryNameEn: 'South Korea',
    countryNameNative: '대한민국',
    currency: 'KRW',
    currencySymbol: '₩',
    officialLanguages: [ContractLanguage.KO],
    defaultLanguage: ContractLanguage.KO,
    legalBasis: LB.ko(
      'in accordance with the Housing Lease Protection Act (주택임대차보호법) and the Civil Act.',
      '주택임대차보호법 및 민법에 따라.'
    ),
    maxDepositMonths: null, // Jeonse (전세) model
    defaultTermMonths: 24,
    jurisdictionLabel: LB.ko('Republic of Korea (대한민국)', '대한민국'),
    regulator: LB.ko('Ministry of Land, Infrastructure and Transport', '국토교통부'),
    paymentConfig: PC.stripe({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      localPaymentMethods: ['Kakao Pay', 'Naver Pay', 'Toss'],
      regulatoryNotes: 'Surcharge generally prohibited in South Korea. Early capture not recommended due to Jeonse system regulations.',
    }),
  },
  [RegionCode.CN]: {
    countryCode: RegionCode.CN,
    countryNameEn: 'China',
    countryNameNative: '中国',
    currency: 'CNY',
    currencySymbol: '¥',
    officialLanguages: [ContractLanguage.ZH],
    defaultLanguage: ContractLanguage.ZH,
    legalBasis: LB.zh(
      'in accordance with the Civil Code of the People\'s Republic of China and applicable housing regulations.',
      '根据《中华人民共和国民法典》及相关住房规定。'
    ),
    maxDepositMonths: 1,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.zh('People\'s Republic of China (中华人民共和国)', '中华人民共和国'),
    regulator: LB.zh('Ministry of Housing and Urban-Rural Development', '住房和城乡建设部'),
    paymentConfig: PC.stripe({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      localPaymentMethods: ['Alipay', 'WeChat Pay'],
      regulatoryNotes: 'Surcharge generally prohibited in China. Early capture not recommended due to Chinese housing regulations.',
    }),
  },
  [RegionCode.IN]: {
    countryCode: RegionCode.IN,
    countryNameEn: 'India',
    countryNameNative: 'भारत',
    currency: 'INR',
    currencySymbol: '₹',
    officialLanguages: [ContractLanguage.HI, ContractLanguage.EN],
    defaultLanguage: ContractLanguage.HI,
    legalBasis: LB.hi(
      'in accordance with the Model Tenancy Act 2021, the Indian Contract Act 1872 and applicable state RERA regulations.',
      'मॉडल किराया अधिनियम 2021, भारतीय अनुबंध अधिनियम 1872 और लागू राज्य RERA विनियमों के अनुसार।'
    ),
    maxDepositMonths: 3,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.hi('India (भारत)', 'भारत'),
    regulator: LB.hi('State RERA authorities', 'राज्य RERA प्राधिकरण'),
    paymentConfig: PC.stripe({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      localPaymentMethods: ['UPI', 'Paytm', 'PhonePe'],
      regulatoryNotes: 'Surcharge generally prohibited in India. Early capture not recommended due to Model Tenancy Act 2021.',
    }),
  },
  [RegionCode.SG]: {
    countryCode: RegionCode.SG,
    countryNameEn: 'Singapore',
    countryNameNative: 'Singapore',
    currency: 'SGD',
    currencySymbol: 'S$',
    officialLanguages: [ContractLanguage.EN],
    defaultLanguage: ContractLanguage.EN,
    legalBasis: LB.en('in accordance with the Estate Agents Act and the Council for Estate Agencies (CEA) rules.'),
    maxDepositMonths: 2,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.en('Republic of Singapore'),
    regulator: LB.en('Council for Estate Agencies (CEA)'),
    paymentConfig: PC.stripe({
      surchargeAllowed: true,
      maxSurchargePercent: 2,
      earlyCaptureDays: 7,
      localPaymentMethods: ['PayNow'],
      regulatoryNotes: 'Surcharge allowed with disclosure in Singapore. Early capture up to 7 days before due date. Verify with Singapore legal counsel.',
    }),
  },
  [RegionCode.MY]: {
    countryCode: RegionCode.MY,
    countryNameEn: 'Malaysia',
    countryNameNative: 'Malaysia',
    currency: 'MYR',
    currencySymbol: 'RM',
    officialLanguages: [ContractLanguage.MS, ContractLanguage.EN],
    defaultLanguage: ContractLanguage.MS,
    legalBasis: LB.ms(
      'in accordance with the Valuers, Appraisers, Estate Agents and Property Managers Act 1981 and the Contracts Act 1950.',
      'mengikut Akta Penilai, Juruukur, Ejen Hartanah dan Pengurus Harta 1981 dan Akta Kontrak 1950.'
    ),
    maxDepositMonths: 2,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.ms('Malaysia', 'Malaysia'),
    regulator: LB.ms('Board of Valuers, Appraisers, Estate Agents and Property Managers (BOVAEA)', 'Lembaga Penilai, Juruukur, Ejen Hartanah dan Pengurus Harta (BOVAEA)'),
    paymentConfig: PC.stripe({
      surchargeAllowed: true,
      maxSurchargePercent: 3,
      earlyCaptureDays: 7,
      localPaymentMethods: ['FPX'],
      regulatoryNotes: 'Surcharge allowed with disclosure in Malaysia. Early capture up to 7 days before due date. Verify with Malaysian legal counsel.',
    }),
  },
  [RegionCode.TH]: {
    countryCode: RegionCode.TH,
    countryNameEn: 'Thailand',
    countryNameNative: 'ประเทศไทย',
    currency: 'THB',
    currencySymbol: '฿',
    officialLanguages: [ContractLanguage.TH],
    defaultLanguage: ContractLanguage.TH,
    legalBasis: LB.th(
      'in accordance with the Civil and Commercial Code of Thailand and the regulations of the Land Department.',
      'ตามประมวลกฎหมายแพ่งและพาณิชย์ของประเทศไทยและระเบียบกรมที่ดิน'
    ),
    maxDepositMonths: 3,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.th('Kingdom of Thailand (ราชอาณาจักรไทย)', 'ราชอาณาจักรไทย'),
    regulator: LB.th('Department of Land (กรมที่ดิน)', 'กรมที่ดิน'),
    paymentConfig: PC.stripe({
      surchargeAllowed: true,
      maxSurchargePercent: 3,
      earlyCaptureDays: 7,
      localPaymentMethods: ['PromptPay'],
      regulatoryNotes: 'Surcharge allowed with disclosure in Thailand. Early capture up to 7 days before due date. Verify with Thai legal counsel.',
    }),
  },
  [RegionCode.AE]: {
    countryCode: RegionCode.AE,
    countryNameEn: 'United Arab Emirates',
    countryNameNative: 'الإمارات العربية المتحدة',
    currency: 'AED',
    currencySymbol: 'د.إ',
    officialLanguages: [ContractLanguage.AR, ContractLanguage.EN],
    defaultLanguage: ContractLanguage.EN,
    legalBasis: LB.ar(
      'in accordance with UAE law, RERA regulations and Dubai Land Department (DLD) requirements.',
      'وفقاً لقوانين دولة الإمارات العربية المتحدة ولوائح مؤسسة التنظيم العقاري (ريرا) ومتطلبات دائرة الأراضي والأملاك في دبي.'
    ),
    maxDepositMonths: 1,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.ar('United Arab Emirates (الإمارات العربية المتحدة)', 'الإمارات العربية المتحدة'),
    regulator: LB.ar('Dubai Land Department / RERA (Dubai)', 'دائرة الأراضي والأملاك / مؤسسة التنظيم العقاري (ريرا)'),
    paymentConfig: PC.checkout({
      surchargeAllowed: true,
      maxSurchargePercent: 3,
      earlyCaptureDays: 7,
      localPaymentMethods: ['Apple Pay', 'local bank transfer'],
      regulatoryNotes: 'Surcharge allowed with disclosure in UAE. Early capture up to 7 days before due date. Checkout.com has strong MENA presence. Verify with UAE legal counsel.',
    }),
  },
  [RegionCode.SA]: {
    countryCode: RegionCode.SA,
    countryNameEn: 'Saudi Arabia',
    countryNameNative: 'المملكة العربية السعودية',
    currency: 'SAR',
    currencySymbol: 'ر.س',
    officialLanguages: [ContractLanguage.AR],
    defaultLanguage: ContractLanguage.AR,
    legalBasis: LB.ar(
      'in accordance with the Saudi Civil Transactions Law, the Real Estate General Authority (REGA) regulations and Vision 2030 housing initiatives.',
      'وفقاً لنظام المعاملات المدنية السعودي ولوائح الهيئة العامة للعقار ومبادرات الإسكان لرؤية 2030.'
    ),
    maxDepositMonths: 1,
    defaultTermMonths: 12,
    jurisdictionLabel: LB.ar('Kingdom of Saudi Arabia (المملكة العربية السعودية)', 'المملكة العربية السعودية'),
    regulator: LB.ar('Real Estate General Authority (REGA) / الهيئة العامة للعقار', 'الهيئة العامة للعقار'),
    paymentConfig: PC.adyen({
      surchargeAllowed: false,
      earlyCaptureDays: 0,
      localPaymentMethods: ['Mada', 'Apple Pay'],
      regulatoryNotes: 'Surcharge generally prohibited in Saudi Arabia. Early capture not recommended due to Saudi housing regulations. Adyen has strong MENA presence.',
    }),
  },
};

// Alias map so 'US' resolves to the USA profile (RegionCode.USA).
export const COUNTRY_CODE_ALIASES: Record<string, RegionCode> = {
  US: RegionCode.USA,
  USA: RegionCode.USA,
  UK: RegionCode.UK,
  GB: RegionCode.UK,
};

export function resolveCountryCode(code: string): RegionCode | null {
  const upper = code.toUpperCase();
  if (upper in COUNTRY_CONTRACT_PROFILES) return upper as RegionCode;
  if (upper in COUNTRY_CODE_ALIASES) return COUNTRY_CODE_ALIASES[upper];
  return null;
}

export function getCountryProfile(countryCode: string | RegionCode): CountryContractProfile | null {
  const resolved = resolveCountryCode(countryCode);
  if (!resolved) return null;
  return COUNTRY_CONTRACT_PROFILES[resolved] ?? null;
}

export const SUPPORTED_COUNTRY_CODES: RegionCode[] = Object.keys(COUNTRY_CONTRACT_PROFILES) as RegionCode[];

export function getSupportedCountryProfiles(): CountryContractProfile[] {
  return Object.values(COUNTRY_CONTRACT_PROFILES).filter(Boolean) as CountryContractProfile[];
}
