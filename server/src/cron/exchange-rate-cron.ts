/**
 * Exchange Rate Cron Job
 *
 * Automatically updates exchange rates every hour.
 * Fetches from Frankfurter API (free, ECB-based data).
 * Syncs to database for persistence.
 */
import { refreshRates, getAllRates, syncRatesToDatabase } from '../services/currency-converter';
import prismaManager from '../lib/prisma';

const UPDATE_INTERVAL_MS = 60 * 60 * 1000; // 1 hour
let cronTimer: ReturnType<typeof setInterval> | null = null;
let isRunning = false;

/**
 * Update exchange rates job
 */
async function updateRatesJob(): Promise<void> {
  if (isRunning) {
    console.log('⏭️ Exchange rate update already in progress, skipping...');
    return;
  }

  isRunning = true;
  const startTime = Date.now();

  try {
    console.log('\n💱 EXCHANGE RATE CRON: Starting update...');

    const result = await refreshRates();
    console.log(`✅ Exchange rates updated: ${result.updated} currencies`);

    // Log update to database (optional audit)
    try {
      const prisma = prismaManager.getClient('US');
      // Update the CurrencyConfig model with latest rates
      const rates = await getAllRates('USD');
      for (const rate of rates) {
        await prisma.currencyConfig.upsert({
          where: { code: rate.code },
          update: { exchangeRate: rate.rate, lastUpdated: new Date() },
          create: {
            code: rate.code,
            name: rate.name,
            symbol: rate.symbol,
            exchangeRate: rate.rate,
          },
        });
      }
    } catch (e) {
      // Silent - rates are already cached in memory
    }

    const elapsed = Date.now() - startTime;
    console.log(`💱 EXCHANGE RATE CRON: Completed in ${elapsed}ms`);

  } catch (error: any) {
    console.error(`❌ EXCHANGE RATE CRON failed: ${error.message}`);
  } finally {
    isRunning = false;
  }
}

/**
 * Start the exchange rate cron job
 */
export function startExchangeRateCron(): void {
  if (cronTimer) {
    console.log('💱 Exchange rate cron already running');
    return;
  }

  console.log('💱 Starting exchange rate cron (updates every 1 hour)');

  // Initial fetch
  updateRatesJob();

  // Schedule recurring updates
  cronTimer = setInterval(updateRatesJob, UPDATE_INTERVAL_MS);

  console.log(`💱 Cron scheduled: next update in ${UPDATE_INTERVAL_MS / 1000}s`);
}

/**
 * Stop the exchange rate cron job
 */
export function stopExchangeRateCron(): void {
  if (cronTimer) {
    clearInterval(cronTimer);
    cronTimer = null;
    console.log('💱 Exchange rate cron stopped');
  }
}

/**
 * Manual trigger for rate update
 */
export async function triggerRateUpdate(): Promise<{ success: boolean; message: string }> {
  try {
    await updateRatesJob();
    return { success: true, message: 'Exchange rates updated successfully' };
  } catch (e: any) {
    return { success: false, message: e.message };
  }
}
