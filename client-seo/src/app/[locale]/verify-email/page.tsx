import type { Metadata } from "next";

import VerifyEmailPage from "../client/verify-email/VerifyEmailPage";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
  title: "Verify Email - Confirm Your Account | Reservatior",
  description: "Verify your email address to activate your Reservatior account and access all features.",
  keywords: ["verify email","email verification","account activation"],
  openGraph: {
      url: `${siteUrl}/${locale}/verify-email`,
    title: "Verify Email - Confirm Your Account | Reservatior",
    description: "Verify your email address to activate your Reservatior account and access all features.",
    type: "website",
  },
  robots: { index: false, follow: false },

    alternates: {
      canonical: `${siteUrl}/${locale}/verify-email`,
    },
  };
}

export default function VerifyEmailPageWrapper() {
  return <VerifyEmailPage />;
}
