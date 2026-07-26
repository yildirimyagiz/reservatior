/**
 * SEO Schema Generator for Google Hotels, Real Estate, and AI Search Engines.
 * Following Schema.org standards for maximum visibility in Google Search Generative Experience (SGE).
 *
 * Extended with:
 *  - FAQPage schema (category-enricher FAQ'larından otomatik)
 *  - BreadcrumbList schema
 *  - keywords[] alanı (category-enricher cluster'larından)
 *  - Product + RealEstateListing daha zengin markup
 */
export interface SEOData {
  type: 'HOTEL' | 'REAL_ESTATE' | 'LISTING' | 'ORGANIZATION';
  title: string;
  description: string;
  image?: string;
  url: string;
  price?: number;
  currency?: string;
  address?: {
    street?: string;
    city: string;
    state?: string;
    zip?: string;
    country: string;
  };
  geo?: {
    lat: number;
    lng: number;
  };
  amenities?: string[];
  rating?: number;
  reviewCount?: number;
}

export const generateSchema = (data: SEOData) => {
  const baseSchema = {
    "@context": "https://schema.org",
    "@type": data.type === 'HOTEL' ? 'Hotel' : data.type === 'REAL_ESTATE' ? 'RealEstateListing' : 'Product',
    "name": data.title,
    "description": data.description,
    "url": data.url,
    "image": data.image || "https://reservatior.com/default-og.jpg", // Replace with real default
  };

  if (data.address) {
    (baseSchema as any).address = {
      "@type": "PostalAddress",
      "streetAddress": data.address.street,
      "addressLocality": data.address.city,
      "addressRegion": data.address.state,
      "postalCode": data.address.zip,
      "addressCountry": data.address.country,
    };
  }

  if (data.geo) {
    (baseSchema as any).geo = {
      "@type": "GeoCoordinates",
      "latitude": data.geo.lat,
      "longitude": data.geo.lng,
    };
  }

  if (data.price && data.currency) {
    (baseSchema as any).offers = {
      "@type": "Offer",
      "price": data.price,
      "priceCurrency": data.currency,
      "availability": "https://schema.org/InStock",
      "seller": {
        "@type": "Organization",
        "name": "Reservatior Direct"
      },
      "priceValidUntil": new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0], // 30 days from now
      "description": "Direct Booking Price - Lowest Guarantee"
    };
  }

  if (data.amenities?.length) {
     (baseSchema as any).amenityFeature = data.amenities.map(name => ({
       "@type": "LocationFeatureSpecification",
       "name": name,
       "value": true
     }));
  }

  return JSON.stringify(baseSchema);
};

export const generateOrganizationSchema = (orgName: string, logo?: string) => {
  return JSON.stringify({
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": orgName,
    "logo": logo || "https://reservatior.com/logo.png",
    "url": "https://reservatior.com",
    "contactPoint": {
      "@type": "ContactPoint",
      "telephone": "+1-800-RESERV",
      "contactType": "customer service"
    }
  });
};

// ─── FAQPage Schema ─────────────────────────────────────────────────────────

/**
 * Google'da "People also ask" ve featured snippet bölümlerinde görünmek için
 * FAQPage schema üretir. category-enricher'dan gelen faq[] ile doğrudan kullanılabilir.
 *
 * @example
 * const { faqs } = enrichCategory("INVESTMENT", "istanbul");
 * const schema = generateFAQSchema(faqs);
 */
export const generateFAQSchema = (
  faqs: Array<{ question: string; answer: string }>
): string => {
  if (!faqs.length) return "";

  return JSON.stringify({
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": faqs.map((faq) => ({
      "@type": "Question",
      "name": faq.question,
      "acceptedAnswer": {
        "@type": "Answer",
        "text": faq.answer,
      },
    })),
  });
};

// ─── BreadcrumbList Schema ─────────────────────────────────────────────────────

export interface BreadcrumbItem {
  name: string;
  url: string;
}

/**
 * Google arama sonucunda URL yolunu gösteren breadcrumb schema üretir.
 * SEO click-through rate'i artırır.
 *
 * @example
 * generateBreadcrumbSchema([
 *   { name: "Ana Sayfa", url: "https://reservatior.com" },
 *   { name: "Dubai", url: "https://reservatior.com/dubai" },
 *   { name: "Satılık Daire", url: "https://reservatior.com/dubai/satilik-daire" },
 * ])
 */
export const generateBreadcrumbSchema = (items: BreadcrumbItem[]): string => {
  return JSON.stringify({
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": items.map((item, index) => ({
      "@type": "ListItem",
      "position": index + 1,
      "name": item.name,
      "item": item.url,
    })),
  });
};

// ─── Enriched RealEstateListing Schema ────────────────────────────────────────

export interface EnrichedSEOData extends SEOData {
  /** category-enricher'dan gelen keyword cluster listesi */
  keywords?: string[];
  /** category-enricher'dan gelen FAQ'lar */
  faqs?: Array<{ question: string; answer: string }>;
  /** Sayfa için breadcrumb yolu */
  breadcrumbs?: BreadcrumbItem[];
  /** yatay konum: neighborhood/district */
  neighborhood?: string;
  /** A/B test için alternatif başlıklar */
  alternativeTitles?: string[];
}

/**
 * Hem RealEstateListing hem de ilave schema type'larını (FAQ + Breadcrumb)
 * tek JSON-LD array olarak döndürür.
 * category-enricher entegrasyonu ile en zengin structured data output'unu üretir.
 *
 * @example
 * const { keywords, faqs, titles } = enrichCategory("INVESTMENT", "istanbul");
 * const schemas = generateEnrichedSchema({
 *   type: "REAL_ESTATE",
 *   title: titles[0],
 *   description: descriptions[0],
 *   url: "https://reservatior.com/istanbul/yatirim",
 *   keywords,
 *   faqs,
 *   breadcrumbs: [
 *     { name: "Ana Sayfa", url: "https://reservatior.com" },
 *     { name: "İstanbul", url: "https://reservatior.com/istanbul" },
 *   ],
 * });
 */
export const generateEnrichedSchema = (data: EnrichedSEOData): string => {
  const schemas: object[] = [];

  // 1. Ana listing schema
  const baseRaw = JSON.parse(generateSchema(data));

  // Keyword'leri ekle (schema.org keywords property)
  if (data.keywords?.length) {
    baseRaw.keywords = data.keywords.join(", ");
  }

  // Neighborhood / district
  if (data.neighborhood) {
    baseRaw.containedInPlace = {
      "@type": "Neighborhood",
      "name": data.neighborhood,
    };
  }

  schemas.push(baseRaw);

  // 2. FAQPage schema
  if (data.faqs?.length) {
    schemas.push(JSON.parse(generateFAQSchema(data.faqs)));
  }

  // 3. BreadcrumbList schema
  if (data.breadcrumbs?.length) {
    schemas.push(JSON.parse(generateBreadcrumbSchema(data.breadcrumbs)));
  }

  // Tek JSON-LD array olarak serialize et
  return JSON.stringify(schemas.length === 1 ? schemas[0] : schemas);
};

// ─── Keyword Density Analyzer ────────────────────────────────────────────────────

/**
 * İçerik metnindeki keyword yoğunluğunu hesaplar.
 * %1–2 yoğunluk ideal kabul edilir; üzeri keyword stuffing olarak algilanır.
 *
 * @returns keyword başına yoğunluk yüzdeleri
 */
export function analyzeKeywordDensity(
  content: string,
  keywords: string[]
): Record<string, { count: number; density: string }> {
  const lowerContent = content.toLowerCase();
  const wordCount = lowerContent.split(/\s+/).length;

  const result: Record<string, { count: number; density: string }> = {};

  for (const kw of keywords) {
    const lkw = kw.toLowerCase();
    let count = 0;
    let idx = 0;
    while ((idx = lowerContent.indexOf(lkw, idx)) !== -1) {
      count++;
      idx += lkw.length;
    }
    const density = wordCount > 0 ? ((count / wordCount) * 100).toFixed(2) : "0.00";
    result[kw] = { count, density: `${density}%` };
  }

  return result;
}
