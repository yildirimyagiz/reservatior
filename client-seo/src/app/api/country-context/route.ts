import { NextRequest, NextResponse } from "next/server";

// ISO 3166-1 alpha-2 → Resortsun region context
const REGION_CONTEXT: Record<string, { region: string; currency: string; locale: string; isRTL: boolean }> = {
  US: { region: "US", currency: "USD", locale: "en", isRTL: false },
  CA: { region: "CA", currency: "CAD", locale: "en", isRTL: false },
  MX: { region: "MX", currency: "MXN", locale: "es", isRTL: false },
  BR: { region: "BR", currency: "BRL", locale: "pt", isRTL: false },
  AR: { region: "AR", currency: "ARS", locale: "es", isRTL: false },
  UK: { region: "UK", currency: "GBP", locale: "en", isRTL: false },
  GB: { region: "UK", currency: "GBP", locale: "en", isRTL: false },
  DE: { region: "DE", currency: "EUR", locale: "de", isRTL: false },
  FR: { region: "FR", currency: "EUR", locale: "fr", isRTL: false },
  ES: { region: "ES", currency: "EUR", locale: "es", isRTL: false },
  IT: { region: "IT", currency: "EUR", locale: "it", isRTL: false },
  NL: { region: "NL", currency: "EUR", locale: "nl", isRTL: false },
  TR: { region: "TR", currency: "TRY", locale: "tr", isRTL: false },
  AU: { region: "AU", currency: "AUD", locale: "en", isRTL: false },
  NZ: { region: "NZ", currency: "NZD", locale: "en", isRTL: false },
  JP: { region: "JP", currency: "JPY", locale: "ja", isRTL: false },
  KR: { region: "KR", currency: "KRW", locale: "ko", isRTL: false },
  CN: { region: "CN", currency: "CNY", locale: "zh", isRTL: false },
  IN: { region: "IN", currency: "INR", locale: "hi", isRTL: false },
  SG: { region: "SG", currency: "SGD", locale: "en", isRTL: false },
  MY: { region: "MY", currency: "MYR", locale: "en", isRTL: false },
  TH: { region: "TH", currency: "THB", locale: "en", isRTL: false },
  AE: { region: "AE", currency: "AED", locale: "ar", isRTL: true },
  SA: { region: "SA", currency: "SAR", locale: "ar", isRTL: true },
};

const DEFAULT_CONTEXT = REGION_CONTEXT.US;

export async function GET(request: NextRequest) {
  // Read geo headers if available (Cloudflare, Vercel, CloudFront)
  const country = (
    request.headers.get("cf-ipcountry") ||
    request.headers.get("x-vercel-ip-country") ||
    request.headers.get("cloudfront-viewer-country") ||
    ""
  ).toUpperCase();

  const context = REGION_CONTEXT[country] || DEFAULT_CONTEXT;

  return NextResponse.json({
    region: context.region,
    currency: context.currency,
    locale: context.locale,
    isRTL: context.isRTL,
    detectionMethod: country ? (request.headers.get("cf-ipcountry") ? "cloudflare" : "geo") : "default",
  });
}
