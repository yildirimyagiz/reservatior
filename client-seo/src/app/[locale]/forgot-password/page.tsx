import type { Metadata } from "next";

import ForgotPasswordPage from "../client/forgot-password/ForgotPasswordPage";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
  title: "Reset Password - Reservatior Account Recovery",
  description: "Reset your Reservatior account password and regain access to your real estate management tools.",
  keywords: ["forgot password","reset password","account recovery"],
  openGraph: {
      url: `${siteUrl}/${locale}/forgot-password`,
    title: "Reset Password - Reservatior Account Recovery",
    description: "Reset your Reservatior account password and regain access to your real estate management tools.",
    type: "website",
  },
  robots: { index: false, follow: false },

    alternates: {
      canonical: `${siteUrl}/${locale}/forgot-password`,
    },
  };
}

export default function ForgotPasswordPageWrapper() {
  return <ForgotPasswordPage />;
}
