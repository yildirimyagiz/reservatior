import type { Metadata, Viewport } from "next";
import Script from "next/script";
import "../globals.css";
import { Providers } from "@/components/providers";
import { inter, outfit } from "@/lib/fonts";

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: [
    { media: "(prefers-color-scheme: dark)", color: "#0A0A0B" },
    { media: "(prefers-color-scheme: light)", color: "#ffffff" },
  ],
};

export const metadata: Metadata = {
  title: "Reservatior - Premium Real Estate Platform with AI",
  description: "Find your perfect property with Reservatior's premium real estate platform.",
};

export default function ClientLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <Script id="locale-init" strategy="beforeInteractive">
        {`(function(){var l=localStorage.getItem("i18nextLng")||localStorage.getItem("reservatior_lang");if(l){if(l==="tr-TR")l="tr";document.documentElement.lang=l;if(l==="ar")document.documentElement.dir="rtl"}})()`}
      </Script>
      <link rel="preconnect" href="https://fonts.googleapis.com" crossOrigin="anonymous" />
      <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
      <body className={`${inter.variable} ${outfit.variable} antialiased`}>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
