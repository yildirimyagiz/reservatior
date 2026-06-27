import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export interface OBConsentRequest {
  tenantId: string;
  bankId: string;
  redirectUrl: string;
}

export interface OBPaymentRequest {
  tenantId: string;
  reservationId: string;
  amount: number;
  currency: string;
  bankId: string;
  redirectUrl: string;
  reference: string;
}

export interface OBVRPMandateRequest {
  tenantId: string;
  leaseId: string;
  negotiationId?: string;
  maxAmountPerMonth: number;
  currency: string;
  bankId: string;
  redirectUrl: string;
  validUntil: Date;
}

export enum PaymentMethodType {
  UPFRONT_CASH = 'UPFRONT_CASH', // 6 veya 12 Aylık Peşin Ödeme
  OPEN_BANKING_TRANSFER = 'OPEN_BANKING_TRANSFER', // Havale / FAST
  CREDIT_CARD = 'CREDIT_CARD' // Pazaryeri Sanal POS
}

export interface PaymentDiscountOptions {
  baseRentAmount: number;
  paymentMethod: PaymentMethodType;
  monthsPaidUpfront?: number; // Sadece UPFRONT_CASH için geçerli (örn: 6 veya 12)
  countryCode: string; // Yasal düzenlemeler için
}

export interface CalculatedPayment {
  originalRent: number;
  finalRent: number;
  discountApplied: number; // Yüzde olarak (örn: 10)
  discountAmount: number; // Tutar olarak (örn: 120 EUR)
  convenienceFee: number; // Kredi kartı işlem bedeli (varsa)
  totalPayable: number;
  notes: string[];
}

/**
 * Reservatior Open Banking Service (PSD2 - AISP / PISP / VRP)
 * Bu servis, bankadan bankaya doğrudan transferleri, depozito taksitlendirmelerini,
 * gelir doğrulamasını ve ödeme yöntemine göre "Dinamik İndirim/Komisyon" (Dynamic Pricing) hesaplamalarını yönetir.
 */
export class OpenBankingService {

  /**
   * Ödeme Yöntemine Göre Kira İndirimi Hesaplama Motoru (Tüm Ülkeler İçin)
   * Kiracı peşin öderse %10'a varan indirim kazanır. Kredi kartı seçerse banka komisyonu yansıtılır.
   */
  static calculateDynamicRent(options: PaymentDiscountOptions): CalculatedPayment {
    let result: CalculatedPayment = {
      originalRent: options.baseRentAmount,
      finalRent: options.baseRentAmount,
      discountApplied: 0,
      discountAmount: 0,
      convenienceFee: 0,
      totalPayable: options.baseRentAmount,
      notes: []
    };

    switch (options.paymentMethod) {
      case PaymentMethodType.UPFRONT_CASH:
        // Peşin Ödeme: 6 aylık peşinatta %5, 12 aylık peşinatta %10 indirim
        if (options.monthsPaidUpfront && options.monthsPaidUpfront >= 12) {
          result.discountApplied = 10;
        } else if (options.monthsPaidUpfront && options.monthsPaidUpfront >= 6) {
          result.discountApplied = 5;
        } else {
          result.discountApplied = 2; // Sadece 1 aylık peşin (erken ödeme) indirimi
        }
        
        result.discountAmount = (result.originalRent * result.discountApplied) / 100;
        result.finalRent = result.originalRent - result.discountAmount;
        result.totalPayable = result.finalRent * (options.monthsPaidUpfront || 1);
        result.notes.push(`Peşin Ödeme İndirimi: %${result.discountApplied} uygulanarak kira ${result.finalRent} birime düşürüldü.`);
        break;

      case PaymentMethodType.OPEN_BANKING_TRANSFER:
        // Açık Bankacılık: Platformun ana hedeflenen ödeme yöntemi. İndirim/Ceza yok (Baz Fiyat)
        // İsteğe bağlı olarak kiracıyı teşvik etmek için %1 platform promosyonu verilebilir.
        result.discountApplied = 0;
        result.notes.push('Açık Bankacılık Transferi: Komisyon yansıtılmadı (Sıfır işlem ücreti).');
        break;

      case PaymentMethodType.CREDIT_CARD:
        // Kredi Kartı: Tüm ülkeler için Iyzico / Stripe / Redsys komisyonunu kiracıya yansıtıyoruz.
        // Ortalama Sanal POS komisyonu %1.5 olarak alınmıştır (Türkiye TROY veya İş Bankası VPOS ortalaması)
        const gatewayFeePct = 1.5; 
        result.convenienceFee = (result.originalRent * gatewayFeePct) / 100;
        result.totalPayable = result.originalRent + result.convenienceFee;
        result.notes.push(`Kredi Kartı İşlem Bedeli: Banka komisyonu (%${gatewayFeePct}) nedeniyle +${result.convenienceFee} birim sepete eklendi.`);
        break;
    }

    return result;
  }

  
  /**
   * AISP: Hesap Bilgisi Servisi İzni (Consent)
   * Kiracının gelirini teyit etmek için bankasından 90 günlük hesap dökümüne salt okunur erişim izni alır.
   */
  static async createAccountConsent(req: OBConsentRequest) {
    console.log(`[OpenBanking] Creating AISP Consent for tenant ${req.tenantId} at bank ${req.bankId}`);
    
    // TODO: Burada gerçek bir Open Banking provider (örn: Tink, GoCardless, Nordigen) API'sine istek atılacak.
    const mockConsentId = `ob_consent_${Date.now()}`;
    const mockAuthUrl = `https://openbanking-sandbox.reservatior.com/auth?consentId=${mockConsentId}&redirect=${encodeURIComponent(req.redirectUrl)}`;

    return {
      consentId: mockConsentId,
      authorizationUrl: mockAuthUrl,
      status: 'AWAITING_AUTHORIZATION'
    };
  }

  /**
   * PISP: Tek Seferlik Ödeme Başlatma (Payment Initiation)
   * İlk depozito taksiti veya ilk kira ödemesi için kullanıcıyı bankasına yönlendirir.
   */
  static async initiateSinglePayment(req: OBPaymentRequest) {
    console.log(`[OpenBanking] Initiating PISP transfer of ${req.amount} ${req.currency} for reservation ${req.reservationId}`);
    
    // 1. Gerçek API'ye bağlanıp PaymentIntent (Ödeme Niyeti) oluştur.
    const mockPaymentId = `ob_pay_${Date.now()}`;
    const mockAuthUrl = `https://openbanking-sandbox.reservatior.com/pay?paymentId=${mockPaymentId}&redirect=${encodeURIComponent(req.redirectUrl)}`;

    // 2. Veritabanında (Prisma) bu ödemeyi PENDING olarak kaydet.
    const paymentRecord = await prisma.payment.create({
      data: {
        tenantId: req.tenantId,
        reservationId: req.reservationId,
        amount: req.amount,
        currencyId: 'cuid-eur', // Gerçek ID ile değiştirilmeli
        paymentDate: new Date(),
        dueDate: new Date(),
        status: 'UNPAID',
        obPaymentId: mockPaymentId,
        obBankId: req.bankId,
        obStatus: 'PENDING',
        reference: req.reference
      }
    });

    return {
      paymentId: mockPaymentId,
      dbPaymentId: paymentRecord.id,
      authorizationUrl: mockAuthUrl,
      status: 'AWAITING_AUTHORIZATION'
    };
  }

  /**
   * VRP: Düzenli Ödeme Yetkisi Alma (Variable Recurring Payments Mandate)
   * Kalan taksitler ve aylık kiranın her ay kullanıcıdan habersiz çekilebilmesi için yetki (Mandate) alır.
   */
  static async setupRecurringMandate(req: OBVRPMandateRequest) {
    console.log(`[OpenBanking] Setting up VRP Mandate for tenant ${req.tenantId}, max amount: ${req.maxAmountPerMonth}`);
    
    const mockMandateId = `ob_vrp_${Date.now()}`;
    const mockAuthUrl = `https://openbanking-sandbox.reservatior.com/vrp-auth?mandateId=${mockMandateId}&redirect=${encodeURIComponent(req.redirectUrl)}`;

    return {
      mandateId: mockMandateId,
      authorizationUrl: mockAuthUrl,
      status: 'AWAITING_AUTHORIZATION'
    };
  }

  /**
   * VRP: Düzenli Ödemeyi Çekme (Execute Recurring Payment)
   * Ayın 1'i geldiğinde cron-job tarafından tetiklenerek daha önce alınan `mandateId` ile parayı anında çeker.
   */
  static async executeRecurringPayment(mandateId: string, amount: number, reference: string) {
    console.log(`[OpenBanking] Executing VRP for mandate ${mandateId}, amount: ${amount}`);
    
    // Gerçek API Call (örn: POST /open-banking/vrp/execute)
    const mockPaymentId = `ob_pay_vrp_${Date.now()}`;

    // Varsayalım banka anında onay verdi.
    return {
      success: true,
      paymentId: mockPaymentId,
      executedAmount: amount,
      status: 'COMPLETED'
    };
  }
}
