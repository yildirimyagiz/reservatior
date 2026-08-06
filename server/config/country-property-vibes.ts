// server/config/country-property-vibes.ts
// Reservatior — Country-specific property vibes/types for ALL supported markets.
// This file defines property categories that are culturally and regionally relevant
// for each market, replacing generic English terms with local terminology.

import { RegionCode } from './ai-yield-optimization';

export interface PropertyVibe {
  icon: string;
  translationKey: string;
  englishName: string;
  count: string;
  descKey: string;
  badgeKey: string;
}

export interface CountryPropertyVibes {
  countryCode: RegionCode;
  countryNameEn: string;
  vibes: PropertyVibe[];
}

// ─── Turkey-specific property vibes (Türkçe terminoloji) ─────────────────────
const TURKEY_VIBES: PropertyVibe[] = [
  { 
    icon: "🏖️", 
    translationKey: "home.vibes.yazlik", 
    englishName: "yazlik", 
    count: "1,204", 
    descKey: "home.vibes.yazlik_desc", 
    badgeKey: "home.vibes.yazlik_badge" 
  },
  { 
    icon: "🏔️", 
    translationKey: "home.vibes.dag_evi", 
    englishName: "dag_evi", 
    count: "853", 
    descKey: "home.vibes.dag_evi_desc", 
    badgeKey: "home.vibes.dag_evi_badge" 
  },
  { 
    icon: "🏛️", 
    translationKey: "home.vibes.kosk", 
    englishName: "kosk", 
    count: "432", 
    descKey: "home.vibes.kosk_desc", 
    badgeKey: "home.vibes.kosk_badge" 
  },
  { 
    icon: "🏙️", 
    translationKey: "home.vibes.dubleks", 
    englishName: "dubleks", 
    count: "921", 
    descKey: "home.vibes.dubleks_desc", 
    badgeKey: "home.vibes.dubleks_badge" 
  },
  { 
    icon: "🌲", 
    translationKey: "home.vibes.mustakil", 
    englishName: "mustakil", 
    count: "3,105", 
    descKey: "home.vibes.mustakil_desc", 
    badgeKey: "home.vibes.mustakil_badge" 
  },
  { 
    icon: "🏰", 
    translationKey: "home.vibes.yali", 
    englishName: "yali", 
    count: "89", 
    descKey: "home.vibes.yali_desc", 
    badgeKey: "home.vibes.yali_badge" 
  },
  { 
    icon: "🏝️", 
    translationKey: "home.vibes.ada", 
    englishName: "ada", 
    count: "42", 
    descKey: "home.vibes.ada_desc", 
    badgeKey: "home.vibes.ada_badge" 
  },
  { 
    icon: "📐", 
    translationKey: "home.vibes.rezidans", 
    englishName: "rezidans", 
    count: "5,602", 
    descKey: "home.vibes.rezidans_desc", 
    badgeKey: "home.vibes.rezidans_badge" 
  },
];

// ─── USA/International property vibes (English terminology) ───────────────────
const USA_VIBES: PropertyVibe[] = [
  { 
    icon: "🏖️", 
    translationKey: "home.vibes.beachfront", 
    englishName: "beachfront", 
    count: "1,204", 
    descKey: "home.vibes.beachfront_desc", 
    badgeKey: "home.vibes.beachfront_badge" 
  },
  { 
    icon: "🏔️", 
    translationKey: "home.vibes.mountains", 
    englishName: "mountains", 
    count: "853", 
    descKey: "home.vibes.mountains_desc", 
    badgeKey: "home.vibes.mountains_badge" 
  },
  { 
    icon: "🏛️", 
    translationKey: "home.vibes.mansions", 
    englishName: "mansions", 
    count: "432", 
    descKey: "home.vibes.mansions_desc", 
    badgeKey: "home.vibes.mansions_badge" 
  },
  { 
    icon: "🏙️", 
    translationKey: "home.vibes.penthouses", 
    englishName: "penthouses", 
    count: "921", 
    descKey: "home.vibes.penthouses_desc", 
    badgeKey: "home.vibes.penthouses_badge" 
  },
  { 
    icon: "🌲", 
    translationKey: "home.vibes.cabins", 
    englishName: "cabins", 
    count: "3,105", 
    descKey: "home.vibes.cabins_desc", 
    badgeKey: "home.vibes.cabins_badge" 
  },
  { 
    icon: "🏰", 
    translationKey: "home.vibes.castles", 
    englishName: "castles", 
    count: "89", 
    descKey: "home.vibes.castles_desc", 
    badgeKey: "home.vibes.castles_badge" 
  },
  { 
    icon: "🏝️", 
    translationKey: "home.vibes.islands", 
    englishName: "islands", 
    count: "42", 
    descKey: "home.vibes.islands_desc", 
    badgeKey: "home.vibes.islands_badge" 
  },
  { 
    icon: "📐", 
    translationKey: "home.vibes.modern", 
    englishName: "modern", 
    count: "5,602", 
    descKey: "home.vibes.modern_desc", 
    badgeKey: "home.vibes.modern_badge" 
  },
];

// ─── Country vibe mappings ─────────────────────────────────────────────────────
export const COUNTRY_PROPERTY_VIBES: Partial<Record<RegionCode, CountryPropertyVibes>> = {
  [RegionCode.TR]: {
    countryCode: RegionCode.TR,
    countryNameEn: 'Türkiye',
    vibes: TURKEY_VIBES,
  },
  [RegionCode.USA]: {
    countryCode: RegionCode.USA,
    countryNameEn: 'United States',
    vibes: USA_VIBES,
  },
  // Default to USA vibes for other markets (can be customized per country)
  [RegionCode.CA]: { countryCode: RegionCode.CA, countryNameEn: 'Canada', vibes: USA_VIBES },
  [RegionCode.UK]: { countryCode: RegionCode.UK, countryNameEn: 'United Kingdom', vibes: USA_VIBES },
  [RegionCode.DE]: { countryCode: RegionCode.DE, countryNameEn: 'Germany', vibes: USA_VIBES },
  [RegionCode.FR]: { countryCode: RegionCode.FR, countryNameEn: 'France', vibes: USA_VIBES },
  [RegionCode.ES]: { countryCode: RegionCode.ES, countryNameEn: 'Spain', vibes: USA_VIBES },
  [RegionCode.IT]: { countryCode: RegionCode.IT, countryNameEn: 'Italy', vibes: USA_VIBES },
  [RegionCode.NL]: { countryCode: RegionCode.NL, countryNameEn: 'Netherlands', vibes: USA_VIBES },
  [RegionCode.BR]: { countryCode: RegionCode.BR, countryNameEn: 'Brazil', vibes: USA_VIBES },
  [RegionCode.AR]: { countryCode: RegionCode.AR, countryNameEn: 'Argentina', vibes: USA_VIBES },
  [RegionCode.AU]: { countryCode: RegionCode.AU, countryNameEn: 'Australia', vibes: USA_VIBES },
  [RegionCode.NZ]: { countryCode: RegionCode.NZ, countryNameEn: 'New Zealand', vibes: USA_VIBES },
  [RegionCode.JP]: { countryCode: RegionCode.JP, countryNameEn: 'Japan', vibes: USA_VIBES },
  [RegionCode.KR]: { countryCode: RegionCode.KR, countryNameEn: 'South Korea', vibes: USA_VIBES },
  [RegionCode.CN]: { countryCode: RegionCode.CN, countryNameEn: 'China', vibes: USA_VIBES },
  [RegionCode.IN]: { countryCode: RegionCode.IN, countryNameEn: 'India', vibes: USA_VIBES },
  [RegionCode.SG]: { countryCode: RegionCode.SG, countryNameEn: 'Singapore', vibes: USA_VIBES },
  [RegionCode.MY]: { countryCode: RegionCode.MY, countryNameEn: 'Malaysia', vibes: USA_VIBES },
  [RegionCode.TH]: { countryCode: RegionCode.TH, countryNameEn: 'Thailand', vibes: USA_VIBES },
  [RegionCode.AE]: { countryCode: RegionCode.AE, countryNameEn: 'United Arab Emirates', vibes: USA_VIBES },
  [RegionCode.SA]: { countryCode: RegionCode.SA, countryNameEn: 'Saudi Arabia', vibes: USA_VIBES },
};

// Helper function to get vibes for a country (defaults to USA vibes if not found)
export function getCountryVibes(countryCode: RegionCode): PropertyVibe[] {
  return COUNTRY_PROPERTY_VIBES[countryCode]?.vibes || USA_VIBES;
}
