import { prisma } from "../../lib/prisma";

// ─────────────────────────────────────────────────────────────
// KATMAN 1: CREDIT ENFORCEMENT (Zorunlu Gate - Fail Fast)
// ─────────────────────────────────────────────────────────────

/**
 * Kredi bakiyesi var mı diye kontrol eder. Yoksa veya yetersizse hemen fırlatır.
 * Bu fonksiyon HİÇBİR ŞEY yazmaz, sadece okur ve karar verir.
 */
export async function enforceAICredits(userId: string, cost: number): Promise<boolean> {
  const balance = await prisma.aICreditBalance.findUnique({
    where: { userId },
  });

  if (!balance) throw new Error("NO_CREDIT_ACCOUNT");

  // Aylık sıfırlama kontrolü
  if (new Date() >= new Date(balance.resetAt)) {
    await prisma.aICreditBalance.update({
      where: { userId },
      data: {
        consumed: 0,
        resetAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
      },
    });
    // Sıfırlandıktan sonra bakiye yeterli
    return true;
  }

  const totalAvailable =
    balance.monthlyQuota + balance.purchasedQuota - balance.consumed;

  if (totalAvailable < cost) {
    throw new Error("INSUFFICIENT_CREDITS");
  }

  return true;
}

// ─────────────────────────────────────────────────────────────
// KATMAN 2: CREDIT DEDUCTION (Single Source of Truth - Atomic)
// ─────────────────────────────────────────────────────────────

/**
 * AI işlemi BAŞARILI olduktan sonra çağrılır.
 * Prisma $transaction ile atomik olarak bakiye düşer + ledger yazılır.
 * İkisi birden ya olur ya olmaz — tutarsızlık imkansız.
 */
export async function deductAICredits(
  userId: string,
  cost: number,
  actionType: string,
  metadata?: Record<string, any>
) {
  return await prisma.$transaction(async (tx) => {
    const balance = await tx.aICreditBalance.findUnique({
      where: { userId },
    });

    if (!balance) throw new Error("NO_CREDIT_ACCOUNT");

    const updated = await tx.aICreditBalance.update({
      where: { userId },
      data: {
        consumed: balance.consumed + cost,
      },
    });

    const remaining = updated.monthlyQuota + updated.purchasedQuota - updated.consumed;

    await tx.aICreditLedger.create({
      data: {
        userId,
        amount: -cost,
        balance: remaining,
        actionType,
        metadata: metadata ?? undefined,
      },
    });

    return { remaining };
  });
}

// ─────────────────────────────────────────────────────────────
// KATMAN 3: COST ESTIMATION (Dynamic & Scalable)
// ─────────────────────────────────────────────────────────────

/**
 * Sorgunun karmaşıklığına göre dinamik maliyet hesaplar.
 * Basit bir "1 kredi" değil — sorgu uzunluğu, POI talebi,
 * karşılaştırma isteği gibi faktörlere göre ölçeklenir.
 */
export function estimateAICost(input: {
  query?: string;
  includePOI?: boolean;
  isCompare?: boolean;
  isValuation?: boolean;
}): number {
  let base = 1;

  // Uzun/karmaşık sorgular daha fazla token harcar
  const complexityMultiplier =
    (input.query?.length || 1) > 100 ? 3 :
    (input.query?.length || 1) > 50 ? 2 : 1;

  // POI (Çevrede neler var) = harici API çağrısı + zenginleştirme
  if (input.includePOI) {
    base += 2;
  }

  // Karşılaştırma = çoklu sonuç analizi
  if (input.isCompare) {
    base += 1;
  }

  // Değerleme = ağır hesaplama
  if (input.isValuation) {
    base += 3;
  }

  return base * complexityMultiplier;
}

// ─────────────────────────────────────────────────────────────
// YARDIMCI: Anonim Kullanıcı Günlük Limit
// ─────────────────────────────────────────────────────────────

const ANONYMOUS_DAILY_LIMIT = 5;
const anonUsage = new Map<string, { count: number; resetAt: number }>();

export function checkAnonymousLimit(ipAddress: string): boolean {
  const now = Date.now();
  const entry = anonUsage.get(ipAddress);

  if (!entry || now >= entry.resetAt) {
    anonUsage.set(ipAddress, { count: 1, resetAt: now + 24 * 60 * 60 * 1000 });
    return true;
  }

  if (entry.count >= ANONYMOUS_DAILY_LIMIT) {
    return false;
  }

  entry.count++;
  return true;
}

// ─────────────────────────────────────────────────────────────
// YARDIMCI: Bakiye Sorgulama & Top-Up
// ─────────────────────────────────────────────────────────────

export async function getBalance(userId: string) {
  const balance = await prisma.aICreditBalance.upsert({
    where: { userId },
    create: { userId, monthlyQuota: 100, purchasedQuota: 0, consumed: 0 },
    update: {},
  });

  return {
    monthlyQuota: balance.monthlyQuota,
    purchased: balance.purchasedQuota,
    consumed: balance.consumed,
    remaining: balance.monthlyQuota + balance.purchasedQuota - balance.consumed,
    resetsAt: balance.resetAt,
  };
}

export async function topUp(userId: string, amount: number) {
  return await prisma.$transaction(async (tx) => {
    const updated = await tx.aICreditBalance.upsert({
      where: { userId },
      create: { userId, monthlyQuota: 100, purchasedQuota: amount, consumed: 0 },
      update: { purchasedQuota: { increment: amount } },
    });

    const remaining = updated.monthlyQuota + updated.purchasedQuota - updated.consumed;

    await tx.aICreditLedger.create({
      data: {
        userId,
        amount: amount,
        balance: remaining,
        actionType: "TOPUP",
      },
    });

    return { remaining };
  });
}

// ─────────────────────────────────────────────────────────────
// YARDIMCI: Yeni Kullanıcı İçin Kredi Hesabı Oluştur
// ─────────────────────────────────────────────────────────────

export async function ensureCreditAccount(userId: string, monthlyQuota: number = 100) {
  return await prisma.aICreditBalance.upsert({
    where: { userId },
    create: { userId, monthlyQuota, purchasedQuota: 0, consumed: 0 },
    update: {},
  });
}
