/**
 * Intelligence Pipeline Service
 *
 * Post-import intelligence processing:
 * - Property scoring (6 dimensions)
 * - Digital twin generation (4 scenarios)
 * - Intelligence profile creation
 * - Event publishing for OS module integration
 */
import prismaManager from '../lib/prisma';

// ─── Types ──────────────────────────────────────────────────────────────────

export interface PropertyScores {
  investmentScore: number;
  rentalScore: number;
  demandScore: number;
  liquidityScore: number;
  riskScore: number;
  locationScore: number;
  overallScore: number;
}

export interface DigitalTwinScenario {
  name: string;
  description: string;
  projectedYield1Y: number;
  projectedYield3Y: number;
  projectedYield5Y: number;
  projectedValue1Y: number;
  projectedValue3Y: number;
  projectedValue5Y: number;
}

export interface IntelligenceResult {
  propertyId: string;
  scores: PropertyScores;
  scenarios: DigitalTwinScenario[];
  recommendations: string[];
  aiConfidence: number;
}

// ─── Score Calculation ──────────────────────────────────────────────────────

function calculatePropertyScores(property: any, facility: any): PropertyScores {
  let investmentScore = 50;
  let rentalScore = 50;
  let demandScore = 50;
  let liquidityScore = 50;
  let riskScore = 50;
  let locationScore = 50;

  // Area-based scoring
  if (property.areaSqm) {
    if (property.areaSqm >= 80 && property.areaSqm <= 150) investmentScore += 10;
    if (property.areaSqm >= 100 && property.areaSqm <= 130) rentalScore += 10;
  }

  // Location scoring (Istanbul premium)
  if (property.city === 'Istanbul') {
    locationScore += 15;
    demandScore += 10;
    liquidityScore += 10;
  }

  // District-based scoring
  const premiumDistricts = ['Şişli', 'Beşiktaş', 'Kadıköy', 'Ataşehir', 'Sarıyer', 'Bakırköy', 'Kartal'];
  if (premiumDistricts.includes(property.state)) {
    locationScore += 10;
    investmentScore += 5;
  }

  // Amenities scoring
  if (facility) {
    const amenityCount = [
      property.havuz, property.spor_salonu, property.otopark,
      property.guvenlik, property.jenerator, property.kamera_sistemi,
    ].filter(Boolean).length;
    investmentScore += amenityCount * 2;
    rentalScore += amenityCount * 2;
  }

  // Year built scoring
  if (property.yearBuilt) {
    const age = new Date().getFullYear() - property.yearBuilt;
    if (age < 5) { liquidityScore += 10; riskScore -= 5; }
    else if (age < 15) { liquidityScore += 5; }
    else { riskScore += 5; }
  }

  // Listing type scoring
  if (property.listingType === 'RENT') {
    rentalScore += 10;
    liquidityScore += 5;
  }

  // Calculate overall
  const overallScore = Math.round(
    (investmentScore + rentalScore + demandScore + liquidityScore + (100 - riskScore) + locationScore) / 6
  );

  return {
    investmentScore: Math.min(100, Math.max(0, investmentScore)),
    rentalScore: Math.min(100, Math.max(0, rentalScore)),
    demandScore: Math.min(100, Math.max(0, demandScore)),
    liquidityScore: Math.min(100, Math.max(0, liquidityScore)),
    riskScore: Math.min(100, Math.max(0, riskScore)),
    locationScore: Math.min(100, Math.max(0, locationScore)),
    overallScore: Math.min(100, Math.max(0, overallScore)),
  };
}

// ─── Digital Twin Generation ────────────────────────────────────────────────

function generateScenarios(property: any): DigitalTwinScenario[] {
  const basePrice = Number(property.listings?.[0]?.price) || 0;
  const baseArea = property.areaSqm || 100;
  const pricePerSqm = basePrice > 0 ? basePrice / baseArea : 0;

  return [
    {
      name: 'Normal Pazar',
      description: 'Mevcut koşullarda normal piyasa büyümesi',
      projectedYield1Y: 0.08,
      projectedYield3Y: 0.25,
      projectedYield5Y: 0.45,
      projectedValue1Y: pricePerSqm * baseArea * 1.08,
      projectedValue3Y: pricePerSqm * baseArea * 1.25,
      projectedValue5Y: pricePerSqm * baseArea * 1.45,
    },
    {
      name: 'Renovasyon + Mobilya',
      description: 'Renovasyon ve mobilya yatırımı ile değer artışı',
      projectedYield1Y: 0.12,
      projectedYield3Y: 0.35,
      projectedYield5Y: 0.60,
      projectedValue1Y: pricePerSqm * baseArea * 1.12,
      projectedValue3Y: pricePerSqm * baseArea * 1.35,
      projectedValue5Y: pricePerSqm * baseArea * 1.60,
    },
    {
      name: 'Kısa Dönem Kiralama (STR)',
      description: 'Airbnb vb. kısa dönem kiralama stratejisi',
      projectedYield1Y: 0.10,
      projectedYield3Y: 0.30,
      projectedYield5Y: 0.55,
      projectedValue1Y: pricePerSqm * baseArea * 1.10,
      projectedValue3Y: pricePerSqm * baseArea * 1.30,
      projectedValue5Y: pricePerSqm * baseArea * 1.55,
    },
    {
      name: 'Fiyat İndirimi',
      description: 'Hızlı satış için %5 fiyat indirimi',
      projectedYield1Y: 0.06,
      projectedYield3Y: 0.20,
      projectedYield5Y: 0.38,
      projectedValue1Y: pricePerSqm * baseArea * 0.95 * 1.06,
      projectedValue3Y: pricePerSqm * baseArea * 0.95 * 1.20,
      projectedValue5Y: pricePerSqm * baseArea * 0.95 * 1.38,
    },
  ];
}

// ─── Intelligence Profile Generation ────────────────────────────────────────

function generateRecommendations(scores: PropertyScores, property: any): string[] {
  const recs: string[] = [];

  if (scores.investmentScore >= 70) recs.push('Güçlü yatırım potansiyeli - portföye ekle');
  if (scores.rentalScore >= 70) recs.push('Yüksek kira getirisi - kiralama stratejisi değerlendir');
  if (scores.demandScore >= 80) recs.push('Yüksek talep - hızlı hareket et');
  if (scores.liquidityScore >= 70) recs.push('Yüksek likidite - kolay satılabilir');
  if (scores.riskScore <= 30) recs.push('Düşük risk - güvenli yatırım');
  if (scores.locationScore >= 80) recs.push('Premium lokasyon - değer artışı beklentisi yüksek');

  if (scores.investmentScore < 50) recs.push('Yatırım skoru düşük - detaylı analiz gerekli');
  if (scores.riskScore >= 70) recs.push('Risk seviyesi yüksek - dikkatli değerlendirme önerilir');

  if (property.listingType === 'SALE') recs.push('Satılık ilan - fiyat optimizasyonu yapılabilir');
  if (property.listingType === 'RENT') recs.push('Kiralık ilan - kira artış potansiyeli değerlendirilmeli');

  return recs;
}

// ─── Main Pipeline ──────────────────────────────────────────────────────────

export async function processPropertyIntelligence(propertyId: string): Promise<IntelligenceResult | null> {
  const prisma = prismaManager.getClient('TR');

  const property = await prisma.property.findUnique({
    where: { id: propertyId },
    include: {
      listings: true,
      facility: true,
    },
  });

  if (!property) return null;

  const facility = (property as any).facility;
  const scores = calculatePropertyScores(property, facility);
  const scenarios = generateScenarios(property);
  const recommendations = generateRecommendations(scores, property);

  // Save PropertyCurrentScore
  await prisma.propertyCurrentScore.upsert({
    where: { propertyId },
    update: {
      investmentScore: scores.investmentScore,
      rentalScore: scores.rentalScore,
      demandScore: scores.demandScore,
      liquidityScore: scores.liquidityScore,
      riskScore: scores.riskScore,
      locationScore: scores.locationScore,
      overallScore: scores.overallScore,
      calculatedAt: new Date(),
    },
    create: {
      propertyId,
      investmentScore: scores.investmentScore,
      rentalScore: scores.rentalScore,
      demandScore: scores.demandScore,
      liquidityScore: scores.liquidityScore,
      riskScore: scores.riskScore,
      locationScore: scores.locationScore,
      overallScore: scores.overallScore,
      modelVersion: 'v1.0',
      confidence: 0.75,
    },
  });

  // Save PropertyDigitalTwin
  await prisma.propertyDigitalTwin.upsert({
    where: { propertyId },
    update: {
      currentState: JSON.stringify({
        property: { name: property.name, address: property.addressLine1, type: property.type },
        financial: { price: property.listings?.[0]?.price, pricePerSqm: property.areaSqm ? Number(property.listings?.[0]?.price) / property.areaSqm : null },
        scores,
      }),
      scenarios: JSON.stringify(scenarios),
      predictions: JSON.stringify({
        '1Year': scenarios[0].projectedValue1Y,
        '3Year': scenarios[0].projectedValue3Y,
        '5Year': scenarios[0].projectedValue5Y,
      }),
      confidenceScore: 0.75,
      lastSimulatedAt: new Date(),
    },
    create: {
      propertyId,
      currentState: JSON.stringify({
        property: { name: property.name, address: property.addressLine1, type: property.type },
        financial: { price: property.listings?.[0]?.price, pricePerSqm: property.areaSqm ? Number(property.listings?.[0]?.price) / property.areaSqm : null },
        scores,
      }),
      scenarios: JSON.stringify(scenarios),
      predictions: JSON.stringify({
        '1Year': scenarios[0].projectedValue1Y,
        '3Year': scenarios[0].projectedValue3Y,
        '5Year': scenarios[0].projectedValue5Y,
      }),
      assumptions: JSON.stringify({ marketGrowth: 0.08, inflation: 0.03, rentalGrowth: 0.05 }),
      modelVersion: 'v1.0',
      confidenceScore: 0.75,
    },
  });

  // Save PropertyIntelligenceProfile
  await prisma.propertyIntelligenceProfile.upsert({
    where: { propertyId },
    update: {
      investmentScore: scores.investmentScore,
      demandScore: scores.demandScore,
      riskScore: scores.riskScore,
      aiRecommendation: recommendations[0] || null,
      dataQuality: 0.75,
      lastUpdated: new Date(),
    },
    create: {
      propertyId,
      countryIsoCode: 'TR',
      citySlug: property.city?.toLowerCase() || 'istanbul',
      districtSlug: property.state?.toLowerCase(),
      propertyType: property.propertyCategory || 'RESIDENTIAL',
      buildingType: 'APARTMENT',
      unitType: property.type || 'APARTMENT',
      totalArea: property.areaSqm || 0,
      bedroomCount: property.bedrooms || 0,
      bathroomCount: property.bathrooms || 0,
      currentValue: Number(property.listings?.[0]?.price) || 0,
      pricePerSqm: property.areaSqm ? (Number(property.listings?.[0]?.price) || 0) / property.areaSqm : 0,
      demandScore: scores.demandScore,
      supplyScore: 50,
      competitionScore: 50,
      marketPosition: 'AT_MARKET',
      investmentScore: scores.investmentScore,
      roi: scenarios[0].projectedYield5Y,
      riskScore: scores.riskScore,
      liquidityScore: scores.liquidityScore,
      growthPotential: scenarios[0].projectedYield5Y,
      lifestyleScore: scores.locationScore,
      aiRecommendation: recommendations[0] || null,
      aiConfidence: 0.75,
      dataQuality: 0.75,
      confidence: 0.75,
    },
  });

  return {
    propertyId,
    scores,
    scenarios,
    recommendations,
    aiConfidence: 0.75,
  };
}

// ─── Batch Processing ───────────────────────────────────────────────────────

export async function processAllProperties(): Promise<{ processed: number; failed: number }> {
  const prisma = prismaManager.getClient('TR');
  const properties = await prisma.property.findMany({
    where: { deletedAt: null },
    select: { id: true },
  });

  let processed = 0;
  let failed = 0;

  for (const prop of properties) {
    try {
      await processPropertyIntelligence(prop.id);
      processed++;
      if (processed % 100 === 0) process.stdout.write(`✅ ${processed} `);
    } catch (e) {
      failed++;
    }
  }

  console.log(`\n📊 Intelligence pipeline complete: ${processed} processed, ${failed} failed`);
  return { processed, failed };
}
