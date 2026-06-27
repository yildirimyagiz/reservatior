import prismaManager from "../lib/prisma";
import * as fs from "node:fs";
import * as path from "node:path";
import { parse } from "csv-parse/sync";

const USA_DIR = "/Users/os2026/Downloads/Reservatior/datalar/airbnb/usa";
const REGION = "US";

/** 
 * Tüm CSV Dosyalarını Tarama 
 */
function findCsvFiles(dir: string, fileList: string[] = []): string[] {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      findCsvFiles(filePath, fileList);
    } else if (filePath.endsWith(".csv")) {
      fileList.push(filePath);
    }
  }
  return fileList;
}

/**
 * 💡 ARBITRAJ VE YÖNETİM FIRSATI HESAPLAMA MOTORU 💡
 * 
 * Tahmini Gelir (Estimated Revenue) Formülü:
 * Aylık Gelir ≈ Gecelik Fiyat x (Aylık Yorum Sayısı / Yorum Bırakma Oranı) x Ortalama Konaklama Süresi
 * (Genel Kabul: Misafirlerin ortalama %50'si yorum bırakır, ortalama konaklama 3 gecedir)
 */
async function processArbitrageAnalytics(prisma: any, filePath: string) {
  const raw = fs.readFileSync(filePath, "utf8");
  const rows: any[] = parse(raw, { columns: true, skip_empty_lines: true });

  const REVIEW_RATE = 0.50; // Misafirlerin %50'si yorum yapar varsayımı
  const AVG_STAY_DAYS = 3;  // Ortalama 3 gece konaklama
  const LONG_TERM_RENT_ESTIMATE = 2500; // Örnek: Bölgedeki ortalama uzun dönem kira bedeli

  let updatedCount = 0;
  let arbitrageCount = 0;
  let managementCount = 0;

  for (const row of rows) {
    const airbnbId = row.id?.toString();
    if (!airbnbId) continue;

    const propertyId = `airbnb_us_${airbnbId}`;

    // Fiyat ve Yorum verilerini parse et
    let rawPrice = row.price || "0";
    rawPrice = rawPrice.replace(/[^0-9.]/g, "");
    const price = parseFloat(rawPrice) || 0;

    const reviewsPerMonth = parseFloat(row.reviews_per_month) || 0;
    const reviewScore = parseFloat(row.review_scores_rating) || 0;
    const reviewCount = parseInt(row.number_of_reviews) || 0;

    // Tahmini Aylık Gelir Hesaplama
    // (Aylık Yorum / Yorum Bırakma Oranı) = Aylık Rezervasyon Sayısı
    // Rezervasyon Sayısı * Ortalama Gün = Dolu Gün Sayısı
    // Dolu Gün Sayısı * Gecelik Fiyat = Aylık Ciro
    const estimatedBookingsPerMonth = reviewsPerMonth / REVIEW_RATE;
    const estimatedOccupiedDays = estimatedBookingsPerMonth * AVG_STAY_DAYS;
    
    // Doluluk oranı (Max 30 gün)
    const occupancyRate = Math.min(estimatedOccupiedDays / 30, 1.0) * 100;
    const estimatedMonthlyRevenue = Math.min(estimatedOccupiedDays, 30) * price;

    // Fırsat Tespiti Algoritmaları
    // 1. Arbitraj Fırsatı: Ev Airbnb'den aylık uzun dönem kirasından (örn 2500$) daha az kazanıyorsa
    // Ev sahibi zarar ediyordur veya yoruluyordur. Gidip evi uzun dönem kiralayarak biz yönetebiliriz!
    const isArbitrageOpp = estimatedMonthlyRevenue > 0 && estimatedMonthlyRevenue < LONG_TERM_RENT_ESTIMATE;

    // 2. Yönetim Fırsatı: Ev iyi para kazanıyor (>4000$) ama misafir puanı düşük (<4.5).
    // Ev sahibi yönetemiyor veya temizlik kötü. Yönetimini devralıp puanı artırarak komisyon alabiliriz!
    const isManagementOpp = estimatedMonthlyRevenue > 4000 && reviewScore > 0 && reviewScore < 4.5;

    try {
      // Veritabanındaki Property modelini Analitik verilerle güncelle
      await prisma.property.update({
        where: { id: propertyId },
        data: {
          strEstimatedRevenue: estimatedMonthlyRevenue,
          strOccupancyRate: occupancyRate,
          strReviewScore: reviewScore,
          strReviewCount: reviewCount,
          arbitrageOpportunity: isArbitrageOpp,
          managementOpportunity: isManagementOpp,
        }
      });
      updatedCount++;
      if (isArbitrageOpp) arbitrageCount++;
      if (isManagementOpp) managementCount++;

    } catch (err) {
      // Property veritabanında yoksa atla
      continue;
    }
  }

  return { updatedCount, arbitrageCount, managementCount };
}

async function main() {
  console.log("💰 Reservatior AI: Airbnb Arbitraj ve Lead Analiz Motoru Başlıyor...\n");
  const prisma = prismaManager.getClient(REGION);

  const csvFiles = findCsvFiles(USA_DIR);
  console.log(`Toplam CSV Dosyası: ${csvFiles.length}`);

  let totalArbitrage = 0;
  let totalManagement = 0;
  let totalProcessed = 0;

  for (const file of csvFiles) {
    process.stdout.write(`📊 Analiz ediliyor: ${file.split("/").pop()}... `);
    const results = await processArbitrageAnalytics(prisma, file);
    console.log(`[Tamamlandı] -> Fırsatlar: ${results.arbitrageCount} Arbitraj, ${results.managementCount} Yönetim`);
    
    totalProcessed += results.updatedCount;
    totalArbitrage += results.arbitrageCount;
    totalManagement += results.managementCount;
  }

  console.log("\n==================================================");
  console.log("🚀 ANALİZ SONUÇLARI (POTANSİYEL LEAD'LER)");
  console.log("==================================================");
  console.log(`Toplam Analiz Edilen Mülk : ${totalProcessed}`);
  console.log(`🚨 Arbitraj Fırsatı Bulunan: ${totalArbitrage} (Airbnb'de Para Kaybedenler)`);
  console.log(`💎 Yönetim Fırsatı Bulunan : ${totalManagement} (Yüksek Ciro, Kötü Yorum Alanlar)`);
  console.log("==================================================");
  console.log("Sıradaki Adım: Bu mülk sahiplerini ('arbitrageOpportunity = true') filtreleyip Lob üzerinden 'Sizi Airbnb yorgunluğundan kurtaralım, garantili kira verelim' konseptli fiziksel posta atabilirsiniz!\n");
}

main().catch(console.error).finally(() => process.exit(0));
