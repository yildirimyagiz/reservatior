// server/config/contract-engine.ts
// AI-Driven Legal Document & Smart Contract Generator
// Automatically generates region-specific legal documents by injecting real-time transaction data.

import { RegionCode } from './ai-yield-optimization';

export enum ContractType {
  RESIDENTIAL_LEASE = 'RESIDENTIAL_LEASE',       // Konut Kira Sözleşmesi
  COMMERCIAL_LEASE = 'COMMERCIAL_LEASE',         // Ticari Kira Sözleşmesi
  SHORT_TERM_BOOKING = 'SHORT_TERM_BOOKING',     // Kısa Dönem / Tatil Rezervasyonu
  SALES_AGREEMENT = 'SALES_AGREEMENT',           // Gayrimenkul Satış Sözleşmesi
  EARNEST_MONEY = 'EARNEST_MONEY',               // Kaparo / Cayma Akçesi Sözleşmesi
  EVICTION_COMMITMENT = 'EVICTION_COMMITMENT',   // Tahliye Taahhütnamesi (Çok Önemli - TR)
  AGENCY_REPRESENTATION = 'AGENCY_REPRESENTATION'// Acente/Emlakçı Yetki Belgesi
}

export interface ContractData {
  property: {
    id: string;
    address: string;
    city: string;
    parcelId?: string; // Ada/Parsel
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
    isZeroDeposit: boolean; // Obligo/Rhino Entegrasyonu
  };
}

/**
 * Contract Template Registry by Region and Type
 * The {VARIABLES} will be replaced dynamically by the engine.
 */
const ContractTemplates: Record<string, Record<ContractType, string>> = {
  [RegionCode.TR]: {
    [ContractType.RESIDENTIAL_LEASE]: `
      <h1 style="text-align:center;">KONUT KİRA SÖZLEŞMESİ</h1>
      <p><strong>Kiraya Veren:</strong> {LANDLORD_NAME} (TC/VKN: {LANDLORD_ID})</p>
      <p><strong>Kiracı:</strong> {TENANT_NAME} (TC/VKN: {TENANT_ID})</p>
      <p><strong>Kiralanan Mecur:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY} (Ada/Parsel: {PROPERTY_PARCEL})</p>
      <p><strong>Kira Bedeli:</strong> {PRICE} {CURRENCY} / Ay</p>
      <p><strong>Başlangıç Tarihi:</strong> {START_DATE}</p>
      <h3>Madde 1 - Depozito ve Güvence</h3>
      <p>{DEPOSIT_CLAUSE}</p>
      <p>İşbu sözleşme tarafların dijital onayı (Reservatior Escrow Sistemi) ile {START_DATE} tarihinde akdedilmiştir.</p>
    `,
    [ContractType.EVICTION_COMMITMENT]: `
      <h1 style="text-align:center;">TAHLİYE TAAHHÜTNAMESİ</h1>
      <p><strong>Taahhüt Eden (Kiracı):</strong> {TENANT_NAME}</p>
      <p><strong>Malik (Kiraya Veren):</strong> {LANDLORD_NAME}</p>
      <p>Halen kiracı olarak kullanmakta olduğum <em>{PROPERTY_ADDRESS}</em> adresindeki mecuru, hiçbir ihtara ve ihbara gerek kalmaksızın <strong>{END_DATE}</strong> tarihinde kayıtsız şartsız boşaltıp, sağlam ve eksiksiz olarak teslim edeceğimi beyan ve taahhüt ederim.</p>
    `,
    [ContractType.EARNEST_MONEY]: `
      <h1 style="text-align:center;">KAPARO VE REZERVASYON SÖZLEŞMESİ</h1>
      <p>Alıcı/Kiracı {TENANT_NAME}, {PROPERTY_ADDRESS} adresindeki taşınmazın işlemi için {PRICE} {CURRENCY} tutarında kaparoyu Reservatior Escrow Havuzuna yatırmıştır. Taraflardan biri haksız cayarsa, Reservatior Akıllı Sözleşme kuralları gereği kaparo irat kaydedilir veya iade edilir.</p>
    `,
    [ContractType.AGENCY_REPRESENTATION]: `
      <h1 style="text-align:center;">EMLAK YETKİ VE TEMSİL SÖZLEŞMESİ</h1>
      <p><strong>Yetkilendirilen Acente:</strong> {AGENT_NAME} (Lisans: {AGENT_LICENSE})</p>
      <p>Yukarıda bilgileri verilen mülkün pazarlanması ve işleme dönüştürülmesi için, işlem bedelinin %{AGENT_COMMISSION}'u oranında hizmet bedeli ödenecektir.</p>
    `,
    // Diğer sözleşmeler buraya eklenebilir (Ticari, Satış vb.)
    [ContractType.COMMERCIAL_LEASE]: `<p>Ticari Kira Sözleşmesi Şablonu...</p>`,
    [ContractType.SHORT_TERM_BOOKING]: `<p>Kısa Dönem Konaklama Sözleşmesi...</p>`,
    [ContractType.SALES_AGREEMENT]: `<p>Gayrimenkul Satış Vaadi Sözleşmesi...</p>`,
  },
  [RegionCode.USA]: {
    [ContractType.RESIDENTIAL_LEASE]: `
      <h1 style="text-align:center;">RESIDENTIAL LEASE AGREEMENT</h1>
      <p><strong>Landlord:</strong> {LANDLORD_NAME}</p>
      <p><strong>Tenant:</strong> {TENANT_NAME}</p>
      <p><strong>Premises:</strong> {PROPERTY_ADDRESS}, {PROPERTY_CITY}</p>
      <p><strong>Rent:</strong> {PRICE} {CURRENCY} / Month</p>
      <h3>Security Deposit</h3>
      <p>{DEPOSIT_CLAUSE}</p>
    `,
    [ContractType.EVICTION_COMMITMENT]: `<p>Not strictly applicable in US in advance (requires court), mapped to Notice of Intent to Vacate.</p>`,
    [ContractType.EARNEST_MONEY]: `<p>Earnest Money Escrow Agreement...</p>`,
    [ContractType.AGENCY_REPRESENTATION]: `<p>Exclusive Right to Sell/Lease Agreement...</p>`,
    [ContractType.COMMERCIAL_LEASE]: `<p>Commercial NNN Lease Agreement...</p>`,
    [ContractType.SHORT_TERM_BOOKING]: `<p>Short-Term Vacation Rental Agreement...</p>`,
    [ContractType.SALES_AGREEMENT]: `<p>Real Estate Purchase and Sale Agreement...</p>`,
  }
};

/**
 * Engine to compile the contract by replacing markers with real data
 */
export class ContractEngine {
  static generateContract(type: ContractType, region: RegionCode, data: ContractData): string {
    // 1. Ülkeye uygun şablonu al (Bulunamazsa ABD/Global varsayılanı kullan)
    const regionalTemplates = ContractTemplates[region] || ContractTemplates[RegionCode.USA];
    let template = regionalTemplates[type];

    if (!template) {
      throw new Error(`Template for \${type} in region \${region} not found.`);
    }

    // 2. Dinamik Depozito Maddesi (Zero-Deposit vs Nakit)
    let depositClause = "";
    if (data.financials.isZeroDeposit) {
      if (region === RegionCode.TR) {
        depositClause = `Kiracı, nakit depozito ödemek yerine yetkili bir sigorta kuruluşundan <strong>Kefalet/Kira Garanti Sigortası</strong> yaptırmış olup, ilgili poliçe işbu sözleşmenin ayrılmaz bir parçasıdır. Nakit depozito alınmamıştır.`;
      } else {
        depositClause = `Tenant has opted for a Zero-Deposit Surety Bond via Obligo/Rhino. No cash deposit is held in escrow. Policy attached.`;
      }
    } else {
      if (region === RegionCode.TR) {
        depositClause = `Kiracı, güvence bedeli olarak <strong>\${data.financials.depositAmount} \${data.financials.currency}</strong> tutarını Reservatior Escrow (Emanet) hesabına yatırmıştır.`;
      } else {
        depositClause = `A security deposit of <strong>\${data.financials.depositAmount} \${data.financials.currency}</strong> is held in a trusted Escrow account.`;
      }
    }

    // 3. Verileri Enjekte Et (String Replace)
    return template
      .replace(/{LANDLORD_NAME}/g, data.landlordOrSeller.fullName)
      .replace(/{LANDLORD_ID}/g, data.landlordOrSeller.nationalIdOrTaxNo)
      .replace(/{TENANT_NAME}/g, data.tenantOrBuyer.fullName)
      .replace(/{TENANT_ID}/g, data.tenantOrBuyer.nationalIdOrTaxNo)
      .replace(/{PROPERTY_ADDRESS}/g, data.property.address)
      .replace(/{PROPERTY_CITY}/g, data.property.city)
      .replace(/{PROPERTY_PARCEL}/g, data.property.parcelId || 'Bilinmiyor')
      .replace(/{PRICE}/g, data.financials.price.toString())
      .replace(/{CURRENCY}/g, data.financials.currency)
      .replace(/{START_DATE}/g, data.financials.startDate)
      .replace(/{END_DATE}/g, data.financials.endDate || 'Belirtilmedi')
      .replace(/{DEPOSIT_CLAUSE}/g, depositClause)
      .replace(/{AGENT_NAME}/g, data.agent?.fullName || 'N/A')
      .replace(/{AGENT_LICENSE}/g, data.agent?.licenseNo || 'N/A')
      .replace(/{AGENT_COMMISSION}/g, data.agent?.commissionRate?.toString() || '0');
  }
}

/*
// Örnek Kullanım:
const htmlDoc = ContractEngine.generateContract(ContractType.RESIDENTIAL_LEASE, RegionCode.TR, {
  property: { id: "p-1", address: "Kanyon Residans No:4", city: "İstanbul", type: "Daire" },
  landlordOrSeller: { fullName: "Ahmet Yılmaz", nationalIdOrTaxNo: "12345678901", address: "" },
  tenantOrBuyer: { fullName: "Mehmet Demir", nationalIdOrTaxNo: "98765432109", address: "" },
  financials: { price: 35000, currency: "TL", isZeroDeposit: true, startDate: "01.06.2026" }
});
*/
