/**
 * src/lib/seo/keyword-engine.ts
 * ─────────────────────────────────────────────────────────────────────────────
 * Reservatior SEO Keyword Intelligence Engine
 * ─────────────────────────────────────────────────────────────────────────────
 *
 * 3 Katmanlı Yapı:
 *  1. Capture  — Arama sorgularını, URL param'larını ve referer header'larını yakalar
 *  2. Valuation — Frekans × Intent × Geo matrisine göre her kelimeyi 0-100 skorlar
 *  3. Enrichment — Yüksek-değerli keyword'leri page meta ve schema.org'a enjekte eder
 *
 * Client-side (browser) + Next.js server-side (generateMetadata) her ikisinde de çalışır.
 */

// ─── Types ────────────────────────────────────────────────────────────────────

export type KeywordIntent =
  | "transactional"   // "satılık villa" → yüksek değer, dönüşüm odaklı
  | "informational"   // "dubai kira fiyatları 2025" → orta değer, içerik için altın
  | "navigational"    // "reservatior giriş" → düşük değer
  | "investment";     // "yatırımlık daire getiri" → en yüksek değer

export type SignalSource =
  | "search_box"      // Platform içi arama kutusu
  | "url_param"       // ?q= veya ?district= gibi URL parametreleri
  | "referer"         // Google/Bing referer header'ından ayrıştırılan keyword
  | "filter"          // Fiyat, tip, şehir filtreleri
  | "voice";          // Sesli arama (gelecek)

export interface KeywordSignal {
  term: string;
  normalizedTerm: string;     // lowercase, trimmed, stop words removed
  locale: string;             // "tr" | "en" | "ar" | "ru" | "zh" | "ko"
  source: SignalSource;
  intent: KeywordIntent;
  city?: string;              // "istanbul" | "dubai" | "london"
  district?: string;          // "beyoglu" | "marina"
  propertyType?: string;      // "villa" | "apartment" | "office"
  listingType?: "sale" | "rent";
  timestamp: number;          // Date.now()
  sessionId: string;
}

export interface KeywordScore {
  term: string;
  locale: string;
  frequency: number;          // Bu term kaç kez göründü
  intentScore: number;        // 0-100
  geoScore: number;           // 0-100 (şehir+ilçe spesifik → daha değerli)
  frequencyScore: number;     // 0-100
  totalValue: number;         // Ağırlıklı toplam 0-100
  intent: KeywordIntent;
  city?: string;
  district?: string;
  propertyType?: string;
  listingType?: "sale" | "rent";
  cluster: string[];          // İlgili long-tail keyword önerileri
  suggestedTitle: string;
  suggestedMetaDescription: string;
  lastSeen: number;
}

export interface EnrichedMetadata {
  title: string;
  description: string;
  keywords: string[];
  openGraphTitle: string;
  openGraphDescription: string;
}

// ─── Constants ────────────────────────────────────────────────────────────────

const INTENT_WEIGHTS: Record<KeywordIntent, number> = {
  investment: 100,
  transactional: 85,
  informational: 50,
  navigational: 15,
};

// Gayrimenkul intent sınıflandırma kuralları (Türkçe + İngilizce + Arapça + Rusça)
const INTENT_RULES: Array<{ pattern: RegExp; intent: KeywordIntent }> = [
  // Investment
  { pattern: /yatırım|yatırımlık|getiri|roi|invest|yield|return|استثمار|инвест/i, intent: "investment" },
  // Transactional
  { pattern: /satılık|satilik|for sale|للبيع|продаж|kiralık|kiralik|for rent|للإيجار|аренд|buy|rent|purchase/i, intent: "transactional" },
  // Navigational
  { pattern: /reservatior|login|giriş|kayıt|signup|hesab/i, intent: "navigational" },
  // Informational (default fallback)
  { pattern: /fiyat|price|değer|value|bilgi|info|nasıl|how|nerede|where/i, intent: "informational" },
];

// Coğrafi keyword'ler → daha spesifik = daha değerli
const GEO_PATTERNS: Array<{ pattern: RegExp; score: number; city?: string }> = [
  { pattern: /beyoğlu|beyoglu|taksim|galata/i, score: 95, city: "istanbul" },
  { pattern: /kadıköy|kadikoy|moda|bostancı/i, score: 95, city: "istanbul" },
  { pattern: /beşiktaş|besiktas|levent|etiler/i, score: 90, city: "istanbul" },
  { pattern: /istanbul|İstanbul/i, score: 70, city: "istanbul" },
  { pattern: /dubai marina|jvc|palm jumeirah|business bay|downtown dubai/i, score: 95, city: "dubai" },
  { pattern: /dubai/i, score: 70, city: "dubai" },
  { pattern: /london|londra/i, score: 65, city: "london" },
  { pattern: /miami|new york|nyc/i, score: 65, city: "miami" },
  { pattern: /barcelona|madrid/i, score: 65, city: "barcelona" },
];

// Property type sınıflandırması
const PROPERTY_TYPE_PATTERNS: Array<{ pattern: RegExp; type: string }> = [
  { pattern: /villa|müstakil|detached/i, type: "villa" },
  { pattern: /daire|apartment|flat|rezidans/i, type: "apartment" },
  { pattern: /stüdyo|studio/i, type: "studio" },
  { pattern: /penthouse/i, type: "penthouse" },
  { pattern: /ofis|office/i, type: "office" },
  { pattern: /arsa|land|tarla/i, type: "land" },
];

// Turkish/Arabic/Russian stop words (indexed search'ten çıkar)
const STOP_WORDS = new Set([
  "ve", "ile", "bir", "bu", "da", "de", "mi", "mı", "için", "olan", "olan",
  "the", "a", "an", "and", "or", "in", "on", "at", "to", "for", "of",
  "في", "من", "على", "إلى", "و",
  "в", "на", "и", "для", "с",
]);

// ─── Keyword Normalizer ───────────────────────────────────────────────────────

export function normalizeTerm(raw: string): string {
  return raw
    .toLowerCase()
    .trim()
    .replace(/['".,!?;:()[\]{}]/g, "")
    .split(/\s+/)
    .filter((w) => w.length > 1 && !STOP_WORDS.has(w))
    .join(" ");
}

// ─── Intent Classifier ────────────────────────────────────────────────────────

export function classifyIntent(term: string): KeywordIntent {
  for (const rule of INTENT_RULES) {
    if (rule.pattern.test(term)) return rule.intent;
  }
  return "informational";
}

// ─── Geo Extractor ───────────────────────────────────────────────────────────

export function extractGeo(term: string): { score: number; city?: string; district?: string } {
  for (const geo of GEO_PATTERNS) {
    if (geo.pattern.test(term)) {
      // District-level match (score >= 90) → extract district
      const isDistrictLevel = geo.score >= 90;
      return {
        score: geo.score,
        city: geo.city,
        district: isDistrictLevel ? geo.pattern.source.split("|")[0].replace(/\//g, "") : undefined,
      };
    }
  }
  return { score: 0 };
}

// ─── Property Type Extractor ─────────────────────────────────────────────────

export function extractPropertyType(term: string): string | undefined {
  for (const p of PROPERTY_TYPE_PATTERNS) {
    if (p.pattern.test(term)) return p.type;
  }
  return undefined;
}

export function extractListingType(term: string): "sale" | "rent" | undefined {
  if (/satılık|satilik|for sale|للبيع|продаж|buy|purchase/i.test(term)) return "sale";
  if (/kiralık|kiralik|for rent|للإيجار|аренд|rent/i.test(term)) return "rent";
  return undefined;
}

// ─── Cluster Generator ───────────────────────────────────────────────────────

export function generateCluster(score: KeywordScore): string[] {
  const { term, city, propertyType, listingType, locale } = score;
  const clusters: string[] = [];

  const listingWords = {
    tr: { sale: "satılık", rent: "kiralık" },
    en: { sale: "for sale", rent: "for rent" },
    ar: { sale: "للبيع", rent: "للإيجار" },
    ru: { sale: "продажа", rent: "аренда" },
  };

  const lw = listingWords[locale as keyof typeof listingWords] || listingWords.en;

  if (city && propertyType) {
    if (listingType === "sale") clusters.push(`${city} ${lw.sale} ${propertyType}`);
    if (listingType === "rent") clusters.push(`${city} ${lw.rent} ${propertyType}`);
    clusters.push(`${city} ${propertyType} fiyatları`);
    clusters.push(`${city} en iyi ${propertyType}`);
  }

  if (city) {
    clusters.push(`${city} emlak`, `${city} gayrimenkul yatırım`, `${city} kira getiri`);
  }

  // Long-tail expansions
  clusters.push(
    `${term} 2025`,
    `${term} fiyat`,
    `${term} taksit`,
    `${term} sıfır depozito`,
  );

  return [...new Set(clusters)].slice(0, 8);
}

// ─── Title/Meta Generator ─────────────────────────────────────────────────────

export function generateSuggestedTitle(score: KeywordScore, baseName = "Reservatior"): string {
  const { city, propertyType, listingType, intent, locale } = score;

  if (intent === "investment" && city) {
    return `${city.charAt(0).toUpperCase() + city.slice(1)} Yatırım Gayrimenkul | ROI Analizi | ${baseName}`;
  }

  if (listingType === "sale" && city && propertyType) {
    return `${city.charAt(0).toUpperCase() + city.slice(1)} Satılık ${propertyType.charAt(0).toUpperCase() + propertyType.slice(1)} | ${baseName}`;
  }

  if (listingType === "rent" && city) {
    return `${city.charAt(0).toUpperCase() + city.slice(1)} Kiralık Daire & Villa | ${baseName}`;
  }

  return `${score.term} | Gayrimenkul Platformu | ${baseName}`;
}

export function generateSuggestedMeta(score: KeywordScore): string {
  const { city, propertyType, listingType, intent } = score;

  if (intent === "investment" && city) {
    return `${city.charAt(0).toUpperCase() + city.slice(1)}'de en yüksek getirili gayrimenkul yatırım fırsatları. ROI analizi, kira getiri oranları ve uzman değerleme raporları.`;
  }

  if (listingType === "sale" && city) {
    return `${city.charAt(0).toUpperCase() + city.slice(1)}'de satılık ${propertyType || "daire ve villa"} ilanları. Taksitli ödeme, sıfır depozito seçenekleriyle hemen keşfet.`;
  }

  if (listingType === "rent" && city) {
    return `${city.charAt(0).toUpperCase() + city.slice(1)}'de kiralık daire, villa ve rezidans. Güvenli escrow, taksitli depozito avantajıyla ${city.charAt(0).toUpperCase() + city.slice(1)}'de kiralık seçenekler.`;
  }

  return `${score.term} için en güncel gayrimenkul ilanları, yatırım fırsatları ve piyasa analizi. Reservatior ile akıllı gayrimenkul kararları alın.`;
}

// ─── Valuation Engine ────────────────────────────────────────────────────────

export function scoreSignals(signals: KeywordSignal[]): KeywordScore[] {
  // Group by normalized term
  const groups = new Map<string, KeywordSignal[]>();
  for (const sig of signals) {
    const key = `${sig.normalizedTerm}::${sig.locale}`;
    if (!groups.has(key)) groups.set(key, []);
    groups.get(key)!.push(sig);
  }

  const scores: KeywordScore[] = [];

  for (const [, group] of groups) {
    const sample = group[0];
    const frequency = group.length;

    // Frequency score (log scale, cap at 100 after 50 occurrences)
    const frequencyScore = Math.min(100, Math.log(frequency + 1) * 30);

    // Intent score
    const intentScore = INTENT_WEIGHTS[sample.intent];

    // Geo score (use the highest geo score in group)
    const geoScores = group.map((s) => extractGeo(s.term).score);
    const geoScore = Math.max(...geoScores, 0);

    // Weighted total: 30% freq + 30% intent + 25% geo + 15% recency
    const recencyScore = group.some((s) => Date.now() - s.timestamp < 3600_000) ? 100 : 50;
    const totalValue = Math.round(
      frequencyScore * 0.30 +
      intentScore * 0.30 +
      geoScore * 0.25 +
      recencyScore * 0.15
    );

    const geo = extractGeo(sample.term);

    const partialScore: KeywordScore = {
      term: sample.term,
      locale: sample.locale,
      frequency,
      intentScore,
      geoScore,
      frequencyScore: Math.round(frequencyScore),
      totalValue,
      intent: sample.intent,
      city: sample.city || geo.city,
      district: sample.district || geo.district,
      propertyType: sample.propertyType,
      listingType: sample.listingType,
      cluster: [],
      suggestedTitle: "",
      suggestedMetaDescription: "",
      lastSeen: Math.max(...group.map((s) => s.timestamp)),
    };

    partialScore.cluster = generateCluster(partialScore);
    partialScore.suggestedTitle = generateSuggestedTitle(partialScore);
    partialScore.suggestedMetaDescription = generateSuggestedMeta(partialScore);

    scores.push(partialScore);
  }

  // Sort by total value descending
  return scores.sort((a, b) => b.totalValue - a.totalValue);
}

// ─── Signal Builder ───────────────────────────────────────────────────────────

let _sessionId: string | null = null;

function getSessionId(): string {
  if (typeof window === "undefined") return "ssr";
  if (!_sessionId) {
    _sessionId = sessionStorage.getItem("kw_session") || `kws_${Date.now().toString(36)}`;
    sessionStorage.setItem("kw_session", _sessionId);
  }
  return _sessionId;
}

export function buildSignal(
  term: string,
  source: SignalSource,
  locale: string,
  overrides: Partial<KeywordSignal> = {}
): KeywordSignal {
  const normalizedTerm = normalizeTerm(term);
  const intent = classifyIntent(term);
  const geo = extractGeo(term);
  const propertyType = extractPropertyType(term);
  const listingType = extractListingType(term);

  return {
    term,
    normalizedTerm,
    locale,
    source,
    intent,
    city: geo.city,
    district: geo.district,
    propertyType,
    listingType,
    timestamp: Date.now(),
    sessionId: getSessionId(),
    ...overrides,
  };
}

// ─── Referer Parser (server-side) ─────────────────────────────────────────────

/**
 * Parse the Referer header from Google/Bing/Yandex/Naver/Baidu
 * to extract the organic search query keyword.
 *
 * Call this in Next.js middleware or server components.
 */
export function parseRefererKeyword(referer: string | null): string | null {
  if (!referer) return null;

  const patterns: Array<{ re: RegExp; param: string }> = [
    { re: /google\./i, param: "q" },
    { re: /bing\.com/i, param: "q" },
    { re: /yandex\./i, param: "text" },
    { re: /yahoo\.com/i, param: "p" },
    { re: /baidu\.com/i, param: "wd" },
    { re: /naver\.com/i, param: "query" },
  ];

  try {
    const url = new URL(referer);
    for (const { re, param } of patterns) {
      if (re.test(url.hostname)) {
        const kw = url.searchParams.get(param);
        if (kw && kw.trim()) return kw.trim();
      }
    }
  } catch {
    // invalid URL
  }

  return null;
}

// ─── Metadata Enricher ────────────────────────────────────────────────────────

/**
 * Given the top scored keywords for a page, enrich the Next.js
 * generateMetadata() return value.
 *
 * Pass the base metadata and the top keyword scores.
 */
export function enrichMetadata(
  base: { title: string; description: string },
  topScores: KeywordScore[],
  opts: { maxKeywords?: number } = {}
): EnrichedMetadata {
  const maxKeywords = opts.maxKeywords ?? 20;
  const top = topScores[0];

  // Collect all keyword terms + clusters
  const keywordSet = new Set<string>();
  for (const s of topScores.slice(0, 5)) {
    keywordSet.add(s.term);
    s.cluster.forEach((c) => keywordSet.add(c));
  }
  const keywords = [...keywordSet].slice(0, maxKeywords);

  // Use top keyword's suggested title/meta only if it's high-value (>60)
  const useEnriched = top && top.totalValue > 60;

  return {
    title: useEnriched ? top.suggestedTitle : base.title,
    description: useEnriched ? top.suggestedMetaDescription : base.description,
    keywords,
    openGraphTitle: useEnriched ? top.suggestedTitle : base.title,
    openGraphDescription: useEnriched ? top.suggestedMetaDescription : base.description,
  };
}

// ─── Local Storage Persistence (browser only) ────────────────────────────────

const LS_KEY = "rsv_kw_signals";
const MAX_STORED = 200;

export function persistSignal(signal: KeywordSignal): void {
  if (typeof window === "undefined") return;
  try {
    const raw = localStorage.getItem(LS_KEY);
    const existing: KeywordSignal[] = raw ? JSON.parse(raw) : [];
    const updated = [...existing, signal].slice(-MAX_STORED);
    localStorage.setItem(LS_KEY, JSON.stringify(updated));
  } catch {
    // Quota or parse error — silent
  }
}

export function loadStoredSignals(): KeywordSignal[] {
  if (typeof window === "undefined") return [];
  try {
    const raw = localStorage.getItem(LS_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch {
    return [];
  }
}

export function getTopKeywords(locale: string, limit = 10): KeywordScore[] {
  const signals = loadStoredSignals().filter((s) => s.locale === locale);
  return scoreSignals(signals).slice(0, limit);
}
