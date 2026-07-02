import type { Metadata } from "next";
import { StudioContent } from "@/app/[locale]/client/social-media/StudioContent";


export const metadata: Metadata = {
  title: "Social Media Studio | Reservatior",
  description: "Manage your social media accounts, schedule property posts, and automate engagement with AI-powered tools.",
  robots: { index: false, follow: false },
};

export default function SocialMediaPage() {
  return <StudioContent />;
}
