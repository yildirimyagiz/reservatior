import type { Metadata, Viewport } from "next";
import "../globals.css";
import { Providers } from "@/components/providers";
import { OrganizationSchema, WebsiteSchema } from "@/components/seo/SchemaScript";
import { inter, outfit } from "@/lib/fonts";
import { LocalizationProvider } from "@/contexts/LocalizationContext";
import { loadLocaleOnServer } from "@/i18n/server-preload";

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';
const siteName = "Reservatior";
const defaultTitle = "Reservatior - Premium Real Estate Platform with AI";
const defaultDescription = "Find your perfect property with Reservatior's premium real estate platform. AI-powered property search, valuations, and automated workflows.";

const SUPPORTED_LOCALES = ["en", "es", "fr", "de", "tr", "ar", "zh", "ja", "ko", "ru", "pt", "it", "nl", "pl", "sv", "da", "fi", "el", "hi", "nb"] as const;

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
  loadLocaleOnServer(locale || "en");
  return (
    <html lang={locale || "en"} dir={locale === "ar" ? "rtl" : "ltr"} suppressHydrationWarning>
      <head>
        <link rel="preload" href="/videos/poster.webp" as="image" fetchPriority="high" />
        <link rel="preconnect" href="https://fonts.googleapis.com" crossOrigin="anonymous" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link rel="preload" href={`/locales/${locale || "en"}.json`} as="fetch" crossOrigin="anonymous" />
      </head>
      <body className={`${inter.variable} ${outfit.variable} antialiased`}>
        <a href="#main-content" className="sr-only focus:not-sr-only focus:fixed focus:top-4 focus:left-4 focus:z-50 focus:px-4 focus:py-2 focus:bg-blue-600 focus:text-white focus:rounded-lg" tabIndex={0}>
          Skip to main content
        </a>
        <OrganizationSchema />
        <WebsiteSchema />
        <LocalizationProvider initialLocale={locale}>
          <Providers><div id="main-content">{children}</div></Providers>
        </LocalizationProvider>
      </body>
    </html>
  );
}
