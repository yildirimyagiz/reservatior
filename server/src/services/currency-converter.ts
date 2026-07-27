/**
 * Currency Conversion Service
 *
 * Real exchange rate conversion with caching and automatic updates.
 * Uses Frankfurter API (free, ECB data) for rates.
 * Supports all 23+ country currencies.
 *
 * Key feature: TRY↔USD automatic conversion for Turkish listings
 * (Turkey law prohibits publishing property prices in USD).
 */
import prismaManager from '../lib/prisma';

// ─── Types ──────────────────────────────────────────────────────────────────

export interface CurrencyRate {
  code: string;
  name: string;
  symbol: string;
  rate: number; // Rate relative to USD
  lastUpdated: Date;
}

export interface ConversionResult {
  amount: number;
  from: string;
  to: string;
  rate: number;
  convertedAmount: number;
  timestamp: string;
}

export interface MultiCurrencyPrice {
  original: { amount: number; currency: string };
  usd: { amount: number; currency: string };
  local: { amount: number; currency: string };
  all: Record<string, number>;
}

// ─── Supported Currencies ───────────────────────────────────────────────────

export const SUPPORTED_CURRENCIES: Record<string, { name: string; symbol: string; country: string }> = {
  USD: { name: 'US Dollar', symbol: '$', country: 'US' },
  TRY: { name: 'Turkish Lira', symbol: '₺', country: 'TR' },
  EUR: { name: 'Euro', symbol: '€', country: 'EU' },
  GBP: { name: 'British Pound', symbol: '£', country: 'UK' },
  AED: { name: 'UAE Dirham', symbol: 'د.إ', country: 'AE' },
  SAR: { name: 'Saudi Riyal', symbol: '﷼', country: 'SA' },
  JPY: { name: 'Japanese Yen', symbol: '¥', country: 'JP' },
  KRW: { name: 'South Korean Won', symbol: '₩', country: 'KR' },
  CNY: { name: 'Chinese Yuan', symbol: '¥', country: 'CN' },
  INR: { name: 'Indian Rupee', symbol: '₹', country: 'IN' },
  SGD: { name: 'Singapore Dollar', symbol: 'S$', country: 'SG' },
  MYR: { name: 'Malaysian Ringgit', symbol: 'RM', country: 'MY' },
  THB: { name: 'Thai Baht', symbol: '฿', country: 'TH' },
  AUD: { name: 'Australian Dollar', symbol: 'A$', country: 'AU' },
  NZD: { name: 'New Zealand Dollar', symbol: 'NZ$', country: 'NZ' },
  CAD: { name: 'Canadian Dollar', symbol: 'C$', country: 'CA' },
  MXN: { name: 'Mexican Peso', symbol: '$', country: 'MX' },
  BRL: { name: 'Brazilian Real', symbol: 'R$', country: 'BR' },
  ARS: { name: 'Argentine Peso', symbol: '$', country: 'AR' },
  CHF: { name: 'Swiss Franc', symbol: 'CHF', country: 'CH' },
  DKK: { name: 'Danish Krone', symbol: 'kr', country: 'DK' },
  NOK: { name: 'Norwegian Krone', symbol: 'kr', country: 'NO' },
  SEK: { name: 'Swedish Krona', symbol: 'kr', country: 'SE' },
  PLN: { name: 'Polish Zloty', symbol: 'zł', country: 'PL' },
  RUB: { name: 'Russian Ruble', symbol: '₽', country: 'RU' },
};

// Country → Default Currency mapping
export const COUNTRY_CURRENCY: Record<string, string> = {
  TR: 'TRY', US: 'USD', UK: 'GBP', DE: 'EUR', FR: 'EUR', ES: 'EUR', IT: 'EUR',
  NL: 'EUR', CA: 'CAD', MX: 'MXN', BR: 'BRL', AR: 'ARS', AU: 'AUD', NZ: 'NZD',
  JP: 'JPY', KR: 'KRW', CN: 'CNY', IN: 'INR', SG: 'SGD', MY: 'MYR', TH: 'THB',
  AE: 'AED', SA: 'SAR',
};

// ─── In-Memory Rate Cache ───────────────────────────────────────────────────

let rateCache: Map<string, CurrencyRate> = new Map();
let lastFetchTime: Date | null = null;
const CACHE_TTL_MS = 60 * 60 * 1000; // 1 hour

// ─── Frankfurter API (Free, ECB-based) ──────────────────────────────────────

const FRANKFURTER_BASE = 'https://api.frankfurter.app';

async function fetchRatesFromAPI(base: string = 'USD'): Promise<Record<string, number>> {
  const currencies = Object.keys(SUPPORTED_CURRENCIES).filter(c => c !== base).join(',');
  const url = `${FRANKFURTER_BASE}/latest?from=${base}&to=${currencies}`;

  console.log(`💱 Fetching exchange rates from Frankfurter API (${base} → ${Object.keys(SUPPORTED_CURRENCIES).length - 1} currencies)...`);

  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`Frankfurter API error: ${response.status}`);
  }

  const data = await response.json() as any;
  console.log(`✅ Rates fetched: ${Object.keys(data.rates).length} currencies, date: ${data.date}`);
  return data.rates;
}

// ─── Database Sync ──────────────────────────────────────────────────────────

async function syncRatesToDatabase(rates: Record<string, number>, base: string = 'USD'): Promise<void> {
  const prisma = prismaManager.getClient('US'); // Base DB for currency config

  for (const [code, rate] of Object.entries(rates)) {
    const meta = SUPPORTED_CURRENCIES[code];
    if (!meta) continue;

    const invertedRate = base === 'USD' ? rate : 1 / rate; // Convert to USD-based

    await prisma.currencyConfig.upsert({
      where: { code },
      update: {
        exchangeRate: invertedRate,
        lastUpdated: new Date(),
      },
      create: {
        code,
        name: meta.name,
        symbol: meta.symbol,
        exchangeRate: invertedRate,
        lastUpdated: new Date(),
      },
    });
  }

  // Also ensure USD itself exists
  await prisma.currencyConfig.upsert({
    where: { code: 'USD' },
    update: { exchangeRate: 1, lastUpdated: new Date() },
    create: {
      code: 'USD',
      name: 'US Dollar',
      symbol: '$',
      exchangeRate: 1,
      lastUpdated: new Date(),
    },
  });

  console.log(`✅ ${Object.keys(rates).length + 1} currencies synced to database`);
}

// ─── Rate Fetching & Caching ────────────────────────────────────────────────

async function ensureRatesLoaded(): Promise<void> {
  const now = new Date();
  if (rateCache.size > 0 && lastFetchTime && (now.getTime() - lastFetchTime.getTime()) < CACHE_TTL_MS) {
    return;
  }

  try {
    const rates = await fetchRatesFromAPI('USD');
    rateCache.clear();

    // Add USD itself
    rateCache.set('USD', {
      code: 'USD', name: 'US Dollar', symbol: '$', rate: 1, lastUpdated: now,
    });

    for (const [code, rate] of Object.entries(rates)) {
      const meta = SUPPORTED_CURRENCIES[code];
      if (meta) {
        rateCache.set(code, {
          code, name: meta.name, symbol: meta.symbol, rate, lastUpdated: now,
        });
      }
    }

    lastFetchTime = now;

    // Sync to database in background (don't await)
    syncRatesToDatabase(rates).catch(e => console.error('DB sync error:', e));

  } catch (error: any) {
    console.error(`❌ Failed to fetch rates: ${error.message}`);

    // Fallback: try to load from database
    if (rateCache.size === 0) {
      await loadRatesFromDatabase();
    }
  }
}

async function loadRatesFromDatabase(): Promise<void> {
  try {
    const prisma = prismaManager.getClient('US');
    const configs = await prisma.currencyConfig.findMany({ where: { isActive: true } });

    if (configs.length > 0) {
      rateCache.clear();
      for (const config of configs) {
        rateCache.set(config.code, {
          code: config.code,
          name: config.name,
          symbol: config.symbol,
          rate: config.exchangeRate,
          lastUpdated: config.lastUpdated,
        });
      }
      console.log(`📦 Loaded ${configs.length} currencies from database cache`);
    }
  } catch (e) {
    console.error('Failed to load rates from DB:', e);
  }
}

// ─── Public API ─────────────────────────────────────────────────────────────

/**
 * Get exchange rate for a currency pair
 */
export async function getRate(from: string, to: string): Promise<number> {
  await ensureRatesLoaded();

  const fromUpper = from.toUpperCase();
  const toUpper = to.toUpperCase();

  if (fromUpper === toUpper) return 1;

  const fromRate = rateCache.get(fromUpper);
  const toRate = rateCache.get(toUpper);

  if (!fromRate || !toRate) {
    throw new Error(`Unsupported currency: ${fromUpper} or ${toUpper}`);
  }

  // Both rates are relative to USD
  // from/to = toRate.rate / fromRate.rate
  return toRate.rate / fromRate.rate;
}

/**
 * Convert amount between currencies
 */
export async function convert(amount: number, from: string, to: string): Promise<ConversionResult> {
  const rate = await getRate(from, to);
  const convertedAmount = Math.round(amount * rate * 100) / 100;

  return {
    amount,
    from: from.toUpperCase(),
    to: to.toUpperCase(),
    rate: Math.round(rate * 1000000) / 1000000,
    convertedAmount,
    timestamp: new Date().toISOString(),
  };
}

/**
 * Get multi-currency price for a property
 * Given a price in one currency, returns it in all major currencies
 */
export async function getMultiCurrencyPrice(amount: number, currency: string): Promise<MultiCurrencyPrice> {
  await ensureRatesLoaded();

  const usdAmount = currency.toUpperCase() === 'USD' ? amount : await convert(amount, currency, 'USD');

  const all: Record<string, number> = {};
  for (const [code, rateInfo] of rateCache) {
    if (currency.toUpperCase() === code) {
      all[code] = amount;
    } else {
      all[code] = Math.round(usdAmount.amount * rateInfo.rate * 100) / 100;
    }
  }

  return {
    original: { amount, currency: currency.toUpperCase() },
    usd: { amount: usdAmount.convertedAmount, currency: 'USD' },
    local: { amount, currency: currency.toUpperCase() },
    all,
  };
}

/**
 * Get all current rates
 */
export async function getAllRates(base: string = 'USD'): Promise<CurrencyRate[]> {
  await ensureRatesLoaded();

  const baseRate = rateCache.get(base.toUpperCase());
  if (!baseRate) throw new Error(`Unsupported base currency: ${base}`);

  return Array.from(rateCache.values()).map(r => ({
    ...r,
    rate: base === 'USD' ? r.rate : r.rate / baseRate.rate,
  }));
}

/**
 * Get rate info for a specific currency
 */
export async function getCurrencyInfo(code: string): Promise<CurrencyRate | null> {
  await ensureRatesLoaded();
  return rateCache.get(code.toUpperCase()) || null;
}

/**
 * Force refresh rates from API
 */
export async function refreshRates(): Promise<{ updated: number; timestamp: string }> {
  lastFetchTime = null; // Force refresh
  await ensureRatesLoaded();
  return {
    updated: rateCache.size,
    timestamp: new Date().toISOString(),
  };
}

// ─── TR-Specific: TRY ↔ USD Auto Conversion ────────────────────────────────

/**
 * For Turkish listings: convert USD price to TRY automatically
 * Turkish law prohibits publishing property prices in USD
 */
export async function getTRYPrice(usdAmount: number): Promise<{
  try: { amount: number; formatted: string };
  usd: { amount: number; formatted: string };
  rate: number;
}> {
  const rate = await getRate('USD', 'TRY');
  const tryAmount = Math.round(usdAmount * rate);

  return {
    try: {
      amount: tryAmount,
      formatted: new Intl.NumberFormat('tr-TR', { style: 'currency', currency: 'TRY', maximumFractionDigits: 0 }).format(tryAmount),
    },
    usd: {
      amount: usdAmount,
      formatted: new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(usdAmount),
    },
    rate,
  };
}

/**
 * Format currency with locale-aware formatting
 */
export async function formatCurrency(amount: number, currencyCode: string, locale?: string): Promise<string> {
  const info = rateCache.get(currencyCode.toUpperCase());
  const autoLocale = locale || (SUPPORTED_CURRENCIES[currencyCode.toUpperCase()]?.country || 'US');

  try {
    return new Intl.NumberFormat(`${autoLocale}-${autoLocale}`, {
      style: 'currency',
      currency: currencyCode.toUpperCase(),
      maximumFractionDigits: 0,
    }).format(amount);
  } catch {
    return `${SUPPORTED_CURRENCIES[currencyCode.toUpperCase()]?.symbol || ''} ${amount.toLocaleString()}`;
  }
}
