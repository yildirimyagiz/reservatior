// Get localization context from localStorage or defaults
const getLocalizationContext = () => {
  if (typeof window !== 'undefined') {
    return {
      'x-country-code': localStorage.getItem('countryCode') || 'US',
      'x-language': localStorage.getItem('language') || 'en',
      'x-currency': localStorage.getItem('currency') || 'USD',
      'x-timezone': localStorage.getItem('timezone') || Intl.DateTimeFormat().resolvedOptions().timeZone,
    };
  }
  return {
    'x-country-code': 'US',
    'x-language': 'en',
    'x-currency': 'USD',
    'x-timezone': 'America/New_York',
  };
};

export const analyticsOSApi = {
  getDashboardStats: async (orgId: string, timeRange?: { start: string; end: string }) => {
    const params = new URLSearchParams({ orgId });
    if (timeRange) {
      params.append('start', timeRange.start);
      params.append('end', timeRange.end);
    }
    const res = await fetch(`/api/v1/analytics-os/dashboard?${params}`, {
      headers: getLocalizationContext(),
    });
    if (!res.ok) throw new Error('Failed to fetch analytics OS dashboard stats');
    return res.json();
  },

  trackMetric: async (data: { metricType: string; value: number; dimensions?: Record<string, any> }) => {
    const res = await fetch('/api/v1/analytics-os/metrics', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        ...getLocalizationContext(),
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to track metric');
    return res.json();
  },

  getKPIs: async (orgId: string) => {
    const res = await fetch(`/api/v1/analytics-os/kpis?orgId=${orgId}`, {
      headers: getLocalizationContext(),
    });
    if (!res.ok) throw new Error('Failed to fetch KPIs');
    return res.json();
  },

  getInsights: async (metricType: string, timeRange: { start: string; end: string }) => {
    const res = await fetch(`/api/v1/analytics-os/insights?metricType=${metricType}&start=${timeRange.start}&end=${timeRange.end}`, {
      headers: getLocalizationContext(),
    });
    if (!res.ok) throw new Error('Failed to fetch insights');
    return res.json();
  },

  createWidget: async (widget: any, orgId: string) => {
    const res = await fetch(`/api/v1/analytics-os/widgets?orgId=${orgId}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        ...getLocalizationContext(),
      },
      body: JSON.stringify(widget),
    });
    if (!res.ok) throw new Error('Failed to create widget');
    return res.json();
  },

  getWidgets: async (orgId: string) => {
    const res = await fetch(`/api/v1/analytics-os/widgets?orgId=${orgId}`, {
      headers: getLocalizationContext(),
    });
    if (!res.ok) throw new Error('Failed to fetch widgets');
    return res.json();
  },

  getDataTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/analytics-os/data-trends?orgId=${orgId}`, {
      headers: getLocalizationContext(),
    });
    if (!res.ok) throw new Error('Failed to fetch data trends');
    return res.json();
  },

  getReportDistribution: async (orgId: string) => {
    const res = await fetch(`/api/v1/analytics-os/report-distribution?orgId=${orgId}`, {
      headers: getLocalizationContext(),
    });
    if (!res.ok) throw new Error('Failed to fetch report distribution');
    return res.json();
  },
};
