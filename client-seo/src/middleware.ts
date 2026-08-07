import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export const locales = ["en","es","fr","de","tr","ar","zh","ja","ko","ru","pt","it","nl","pl","sv","da","fi","el","hi","nb"];
export const defaultLocale = "en";

// IP → locale haritası (CDN header'larından gelen ISO 3166-1 alpha-2 → i18n dil kodu)
const COUNTRY_TO_LOCALE: Record<string, string> = {
  TR: "tr", AE: "ar", SA: "ar", DE: "de", FR: "fr",
  ES: "es", IT: "it", NL: "nl", MX: "es", BR: "pt",
  AR: "es", JP: "ja", KR: "ko", CN: "zh", IN: "hi",
  GB: "en", UK: "en", AU: "en", NZ: "en", SG: "en",
  CA: "en", MY: "en", TH: "en", PL: "pl", SE: "sv",
  DK: "da", FI: "fi", GR: "el", NO: "nb", RU: "ru",
  US: "en",
};

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Locale JSON'ları her istekte ETag ile yeniden doğrulanmalı; aksi halde
  // tarayıcı eski (eksik anahtarlı) çevirileri günlerce önbelleğe alır ve
  // sayfada ham i18n anahtarları görünür (max-age=86400 + stale copy).
  if (pathname.startsWith("/locales/")) {
    const localeRes = NextResponse.next();
    localeRes.headers.set("Cache-Control", "no-cache, max-age=0, must-revalidate");
    return localeRes;
  }

  // Statik dosyalar, API ve Next.js internal yollarını atla
  if (
    pathname.startsWith("/_next") ||
    pathname.startsWith("/api") ||
    pathname.includes(".") ||
    pathname === "/favicon.ico" ||
    pathname === "/sitemap.xml" ||
    pathname === "/robots.txt" ||
    pathname === "/site.webmanifest"
  ) {
    return NextResponse.next();
  }

  // Zaten locale ile başlıyorsa dokunma
  const pathnameHasLocale = locales.some(
    (locale) => pathname.startsWith(`/${locale}/`) || pathname === `/${locale}`
  );
  if (pathnameHasLocale) return NextResponse.next();

  // CDN header'larından IP ülkesini tespit et
  const cfCountry     = request.headers.get("cf-ipcountry");
  const vercelCountry = request.headers.get("x-vercel-ip-country");
  const cfCountryUpper = (cfCountry || vercelCountry || "").toUpperCase();

  // Accept-Language başlığından birincil dili al
  const acceptLang  = request.headers.get("accept-language") || "";
  const primaryLang = acceptLang.split(",")[0]?.split("-")[0]?.toLowerCase() || "";

  // Locale önceliği: 1. IP ülkesi → 2. Accept-Language → 3. default
  let locale = defaultLocale;
  if (cfCountryUpper && COUNTRY_TO_LOCALE[cfCountryUpper]) {
    locale = COUNTRY_TO_LOCALE[cfCountryUpper];
  } else if (primaryLang && locales.includes(primaryLang)) {
    locale = primaryLang;
  }

  // Kullanıcının daha önce manuel seçtiği dili localStorage'dan okuyamayız
  // (middleware sunucu tarafında çalışır), bu yüzden cookie'ye bakıyoruz
  const savedLocale = request.cookies.get("NEXT_LOCALE")?.value;
  if (savedLocale && locales.includes(savedLocale)) {
    locale = savedLocale;
  }

  request.nextUrl.pathname = `/${locale}${pathname === "/" ? "" : pathname}`;
  const response = NextResponse.rewrite(request.nextUrl);
  response.cookies.set("NEXT_LOCALE", locale, { path: "/", maxAge: 365 * 24 * 60 * 60 });
  return response;
}

export const config = {
  matcher: ["/((?!_next|api|.*\\..*).*)", "/locales/:path*"],
};
