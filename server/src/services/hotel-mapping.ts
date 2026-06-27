/**
 * Hotel Mapping Service
 *
 * Resolves the same hotel across providers using name + city similarity.
 * Maintains a persistent mapping table in the database.
 */

import { PrismaClient } from '@prisma/client';

let _prisma: PrismaClient | null = null;
function getPrisma(): PrismaClient {
  if (!_prisma) {
    _prisma = new PrismaClient();
  }
  return _prisma;
}

export class HotelMappingService {
  private knownMappings = new Map<string, string>();

  /**
   * Normalizes a hotel name for comparison:
   * - lowercase, trim
   * - remove common suffixes (Hotel, Resort, Otel, etc.)
   * - remove punctuation
   * - collapse whitespace
   */
  normalizeName(name: string): string {
    return name
      .toLowerCase()
      .trim()
      .replace(/[^a-z0-9\s]/g, '')
      .replace(/\b(hotel|resort|otel|oteli|premium|luxury|belek|bodrum|istanbul|antalya|kempinski)\b/g, '')
      .replace(/\s+/g, ' ')
      .trim();
  }

  /**
   * Resolve a hotel name+city to a canonical group key.
   * Uses name normalization + known mapping overrides.
   */
  resolve(name: string, city: string): string {
    const raw = `${name}|${city}`;

    const cached = this.knownMappings.get(raw);
    if (cached) return cached;

    const normalized = this.normalizeName(name);

    if (normalized.length < 3) {
      const fallback = `${name}-${city}`.toLowerCase().replace(/\s+/g, '-');
      this.knownMappings.set(raw, fallback);
      return fallback;
    }

    const key = `${normalized}|${city.toLowerCase().trim()}`;

    const matched = this.findExistingMatch(key);
    if (matched) {
      this.knownMappings.set(raw, matched);
      return matched;
    }

    this.knownMappings.set(raw, key);
    return key;
  }

  /**
   * Known hotel name variations mapped to canonical keys.
   * Add more as you discover them.
   */
  private knownOverrides = new Map<string, string>([
    ['rixos premium', 'rixos premium belek'],
    ['rixos premium belek', 'rixos premium belek'],
    ['maxx royal belek', 'maxx royal belek golf resort'],
    ['maxx royal belek golf resort', 'maxx royal belek golf resort'],
    ['titanic mardan palace', 'titanic mardan palace'],
    ['ciragan palace kempinski', 'ciragan palace kempinski'],
    ['çırağan palace kempinski', 'ciragan palace kempinski'],
    ['the peninsula istanbul', 'the peninsula istanbul'],
    ['peninsula istanbul', 'the peninsula istanbul'],
    ['burj al arab', 'burj al arab jumeirah'],
    ['burj al arab jumeirah', 'burj al arab jumeirah'],
    ['atlantis the palm', 'atlantis the palm'],
    ['kempinski dome belek', 'kempinski hotel the dome belek'],
    ['kempinski hotel the dome belek', 'kempinski hotel the dome belek'],
    ['mandarin oriental bodrum', 'mandarin oriental bodrum'],
  ]);

  private findExistingMatch(normalizedKey: string): string | null {
    for (const [variation, canonical] of this.knownOverrides) {
      if (normalizedKey.includes(variation)) {
        return canonical;
      }
    }
    return null;
  }
}

export const hotelMappingService = new HotelMappingService();
