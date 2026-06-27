/**
 * Reservatior Global Rental Compliance Engine
 * 
 * Bu motor, farklı Avrupa ülkelerindeki (ES, UK, DE, FR, vb.) 
 * "Kiracı Koruma Yasalarına" göre yasal komisyon hesaplamalarını, 
 * Açık Bankacılık (Open Banking) işlem kurallarını ve
 * depozito taksitlendirme limitlerini yönetir.
 */

export type CountryCode = 'ES' | 'UK' | 'DE' | 'FR' | 'IT' | 'NL' | 'AE' | 'TR';
export type RentalTerm = 'LONG_TERM' | 'MID_TERM' | 'SHORT_TERM';

export interface ComplianceRequest {
  countryCode: CountryCode;
  rentalTerm: RentalTerm;
  monthlyRent: number;
  squareMeters?: number; // Fransa Loi ALUR gibi metrekare tabanlı cap'ler için
  requestedDepositAmount: number; // Ev sahibinin talep ettiği depozito
}

export interface ComplianceResponse {
  isLegal: boolean;
  landlordCommissionPct: number;
  tenantCommissionPct: number;
  tenantServiceFeePct: number; // Komisyon olmayan, "Premium Paket" adı altındaki ücret
  maxDepositAllowed: number; // Yasal olarak alınabilecek maksimum depozito
  depositInstallmentsAllowed: boolean;
  maxInstallmentMonths: number;
  complianceNotes: string[];
}

export class RentalComplianceEngine {
  
  static evaluate(request: ComplianceRequest): ComplianceResponse {
    const { countryCode, rentalTerm, monthlyRent, squareMeters, requestedDepositAmount } = request;

    let response: ComplianceResponse = {
      isLegal: true,
      landlordCommissionPct: 0,
      tenantCommissionPct: 0,
      tenantServiceFeePct: 0,
      maxDepositAllowed: requestedDepositAmount,
      depositInstallmentsAllowed: false,
      maxInstallmentMonths: 1,
      complianceNotes: []
    };

    switch (countryCode) {
      case 'ES': // İspanya - Ley 12/2023 (Nueva Ley de Vivienda)
        if (rentalTerm === 'LONG_TERM') {
          // Uzun dönemde kiracıdan emlak komisyonu almak YASAKTIR.
          response.landlordCommissionPct = 3.5;
          response.tenantCommissionPct = 0.0;
          // Kiracıya %3.5 opsiyonel "Open Banking Premium Service" satabiliriz.
          response.tenantServiceFeePct = 3.5; 
          
          // İspanya'da LAU'ya göre konutlar için yasal depozito max 1 aydır. 
          // (Ek garanti - fianza adicional - olarak 2 ay daha istenebilir, toplam 3 ay)
          response.maxDepositAllowed = monthlyRent * 3; 
          
          if (requestedDepositAmount > response.maxDepositAllowed) {
            response.isLegal = false;
            response.complianceNotes.push('HATA: İspanya yasalarına göre depozito + ek garanti toplamı 3 aylık kirayı aşamaz.');
          }

          response.depositInstallmentsAllowed = true;
          response.maxInstallmentMonths = 6; // Open Banking ile 6 taksite kadar izin veriyoruz
          response.complianceNotes.push('BİLGİ: Uzun dönem kiralama. Kiracı hizmet bedeli ZORUNLU DEĞİL, opsiyonel Premium Paket olarak sunulmalıdır.');
        } else {
          // Orta Dönem (Temporada) yasaya tabi değildir. 
          response.landlordCommissionPct = 3.5;
          response.tenantCommissionPct = 3.5; 
          response.maxDepositAllowed = monthlyRent * 2;
          response.depositInstallmentsAllowed = true;
          response.maxInstallmentMonths = 3;
        }
        break;

      case 'UK': // Birleşik Krallık - Tenant Fees Act 2019
        // Kiracıdan hiçbir surette ücret/hizmet bedeli alınamaz.
        response.landlordCommissionPct = 7.0; // Tüm maliyet ev sahibine
        response.tenantCommissionPct = 0.0;
        response.tenantServiceFeePct = 0.0; 

        // Yasal sınır: Yıllık kira £50k altındaysa max 5 hafta depozito.
        const maxWeeksDeposit = (monthlyRent * 12) < 50000 ? 5 : 6;
        response.maxDepositAllowed = (monthlyRent / 4.33) * maxWeeksDeposit;

        if (requestedDepositAmount > response.maxDepositAllowed) {
          response.isLegal = false;
          response.complianceNotes.push(`HATA: UK Tenant Fees Act gereği depozito maksimum ${maxWeeksDeposit} hafta olabilir.`);
        }

        response.depositInstallmentsAllowed = true;
        response.maxInstallmentMonths = 3; // Open Banking Direct Debit/VRP ile
        response.complianceNotes.push('BİLGİ: Tenant Fees Act devrede. Kiracıdan hiçbir ücret alınamaz.');
        break;

      case 'DE': // Almanya - Bestellerprinzip (Siparişi veren öder)
        response.landlordCommissionPct = 7.0; 
        response.tenantCommissionPct = 0.0;
        response.tenantServiceFeePct = 0.0; 

        // Almanya'da yasal depozito (Kaution) max 3 aylık soğuk kiradır (Kaltmiete).
        response.maxDepositAllowed = monthlyRent * 3;
        
        // Yasa gereği kiracının depozitoyu 3 taksitte ödeme HAKKI vardır.
        response.depositInstallmentsAllowed = true;
        response.maxInstallmentMonths = 3; 

        response.complianceNotes.push('BİLGİ: Bestellerprinzip devrede. Platform hizmetini ev sahibi başlattığı için komisyonu sadece ev sahibi öder.');
        response.complianceNotes.push('BİLGİ: Almanya yasaları gereği kiracının depozitoyu 3 taksitte ödeme hakkı saklıdır.');
        break;

      case 'FR': // Fransa - Loi ALUR
        response.landlordCommissionPct = 3.5;
        // Fransa'da kiracıdan komisyon alınabilir ama metrekare bazlı bir TAVAN (Cap) vardır.
        // Ortalama zone için 12€/m² + 3€/m² envanter = 15€/m² maksimum kiracı ücreti.
        const maxTenantFeeAlur = (squareMeters || 0) * 15;
        const requestedTenantFee = monthlyRent * 12 * 0.035; // Yıllık kiranın %3.5'i

        if (squareMeters && requestedTenantFee > maxTenantFeeAlur) {
          // Tavan aşıldı, kiracı ücretini yasal sınıra çek
          response.tenantCommissionPct = 0.0; // Yüzde bazlı kullanma
          response.tenantServiceFeePct = (maxTenantFeeAlur / (monthlyRent * 12)) * 100;
          response.complianceNotes.push(`BİLGİ: Loi ALUR tavanı uygulandı. Kiracı ücreti €${maxTenantFeeAlur} olarak sınırlandırıldı.`);
        } else {
          response.tenantCommissionPct = 3.5;
        }
        
        response.maxDepositAllowed = monthlyRent * 1; // Eşyasız için max 1 ay (Eşyalı 2 ay olabilir)
        response.depositInstallmentsAllowed = true;
        response.maxInstallmentMonths = 3;
        break;

      case 'NL': // Hollanda - Dienen van twee heren (İki efendiye hizmet yasağı)
        response.landlordCommissionPct = 7.0;
        response.tenantCommissionPct = 0.0;
        response.tenantServiceFeePct = 0.0;
        response.maxDepositAllowed = monthlyRent * 2; // Yasal max 2 ay
        response.depositInstallmentsAllowed = true;
        response.maxInstallmentMonths = 2;
        response.complianceNotes.push('BİLGİ: Hollanda yasaları gereği ikili temsil (hem kiracıdan hem ev sahibinden komisyon alma) yasaktır.');
        break;

      case 'IT': // İtalya - Provvigione
        // İtalya'da her iki taraftan komisyon almak tamamen yasaldır ve standarttır.
        response.landlordCommissionPct = 3.5;
        response.tenantCommissionPct = 3.5;
        response.maxDepositAllowed = monthlyRent * 3; // Yasal max 3 ay (Caparra)
        response.depositInstallmentsAllowed = true;
        response.maxInstallmentMonths = 3;
        response.complianceNotes.push('BİLGİ: İtalya pazarında her iki taraftan komisyon almak yasal standarttır.');
        break;

      default:
        // TR ve AE gibi pazarlar için standart varsayım (Serbest Piyasa)
        response.landlordCommissionPct = 3.5;
        response.tenantCommissionPct = 3.5;
        response.maxDepositAllowed = monthlyRent * 3;
        response.depositInstallmentsAllowed = true;
        response.maxInstallmentMonths = 6;
        break;
    }

    return response;
  }
}
