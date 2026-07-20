export interface LocalizationOSMetrics {
  totalCountries: number;
  activeCountries: number;
  totalTranslations: number;
  translationAccuracy: number;
  localizedContent: number;
  contentCoverage: number;
  exchangeRateUpdates: number;
  currencyConversions: number;
  supportedLanguages: number;
  systemLatency: number;
}

export const LocalizationOSMetricDefinitions: Record<string, any> = {
  total_countries: { name: 'Total Countries', unit: 'count', category: 'country' },
  active_countries: { name: 'Active Countries', unit: 'count', category: 'country' },
  total_translations: { name: 'Total Translations', unit: 'count', category: 'translation' },
  translation_accuracy: { name: 'Translation Accuracy', unit: 'percentage', category: 'translation' },
  localized_content: { name: 'Localized Content', unit: 'count', category: 'content' },
  content_coverage: { name: 'Content Coverage', unit: 'percentage', category: 'content' },
  exchange_rate_updates: { name: 'Exchange Rate Updates', unit: 'count', category: 'exchange_rate' },
  currency_conversions: { name: 'Currency Conversions', unit: 'count', category: 'exchange_rate' },
  supported_languages: { name: 'Supported Languages', unit: 'count', category: 'language' },
  system_latency: { name: 'System Latency', unit: 'milliseconds', category: 'performance' },
};

export class LocalizationOSMetricsCollector {
  private metrics = new Map<string, number>();
  
  recordMetric(name: string, value: number): void {
    this.metrics.set(name, value);
  }
  
  getMetric(name: string): number | undefined {
    return this.metrics.get(name);
  }
  
  getAllMetrics(): Record<string, number> {
    return Object.fromEntries(this.metrics);
  }
  
  reset(): void {
    this.metrics.clear();
  }
}
