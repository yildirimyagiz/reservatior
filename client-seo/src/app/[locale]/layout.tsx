import type { Metadata, Viewport } from "next";
import "../globals.css";
import Script from "next/script";
import { Providers } from "@/components/providers";
import { OrganizationSchema, WebsiteSchema } from "@/components/seo/SchemaScript";
import { inter, outfit } from "@/lib/fonts";
import { LocalizationProvider } from "@/contexts/LocalizationContext";

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';
const siteName = "Reservatior";
const defaultTitle = "Reservatior - Premium Real Estate Platform with AI";
const defaultDescription = "Find your perfect property with Reservatior's premium real estate platform. AI-powered property search, valuations, and automated workflows.";

const SUPPORTED_LOCALES = ["en", "tr", "ar", "es", "fr", "de", "ru", "pt", "zh", "ja", "ko", "it", "nl", "pl", "sv", "da", "fi", "el", "hi", "id"] as const;

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: [
    { media: "(prefers-color-scheme: dark)", color: "#0A0A0B" },
    { media: "(prefers-color-scheme: light)", color: "#ffffff" },
  ],
};

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  const languages: Record<string, string> = {
    "x-default": `${siteUrl}/en`,
  };
  for (const l of SUPPORTED_LOCALES) {
    languages[l] = `${siteUrl}/${l}`;
  }

  const ogImage = `${siteUrl}/api/og`;

  return {
    metadataBase: new URL(siteUrl),
    title: defaultTitle,
    description: defaultDescription,
    keywords: ["real estate", "property search", "AI valuation", "property management", "booking system", "automated workflows"],
    authors: [{ name: "Reservatior" }],
    creator: "Reservatior",
    publisher: "Reservatior",
    formatDetection: {
      email: false,
      address: false,
      telephone: false,
    },
    icons: {
      icon: "/favicon.ico",
      apple: [{ url: "/apple-touch-icon.svg", sizes: "180x180", type: "image/svg+xml" }],
    },
    manifest: "/site.webmanifest",
    appleWebApp: {
      title: "Reservatior",
      statusBarStyle: "black-translucent",
    },
    other: {
      "mobile-web-app-capable": "yes",
    },
    openGraph: {
      type: "website",
      locale: locale === "tr" ? "tr_TR" : locale === "ar" ? "ar_SA" : "en_US",
      url: siteUrl,
      siteName,
      title: defaultTitle,
      description: defaultDescription,
      images: [
        {
          url: ogImage,
          width: 1200,
          height: 630,
          alt: siteName,
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title: defaultTitle,
      description: defaultDescription,
      images: [ogImage],
    },
    robots: {
      index: true,
      follow: true,
      googleBot: {
        index: true,
        follow: true,
        'max-video-preview': -1,
        'max-image-preview': 'large',
        'max-snippet': -1,
      },
    },
    alternates: {
      canonical: locale === "en" ? `${siteUrl}` : `${siteUrl}/${locale}`,
      languages,
    },
    verification: {
      google: process.env.NEXT_PUBLIC_GOOGLE_VERIFICATION,
    },
  };
}

export default function RootLayout({
  children,
  params: { locale },
}: Readonly<{
  children: React.ReactNode;
  params: { locale: string };
}>) {
  return (
    <html lang={locale || "en"} suppressHydrationWarning>
      <head>
        <link rel="preload" href="/videos/ozak-bg.mp4" as="video" type="video/mp4" />
        <link rel="preload" href="/videos/poster.webp" as="image" />
        <link rel="preconnect" href="https://images.unsplash.com" crossOrigin="anonymous" />
        <link rel="dns-prefetch" href="https://images.unsplash.com" />
      </head>
      <body className={`${inter.variable} ${outfit.variable} antialiased`}>
        <Script id="locale-init" strategy="afterInteractive">
          {`(function(){var urlLocale="${locale}"; var l=urlLocale||localStorage.getItem("i18nextLng")||localStorage.getItem("reservatior_lang");if(l){if(l==="tr-TR")l="tr";document.documentElement.lang=l;if(l==="ar"){document.documentElement.dir="rtl"}else{document.documentElement.dir="ltr"}}})()`}
        </Script>
        <Script id="localization-init" strategy="beforeInteractive">
          {`(function(){var urlLocale="${locale}"; var countryCode="US"; var currency="USD"; if(urlLocale==="tr"){countryCode="TR";currency="TRY"}else if(urlLocale==="ar"){countryCode="SA";currency="SAR"}else if(urlLocale==="es"){countryCode="ES";currency="EUR"}else if(urlLocale==="fr"){countryCode="FR";currency="EUR"}else if(urlLocale==="de"){countryCode="DE";currency="EUR"}else if(urlLocale==="ru"){countryCode="RU";currency="RUB"}else if(urlLocale==="pt"){countryCode="PT";currency="EUR"}else if(urlLocale==="zh"){countryCode="CN";currency="CNY"}else if(urlLocale==="ja"){countryCode="JP";currency="JPY"}else if(urlLocale==="ko"){countryCode="KR";currency="KRW"}else if(urlLocale==="it"){countryCode="IT";currency="EUR"}else if(urlLocale==="nl"){countryCode="NL";currency="EUR"}else if(urlLocale==="pl"){countryCode="PL";currency="PLN"}else if(urlLocale==="sv"){countryCode="SE";currency="SEK"}else if(urlLocale==="da"){countryCode="DK";currency="DKK"}else if(urlLocale==="fi"){countryCode="FI";currency="EUR"}else if(urlLocale==="el"){countryCode="GR";currency="EUR"}else if(urlLocale==="hi"){countryCode="IN";currency="INR"}else if(urlLocale==="id"){countryCode="ID";currency="IDR"};localStorage.setItem("countryCode",localStorage.getItem("countryCode")||countryCode);localStorage.setItem("language",localStorage.getItem("language")||urlLocale||"en");localStorage.setItem("currency",localStorage.getItem("currency")||currency);localStorage.setItem("timezone",localStorage.getItem("timezone")||Intl.DateTimeFormat().resolvedOptions().timeZone)()`}
        </Script>
        <OrganizationSchema />
        <WebsiteSchema />
        <LocalizationProvider>
          <Providers>{children}</Providers>
        </LocalizationProvider>
      </body>
    </html>
  );
}
