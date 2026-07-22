import type { Metadata } from "next";

import AuthCallbackPage from "../../client/auth/callback/AuthCallbackPage";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
  title: "Authentication - Reservatior",
  description: "Completing authentication process for Reservatior platform.",
  keywords: ["authentication","callback","OAuth"],
  openGraph: {
      url: `${siteUrl}/${locale}/auth/callback`,
    title: "Authentication - Reservatior",
    description: "Completing authentication process for Reservatior platform.",
    type: "website",
  },

    alternates: {
      canonical: `${siteUrl}/${locale}/auth/callback`,
    },
  };
}

export default function AuthCallbackPageWrapper() {
  return <AuthCallbackPage />;
}
