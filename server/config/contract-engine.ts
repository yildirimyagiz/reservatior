// server/config/contract-engine.ts
// AI-Driven Legal Document & Smart Contract Generator
//
// Supports:
//   - 23 countries (TR, US, CA, MX, UK, DE, FR, ES, IT, NL, BR, AR, AU, NZ,
//     JP, KR, CN, IN, SG, MY, TH, AE, SA)
//   - 16 contract languages (tr, en, ar, de, fr, es, it, ru, pt, ja, nl, ko,
//     zh, hi, th, ms)
//   - 8 contract types:
//       RESIDENTIAL_LEASE / COMMERCIAL_LEASE / SHORT_TERM_BOOKING /
//       SALES_AGREEMENT / EARNEST_MONEY / EVICTION_COMMITMENT /
//       AGENCY_REPRESENTATION (platform ⇄ realtor/agent) /
//       PROPERTY_MANAGEMENT (platform ⇄ property owner)
//   - 3 commission models: INSTALLMENT_12 / HYBRID_50_6 / TRADITIONAL_1M
//
// Country legal profiles live in ./country-contract-config.ts.

import { RegionCode } from './ai-yield-optimization';
import {
  ContractLanguage,
  CONTRACT_LANGUAGE_NAMES,
  COUNTRY_CONTRACT_PROFILES,
  SUPPORTED_COUNTRY_CODES,
  getCountryProfile,
} from './country-contract-config';

// Re-export language helpers so existing imports keep working.
export { ContractLanguage, CONTRACT_LANGUAGE_NAMES };

// Commission models (inline to avoid circular import)
export enum ContractCommissionModel {
  INSTALLMENT_12  = 'INSTALLMENT_12',   // A: 12 ay %4/ay carry + %2 platform
  HYBRID_50_6     = 'HYBRID_50_6',      // B: %50 pesin + %60'i 6 taksit + %2 platform
  TRADITIONAL_1M  = 'TRADITIONAL_1M',   // C: 1 ay kira pesinen + %2 platform
}

export enum ContractType {
  RESIDENTIAL_LEASE    = 'RESIDENTIAL_LEASE',
  COMMERCIAL_LEASE     = 'COMMERCIAL_LEASE',
  SHORT_TERM_BOOKING   = 'SHORT_TERM_BOOKING',
  SALES_AGREEMENT      = 'SALES_AGREEMENT',
  EARNEST_MONEY        = 'EARNEST_MONEY',
  EVICTION_COMMITMENT  = 'EVICTION_COMMITMENT',
  AGENCY_REPRESENTATION = 'AGENCY_REPRESENTATION',
  PROPERTY_MANAGEMENT   = 'PROPERTY_MANAGEMENT',
}

export const CONTRACT_TYPE_LABELS: Record<ContractType, Partial<Record<ContractLanguage, string>>> = {
  [ContractType.RESIDENTIAL_LEASE]: {
    [ContractLanguage.EN]: 'Residential Lease',
    [ContractLanguage.TR]: 'Konut Kira Sözleşmesi',
    [ContractLanguage.AR]: 'عقد إيجار سكني',
  },
  [ContractType.COMMERCIAL_LEASE]: {
    [ContractLanguage.EN]: 'Commercial Lease',
    [ContractLanguage.TR]: 'Ticari Kira Sözleşmesi',
    [ContractLanguage.AR]: 'عقد إيجار تجاري',
  },
  [ContractType.SHORT_TERM_BOOKING]: {
    [ContractLanguage.EN]: 'Short-Term Rental Agreement',
    [ContractLanguage.TR]: 'Kısa Dönem Konaklama Sözleşmesi',
    [ContractLanguage.AR]: 'اتفاقية إيجار قصير الأجل',
  },
  [ContractType.SALES_AGREEMENT]: {
    [ContractLanguage.EN]: 'Property Sale Agreement',
    [ContractLanguage.TR]: 'Gayrimenkul Satış Sözleşmesi',
    [ContractLanguage.AR]: 'عقد بيع العقار',
  },
  [ContractType.EARNEST_MONEY]: {
    [ContractLanguage.EN]: 'Earnest Money / Reservation Agreement',
    [ContractLanguage.TR]: 'Kaparo ve Rezervasyon Sözleşmesi',
    [ContractLanguage.AR]: 'اتفاقية عربون وحجز',
  },
  [ContractType.EVICTION_COMMITMENT]: {
    [ContractLanguage.EN]: 'Vacating Commitment',
    [ContractLanguage.TR]: 'Tahliye Taahhütnamesi',
    [ContractLanguage.AR]: 'تعهد بالإخلاء',
  },
  [ContractType.AGENCY_REPRESENTATION]: {
    [ContractLanguage.EN]: 'Agency & Representation Agreement',
    [ContractLanguage.TR]: 'Emlak Yetki ve Temsil Sözleşmesi',
    [ContractLanguage.AR]: 'اتفاقية وكالة وتمثيل',
  },
  [ContractType.PROPERTY_MANAGEMENT]: {
    [ContractLanguage.EN]: 'Property Management Service Agreement',
    [ContractLanguage.TR]: 'Gayrimenkul Yönetim Hizmet Sözleşmesi',
    [ContractLanguage.AR]: 'اتفاقية خدمات إدارة العقارات',
  },
};

export interface ContractData {
  property: {
    id: string;
    address: string;
    city: string;
    parcelId?: string;
    type: string;
  };
  landlordOrSeller: {
    fullName: string;
    nationalIdOrTaxNo: string;
    address: string;
  };
  tenantOrBuyer: {
    fullName: string;
    nationalIdOrTaxNo: string;
    address: string;
  };
  agent?: {
    fullName: string;
    licenseNo: string;
    commissionRate: number;
    agencyName?: string;
  };
  platform?: {
    fullName: string;
    registrationNo?: string;
    address?: string;
  };
  financials: {
    price: number;
    currency: string;
    depositAmount?: number;
    startDate: string;
    endDate?: string;
    termMonths?: number;
    isZeroDeposit: boolean;
    commissionModel?: ContractCommissionModel;
    commissionTotal?: number;
    platformInsuranceFee?: number;
    commissionInstallments?: number;
    monthlyInstallment?: number;
    downPayment?: number;
    landlordFeeLabel?: string;
    tenantFeeLabel?: string;
    loadShiftedToLandlord?: boolean;
    managementFeePct?: number;
    serviceFeePct?: number;
  };
  legal?: {
    officialLanguage?: ContractLanguage;
    additionalLanguage?: ContractLanguage;
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Localized phrase library (boilerplate section titles & labels).
// Official languages of every supported country are covered; the engine falls
// back to English for any language lacking a phrase.
// ─────────────────────────────────────────────────────────────────────────────
interface Phrases {
  officialNote: string;
  dateLabel: string;
  partiesTitle: string;
  landlordLabel: string;
  tenantLabel: string;
  sellerLabel: string;
  buyerLabel: string;
  propertyTitle: string;
  propertyTypeLabel: string;
  addressLabel: string;
  rentLabel: string;
  priceLabel: string;
  termLabel: string;
  termUnit: string;
  startLabel: string;
  endLabel: string;
  depositTitle: string;
  commissionTitle: string;
  legalBasisTitle: string;
  governingLawTitle: string;
  disputeTitle: string;
  signaturesTitle: string;
  additionalTitle: string;
  saleWarrantyTitle: string;
  servicesTitle: string;
  managementFeeTitle: string;
  agentTitle: string;
  agentLabel: string;
  licenseLabel: string;
  commissionRateLabel: string;
  escrowTitle: string;
  governingLawNote: string;
  disputeNote: string;
  zeroDepositClause: string;
  depositClause: string;
}

const P: Record<ContractLanguage, Phrases> = {
  [ContractLanguage.EN]: {
    officialNote: '<p><em>This is a computer-generated agreement. Please review with a qualified professional before signing.</em></p>',
    dateLabel: 'Date',
    partiesTitle: 'The Parties',
    landlordLabel: 'Landlord',
    tenantLabel: 'Tenant',
    sellerLabel: 'Seller',
    buyerLabel: 'Buyer',
    propertyTitle: 'Property',
    propertyTypeLabel: 'Property Type',
    addressLabel: 'Address',
    rentLabel: 'Rent',
    priceLabel: 'Purchase Price',
    termLabel: 'Term',
    termUnit: 'months',
    startLabel: 'Start Date',
    endLabel: 'End Date',
    depositTitle: 'Security Deposit',
    commissionTitle: 'Commission & Fees',
    legalBasisTitle: 'Legal Basis',
    governingLawTitle: 'Governing Law & Jurisdiction',
    disputeTitle: 'Dispute Resolution',
    signaturesTitle: 'Signatures',
    additionalTitle: 'Additional Terms',
    saleWarrantyTitle: 'Title & Condition Warranty',
    servicesTitle: 'Services',
    managementFeeTitle: 'Management Fee',
    agentTitle: 'Agent / Broker',
    agentLabel: 'Agent',
    licenseLabel: 'License No.',
    commissionRateLabel: 'Commission Rate',
    escrowTitle: 'Escrow & Payment',
    governingLawNote: 'This agreement is governed by the laws of {JURISDICTION}.',
    disputeNote: 'The parties shall first attempt to resolve disputes amicably through {PLATFORM} mediation before any legal action.',
    zeroDepositClause: 'The Tenant opted for a Zero-Deposit Surety Bond. No cash deposit is held. The policy is attached as an annex.',
    depositClause: 'A security deposit of {AMOUNT} {CURRENCY} is held in a regulated escrow account and returned subject to the terms of this agreement.',
  },
  [ContractLanguage.TR]: {
    officialNote: '<p><em>Bu sözleşme bilgisayar ortamında üretilmiştir. İmzalamadan önce lütfen yetkili bir profesyonelle inceleyiniz.</em></p>',
    dateLabel: 'Tarih',
    partiesTitle: 'Taraflar',
    landlordLabel: 'Kiraya Veren / Malik',
    tenantLabel: 'Kiracı',
    sellerLabel: 'Satıcı',
    buyerLabel: 'Alıcı',
    propertyTitle: 'Kiralanan / Taşınmaz',
    propertyTypeLabel: 'Taşınmaz Türü',
    addressLabel: 'Adres',
    rentLabel: 'Kira Bedeli',
    priceLabel: 'Satış Bedeli',
    termLabel: 'Süre',
    termUnit: 'ay',
    startLabel: 'Başlangıç Tarihi',
    endLabel: 'Bitiş Tarihi',
    depositTitle: 'Güvence Bedeli (Depozito)',
    commissionTitle: 'Komisyon ve Ücretler',
    legalBasisTitle: 'Yasal Dayanak',
    governingLawTitle: 'Uygulanacak Hukuk ve Yetki',
    disputeTitle: 'Uyuşmazlıkların Çözümü',
    signaturesTitle: 'İmzalar',
    additionalTitle: 'Ek Hükümler',
    saleWarrantyTitle: 'Mülkiyet ve İfraz Garantisi',
    servicesTitle: 'Hizmetler',
    managementFeeTitle: 'Yönetim Ücreti',
    agentTitle: 'Emlak Danışmanı / Komisyoncu',
    agentLabel: 'Danışman',
    licenseLabel: 'Lisans No',
    commissionRateLabel: 'Komisyon Oranı',
    escrowTitle: 'Escrow ve Ödeme',
    governingLawNote: 'Bu sözleşme {JURISDICTION} hukukuna tabidir.',
    disputeNote: 'Taraflar, hukuki yola başvurmadan önce uyuşmazlıkları {PLATFORM} arabuluculuğu ile çözmeye çalışacaklardır.',
    zeroDepositClause: 'Kiracı, nakit depozito yerine Kefalet/Kira Garanti Sigortası yaptırmıştır. Poliçe sözleşmenin ekidir.',
    depositClause: 'Güvence bedeli olarak {AMOUNT} {CURRENCY} düzenlenmiş bir escrow hesabında tutulur ve sözleşme hükümlerine göre iade edilir.',
  },
  [ContractLanguage.AR]: {
    officialNote: '<p><em>هذا العقد منشأ إلكترونياً. يرجى مراجعته مع مختص مؤهل قبل التوقيع.</em></p>',
    dateLabel: 'التاريخ',
    partiesTitle: 'الأطراف',
    landlordLabel: 'المؤجر / المالك',
    tenantLabel: 'المستأجر',
    sellerLabel: 'البائع',
    buyerLabel: 'المشتري',
    propertyTitle: 'العقار',
    propertyTypeLabel: 'نوع العقار',
    addressLabel: 'العنوان',
    rentLabel: 'الإيجار',
    priceLabel: 'ثمن البيع',
    termLabel: 'المدة',
    termUnit: 'أشهر',
    startLabel: 'تاريخ البدء',
    endLabel: 'تاريخ الانتهاء',
    depositTitle: 'مبلغ التأمين',
    commissionTitle: 'العمولة والرسوم',
    legalBasisTitle: 'الأساس القانوني',
    governingLawTitle: 'القانون الواجب التطبيق والاختصاص',
    disputeTitle: 'تسوية النزاعات',
    signaturesTitle: 'التوقيعات',
    additionalTitle: 'شروط إضافية',
    saleWarrantyTitle: 'ضمان الملكية والحالة',
    servicesTitle: 'الخدمات',
    managementFeeTitle: 'رسوم الإدارة',
    agentTitle: 'الوكيل / الوسيط',
    agentLabel: 'الوكيل',
    licenseLabel: 'رقم الرخصة',
    commissionRateLabel: 'نسبة العمولة',
    escrowTitle: 'الضمان والدفع',
    governingLawNote: 'يخضع هذا العقد لقوانين {JURISDICTION}.',
    disputeNote: 'يسعى الطرفان لحل النزاعات ودياً عبر وساطة {PLATFORM} قبل أي إجراء قانوني.',
    zeroDepositClause: 'اختار المستأجر سند ضمان بدلاً من التأمين النقدي. لا يتم الاحتفاظ بأي مبلغ نقدي. الوثيقة مرفقة.',
    depositClause: 'يتم الاحتفاظ بتأمين قدره {AMOUNT} {CURRENCY} في حساب ضمان منظم ويُعاد وفقاً لشروط هذا العقد.',
  },
  [ContractLanguage.DE]: {
    officialNote: '<p><em>Dieser Vertrag wurde computergeneriert. Bitte vor Unterzeichnung von einem Fachmann prüfen lassen.</em></p>',
    dateLabel: 'Datum',
    partiesTitle: 'Die Parteien',
    landlordLabel: 'Vermieter',
    tenantLabel: 'Mieter',
    sellerLabel: 'Verkäufer',
    buyerLabel: 'Käufer',
    propertyTitle: 'Mietobjekt',
    propertyTypeLabel: 'Objektart',
    addressLabel: 'Anschrift',
    rentLabel: 'Miete',
    priceLabel: 'Kaufpreis',
    termLabel: 'Laufzeit',
    termUnit: 'Monaten',
    startLabel: 'Beginn',
    endLabel: 'Ende',
    depositTitle: 'Kaution',
    commissionTitle: 'Provision & Gebühren',
    legalBasisTitle: 'Rechtsgrundlage',
    governingLawTitle: 'Anwendbares Recht & Gerichtsstand',
    disputeTitle: 'Streitbeilegung',
    signaturesTitle: 'Unterschriften',
    additionalTitle: 'Zusätzliche Bedingungen',
    saleWarrantyTitle: 'Eigentums- und Zustandsgarantie',
    servicesTitle: 'Leistungen',
    managementFeeTitle: 'Verwaltungsgebühr',
    agentTitle: 'Makler / Vermittler',
    agentLabel: 'Makler',
    licenseLabel: 'Lizenz-Nr.',
    commissionRateLabel: 'Provisionssatz',
    escrowTitle: 'Treuhand & Zahlung',
    governingLawNote: 'Dieser Vertrag unterliegt dem Recht von {JURISDICTION}.',
    disputeNote: 'Die Parteien versuchen Streitigkeiten zunächst im Wege einer {PLATFORM}-Vermittlung beizulegen.',
    zeroDepositClause: 'Der Mieter hat eine Kautionsbürgschaft gewählt. Es wird keine Barkaution hinterlegt.',
    depositClause: 'Eine Kaution von {AMOUNT} {CURRENCY} wird auf einem Treuhandkonto hinterlegt und gemäß den Vertragsbedingungen zurückgezahlt.',
  },
  [ContractLanguage.FR]: {
    officialNote: '<p><em>Ce contrat est généré électroniquement. Merci de le faire vérifier par un professionnel avant signature.</em></p>',
    dateLabel: 'Date',
    partiesTitle: 'Les Parties',
    landlordLabel: 'Bailleur',
    tenantLabel: 'Locataire',
    sellerLabel: 'Vendeur',
    buyerLabel: 'Acheteur',
    propertyTitle: 'Bien',
    propertyTypeLabel: 'Type de bien',
    addressLabel: 'Adresse',
    rentLabel: 'Loyer',
    priceLabel: 'Prix de vente',
    termLabel: 'Durée',
    termUnit: 'mois',
    startLabel: 'Début',
    endLabel: 'Fin',
    depositTitle: 'Dépôt de garantie',
    commissionTitle: 'Commission & Frais',
    legalBasisTitle: 'Base légale',
    governingLawTitle: 'Droit applicable & Juridiction',
    disputeTitle: 'Règlement des litiges',
    signaturesTitle: 'Signatures',
    additionalTitle: 'Conditions supplémentaires',
    saleWarrantyTitle: 'Garantie de titre et d’état',
    servicesTitle: 'Prestations',
    managementFeeTitle: 'Frais de gestion',
    agentTitle: 'Agent / Courtier',
    agentLabel: 'Agent',
    licenseLabel: 'N° de licence',
    commissionRateLabel: 'Taux de commission',
    escrowTitle: 'Séquestre & Paiement',
    governingLawNote: 'Le présent contrat est régi par le droit de {JURISDICTION}.',
    disputeNote: 'Les parties tenteront de résoudre les litiges à l’amiable via la médiation de {PLATFORM}.',
    zeroDepositClause: 'Le locataire a opté pour un dépôt de garantie numérique. Aucun dépôt en espèces.',
    depositClause: 'Un dépôt de garantie de {AMOUNT} {CURRENCY} est conservé sur un compte séquestre réglementé et restitué selon les termes du contrat.',
  },
  [ContractLanguage.ES]: {
    officialNote: '<p><em>Este contrato se ha generado electrónicamente. Revíselo con un profesional antes de firmar.</em></p>',
    dateLabel: 'Fecha',
    partiesTitle: 'Las Partes',
    landlordLabel: 'Arrendador',
    tenantLabel: 'Arrendatario',
    sellerLabel: 'Vendedor',
    buyerLabel: 'Comprador',
    propertyTitle: 'Inmueble',
    propertyTypeLabel: 'Tipo de inmueble',
    addressLabel: 'Dirección',
    rentLabel: 'Renta',
    priceLabel: 'Precio de venta',
    termLabel: 'Duración',
    termUnit: 'meses',
    startLabel: 'Inicio',
    endLabel: 'Fin',
    depositTitle: 'Fianza / Depósito',
    commissionTitle: 'Comisión y Honorarios',
    legalBasisTitle: 'Base Legal',
    governingLawTitle: 'Legislación Aplicable y Jurisdicción',
    disputeTitle: 'Resolución de Conflictos',
    signaturesTitle: 'Firmas',
    additionalTitle: 'Condiciones Adicionales',
    saleWarrantyTitle: 'Garantía de Título y Estado',
    servicesTitle: 'Servicios',
    managementFeeTitle: 'Honorarios de Gestión',
    agentTitle: 'Agente / Corredor',
    agentLabel: 'Agente',
    licenseLabel: 'Nº de licencia',
    commissionRateLabel: 'Tasa de comisión',
    escrowTitle: 'Depósito en Garantía y Pago',
    governingLawNote: 'Este contrato se rige por la legislación de {JURISDICTION}.',
    disputeNote: 'Las partes intentarán resolver las disputas de forma amistosa mediante la mediación de {PLATFORM}.',
    zeroDepositClause: 'El arrendatario optó por un seguro de caución. No se retiene depósito en efectivo.',
    depositClause: 'Se retiene una fianza de {AMOUNT} {CURRENCY} en una cuenta de depósito regulada, devuelta según los términos del contrato.',
  },
  [ContractLanguage.IT]: {
    officialNote: '<p><em>Il presente contratto è generato elettronicamente. Si prega di farlo esaminare da un professionista prima della firma.</em></p>',
    dateLabel: 'Data',
    partiesTitle: 'Le Parti',
    landlordLabel: 'Locatore',
    tenantLabel: 'Conduttore',
    sellerLabel: 'Venditore',
    buyerLabel: 'Acquirente',
    propertyTitle: 'Immobile',
    propertyTypeLabel: 'Tipologia',
    addressLabel: 'Indirizzo',
    rentLabel: 'Canone',
    priceLabel: 'Prezzo di vendita',
    termLabel: 'Durata',
    termUnit: 'mesi',
    startLabel: 'Inizio',
    endLabel: 'Fine',
    depositTitle: 'Deposito cauzionale',
    commissionTitle: 'Provvigione e Spese',
    legalBasisTitle: 'Base giuridica',
    governingLawTitle: 'Legge applicabile e Foro competente',
    disputeTitle: 'Risoluzione delle controversie',
    signaturesTitle: 'Firme',
    additionalTitle: 'Condizioni aggiuntive',
    saleWarrantyTitle: 'Garanzia di titolo e stato',
    servicesTitle: 'Servizi',
    managementFeeTitle: 'Spese di gestione',
    agentTitle: 'Agente / Mediatore',
    agentLabel: 'Agente',
    licenseLabel: 'N. licenza',
    commissionRateLabel: 'Tasso di provvigione',
    escrowTitle: 'Deposito di garanzia e Pagamento',
    governingLawNote: 'Il presente contratto è disciplinato dalla legge di {JURISDICTION}.',
    disputeNote: 'Le parti tenteranno di risolvere le controversie tramite la mediazione di {PLATFORM}.',
    zeroDepositClause: 'Il conduttore ha scelto una polizza cauzionale. Non è trattenuto alcun deposito in contanti.',
    depositClause: 'Un deposito cauzionale di {AMOUNT} {CURRENCY} è trattenuto su un conto escrow regolamentato.',
  },
  [ContractLanguage.RU]: {
    officialNote: '<p><em>Договор сгенерирован автоматически. Перед подписанием проконсультируйтесь со специалистом.</em></p>',
    dateLabel: 'Дата',
    partiesTitle: 'Стороны',
    landlordLabel: 'Арендодатель',
    tenantLabel: 'Арендатор',
    sellerLabel: 'Продавец',
    buyerLabel: 'Покупатель',
    propertyTitle: 'Объект',
    propertyTypeLabel: 'Тип объекта',
    addressLabel: 'Адрес',
    rentLabel: 'Арендная плата',
    priceLabel: 'Цена продажи',
    termLabel: 'Срок',
    termUnit: 'месяцев',
    startLabel: 'Начало',
    endLabel: 'Окончание',
    depositTitle: 'Обеспечительный депозит',
    commissionTitle: 'Комиссия и сборы',
    legalBasisTitle: 'Правовое основание',
    governingLawTitle: 'Применимое право и юрисдикция',
    disputeTitle: 'Разрешение споров',
    signaturesTitle: 'Подписи',
    additionalTitle: 'Дополнительные условия',
    saleWarrantyTitle: 'Гарантия права собственности и состояния',
    servicesTitle: 'Услуги',
    managementFeeTitle: 'Плата за управление',
    agentTitle: 'Агент / Брокер',
    agentLabel: 'Агент',
    licenseLabel: 'Номер лицензии',
    commissionRateLabel: 'Ставка комиссии',
    escrowTitle: 'Эскроу и оплата',
    governingLawNote: 'Настоящий договор регулируется законодательством {JURISDICTION}.',
    disputeNote: 'Стороны попытаются урегулировать споры путём посредничества {PLATFORM}.',
    zeroDepositClause: 'Арендатор выбрал поручительство вместо наличного депозита.',
    depositClause: 'Обеспечительный депозит {AMOUNT} {CURRENCY} хранится на регулируемом эскроу-счёте.',
  },
  [ContractLanguage.PT]: {
    officialNote: '<p><em>Este contrato foi gerado eletronicamente. Consulte um profissional antes de assinar.</em></p>',
    dateLabel: 'Data',
    partiesTitle: 'As Partes',
    landlordLabel: 'Locador',
    tenantLabel: 'Locatário',
    sellerLabel: 'Vendedor',
    buyerLabel: 'Comprador',
    propertyTitle: 'Imóvel',
    propertyTypeLabel: 'Tipo de imóvel',
    addressLabel: 'Endereço',
    rentLabel: 'Aluguel',
    priceLabel: 'Preço de venda',
    termLabel: 'Prazo',
    termUnit: 'meses',
    startLabel: 'Início',
    endLabel: 'Fim',
    depositTitle: 'Depósito de Garantia',
    commissionTitle: 'Comissão e Taxas',
    legalBasisTitle: 'Base Legal',
    governingLawTitle: 'Lei Aplicável e Jurisdição',
    disputeTitle: 'Resolução de Conflitos',
    signaturesTitle: 'Assinaturas',
    additionalTitle: 'Condições Adicionais',
    saleWarrantyTitle: 'Garantia de Título e Estado',
    servicesTitle: 'Serviços',
    managementFeeTitle: 'Taxa de Administração',
    agentTitle: 'Corretor',
    agentLabel: 'Corretor',
    licenseLabel: 'Nº da licença',
    commissionRateLabel: 'Taxa de comissão',
    escrowTitle: 'Caução e Pagamento',
    governingLawNote: 'Este contrato é regido pelas leis de {JURISDICTION}.',
    disputeNote: 'As partes tentarão resolver disputas amigavelmente por mediação da {PLATFORM}.',
    zeroDepositClause: 'O locatário optou por seguro-fiança. Nenhum depósito em dinheiro é retido.',
    depositClause: 'Um depósito de garantia de {AMOUNT} {CURRENCY} é mantido em conta escrow regulamentada.',
  },
  [ContractLanguage.JA]: {
    officialNote: '<p><em>この契約書は自動生成されています。署名前に専門家による確認をお勧めします。</em></p>',
    dateLabel: '日付',
    partiesTitle: '当事者',
    landlordLabel: '貸主',
    tenantLabel: '借主',
    sellerLabel: '売主',
    buyerLabel: '買主',
    propertyTitle: '物件',
    propertyTypeLabel: '物件種別',
    addressLabel: '住所',
    rentLabel: '賃料',
    priceLabel: '売買価格',
    termLabel: '期間',
    termUnit: 'ヶ月',
    startLabel: '開始日',
    endLabel: '終了日',
    depositTitle: '敷金',
    commissionTitle: '手数料',
    legalBasisTitle: '法的根拠',
    governingLawTitle: '準拠法および管轄',
    disputeTitle: '紛争解決',
    signaturesTitle: '署名',
    additionalTitle: 'その他の条件',
    saleWarrantyTitle: '所有権および状態の保証',
    servicesTitle: 'サービス',
    managementFeeTitle: '管理費',
    agentTitle: '仲介業者',
    agentLabel: '仲介',
    licenseLabel: '免許番号',
    commissionRateLabel: '手数料率',
    escrowTitle: 'エスクローと支払い',
    governingLawNote: '本契約は{JURISDICTION}の法律に準拠します。',
    disputeNote: '当事者は、法的措置の前に{PLATFORM}の調停により紛争解決を試みます。',
    zeroDepositClause: '借主は現金の敷金の代わりに保証保険を選択しました。',
    depositClause: '{AMOUNT} {CURRENCY}の敷金が規制エスクロー口座に預託されます。',
  },
  [ContractLanguage.NL]: {
    officialNote: '<p><em>Dit contract is automatisch gegenereerd. Laat het vóór ondertekening controleren door een professional.</em></p>',
    dateLabel: 'Datum',
    partiesTitle: 'Partijen',
    landlordLabel: 'Verhuurder',
    tenantLabel: 'Huurder',
    sellerLabel: 'Verkoper',
    buyerLabel: 'Koper',
    propertyTitle: 'Onroerend goed',
    propertyTypeLabel: 'Type woning',
    addressLabel: 'Adres',
    rentLabel: 'Huur',
    priceLabel: 'Koopprijs',
    termLabel: 'Looptijd',
    termUnit: 'maanden',
    startLabel: 'Aanvang',
    endLabel: 'Einde',
    depositTitle: 'Borg',
    commissionTitle: 'Courtage en kosten',
    legalBasisTitle: 'Rechtsgrondslag',
    governingLawTitle: 'Toepasselijk recht en jurisdictie',
    disputeTitle: 'Geschillenbeslechting',
    signaturesTitle: 'Handtekeningen',
    additionalTitle: 'Aanvullende voorwaarden',
    saleWarrantyTitle: 'Garantie van titel en staat',
    servicesTitle: 'Diensten',
    managementFeeTitle: 'Beheerfee',
    agentTitle: 'Makelaar',
    agentLabel: 'Makelaar',
    licenseLabel: 'Licentienummer',
    commissionRateLabel: 'Courtagepercentage',
    escrowTitle: 'Escrow en betaling',
    governingLawNote: 'Deze overeenkomst wordt beheerst door het recht van {JURISDICTION}.',
    disputeNote: 'Partijen proberen geschillen eerst via bemiddeling van {PLATFORM} op te lossen.',
    zeroDepositClause: 'De huurder koos voor een borgtocht. Er wordt geen contante borg aangehouden.',
    depositClause: 'Een borg van {AMOUNT} {CURRENCY} wordt aangehouden op een gereguleerde escrowrekening.',
  },
  [ContractLanguage.KO]: {
    officialNote: '<p><em>이 계약서는 자동 생성되었습니다. 서명 전에 전문가의 검토를 받으시기 바랍니다.</em></p>',
    dateLabel: '날짜',
    partiesTitle: '당사자',
    landlordLabel: '임대인',
    tenantLabel: '임차인',
    sellerLabel: '매도인',
    buyerLabel: '매수인',
    propertyTitle: '부동산',
    propertyTypeLabel: '부동산 유형',
    addressLabel: '주소',
    rentLabel: '임대료',
    priceLabel: '매매가',
    termLabel: '기간',
    termUnit: '개월',
    startLabel: '시작일',
    endLabel: '종료일',
    depositTitle: '보증금',
    commissionTitle: '수수료',
    legalBasisTitle: '법적 근거',
    governingLawTitle: '준거법 및 관할',
    disputeTitle: '분쟁 해결',
    signaturesTitle: '서명',
    additionalTitle: '추가 조건',
    saleWarrantyTitle: '소유권 및 상태 보증',
    servicesTitle: '서비스',
    managementFeeTitle: '관리 수수료',
    agentTitle: '중개인',
    agentLabel: '중개인',
    licenseLabel: '면허 번호',
    commissionRateLabel: '수수료율',
    escrowTitle: '에스크로 및 결제',
    governingLawNote: '이 계약은 {JURISDICTION}의 법률에 따릅니다.',
    disputeNote: '당사자는 법적 조치 전에 {PLATFORM}의 조정을 통해 분쟁 해결을 시도합니다.',
    zeroDepositClause: '임차인은 현금 보증금 대신 보증보험을 선택했습니다.',
    depositClause: '{AMOUNT} {CURRENCY}의 보증금이 규제된 에스크로 계좌에 보관됩니다.',
  },
  [ContractLanguage.ZH]: {
    officialNote: '<p><em>本合同为自动生成。签署前请咨询专业人士。</em></p>',
    dateLabel: '日期',
    partiesTitle: '合同双方',
    landlordLabel: '出租人',
    tenantLabel: '承租人',
    sellerLabel: '卖方',
    buyerLabel: '买方',
    propertyTitle: '物业',
    propertyTypeLabel: '物业类型',
    addressLabel: '地址',
    rentLabel: '租金',
    priceLabel: '售价',
    termLabel: '期限',
    termUnit: '个月',
    startLabel: '开始日期',
    endLabel: '结束日期',
    depositTitle: '押金',
    commissionTitle: '佣金及费用',
    legalBasisTitle: '法律依据',
    governingLawTitle: '适用法律与管辖',
    disputeTitle: '争议解决',
    signaturesTitle: '签署',
    additionalTitle: '附加条款',
    saleWarrantyTitle: '产权及状况保证',
    servicesTitle: '服务',
    managementFeeTitle: '管理费',
    agentTitle: '经纪人',
    agentLabel: '经纪人',
    licenseLabel: '许可证号',
    commissionRateLabel: '佣金率',
    escrowTitle: '托管与付款',
    governingLawNote: '本合同受{JURISDICTION}法律管辖。',
    disputeNote: '双方将先通过{PLATFORM}调解友好解决争议。',
    zeroDepositClause: '承租人选择投保担保而非现金押金。',
    depositClause: '{AMOUNT} {CURRENCY}押金存放于受监管的托管账户。',
  },
  [ContractLanguage.HI]: {
    officialNote: '<p><em>यह अनुबंध स्वचालित रूप से निर्मित है। हस्ताक्षर से पहले किसी विशेषज्ञ से समीक्षा कराएँ।</em></p>',
    dateLabel: 'तिथि',
    partiesTitle: 'पक्षकार',
    landlordLabel: 'मकान मालिक',
    tenantLabel: 'किरायेदार',
    sellerLabel: 'विक्रेता',
    buyerLabel: 'क्रेता',
    propertyTitle: 'संपत्ति',
    propertyTypeLabel: 'संपत्ति का प्रकार',
    addressLabel: 'पता',
    rentLabel: 'किराया',
    priceLabel: 'क्रय मूल्य',
    termLabel: 'अवधि',
    termUnit: 'महीने',
    startLabel: 'आरंभ तिथि',
    endLabel: 'समाप्ति तिथि',
    depositTitle: 'सुरक्षा जमा',
    commissionTitle: 'कमीशन और शुल्क',
    legalBasisTitle: 'कानूनी आधार',
    governingLawTitle: 'लागू कानून और अधिकारिता',
    disputeTitle: 'विवाद समाधान',
    signaturesTitle: 'हस्ताक्षर',
    additionalTitle: 'अतिरिक्त शर्तें',
    saleWarrantyTitle: 'स्वामित्व और स्थिति की गारंटी',
    servicesTitle: 'सेवाएँ',
    managementFeeTitle: 'प्रबंधन शुल्क',
    agentTitle: 'एजेंट / दलाल',
    agentLabel: 'एजेंट',
    licenseLabel: 'लाइसेंस संख्या',
    commissionRateLabel: 'कमीशन दर',
    escrowTitle: 'एस्क्रो और भुगतान',
    governingLawNote: 'यह अनुबंध {JURISDICTION} के कानूनों द्वारा नियंत्रित है।',
    disputeNote: 'पक्षकार कानूनी कार्रवाई से पहले {PLATFORM} मध्यस्थता से विवाद सुलझाने का प्रयास करेंगे।',
    zeroDepositClause: 'किरायेदार ने नकद जमा के बजाय गारंटी बांड चुना।',
    depositClause: '{AMOUNT} {CURRENCY} की सुरक्षा जमा विनियमित एस्क्रो खाते में रखी जाती है।',
  },
  [ContractLanguage.TH]: {
    officialNote: '<p><em>สัญญานี้ถูกสร้างโดยอัตโนมัติ กรุณาให้ผู้เชี่ยวชาญตรวจสอบก่อนลงนาม</em></p>',
    dateLabel: 'วันที่',
    partiesTitle: 'คู่สัญญา',
    landlordLabel: 'ผู้ให้เช่า',
    tenantLabel: 'ผู้เช่า',
    sellerLabel: 'ผู้ขาย',
    buyerLabel: 'ผู้ซื้อ',
    propertyTitle: 'ทรัพย์สิน',
    propertyTypeLabel: 'ประเภททรัพย์สิน',
    addressLabel: 'ที่อยู่',
    rentLabel: 'ค่าเช่า',
    priceLabel: 'ราคาซื้อขาย',
    termLabel: 'ระยะเวลา',
    termUnit: 'เดือน',
    startLabel: 'วันเริ่มต้น',
    endLabel: 'วันสิ้นสุด',
    depositTitle: 'เงินประกัน',
    commissionTitle: 'ค่านายหน้าและค่าธรรมเนียม',
    legalBasisTitle: 'พื้นฐานทางกฎหมาย',
    governingLawTitle: 'กฎหมายที่ใช้บังคับและเขตอำนาจ',
    disputeTitle: 'การระงับข้อพิพาท',
    signaturesTitle: 'ลายเซ็น',
    additionalTitle: 'ข้อกำหนดเพิ่มเติม',
    saleWarrantyTitle: 'การรับประกันกรรมสิทธิ์และสภาพ',
    servicesTitle: 'บริการ',
    managementFeeTitle: 'ค่าบริหารจัดการ',
    agentTitle: 'ตัวแทน / นายหน้า',
    agentLabel: 'ตัวแทน',
    licenseLabel: 'เลขที่ใบอนุญาต',
    commissionRateLabel: 'อัตราค่านายหน้า',
    escrowTitle: 'เอสโครว์และการชำระเงิน',
    governingLawNote: 'สัญญานี้อยู่ภายใต้กฎหมายของ {JURISDICTION}',
    disputeNote: 'คู่สัญญาจะพยายามระงับข้อพิพาทโดยการไกล่เกลี่ยของ {PLATFORM} ก่อนดำเนินคดี',
    zeroDepositClause: 'ผู้เช่าเลือกใช้หนังสือค้ำประกันแทนเงินประกันสด',
    depositClause: 'เงินประกัน {AMOUNT} {CURRENCY} ถูกเก็บไว้ในบัญชีเอสโครว์ตามระเบียบ',
  },
  [ContractLanguage.MS]: {
    officialNote: '<p><em>Kontrak ini dijana secara automatik. Sila dapatkan semakan profesional sebelum menandatangani.</em></p>',
    dateLabel: 'Tarikh',
    partiesTitle: 'Pihak-Pihak',
    landlordLabel: 'Tuan Rumah',
    tenantLabel: 'Penyewa',
    sellerLabel: 'Penjual',
    buyerLabel: 'Pembeli',
    propertyTitle: 'Hartanah',
    propertyTypeLabel: 'Jenis hartanah',
    addressLabel: 'Alamat',
    rentLabel: 'Sewa',
    priceLabel: 'Harga jualan',
    termLabel: 'Tempoh',
    termUnit: 'bulan',
    startLabel: 'Tarikh mula',
    endLabel: 'Tarikh tamat',
    depositTitle: 'Deposit Keselamatan',
    commissionTitle: 'Komisen dan Yuran',
    legalBasisTitle: 'Asas Undang-Undang',
    governingLawTitle: 'Undang-Undang dan Bidang Kuasa',
    disputeTitle: 'Penyelesaian Pertikaian',
    signaturesTitle: 'Tandatangan',
    additionalTitle: 'Terma Tambahan',
    saleWarrantyTitle: 'Jaminan Hak Milik dan Keadaan',
    servicesTitle: 'Perkhidmatan',
    managementFeeTitle: 'Yuran Pengurusan',
    agentTitle: 'Ejen / Broker',
    agentLabel: 'Ejen',
    licenseLabel: 'No. lesen',
    commissionRateLabel: 'Kadar komisen',
    escrowTitle: 'Eskrow dan Pembayaran',
    governingLawNote: 'Kontrak ini tertakluk kepada undang-undang {JURISDICTION}.',
    disputeNote: 'Pihak-pihak akan cuba menyelesaikan pertikaian melalui pengantaraan {PLATFORM}.',
    zeroDepositClause: 'Penyewa memilih ikatan jaminan dan bukannya deposit tunai.',
    depositClause: 'Deposit keselamatan {AMOUNT} {CURRENCY} dipegang dalam akaun eskrow terkawal.',
  },
};

const FALLBACK_PHRASES: Phrases = P[ContractLanguage.EN];

// ─────────────────────────────────────────────────────────────────────────────
// Commission model clause templates per language
// ─────────────────────────────────────────────────────────────────────────────
const CommissionModelClauses: Record<ContractCommissionModel, Partial<Record<ContractLanguage, string>>> = {
  [ContractCommissionModel.INSTALLMENT_12]: {
    [ContractLanguage.TR]: `Komisyon toplam {COMMISSION_TOTAL} {CURRENCY} olup {INSTALLMENTS} eşit aylık taksitte ödenir ({MONTHLY_INSTALLMENT} {CURRENCY}/ay). Aylık %4 taşıma bedeli uygulanır. %2 Platform Güvencesi ve Sigorta Bedeli ({PLATFORM_FEE} {CURRENCY}) ayrıca tahsil edilir.`,
    [ContractLanguage.EN]: `Commission totals {COMMISSION_TOTAL} {CURRENCY}, payable in {INSTALLMENTS} equal monthly installments of {MONTHLY_INSTALLMENT} {CURRENCY}. A 4% monthly carry fee applies. A 2% Platform Guarantee & Insurance Fee of {PLATFORM_FEE} {CURRENCY} is also collected.`,
    [ContractLanguage.AR]: `العمولة الكلية {COMMISSION_TOTAL} {CURRENCY}، تسدد على {INSTALLMENTS} قسطاً شهرياً بقيمة {MONTHLY_INSTALLMENT} {CURRENCY}. رسوم 4% شهرياً. ورسوم ضمان المنصة 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.DE]: `Die Provision beträgt insgesamt {COMMISSION_TOTAL} {CURRENCY}, zahlbar in {INSTALLMENTS} gleichen Monatsraten à {MONTHLY_INSTALLMENT} {CURRENCY}. Monatliche Bereitstellungsgebühr 4%. Plattformgebühr 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.FR]: `Commission totale {COMMISSION_TOTAL} {CURRENCY}, payable en {INSTALLMENTS} mensualités de {MONTHLY_INSTALLMENT} {CURRENCY}. Frais mensuels 4%. Frais plateforme 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.ES]: `Comisión total {COMMISSION_TOTAL} {CURRENCY}, pagadera en {INSTALLMENTS} cuotas de {MONTHLY_INSTALLMENT} {CURRENCY}/mes. Cargo mensual 4%. Tarifa plataforma 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.IT]: `Provvigione totale {COMMISSION_TOTAL} {CURRENCY}, pagabile in {INSTALLMENTS} rate mensili di {MONTHLY_INSTALLMENT} {CURRENCY}. Spese mensili 4%. Quota piattaforma 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.RU]: `Общая комиссия {COMMISSION_TOTAL} {CURRENCY}, выплачивается {INSTALLMENTS} равными платежами по {MONTHLY_INSTALLMENT} {CURRENCY}. Ежемесячный сбор 4%. Плата за платформу 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.PT]: `Comissão total {COMMISSION_TOTAL} {CURRENCY}, pagável em {INSTALLMENTS} parcelas de {MONTHLY_INSTALLMENT} {CURRENCY}. Taxa mensal 4%. Taxa plataforma 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.JA]: `手数料合計 {COMMISSION_TOTAL} {CURRENCY}、{INSTALLMENTS}回分割 {MONTHLY_INSTALLMENT} {CURRENCY}/月。月次4%運用手数料。プラットフォーム保証2% ({PLATFORM_FEE} {CURRENCY})。`,
    [ContractLanguage.NL]: `Courtage in totaal {COMMISSION_TOTAL} {CURRENCY}, betaalbaar in {INSTALLMENTS} gelijke maandtermijnen van {MONTHLY_INSTALLMENT} {CURRENCY}. Maandelijkse bereidstellingskosten 4%. Platformkosten 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.KO]: `수수료 합계 {COMMISSION_TOTAL} {CURRENCY}, {INSTALLMENTS}개월 균등 분할 ({MONTHLY_INSTALLMENT} {CURRENCY}/월). 월 4% 보관 수수료 적용. 플랫폼 보증료 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.ZH]: `佣金总额 {COMMISSION_TOTAL} {CURRENCY}，分{INSTALLMENTS}期等额月付（{MONTHLY_INSTALLMENT} {CURRENCY}/月）。每月4%管理费用。另收2%平台保障费（{PLATFORM_FEE} {CURRENCY}）。`,
    [ContractLanguage.HI]: `कुल कमीशन {COMMISSION_TOTAL} {CURRENCY}, {INSTALLMENTS} समान मासिक किश्तों में ({MONTHLY_INSTALLMENT} {CURRENCY}/माह)। मासिक 4% शुल्क लागू। 2% प्लेटफ़ॉर्म गारंटी शुल्क ({PLATFORM_FEE} {CURRENCY}) भी लिया जाता है।`,
    [ContractLanguage.TH]: `ค่านายหน้าทั้งหมด {COMMISSION_TOTAL} {CURRENCY} ผ่อนชำระ {INSTALLMENTS} งวด ({MONTHLY_INSTALLMENT} {CURRENCY}/เดือน) ค่าธรรมเนียม 4% ต่อเดือน และค่าธรรมเนียมแพลตฟอร์ม 2% ({PLATFORM_FEE} {CURRENCY})`,
    [ContractLanguage.MS]: `Komisen berjumlah {COMMISSION_TOTAL} {CURRENCY}, dibayar dalam {INSTALLMENTS} ansuran bulanan ({MONTHLY_INSTALLMENT} {CURRENCY}/bulan). Caj bulanan 4%. Yuran platform 2% ({PLATFORM_FEE} {CURRENCY}).`,
  },
  [ContractCommissionModel.HYBRID_50_6]: {
    [ContractLanguage.TR]: `Komisyonun %50'si ({DOWN_PAYMENT} {CURRENCY}) imzada peşinen Reservatior Escrow'a yatırılır. Kalan bakiye +%10 servis bedeliyle 6 taksitte ödenir ({MONTHLY_INSTALLMENT} {CURRENCY}/ay). %2 Platform Güvencesi ({PLATFORM_FEE} {CURRENCY}) peşinate dahildir. Bu model yaklaşık 1 aylık kira tutarını geçiş eşiği olarak kullanır.`,
    [ContractLanguage.EN]: `50% of commission ({DOWN_PAYMENT} {CURRENCY}) is due upfront into Reservatior Escrow at signing. The remaining balance + 10% service fee is paid over 6 installments of {MONTHLY_INSTALLMENT} {CURRENCY}/month. The 2% Platform & Insurance Fee ({PLATFORM_FEE} {CURRENCY}) is collected with the down payment. This model uses ~1 month rent as the transition threshold.`,
    [ContractLanguage.AR]: `50% من العمولة ({DOWN_PAYMENT} {CURRENCY}) مقدماً عند التوقيع. الباقي +10% على 6 أقساط ({MONTHLY_INSTALLMENT} {CURRENCY}/شهر). رسوم المنصة 2% ({PLATFORM_FEE} {CURRENCY}) مع الدفعة الأولى.`,
    [ContractLanguage.DE]: `50% der Provision ({DOWN_PAYMENT} {CURRENCY}) bei Unterzeichnung. Rest +10% auf 6 Raten ({MONTHLY_INSTALLMENT} {CURRENCY}/Monat). Plattformgebühr 2% ({PLATFORM_FEE} {CURRENCY}) mit Anzahlung.`,
    [ContractLanguage.FR]: `50% de commission ({DOWN_PAYMENT} {CURRENCY}) à la signature. Solde +10% sur 6 mensualités ({MONTHLY_INSTALLMENT} {CURRENCY}/mois). Frais plateforme 2% ({PLATFORM_FEE} {CURRENCY}) avec acompte.`,
    [ContractLanguage.ES]: `50% de comisión ({DOWN_PAYMENT} {CURRENCY}) al firmar. Resto +10% en 6 cuotas ({MONTHLY_INSTALLMENT} {CURRENCY}/mes). Tarifa plataforma 2% ({PLATFORM_FEE} {CURRENCY}) con pago inicial.`,
    [ContractLanguage.RU]: `50% комиссии ({DOWN_PAYMENT} {CURRENCY}) при подписании. Остаток +10% в 6 платежей ({MONTHLY_INSTALLMENT} {CURRENCY}/мес). Плата платформы 2% ({PLATFORM_FEE} {CURRENCY}) с авансом.`,
    [ContractLanguage.PT]: `50% da comissão ({DOWN_PAYMENT} {CURRENCY}) na assinatura. Saldo +10% em 6 parcelas ({MONTHLY_INSTALLMENT} {CURRENCY}/mês). Taxa plataforma 2% ({PLATFORM_FEE} {CURRENCY}) com entrada.`,
    [ContractLanguage.JA]: `手数料の50%（{DOWN_PAYMENT} {CURRENCY}）を署名時に前払い。残額+10%を6回分割（{MONTHLY_INSTALLMENT} {CURRENCY}/月）。プラットフォーム料2%（{PLATFORM_FEE} {CURRENCY}）は頭金と同時徴収。`,
    [ContractLanguage.NL]: `50% van de courtage ({DOWN_PAYMENT} {CURRENCY}) bij ondertekening. Rest +10% in 6 termijnen ({MONTHLY_INSTALLMENT} {CURRENCY}/maand). Platformkosten 2% ({PLATFORM_FEE} {CURRENCY}) met aanbetaling.`,
    [ContractLanguage.KO]: `수수료의 50%({DOWN_PAYMENT} {CURRENCY})는 서명 시 선불. 잔액+10%를 6회 분할({MONTHLY_INSTALLMENT} {CURRENCY}/월). 플랫폼 보증료 2%({PLATFORM_FEE} {CURRENCY})는 계약금과 함께.`,
  },
  [ContractCommissionModel.TRADITIONAL_1M]: {
    [ContractLanguage.TR]: `Komisyon olarak 1 aylık kira bedeli ({DOWN_PAYMENT} {CURRENCY}) imzada peşinen ödenir. %2 Platform Güvencesi ve Sigorta Bedeli ({PLATFORM_FEE} {CURRENCY}) ayrıca tahsil edilir.`,
    [ContractLanguage.EN]: `A commission equal to one month's rent ({DOWN_PAYMENT} {CURRENCY}) is due at signing. A 2% Platform Guarantee & Insurance Fee ({PLATFORM_FEE} {CURRENCY}) is also collected.`,
    [ContractLanguage.AR]: `عمولة تعادل شهر إيجار ({DOWN_PAYMENT} {CURRENCY}) عند التوقيع. رسوم منصة 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.DE]: `Provision in Höhe einer Monatsmiete ({DOWN_PAYMENT} {CURRENCY}) bei Unterzeichnung. Plattformgebühr 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.FR]: `Commission égale à un mois de loyer ({DOWN_PAYMENT} {CURRENCY}) à la signature. Frais plateforme 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.ES]: `Comisión equivalente a un mes de alquiler ({DOWN_PAYMENT} {CURRENCY}) al firmar. Tarifa plataforma 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.RU]: `Комиссия равная одному месяцу аренды ({DOWN_PAYMENT} {CURRENCY}) при подписании. Плата платформы 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.PT]: `Comissão equivalente a um mês de aluguel ({DOWN_PAYMENT} {CURRENCY}) na assinatura. Taxa plataforma 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.JA]: `署名時に1ヶ月分賃料（{DOWN_PAYMENT} {CURRENCY}）相当の手数料。プラットフォーム料2%（{PLATFORM_FEE} {CURRENCY}）も徴収。`,
    [ContractLanguage.NL]: `Courtage ter hoogte van één maand huur ({DOWN_PAYMENT} {CURRENCY}) bij ondertekening. Platformkosten 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.KO]: `계약금({DOWN_PAYMENT} {CURRENCY}) 1개월분 임대료에 해당하는 수수료. 플랫폼 보증료 2%({PLATFORM_FEE} {CURRENCY}).`,
  },
};

// ─────────────────────────────────────────────────────────────────────────────
// Template builder — composes a full localized HTML template for any
// country × type × language from the phrase library + country profile.
// Placeholders ({LANDLORD_NAME}, {PRICE}, ...) are filled by generateContract.
// ─────────────────────────────────────────────────────────────────────────────
type PhraseKey = keyof Phrases;

function phrase(lang: ContractLanguage, key: PhraseKey): string {
  return P[lang]?.[key] ?? FALLBACK_PHRASES[key];
}

interface TemplateComposerArgs {
  type: ContractType;
  region: RegionCode;
  language: ContractLanguage;
  ph: Phrases;
}

function composeTemplate(args: TemplateComposerArgs): string {
  const { type, region, language, ph } = args;
  const profile = COUNTRY_CONTRACT_PROFILES[region] ?? COUNTRY_CONTRACT_PROFILES[RegionCode.USA]!;
  const legalBasis =
    profile.legalBasis[language] ?? profile.legalBasis[profile.defaultLanguage] ?? profile.legalBasis[ContractLanguage.EN] ?? '';
  const jurisdiction =
    profile.jurisdictionLabel[language] ?? profile.jurisdictionLabel[profile.defaultLanguage] ?? profile.countryNameEn;

  const isLease = type === ContractType.RESIDENTIAL_LEASE || type === ContractType.COMMERCIAL_LEASE || type === ContractType.SHORT_TERM_BOOKING;
  const isSale = type === ContractType.SALES_AGREEMENT || type === ContractType.EARNEST_MONEY;
  const counterPartyLabel = isSale ? ph.buyerLabel : ph.tenantLabel;
  const principalLabel = isSale ? ph.sellerLabel : ph.landlordLabel;

  const sections: string[] = [];

  // Header + official language note
  sections.push(`<h1 style="text-align:center;margin:0 0 4px;">${CONTRACT_TYPE_LABELS[type][language] ?? CONTRACT_TYPE_LABELS[type][ContractLanguage.EN]}</h1>`);
  if (language !== ContractLanguage.EN) {
    sections.push(`<p style="text-align:center;margin:0 0 8px;">${ph.officialNote}</p>`);
  }

  // Parties
  sections.push(`<h3>${ph.partiesTitle}</h3>`);
  sections.push(`<p><strong>${principalLabel}:</strong> {LANDLORD_NAME} (ID/No: {LANDLORD_ID})</p>`);
  sections.push(`<p><strong>${counterPartyLabel}:</strong> {TENANT_NAME} (ID/No: {TENANT_ID})</p>`);

  // Property
  sections.push(`<h3>${ph.propertyTitle}</h3>`);
  sections.push(`<p><strong>${ph.propertyTypeLabel}:</strong> {PROPERTY_TYPE}</p>`);
  sections.push(`<p><strong>${ph.addressLabel}:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY} (Ref: {PROPERTY_PARCEL})</p>`);

  // Financials
  sections.push(`<h3>${ph.escrowTitle}</h3>`);
  if (isLease) {
    sections.push(`<p><strong>${ph.rentLabel}:</strong> {PRICE} {CURRENCY}/month</p>`);
  } else {
    sections.push(`<p><strong>${ph.priceLabel}:</strong> {PRICE} {CURRENCY}</p>`);
  }
  if (isLease) {
    sections.push(`<p><strong>${ph.termLabel}:</strong> {TERM_MONTHS} ${ph.termUnit}</p>`);
  }
  sections.push(`<p><strong>${ph.startLabel}:</strong> {START_DATE}</p>`);
  if (type === ContractType.RESIDENTIAL_LEASE || type === ContractType.COMMERCIAL_LEASE) {
    sections.push(`<p><strong>${ph.endLabel}:</strong> {END_DATE}</p>`);
  }

  // Deposit
  sections.push(`<h3>${ph.depositTitle}</h3>`);
  sections.push(`<p>{DEPOSIT_CLAUSE}</p>`);

  // Commission (sales + leases where a model applies)
  sections.push(`<h3>${ph.commissionTitle}</h3>`);
  sections.push(`<p>{COMMISSION_CLAUSE}</p>`);

  // Services (property management / agency)
  if (type === ContractType.PROPERTY_MANAGEMENT || type === ContractType.AGENCY_REPRESENTATION) {
    sections.push(`<h3>${ph.servicesTitle}</h3>`);
    if (type === ContractType.PROPERTY_MANAGEMENT) {
      sections.push(`<p>{SERVICES_CLAUSE}</p>`);
      sections.push(`<p><strong>${ph.managementFeeTitle}:</strong> {MANAGEMENT_FEE}%</p>`);
    } else {
      sections.push(`<p>{AGENCY_CLAUSE}</p>`);
    }
    sections.push(`<p><strong>${ph.agentLabel}:</strong> {AGENT_NAME} (${ph.licenseLabel}: {AGENT_LICENSE})</p>`);
    sections.push(`<p><strong>${ph.commissionRateLabel}:</strong> {AGENT_COMMISSION}%</p>`);
  }

  // Sales warranty
  if (isSale) {
    sections.push(`<h3>${ph.saleWarrantyTitle}</h3>`);
    sections.push(`<p>{WARRANTY_CLAUSE}</p>`);
  }

  // Legal basis / governing law / disputes
  sections.push(`<h3>${ph.legalBasisTitle}</h3>`);
  sections.push(`<p>${legalBasis}</p>`);
  sections.push(`<h3>${ph.governingLawTitle}</h3>`);
  sections.push(`<p>${ph.governingLawNote.replace('{JURISDICTION}', jurisdiction)}</p>`);
  sections.push(`<h3>${ph.disputeTitle}</h3>`);
  sections.push(`<p>${ph.disputeNote.replace('{PLATFORM}', 'Reservatior')}</p>`);

  // Additional terms
  sections.push(`<h3>${ph.additionalTitle}</h3>`);
  sections.push(`<p>{ADDITIONAL_TERMS}</p>`);

  // Signatures
  sections.push(`<h3>${ph.signaturesTitle}</h3>`);
  sections.push(`<p>${ph.dateLabel}: {START_DATE}</p>`);
  sections.push(`<div style="display:flex;justify-content:space-between;gap:24px;margin-top:12px;">
    <div style="flex:1;border-top:1px solid #333;padding-top:6px;">${principalLabel} / {LANDLORD_NAME}</div>
    <div style="flex:1;border-top:1px solid #333;padding-top:6px;">${counterPartyLabel} / {TENANT_NAME}</div>
  </div>`);

  return sections.join('\n');
}

// ─────────────────────────────────────────────────────────────────────────────
// Build the full template map: country × type × language
// ─────────────────────────────────────────────────────────────────────────────
type TemplateMap = Partial<Record<ContractLanguage, string>>;
const ContractTemplates: Record<string, Partial<Record<ContractType, TemplateMap>>> = {};

function buildAllTemplates(): void {
  for (const region of SUPPORTED_COUNTRY_CODES) {
    const profile = COUNTRY_CONTRACT_PROFILES[region]!;
    const languages: ContractLanguage[] = Array.from(new Set([...profile.officialLanguages, ContractLanguage.EN]));

    const typeMap: Partial<Record<ContractType, TemplateMap>> = {};
    for (const type of Object.values(ContractType)) {
      const langMap: TemplateMap = {};
      for (const lang of languages) {
        langMap[lang] = composeTemplate({ type, region, language: lang, ph: P[lang] });
      }
      typeMap[type] = langMap;
    }
    ContractTemplates[region] = typeMap;
  }
}

buildAllTemplates();

// ─────────────────────────────────────────────────────────────────────────────
// Multi-Lingual Legal Dictionaries for Enterprise Agency & Property Management
// ─────────────────────────────────────────────────────────────────────────────
const GLOBAL_SERVICE_CLAUSES: Record<ContractLanguage, string> = {
  [ContractLanguage.TR]: 'Reservatior Platformu; mülkün global kanallarda münhasır pazarlanması, yapay zeka destekli fiyat dengelemesi, kiracı risk ve skor analizi, kira ve güvence bedelinin emniyetli Escrow hesaplarında takibi ile yasal mevzuata uygun bakım ve tahliye süreçlerinin uçtan uca dijital yönetimini taahhüt eder.',
  [ContractLanguage.EN]: 'The Reservatior Platform commits to end-to-end digital property management, including exclusive worldwide listing distribution, AI-driven yield optimization, credit and KYC verification of tenants, secure Escrow rent/deposit collection, and regulatory-compliant maintenance and vacating facilitation.',
  [ContractLanguage.AR]: 'تلتزم منصة Reservatior بالإدارة الرقمية الكاملة للعقارات، بما في ذلك التسويق الحصري العالمي، وتحسين العائد مدفوعاً بالذكاء الاصطناعي، وتقييم جدارة المستأجرين، وتحصيل الإيجار والتأمين بحسابات ضمان آمنة، وإدارة الصيانة وفقاً للأنظمة المحلية.',
  [ContractLanguage.DE]: 'Die Reservatior-Plattform übernimmt die vollständige digitale Immobilienverwaltung, einschließlich internationaler Vermarktung, KI-gestützter Mietpreisoptimierung, Bonitäts- und KYC-Prüfung der Mieter, gesicherter Miet- und Kautionsabwicklung über Escrow-Konten sowie rechtskonformer Mängel- und Rücknahmeprozesse.',
  [ContractLanguage.FR]: 'La Plateforme Reservatior s\'engage à assurer la gestion numérique complète du bien, y compris sa diffusion internationale exclusive, l\'optimisation des rendements par IA, la vérification KYC des locataires, la gestion des loyers et dépôts sous séquestre, ainsi que le respect strict de la réglementation locale.',
  [ContractLanguage.ES]: 'La Plataforma Reservatior se compromete a la gestión integral digital de la propiedad, incluyendo comercialización mundial exclusiva, optimización de renta por IA, verificación de solvencia del inquilino, cobro seguro mediante cuentas de depósito en garantía (Escrow) y cumplimiento legal y normativo.',
  [ContractLanguage.IT]: 'La Piattaforma Reservatior si impegna alla gestione digitale completa dell\'immobile, inclusa la promozione globale, l\'ottimizzazione del rendimento tramite IA, la verifica KYC degli inquilini, la riscossione sicura di affitto e cauzione su conti vincolati (Escrow) e la conformità alle disposizioni legislative.',
  [ContractLanguage.RU]: 'Платформа Reservatior обязуется осуществлять комплексное цифровое управление недвижимостью, включая глобальный маркетинг, оптимизацию доходности с помощью ИИ, верификацию KYC арендаторов, безопасное ведение эскроу-счетов для аренды и залога, а также полное соблюдение местных законов.',
  [ContractLanguage.PT]: 'A Plataforma Reservatior compromete-se com a gestão digital integral do imóvel, incluindo marketing global exclusivo, otimização de rentabilidade via IA, verificação KYC de inquilinos, arrecadação segura de aluguel e caução em conta Escrow, além da conformidade estrita com a legislação local.',
  [ContractLanguage.JA]: 'Reservatiorプラットフォームは、世界的な独占物件広告、AI主導の収益最適化、賃借人的格性の身元 (KYC) 確証、安全なエスクロー口座による家賃・保証金管理、法令に準拠した管理手続きを含む、エンドツーエンドの包括的な物件管理を行うことを誓約します。',
  [ContractLanguage.NL]: 'Het Reservatior-platform verplicht zich tot een volledig digitaal vastgoedbeheer, inclusief exclusieve mondiale marketing, AI-gedreven rendementsoptimalisatie, screening van huurders, veilige afhandeling van huur en borg via escrow-rekeningen, en strikte naleving van de geldende wetgeving.',
  [ContractLanguage.KO]: 'Reservatior 플랫폼은 독점적 글로벌 홍보, AI 기반 수익률 최적화, 임차인 KYC 신원 대조 및 신용 검증, 에스크로 계좌를 통한 안전한 임대료·보증금 관리, 법령에 의거한 유지보수 및 법적 보호를 포함하는 종합적 자산관리 서비스를 보증합니다.',
  [ContractLanguage.ZH]: 'Reservatior 平台致力于提供涵盖全生命周期的全数码化不动产管理与托收支持体系，责任囊括全球独创整合营销、AI收益精算优化、承租方财务与KYC审查、中立第三方托管（Escrow）机制与依照当地住房法令执行的权状清退体系。',
  [ContractLanguage.HI]: 'Reservatior प्लेटफ़ॉर्म वैश्विक स्तर पर विशिष्ट विपणन, एआई-संचालित आय अनुकूलन, किरायेदार की सत्यापन प्रक्रिया, सुरक्षित एस्क्रो बैंक खातों के माध्यम से किराया व जमाराशी प्रबंधन और कानूनी अनुपालन सहित संपूर्ण डिजिटल संपत्ति प्रबंधन प्रदान करने के लिए प्रतिबद्ध है।',
  [ContractLanguage.TH]: 'แพลตฟอร์ม Reservatior มุ่งมั่นในการบริหารจัดการอสังหาริมทรัพย์ดิจิทัลอย่างครบวงจร ซึ่งรวมถึงการทำการตลาดโลกแบบเอ็กซ์คลูซีฟ, การใช้นวัตกรรม AI เพื่อต่อยอดผลตอบแทน, การตรวจสอบคุณสมบัติผู้เช่า, ระบบชำระเงินประกัน Escrow ที่รัดกุม และการบังคับใช้ข้อตกลงอย่างถูกต้องตามกฎหมายในเขตอำนาจศาลท้องถิ่น',
  [ContractLanguage.MS]: 'Platform Reservatior mengkhususkan pengurusan penginapan digital terpadu secara utuh merangkumi publisiti pasaran antarabangsa eksklusif, maksimasi pulangan berteraskan kecerdasan buatan (AI), proses pengisytiharan KYC penyewa sah, dan kutipan kewangan dalam akaun Escrow terselia.'
};

const GLOBAL_AGENCY_CLAUSES: Record<ContractLanguage, string> = {
  [ContractLanguage.TR]: 'İşbu sözleşme ile Lisanslı Emlakçı/Broker ile Reservatior Platformu arasında kurumsal co-brokerage ve ortak yetkilendirme akdi tesis edilmiştir. Taraflar, MLS/NWMLS veri akış kurallarına tam riayeti, yerel emlak lisans kanunlarına uyumu ve komisyon hak edişlerinin otomatik Escrow havuzunda güvence altına alınarak paylaşılmasını gayri kabili rücu kabul eder.',
  [ContractLanguage.EN]: 'This agreement establishes a formal Co-Brokerage and Agency Representation partnership between the Licensed Real Estate Broker and the Reservatior Platform. Both parties irrevocably guarantee adherence to localized MLS/NWMLS listing directives, compliance with statutory real estate commission frameworks, and transparent split of earned commissions via secure regulatory Escrow disbursement.',
  [ContractLanguage.AR]: 'تؤسس هذه الاتفاقية شراكة رسمية للوساطة المشتركة والتمثيل التجاري بين الوسيط العقاري المرخص ومنصة Reservatior. يضمن الطرفان الالتزام بمعايير الإدراج المحلية (MLS)، والامتثال لأنظمة العمولة العقارية القانونية، وتوزيع حقوق العمولات المكتسبة بشفافية عبر الحسابات الائتمانية المؤمنة.',
  [ContractLanguage.DE]: 'Mit diesem Vertrag wird eine formelle Kooperations- und Maklervertretungs-Vereinbarung zwischen dem lizenzierten Immobilienmakler und der Reservatior-Plattform begründet. Beide Parteien verpflichten sich zur strikten Einhaltung regionaler MLS-Richtlinien, rechtskonformen Provisionsbeteiligungen und der automatisierten Treuhandauszahlung (Escrow).',
  [ContractLanguage.FR]: 'Le présent contrat institue un accord formel de co-courtage et de représentation commerciale entre l\'Agent Immobilier agréé et la Plateforme Reservatior. Les parties garantissent le strict respect des régulations MLS, la conformité légale des honoraires et la répartition des commissions sécurisées sous séquestre officiel (Escrow).',
  [ContractLanguage.ES]: 'El presente acuerdo constituye una alianza formal de representación y corretaje conjunto (Co-Brokerage) entre el Agente Inmobiliario con licencia y la Plataforma Reservatior. Las partes se comprometen al cumplimiento de normativas MLS locales, pautas regulatorias para comisiones de corretaje y la dispersión equitativa de comisiones devengadas mediante cuentas de garantía (Escrow).',
  [ContractLanguage.IT]: 'Questo accordo sancisce una cooperazione ufficiale di mandato e co-intermediazione tra l\'Agente Immobiliare abilitato e la Piattaforma Reservatior. Entrambi i contraenti si vincolano all\'osservanza dei regolamenti MLS regionali, alle direttive sulle provvigioni e alla spartizione protetta e trasparente dei compensi mediante conti di garanzia di terze parti (Escrow).',
  [ContractLanguage.RU]: 'Данное соглашение устанавливает официальное партнерство по ко-брокериджу и представительству между Лицензированным риелтором и Платформой Reservatior. Стороны обязуются соблюдать локальные правила баз данных MLS, законы о риелторской деятельности и обеспечивать выплату и распределение комиссионных исключительно через защищенные эскроу-счета.',
  [ContractLanguage.PT]: 'Este instrumento estabelece uma parceria de co-corretagem e representação comercial entre o Corretor de Imóveis devidamente credenciado e a Plataforma Reservatior. As partes declaram total obediência às normas de divulgação imobiliária (MLS), limites regulatórios de honorários e partilha transparente da comissão por liquidação Escrow.',
  [ContractLanguage.JA]: '本契約は、正当な公認資格を持つ宅地建物取引業者とReservatiorプラットフォームとの間で正式な共同仲介および代理表章パートナーシップを樹立するものです。両当事者は、地域の不動産情報交換システム (MLS) 基準の完全な厳守、法定手数料枠組みの一致、並びに認可エスクロー口座を経由した報酬分配を確約します。',
  [ContractLanguage.NL]: 'Deze overeenkomst vestigt een formeel samenwerkingsverband inzake makelaardij en vertegenwoordiging tussen de erkende Vastgoedmakelaar en het Reservatior-platform. Partijen garanderen de naleving van professionele MLS-richtlijnen, de geldende vergoedingennormen en de geautomatiseerde en beschermde uitbetaling van commissiedelen via erkende escrow-rekeningen.',
  [ContractLanguage.KO]: '본 약서는 공인 자격을 보유한 부동산 중개업자(Broker)와 Reservatior 플랫폼 간의 공식적인 공동 중개(Co-Brokerage) 및 전속 업무협약 파트너십을 체결함을 증명합니다. 쌍방은 현지 매물 관제 규정(MLS) 준수, 합법적 보수료율 억지, 그리고 에스크로 보증 계정을 통한 투명한 수당 분배를 승인합니다.',
  [ContractLanguage.ZH]: '本协议正式确立持牌合法执业地产经纪机房与 Reservatior 平台之间专属的共同联合行纪（Co-Brokerage）及挂牌授权框架。双方承诺绝对遵循不动产行业公约（含完整 MLS 与权属核查系统）、恪守属地法令佣金红线，且款项一律经独立第三方中立托管专户（Escrow）统一拆放及分配。',
  [ContractLanguage.HI]: 'यह समझौता पंजीकृत रियल एस्टेट ब्रोकर और Reservatior प्लेटफ़ॉर्म के बीच औपचारिक साझेदारी स्थापित करता है। दोनों पक्ष स्थानीय एमएलएस नियमों के अनुपालन, कानूनी दलाली नियमों तथा एस्क्रो बैंक सुरक्षा प्रणाली के माध्यम से अर्जित कमीशन के पारदर्शी विभाजन के लिए पूरी तरह से प्रतिबद्ध हैं।',
  [ContractLanguage.TH]: 'สัญญานี้มีจุดประสงค์เพื่อก่อตั้งข้อตกลงพันธมิตรทางธุรกิจด้านการเป็นตัวแทนนายหน้าอสังหาริมทรัพย์ (Co-Brokerage) ระหว่างนายหน้าจดทะเบียนกับแพลตฟอร์ม Reservatior คู่สัญญาต่างตกลงปฏิบัติตามวินัยระบบข้อมูลอสังหาริมทรัพย์ (MLS) และรับการกระจายผลกำไรอย่างเที่ยงตรงผ่านบัญชีคนกลางค้ำประกัน (Escrow)',
  [ContractLanguage.MS]: 'Perjanjian ini mengiktiraf ikatan rasmi perwakil niaga gabungan (Co-Brokerage) dan ketetapan mandat sah antara Ejen Hartanah berlesen dan Platform Reservatior. Kedua-dua pihak menegaskan komitmen mematuhi standard senarai MLS, regulasi bayaran komisen, serta kepastian pengasingan caj kejayaan di bawah akaun amanah rasmi (Escrow).'
};

const GLOBAL_WARRANTY_CLAUSES: Record<ContractLanguage, string> = {
  [ContractLanguage.TR]: 'Satıcı ve Kiraya Veren; taşınmazın mülkiyet ve kullanım hakkının kendisine ait olduğunu, üzerinde hak ihlali ya da kısıtlayıcı takyidat bulunmadığını beyan, tazmin ve taahhüt eder.',
  [ContractLanguage.EN]: 'The Seller / Landlord warrants that it holds good, unencumbered title and rightful possession of the property, free of undisclosed liens, disputes, or restrictions.',
  [ContractLanguage.AR]: 'يقر البائع / المؤجر بأنه صاحب الحيازة القانونية والملكية التامة للعقار وأنه خالي من أي رهن أو منازعات أو قيود قانونية.',
  [ContractLanguage.DE]: 'Der Verkäufer / Vermieter garantiert, dass er das unbestrittene Eigentums- und Nutzungsrecht an der Immobilie hält, frei von nicht offen gelegten Pfandrechten oder Belastungen.',
  [ContractLanguage.FR]: 'Le Vendeur / Bailleur garantit qu\'il détient le titre de propriété légal et sans réserve de l\'immeuble, exempt de tout privilège ou hypothèque non déclarée.',
  [ContractLanguage.ES]: 'El Vendedor / Arrendador garantiza que ostenta el título legítimo y pleno de la propiedad, libre de cargas, gravámenes o litigios pendientes.',
  [ContractLanguage.IT]: 'Il Venditore / Locatore garantisce la piena e legittima titolarità dell\'immobile, libero da gravami, iscrizioni ipotecarie o vincoli pregiudizio.',
  [ContractLanguage.RU]: 'Продавец / Арендодатель гарантирует наличие безусловного права собственности и владения недвижимостью, свободной от обременений и притязаний третьих лиц.',
  [ContractLanguage.PT]: 'O Vendedor / Locador garante possuir o título de propriedade justo e perfeito do imóvel, livre de ônus reais, hipotecas ou impedimentos judiciais.',
  [ContractLanguage.JA]: '売主および賃貸人は、対象物件に対して完全にして正当な法的所有権を保持しており、未開示の留置権や紛争が一切存在しないことを表明し保証します。',
  [ContractLanguage.NL]: 'De Verkoper / Verhuurder garandeert de onvoorwaardelijke en rechtmatige eigendom en het exclusieve gebruiksrecht van het vastgoed, vrij van verborgen lasten of beslagen.',
  [ContractLanguage.KO]: '매도인 및 임대인은 본 대상 자산에 대해 제한이나 침해 없는 권원 및 적법한 소유권을 전적으로 보유하고 있음을 명백히 밝히고 보증합니다.',
  [ContractLanguage.ZH]: '出卖方/出租方在此声明并严格保证：其拥有该标的物业无争议且完整有效的所有权及处分权，且标的物业其身上毫无隐藏设定担保、司法查封及第三人权利。',
  [ContractLanguage.HI]: 'विक्रेता / मकान मालिक गारंटी देता है कि उसके पास संपत्ति का पूर्ण और निर्विवाद कानूनी स्वामित्व है, जो किसी भी प्रकार के ऋण या विवाद से मुक्त है।',
  [ContractLanguage.TH]: 'ผู้ขายและผู้ให้เช่าขอให้คำรับรองและตกลงว่า ตนมีกรรมสิทธิ์ในอสังหาริมทรัพย์ที่ถูกต้องสมบูรณ์ และปราศจากภาระผูกพันหรือสิทธิเรียกร้องของบุคคลที่สามทุกประการ',
  [ContractLanguage.MS]: 'Penjual / Tuan Rumah menjembut jaminan kukuh berdaftar bahawa kepemilikannya terhadap hartanah ini adalah hak cipta abadi dan bebas dari tuntutan hak gadai janji atau pertikai amanah.'
};

// ─────────────────────────────────────────────────────────────────────────────
export class ContractEngine {
  /**
   * Generate a compiled HTML contract for any supported country × type × language.
   */
  static generateContract(
    type: ContractType,
    region: RegionCode,
    data: ContractData,
    language: ContractLanguage = ContractLanguage.EN
  ): string {
    const regionalTemplates = ContractTemplates[region] ?? ContractTemplates[RegionCode.USA];
    const typeTemplates = regionalTemplates?.[type];
    if (!typeTemplates) throw new Error(`Template for ${type} / ${region} not found.`);

    let template = typeTemplates[language] ?? typeTemplates[ContractLanguage.EN] ?? Object.values(typeTemplates)[0];
    if (!template) throw new Error(`No template for language ${language} / ${type}.`);

    // Deposit clause
    let depositClause = '';
    if (data.financials.isZeroDeposit) {
      depositClause = phrase(language, 'zeroDepositClause');
    } else {
      depositClause = phrase(language, 'depositClause')
        .replace('{AMOUNT}', String(data.financials.depositAmount ?? 0))
        .replace('{CURRENCY}', data.financials.currency);
    }

    // Commission clause
    let commissionClause = '';
    if (type === ContractType.SALES_AGREEMENT || type === ContractType.RESIDENTIAL_LEASE || type === ContractType.COMMERCIAL_LEASE) {
      if (data.financials.commissionModel) {
        const clauseMap = CommissionModelClauses[data.financials.commissionModel];
        let raw = clauseMap[language] ?? clauseMap[ContractLanguage.EN] ?? '';

        // Dynamic Fee Labels & Legal Load Shifting Waivers
        if (data.financials.loadShiftedToLandlord) {
          if (language === ContractLanguage.TR) {
            raw += `\n[Yasal Feragatname] Alıcıdan/Kiracıdan yerel mevzuat gereği hiçbir ücret talep edilmemiş olup, tüm maliyetler Satıcı/Ev Sahibi tarafından "${data.financials.landlordFeeLabel}" adı altında karşılanmıştır.`;
          } else if (language === ContractLanguage.DE) {
            raw += `\n[Haftungsausschluss] Gesetzlich bedingt wurden dem Käufer/Mieter keine Gebühren in Rechnung gestellt. Alle Kosten werden vom Verkäufer/Vermieter als "${data.financials.landlordFeeLabel}" getragen.`;
          } else {
            raw += `\n[Legal Waiver] By local law, no fees have been charged to the Buyer/Tenant. All costs are covered by the Seller/Landlord under the label "${data.financials.landlordFeeLabel}".`;
          }
        } else {
          if (data.financials.tenantFeeLabel && data.financials.tenantFeeLabel !== "Sales Commission") {
            if (language === ContractLanguage.TR) {
              raw += `\nAlıcı/Kiracı tarafından ödenen tutar "${data.financials.tenantFeeLabel}" olarak faturalandırılmıştır.`;
            } else {
              raw += `\nThe amount paid by the Buyer/Tenant is billed as "${data.financials.tenantFeeLabel}".`;
            }
          }
        }

        commissionClause = raw
          .replace(/{COMMISSION_TOTAL}/g, String(data.financials.commissionTotal ?? 0))
          .replace(/{PLATFORM_FEE}/g, String(data.financials.platformInsuranceFee ?? 0))
          .replace(/{INSTALLMENTS}/g, String(data.financials.commissionInstallments ?? 0))
          .replace(/{MONTHLY_INSTALLMENT}/g, String(data.financials.monthlyInstallment ?? 0))
          .replace(/{DOWN_PAYMENT}/g, String(data.financials.downPayment ?? 0));
      } else {
        // Default: state the agreed price / rent with platform guarantee.
        commissionClause = `Reservatior ${phrase(language, 'commissionTitle').toLowerCase()}`;
      }
    } else {
      commissionClause = '—';
    }

    // Agency / property-management clauses
    let servicesClause = '';
    let agencyClause = '';
    if (type === ContractType.PROPERTY_MANAGEMENT) {
      servicesClause = GLOBAL_SERVICE_CLAUSES[language] ?? GLOBAL_SERVICE_CLAUSES[ContractLanguage.EN];
    }
    if (type === ContractType.AGENCY_REPRESENTATION) {
      agencyClause = GLOBAL_AGENCY_CLAUSES[language] ?? GLOBAL_AGENCY_CLAUSES[ContractLanguage.EN];
    }

    const warrantyClause = GLOBAL_WARRANTY_CLAUSES[language] ?? GLOBAL_WARRANTY_CLAUSES[ContractLanguage.EN];

    const additionalTerms = data.legal?.additionalLanguage
      ? `This agreement is also available in ${CONTRACT_LANGUAGE_NAMES[data.legal.additionalLanguage]}.`
      : 'Standard terms and conditions apply.';


    return template
      .replace(/{LANDLORD_NAME}/g, data.landlordOrSeller.fullName)
      .replace(/{LANDLORD_ID}/g, data.landlordOrSeller.nationalIdOrTaxNo)
      .replace(/{TENANT_NAME}/g, data.tenantOrBuyer.fullName)
      .replace(/{TENANT_ID}/g, data.tenantOrBuyer.nationalIdOrTaxNo)
      .replace(/{PROPERTY_TYPE}/g, data.property.type || 'Residential')
      .replace(/{PROPERTY_ADDRESS}/g, data.property.address)
      .replace(/{PROPERTY_CITY}/g, data.property.city)
      .replace(/{PROPERTY_PARCEL}/g, data.property.parcelId || 'N/A')
      .replace(/{PRICE}/g, String(data.financials.price))
      .replace(/{CURRENCY}/g, data.financials.currency)
      .replace(/{TERM_MONTHS}/g, String(data.financials.termMonths ?? 12))
      .replace(/{START_DATE}/g, data.financials.startDate)
      .replace(/{END_DATE}/g, data.financials.endDate || 'N/A')
      .replace(/{DEPOSIT_CLAUSE}/g, depositClause)
      .replace(/{COMMISSION_CLAUSE}/g, commissionClause)
      .replace(/{SERVICES_CLAUSE}/g, servicesClause)
      .replace(/{AGENCY_CLAUSE}/g, agencyClause)
      .replace(/{WARRANTY_CLAUSE}/g, warrantyClause)
      .replace(/{MANAGEMENT_FEE}/g, String(data.financials.managementFeePct ?? 8))
      .replace(/{AGENT_NAME}/g, data.agent?.fullName || data.platform?.fullName || 'Reservatior')
      .replace(/{AGENT_LICENSE}/g, data.agent?.licenseNo || data.platform?.registrationNo || 'N/A')
      .replace(/{AGENT_COMMISSION}/g, String(data.agent?.commissionRate ?? 0))
      .replace(/{ADDITIONAL_TERMS}/g, additionalTerms);
  }

  /** Aynı sözleşmeyi birden fazla dilde üret */
  static generateMultiLanguage(
    type: ContractType,
    region: RegionCode,
    data: ContractData,
    languages: ContractLanguage[]
  ): Record<ContractLanguage, string> {
    const results: Partial<Record<ContractLanguage, string>> = {};
    for (const lang of languages) {
      results[lang] = this.generateContract(type, region, data, lang);
    }
    return results as Record<ContractLanguage, string>;
  }

  /** List all available template types for a country. */
  static listTemplatesForCountry(region: RegionCode): {
    type: ContractType;
    languages: ContractLanguage[];
  }[] {
    const regional = ContractTemplates[region] ?? ContractTemplates[RegionCode.USA];
    return Object.entries(regional).map(([type, langs]) => ({
      type: type as ContractType,
      languages: Object.keys(langs ?? {}) as ContractLanguage[],
    }));
  }

  /** Full catalog for all countries. */
  static getTemplateCatalog(): {
    country: string;
    countryName: string;
    currency: string;
    languages: ContractLanguage[];
    types: { type: ContractType; languages: ContractLanguage[] }[];
  }[] {
    return SUPPORTED_COUNTRY_CODES.map((region) => {
      const profile = COUNTRY_CONTRACT_PROFILES[region]!;
      return {
        country: region,
        countryName: profile.countryNameEn,
        currency: profile.currency,
        languages: profile.officialLanguages,
        types: this.listTemplatesForCountry(region),
      };
    });
  }

  /** Suggest a template when no language is passed (official language first). */
  static getDefaultLanguage(region: RegionCode): ContractLanguage {
    return COUNTRY_CONTRACT_PROFILES[region]?.defaultLanguage ?? ContractLanguage.EN;
  }

  /** Get the language map for a country/type pair, or null if unsupported. */
  static getTemplate(
    region: RegionCode,
    type: ContractType,
  ): { region: RegionCode; type: ContractType; languages: ContractLanguage[]; defaultLanguage: ContractLanguage } | null {
    const regional = ContractTemplates[region] ?? ContractTemplates[RegionCode.USA];
    const langs = regional[type];
    if (!langs) return null;
    return {
      region,
      type,
      languages: Object.keys(langs) as ContractLanguage[],
      defaultLanguage: this.getDefaultLanguage(region),
    };
  }

  static getProfile(region: RegionCode) {
    return getCountryProfile(region);
  }
}
