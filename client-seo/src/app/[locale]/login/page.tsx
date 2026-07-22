import type { Metadata } from "next";

import LoginPage from "../client/login/LoginPage";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
  title: "Sign In - Reservatior Account Access",
  description: "Sign in to your Reservatior account to manage properties, bookings, and access AI-powered real estate tools.",
  keywords: ["login","sign in","account access","real estate platform"],
  openGraph: {
      url: `${siteUrl}/${locale}/login`,
    title: "Sign In - Reservatior Account Access",
    description: "Sign in to your Reservatior account to manage properties, bookings, and access AI-powered real estate tools.",
    type: "website",
  },
  robots: { index: false, follow: false },

    alternates: {
      canonical: `${siteUrl}/${locale}/login`,
    },
  };
}

export default function LoginPageWrapper() {
  return <LoginPage />;
}
