// server/config/contract-engine.ts
// AI-Driven Legal Document & Smart Contract Generator
// Supports: Multi-language (TR/EN/AR/DE/FR/ES/RU), Lease + Sales contracts,
// 3 Commission Models: INSTALLMENT_12 (%4/ay) / HYBRID_50_6 (%50+%60x6) / TRADITIONAL_1M

import { RegionCode } from './ai-yield-optimization';

// Supported contract languages
export enum ContractLanguage {
  TR = 'tr',
  EN = 'en',
  AR = 'ar',
  DE = 'de',
  FR = 'fr',
  ES = 'es',
  RU = 'ru',
  PT = 'pt',
  JA = 'ja',
}

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
}

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
  };
  financials: {
    price: number;
    currency: string;
    depositAmount?: number;
    startDate: string;
    endDate?: string;
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
  };
  legal?: {
    officialLanguage?: ContractLanguage;
    additionalLanguage?: ContractLanguage;
  };
}

// Commission model clause templates per language
const CommissionModelClauses: Record<ContractCommissionModel, Record<ContractLanguage, string>> = {
  [ContractCommissionModel.INSTALLMENT_12]: {
    [ContractLanguage.TR]: `Komisyon toplam {COMMISSION_TOTAL} {CURRENCY} olup {INSTALLMENTS} esit aylik taksitte odenir ({MONTHLY_INSTALLMENT} {CURRENCY}/ay). Aylik %4 tasima bedeli uygulanir. %2 Platform Guvencesi ve Sigorta Bedeli ({PLATFORM_FEE} {CURRENCY}) ayrica tahsil edilir.`,
    [ContractLanguage.EN]: `Commission totals {COMMISSION_TOTAL} {CURRENCY}, payable in {INSTALLMENTS} equal monthly installments of {MONTHLY_INSTALLMENT} {CURRENCY}. A 4% monthly carry fee applies. A 2% Platform Guarantee & Insurance Fee of {PLATFORM_FEE} {CURRENCY} is also collected.`,
    [ContractLanguage.AR]: `العمولة الكلية {COMMISSION_TOTAL} {CURRENCY}، تسدد على {INSTALLMENTS} قسطا شهريا بقيمة {MONTHLY_INSTALLMENT} {CURRENCY}. رسوم 4% شهريا. ورسوم ضمان المنصة 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.DE]: `Die Provision betraegt insgesamt {COMMISSION_TOTAL} {CURRENCY}, zahlbar in {INSTALLMENTS} gleichen Monatsraten à {MONTHLY_INSTALLMENT} {CURRENCY}. Monatliche Bereitstellungsgebuehr 4%. Plattformgebuehr 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.FR]: `Commission totale {COMMISSION_TOTAL} {CURRENCY}, payable en {INSTALLMENTS} mensualites de {MONTHLY_INSTALLMENT} {CURRENCY}. Frais mensuels 4%. Frais plateforme 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.ES]: `Comision total {COMMISSION_TOTAL} {CURRENCY}, pagadera en {INSTALLMENTS} cuotas de {MONTHLY_INSTALLMENT} {CURRENCY}/mes. Cargo mensual 4%. Tarifa plataforma 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.RU]: `Общая комиссия {COMMISSION_TOTAL} {CURRENCY}, выплачивается {INSTALLMENTS} равными платежами по {MONTHLY_INSTALLMENT} {CURRENCY}. Ежемесячный сбор 4%. Плата за платформу 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.PT]: `Comissao total {COMMISSION_TOTAL} {CURRENCY}, pagavel em {INSTALLMENTS} parcelas de {MONTHLY_INSTALLMENT} {CURRENCY}. Taxa mensal 4%. Taxa plataforma 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.JA]: `手数料合計 {COMMISSION_TOTAL} {CURRENCY}、{INSTALLMENTS}回分割 {MONTHLY_INSTALLMENT} {CURRENCY}/月。月次4%運用手数料。プラットフォーム保証2% ({PLATFORM_FEE} {CURRENCY})。`,
  },
  [ContractCommissionModel.HYBRID_50_6]: {
    [ContractLanguage.TR]: `Komisyonun %50si ({DOWN_PAYMENT} {CURRENCY}) imzada pesinen Reservatior Escrow'a yatirilir. Kalan bakiye +%10 servis bedeliyle 6 taksitte odenir ({MONTHLY_INSTALLMENT} {CURRENCY}/ay). %2 Platform Guvencesi ({PLATFORM_FEE} {CURRENCY}) pesinate dahildir. Bu model yaklasik 1 aylik kira tutarini gecis esigi olarak kullanir.`,
    [ContractLanguage.EN]: `50% of commission ({DOWN_PAYMENT} {CURRENCY}) is due upfront into Reservatior Escrow at signing. The remaining balance + 10% service fee is paid over 6 installments of {MONTHLY_INSTALLMENT} {CURRENCY}/month. The 2% Platform & Insurance Fee ({PLATFORM_FEE} {CURRENCY}) is collected with the down payment. This model uses ~1 month rent as the transition threshold.`,
    [ContractLanguage.AR]: `50% من العمولة ({DOWN_PAYMENT} {CURRENCY}) مسبقا عند التوقيع. الباقي +10% على 6 اقساط ({MONTHLY_INSTALLMENT} {CURRENCY}/شهر). رسوم المنصة 2% ({PLATFORM_FEE} {CURRENCY}) مع الدفعة الاولى.`,
    [ContractLanguage.DE]: `50% der Provision ({DOWN_PAYMENT} {CURRENCY}) bei Unterzeichnung. Rest +10% auf 6 Raten ({MONTHLY_INSTALLMENT} {CURRENCY}/Monat). Plattformgebuehr 2% ({PLATFORM_FEE} {CURRENCY}) mit Anzahlung.`,
    [ContractLanguage.FR]: `50% de commission ({DOWN_PAYMENT} {CURRENCY}) a la signature. Solde +10% sur 6 mensualites ({MONTHLY_INSTALLMENT} {CURRENCY}/mois). Frais plateforme 2% ({PLATFORM_FEE} {CURRENCY}) avec acompte.`,
    [ContractLanguage.ES]: `50% de comision ({DOWN_PAYMENT} {CURRENCY}) al firmar. Resto +10% en 6 cuotas ({MONTHLY_INSTALLMENT} {CURRENCY}/mes). Tarifa plataforma 2% ({PLATFORM_FEE} {CURRENCY}) con pago inicial.`,
    [ContractLanguage.RU]: `50% комиссии ({DOWN_PAYMENT} {CURRENCY}) при подписании. Остаток +10% в 6 платежей ({MONTHLY_INSTALLMENT} {CURRENCY}/мес). Плата платформы 2% ({PLATFORM_FEE} {CURRENCY}) с авансом.`,
    [ContractLanguage.PT]: `50% da comissao ({DOWN_PAYMENT} {CURRENCY}) na assinatura. Saldo +10% em 6 parcelas ({MONTHLY_INSTALLMENT} {CURRENCY}/mes). Taxa plataforma 2% ({PLATFORM_FEE} {CURRENCY}) com entrada.`,
    [ContractLanguage.JA]: `手数料の50%（{DOWN_PAYMENT} {CURRENCY}）を署名時に前払い。残額+10%を6回分割（{MONTHLY_INSTALLMENT} {CURRENCY}/月）。プラットフォーム料2%（{PLATFORM_FEE} {CURRENCY}）は頭金と同時徴収。`,
  },
  [ContractCommissionModel.TRADITIONAL_1M]: {
    [ContractLanguage.TR]: `Komisyon olarak 1 aylik kira bedeli ({DOWN_PAYMENT} {CURRENCY}) imzada pesinen odenir. %2 Platform Guvencesi ve Sigorta Bedeli ({PLATFORM_FEE} {CURRENCY}) ayrica tahsil edilir.`,
    [ContractLanguage.EN]: `A commission equal to one month's rent ({DOWN_PAYMENT} {CURRENCY}) is due at signing. A 2% Platform Guarantee & Insurance Fee ({PLATFORM_FEE} {CURRENCY}) is also collected.`,
    [ContractLanguage.AR]: `عمولة تعادل شهر ايجار ({DOWN_PAYMENT} {CURRENCY}) عند التوقيع. رسوم منصة 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.DE]: `Provision in Hoehe einer Monatsmiete ({DOWN_PAYMENT} {CURRENCY}) bei Unterzeichnung. Plattformgebuehr 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.FR]: `Commission egale a un mois de loyer ({DOWN_PAYMENT} {CURRENCY}) a la signature. Frais plateforme 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.ES]: `Comision equivalente a un mes de alquiler ({DOWN_PAYMENT} {CURRENCY}) al firmar. Tarifa plataforma 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.RU]: `Комиссия равная одному месяцу аренды ({DOWN_PAYMENT} {CURRENCY}) при подписании. Плата платформы 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.PT]: `Comissao equivalente a um mes de aluguel ({DOWN_PAYMENT} {CURRENCY}) na assinatura. Taxa plataforma 2% ({PLATFORM_FEE} {CURRENCY}).`,
    [ContractLanguage.JA]: `署名時に1ヶ月分賃料（{DOWN_PAYMENT} {CURRENCY}）相当の手数料。プラットフォーム料2%（{PLATFORM_FEE} {CURRENCY}）も徴収。`,
  },
};

// Region + Type + Language template map
type TemplateMap = Partial<Record<ContractLanguage, string>>;
const ContractTemplates: Record<string, Partial<Record<ContractType, TemplateMap>>> = {
  [RegionCode.TR]: {
    [ContractType.RESIDENTIAL_LEASE]: {
      [ContractLanguage.TR]: `<h1 style="text-align:center;">KONUT KIRA SOZLESMESI</h1><p><strong>Kiraya Veren:</strong> {LANDLORD_NAME} (TC/VKN: {LANDLORD_ID})</p><p><strong>Kiraci:</strong> {TENANT_NAME} (TC/VKN: {TENANT_ID})</p><p><strong>Kiralanan:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY} (Ada/Parsel: {PROPERTY_PARCEL})</p><p><strong>Kira:</strong> {PRICE} {CURRENCY}/Ay</p><p><strong>Baslangic:</strong> {START_DATE}</p><h3>Depozito</h3><p>{DEPOSIT_CLAUSE}</p>`,
      [ContractLanguage.EN]: `<p><em>Note: The legally binding version of this agreement is in Turkish.</em></p><h1 style="text-align:center;">RESIDENTIAL LEASE AGREEMENT (Turkey)</h1><p><strong>Landlord:</strong> {LANDLORD_NAME}</p><p><strong>Tenant:</strong> {TENANT_NAME}</p><p><strong>Premises:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY}</p><p><strong>Rent:</strong> {PRICE} {CURRENCY}/Month</p><h3>Security Deposit</h3><p>{DEPOSIT_CLAUSE}</p>`,
      [ContractLanguage.RU]: `<p><em>Примечание: юридически обязывающей версией является турецкий текст.</em></p><h1 style="text-align:center;">ДОГОВОР АРЕНДЫ (Турция)</h1><p><strong>Арендодатель:</strong> {LANDLORD_NAME}</p><p><strong>Арендатор:</strong> {TENANT_NAME}</p><p><strong>Адрес:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY}</p><p><strong>Аренда:</strong> {PRICE} {CURRENCY}/мес</p><h3>Залог</h3><p>{DEPOSIT_CLAUSE}</p>`,
    },
    [ContractType.SALES_AGREEMENT]: {
      [ContractLanguage.TR]: `<h1 style="text-align:center;">GAYRIMENKUL SATIS VAADI SOZLESMESI</h1><p><strong>Satici:</strong> {LANDLORD_NAME} (TC/VKN: {LANDLORD_ID})</p><p><strong>Alici:</strong> {TENANT_NAME} (TC/VKN: {TENANT_ID})</p><p><strong>Tasinmaz:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY} (Ada/Parsel: {PROPERTY_PARCEL})</p><p><strong>Satis Bedeli:</strong> {PRICE} {CURRENCY}</p><p><strong>Sozlesme Tarihi:</strong> {START_DATE}</p><h3>Odeme ve Komisyon</h3><p>{COMMISSION_CLAUSE}</p><h3>Devir</h3><p>Satis bedelinin Reservatior Escrow hesabina yatmasini mUteakip tapu devri gerceklestirilecektir.</p>`,
      [ContractLanguage.EN]: `<p><em>Note: Turkish version is legally binding where required.</em></p><h1 style="text-align:center;">REAL ESTATE PURCHASE & SALE AGREEMENT</h1><p><strong>Seller:</strong> {LANDLORD_NAME}</p><p><strong>Buyer:</strong> {TENANT_NAME}</p><p><strong>Property:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY}</p><p><strong>Sale Price:</strong> {PRICE} {CURRENCY}</p><p><strong>Date:</strong> {START_DATE}</p><h3>Commission & Payment</h3><p>{COMMISSION_CLAUSE}</p>`,
      [ContractLanguage.AR]: `<h1 style="text-align:center;">عقد بيع عقار</h1><p><strong>البائع:</strong> {LANDLORD_NAME}</p><p><strong>المشتري:</strong> {TENANT_NAME}</p><p><strong>العقار:</strong> {PROPERTY_ADDRESS}</p><p><strong>سعر البيع:</strong> {PRICE} {CURRENCY}</p><h3>العمولة والدفع</h3><p>{COMMISSION_CLAUSE}</p>`,
      [ContractLanguage.DE]: `<h1 style="text-align:center;">IMMOBILIENKAUFVERTRAG</h1><p><strong>Verkaeufer:</strong> {LANDLORD_NAME}</p><p><strong>Kaeufer:</strong> {TENANT_NAME}</p><p><strong>Objekt:</strong> {PROPERTY_ADDRESS}</p><p><strong>Kaufpreis:</strong> {PRICE} {CURRENCY}</p><h3>Provision</h3><p>{COMMISSION_CLAUSE}</p>`,
      [ContractLanguage.RU]: `<h1 style="text-align:center;">ДОГОВОР КУПЛИ-ПРОДАЖИ</h1><p><strong>Продавец:</strong> {LANDLORD_NAME}</p><p><strong>Покупатель:</strong> {TENANT_NAME}</p><p><strong>Объект:</strong> {PROPERTY_ADDRESS}</p><p><strong>Цена:</strong> {PRICE} {CURRENCY}</p><h3>Комиссия</h3><p>{COMMISSION_CLAUSE}</p>`,
    },
    [ContractType.EVICTION_COMMITMENT]: {
      [ContractLanguage.TR]: `<h1 style="text-align:center;">TAHLIYE TAAHHUTNAMESE</h1><p>Taahhut Eden: {TENANT_NAME}</p><p>Malik: {LANDLORD_NAME}</p><p>{PROPERTY_ADDRESS} adresindeki mecuru {END_DATE} tarihinde kayitsiz sartsiz bosaltacagimi taahhut ederim.</p>`,
    },
    [ContractType.EARNEST_MONEY]: {
      [ContractLanguage.TR]: `<h1>KAPARO VE REZERVASYON SOZLESMESI</h1><p>{TENANT_NAME}, {PROPERTY_ADDRESS} icin {PRICE} {CURRENCY} kaparo Reservatior Escrow'a yatirmistir.</p>`,
    },
    [ContractType.AGENCY_REPRESENTATION]: {
      [ContractLanguage.TR]: `<h1>EMLAK YETKI VE TEMSIL SOZLESMESI</h1><p><strong>Acente:</strong> {AGENT_NAME} (Lisans: {AGENT_LICENSE})</p><p>Is bedelinin %{AGENT_COMMISSION}'u hizmet bedeli.</p>`,
    },
    [ContractType.COMMERCIAL_LEASE]: { [ContractLanguage.TR]: `<p>Ticari Kira Sozlesmesi...</p>` },
    [ContractType.SHORT_TERM_BOOKING]: { [ContractLanguage.TR]: `<p>Kisa Donem Konaklama...</p>` },
  },
  [RegionCode.USA]: {
    [ContractType.RESIDENTIAL_LEASE]: {
      [ContractLanguage.EN]: `<h1 style="text-align:center;">RESIDENTIAL LEASE AGREEMENT</h1><p><strong>Landlord:</strong> {LANDLORD_NAME}</p><p><strong>Tenant:</strong> {TENANT_NAME}</p><p><strong>Premises:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY}</p><p><strong>Rent:</strong> {PRICE} {CURRENCY}/Month</p><h3>Security Deposit</h3><p>{DEPOSIT_CLAUSE}</p>`,
      [ContractLanguage.ES]: `<h1 style="text-align:center;">CONTRATO DE ARRENDAMIENTO</h1><p><strong>Arrendador:</strong> {LANDLORD_NAME}</p><p><strong>Arrendatario:</strong> {TENANT_NAME}</p><p><strong>Propiedad:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY}</p><p><strong>Renta:</strong> {PRICE} {CURRENCY}/Mes</p><h3>Deposito de Seguridad</h3><p>{DEPOSIT_CLAUSE}</p>`,
    },
    [ContractType.SALES_AGREEMENT]: {
      [ContractLanguage.EN]: `<h1 style="text-align:center;">REAL ESTATE PURCHASE & SALE AGREEMENT</h1><p><strong>Seller:</strong> {LANDLORD_NAME}</p><p><strong>Buyer:</strong> {TENANT_NAME}</p><p><strong>Property:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY}</p><p><strong>Sale Price:</strong> {PRICE} {CURRENCY}</p><p><strong>Date:</strong> {START_DATE}</p><h3>Commission & Fees</h3><p>{COMMISSION_CLAUSE}</p>`,
    },
    [ContractType.EVICTION_COMMITMENT]: { [ContractLanguage.EN]: `<p>Notice of Intent to Vacate (US courts required for eviction).</p>` },
    [ContractType.EARNEST_MONEY]: { [ContractLanguage.EN]: `<p>Earnest Money Escrow Agreement...</p>` },
    [ContractType.AGENCY_REPRESENTATION]: { [ContractLanguage.EN]: `<p>Exclusive Right to Sell/Lease Agreement...</p>` },
    [ContractType.COMMERCIAL_LEASE]: { [ContractLanguage.EN]: `<p>Commercial NNN Lease Agreement...</p>` },
    [ContractType.SHORT_TERM_BOOKING]: { [ContractLanguage.EN]: `<p>Short-Term Vacation Rental Agreement...</p>` },
  },
  [RegionCode.AE]: {
    [ContractType.RESIDENTIAL_LEASE]: {
      [ContractLanguage.EN]: `<h1 style="text-align:center;">TENANCY CONTRACT (UAE / RERA)</h1><p><strong>Landlord:</strong> {LANDLORD_NAME}</p><p><strong>Tenant:</strong> {TENANT_NAME}</p><p><strong>Premises:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY}</p><p><strong>Annual Rent:</strong> {PRICE} {CURRENCY}</p><h3>Security Deposit</h3><p>{DEPOSIT_CLAUSE}</p>`,
      [ContractLanguage.AR]: `<h1 style="text-align:center;">عقد ايجار (الامارات / ريرا)</h1><p><strong>المؤجر:</strong> {LANDLORD_NAME}</p><p><strong>المستأجر:</strong> {TENANT_NAME}</p><p><strong>العقار:</strong> {PROPERTY_ADDRESS}</p><p><strong>الايجار السنوي:</strong> {PRICE} {CURRENCY}</p><h3>مبلغ التامين</h3><p>{DEPOSIT_CLAUSE}</p>`,
    },
    [ContractType.SALES_AGREEMENT]: {
      [ContractLanguage.EN]: `<p>UAE Real Estate Sale Agreement (DLD Compliant)...</p>`,
      [ContractLanguage.AR]: `<p>عقد بيع عقار (متوافق مع دائرة الاراضي)...</p>`,
    },
    [ContractType.EVICTION_COMMITMENT]: { [ContractLanguage.EN]: `<p>UAE Eviction Notice (RERA Form C)...</p>` },
    [ContractType.EARNEST_MONEY]: { [ContractLanguage.EN]: `<p>MOU & Deposit Agreement (UAE)...</p>` },
    [ContractType.AGENCY_REPRESENTATION]: { [ContractLanguage.EN]: `<p>Form A - Listing Agreement (RERA)...</p>` },
    [ContractType.COMMERCIAL_LEASE]: { [ContractLanguage.EN]: `<p>Commercial Lease (RERA compliant)...</p>` },
    [ContractType.SHORT_TERM_BOOKING]: { [ContractLanguage.EN]: `<p>Short-Term Rental - DTCM License Required...</p>` },
  },
};

// ─────────────────────────────────────────────────────────────────────────────
export class ContractEngine {
  static generateContract(
    type: ContractType,
    region: RegionCode,
    data: ContractData,
    language: ContractLanguage = ContractLanguage.EN
  ): string {
    const regionalTemplates = ContractTemplates[region] ?? ContractTemplates[RegionCode.USA];
    const typeTemplates = regionalTemplates?.[type] ?? ContractTemplates[RegionCode.USA]?.[type];
    if (!typeTemplates) throw new Error(`Template for ${type} / ${region} not found.`);

    let template = typeTemplates[language]
      ?? typeTemplates[ContractLanguage.EN]
      ?? Object.values(typeTemplates)[0];
    if (!template) throw new Error(`No template for language ${language} / ${type}.`);

    // Deposit clause
    let depositClause = '';
    if (data.financials.isZeroDeposit) {
      depositClause = language === ContractLanguage.TR
        ? 'Kiraci, nakit depozito yerine Kefalet/Kira Garanti Sigortasi yaptirilmistir. Police sozlesmenin ekidir.'
        : 'Tenant opted for a Zero-Deposit Surety Bond. No cash deposit held. Policy attached as Exhibit A.';
    } else {
      depositClause = language === ContractLanguage.TR
        ? `Kiraci, guvence bedeli olarak <strong>${data.financials.depositAmount} ${data.financials.currency}</strong> Reservatior Escrow hesabina yatirmistir.`
        : `A security deposit of <strong>${data.financials.depositAmount} ${data.financials.currency}</strong> is held in a regulated Escrow account.`;
    }

    // Commission clause
    let commissionClause = '';
    if (type === ContractType.SALES_AGREEMENT && data.financials.commissionModel) {
      const clauseMap = CommissionModelClauses[data.financials.commissionModel];
      let raw = clauseMap[language] ?? clauseMap[ContractLanguage.EN] ?? '';
      
      // Dynamic Fee Labels & Legal Load Shifting Waivers
      if (data.financials.loadShiftedToLandlord) {
        if (language === ContractLanguage.TR) {
          raw += `\n[Yasal Feragatname] Alicidan/Kiracidan yerel mevzuat geregi hicbir ucret talep edilmemis olup, tum maliyetler Satici/Ev Sahibi tarafindan "${data.financials.landlordFeeLabel}" adi altinda karsilanmistir.`;
        } else if (language === ContractLanguage.DE) {
          raw += `\n[Haftungsausschluss] Gesetzlich bedingt wurden dem Kaeufer/Mieter keine Gebuehren in Rechnung gestellt. Alle Kosten werden vom Verkaeufer/Vermieter als "${data.financials.landlordFeeLabel}" getragen.`;
        } else {
          raw += `\n[Legal Waiver] By local law, no fees have been charged to the Buyer/Tenant. All costs are covered by the Seller/Landlord under the label "${data.financials.landlordFeeLabel}".`;
        }
      } else {
        if (data.financials.tenantFeeLabel && data.financials.tenantFeeLabel !== "Sales Commission") {
           if (language === ContractLanguage.TR) {
             raw += `\nAlici/Kiraci tarafindan odenen tutar "${data.financials.tenantFeeLabel}" olarak faturalandirilmistir.`;
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
    }

    return template
      .replace(/{LANDLORD_NAME}/g, data.landlordOrSeller.fullName)
      .replace(/{LANDLORD_ID}/g, data.landlordOrSeller.nationalIdOrTaxNo)
      .replace(/{TENANT_NAME}/g, data.tenantOrBuyer.fullName)
      .replace(/{TENANT_ID}/g, data.tenantOrBuyer.nationalIdOrTaxNo)
      .replace(/{PROPERTY_ADDRESS}/g, data.property.address)
      .replace(/{PROPERTY_CITY}/g, data.property.city)
      .replace(/{PROPERTY_PARCEL}/g, data.property.parcelId || 'N/A')
      .replace(/{PRICE}/g, String(data.financials.price))
      .replace(/{CURRENCY}/g, data.financials.currency)
      .replace(/{START_DATE}/g, data.financials.startDate)
      .replace(/{END_DATE}/g, data.financials.endDate || 'N/A')
      .replace(/{DEPOSIT_CLAUSE}/g, depositClause)
      .replace(/{COMMISSION_CLAUSE}/g, commissionClause)
      .replace(/{AGENT_NAME}/g, data.agent?.fullName || 'N/A')
      .replace(/{AGENT_LICENSE}/g, data.agent?.licenseNo || 'N/A')
      .replace(/{AGENT_COMMISSION}/g, String(data.agent?.commissionRate ?? 0));
  }

  /** Ayni sozlesmeyi birden fazla dilde uret */
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
}
