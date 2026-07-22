import type { Metadata } from "next";

import SignupPage from "../client/signup/SignupPage";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
  title: "Create Account - Join Reservatior",
  description: "Create your Reservatior account and start managing properties with AI-powered real estate tools.",
  keywords: ["sign up","create account","register","real estate platform"],
  openGraph: {
      url: `${siteUrl}/${locale}/signup`,
    title: "Create Account - Join Reservatior",
    description: "Create your Reservatior account and start managing properties with AI-powered real estate tools.",
    type: "website",
  },
  robots: { index: false, follow: false },

    alternates: {
      canonical: `${siteUrl}/${locale}/signup`,
    },
  };
}

export default function SignupPageWrapper() {
  return <SignupPage />;
}
