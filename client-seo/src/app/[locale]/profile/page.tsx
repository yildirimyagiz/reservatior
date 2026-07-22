import type { Metadata } from "next";

import ProfilePage from "../client/profile/ProfilePage";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
  title: "Profile - Account Settings | Reservatior",
  description: "Manage your Reservatior account settings, preferences, and personal information.",
  keywords: ["profile","account settings","preferences","user profile"],
  openGraph: {
      url: `${siteUrl}/${locale}/profile`,
    title: "Profile - Account Settings | Reservatior",
    description: "Manage your Reservatior account settings, preferences, and personal information.",
    type: "website",
  },

    alternates: {
      canonical: `${siteUrl}/${locale}/profile`,
    },
  };
}

export default function ProfilePageWrapper() {
  return <ProfilePage />;
}
