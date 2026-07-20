/**
 * Localization OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const localizationDashboards: DashboardConfig[] = [
  {
    id: 'localization-overview',
    name: 'Localization Overview',
    description: 'Overview of localization metrics and coverage',
    osModule: 'LocalizationOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Countries',
        metricName: 'localization.total_countries',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Languages',
        metricName: 'localization.total_languages',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Currencies',
        metricName: 'localization.total_currencies',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Translation Completion',
        metricName: 'localization.translation_completion',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Translation Progress',
        metricName: 'localization.translation_progress',
        config: { chartType: 'bar' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Content by Language',
        metricName: 'localization.content_by_language',
        config: { chartType: 'pie' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Language Coverage',
        metricName: 'localization.language_coverage',
        config: { columns: ['language', 'completion_rate', 'total_keys', 'translated_keys', 'last_updated'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'localization-translations',
    name: 'Translation Activity',
    description: 'Translation metrics and AI translation performance',
    osModule: 'LocalizationOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Translations Today',
        metricName: 'translations.total_today',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'AI Translations',
        metricName: 'translations.ai_generated',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Manual Translations',
        metricName: 'translations.manual',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Pending Translations',
        metricName: 'translations.pending',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Translation Volume Trend',
        metricName: 'translations.volume_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Translation by Language Pair',
        metricName: 'translations.by_language_pair',
        config: { chartType: 'heatmap' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Translations',
        metricName: 'translations.recent',
        config: { columns: ['key', 'source_language', 'target_language', 'method', 'timestamp'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'localization-regional',
    name: 'Regional Performance',
    description: 'Regional metrics and localization effectiveness',
    osModule: 'LocalizationOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Active Countries',
        metricName: 'regional.active_countries',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Regional Content Views',
        metricName: 'regional.content_views',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Localized Conversions',
        metricName: 'regional.localized_conversions',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Localization Lift',
        metricName: 'regional.localization_lift',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Traffic by Country',
        metricName: 'regional.traffic_by_country',
        config: { chartType: 'bar' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Conversion Rate by Region',
        metricName: 'regional.conversion_by_region',
        config: { chartType: 'line' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Regional Performance',
        metricName: 'regional.performance',
        config: { columns: ['country', 'traffic', 'conversions', 'conversion_rate', 'localization_status'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'localization-currency',
    name: 'Currency & Pricing',
    description: 'Currency configuration and pricing metrics',
    osModule: 'LocalizationOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Active Currencies',
        metricName: 'currency.active',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Exchange Rate Updates Today',
        metricName: 'currency.rate_updates',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Price Calculations Today',
        metricName: 'currency.price_calculations',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Regional Pricing Adjustments',
        metricName: 'currency.pricing_adjustments',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Exchange Rate Changes',
        metricName: 'currency.exchange_rate_changes',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue by Currency',
        metricName: 'currency.revenue_by_currency',
        config: { chartType: 'pie' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Currency Performance',
        metricName: 'currency.performance',
        config: { columns: ['currency', 'exchange_rate', 'volume', 'revenue', 'last_updated'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'localization-seo',
    name: 'SEO & Content',
    description: 'Localized SEO and content performance',
    osModule: 'LocalizationOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Localized Pages',
        metricName: 'seo.localized_pages',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'SEO Metadata Generated',
        metricName: 'seo.metadata_generated',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Organic Traffic Localized',
        metricName: 'seo.organic_traffic',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Local Search Rankings',
        metricName: 'seo.local_rankings',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Organic Traffic by Region',
        metricName: 'seo.organic_traffic_by_region',
        config: { chartType: 'bar' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'SEO Performance Trend',
        metricName: 'seo.performance_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Localized Pages',
        metricName: 'seo.top_pages',
        config: { columns: ['page', 'language', 'views', 'conversions', 'ranking'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Localization OS dashboards
 */
export function registerLocalizationDashboards() {
  localizationDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[LocalizationOS] Registered ${localizationDashboards.length} dashboards`);
}
