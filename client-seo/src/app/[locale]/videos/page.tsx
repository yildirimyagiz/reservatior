import Videos from "@/pages-spa/client/Videos";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Property Video Tours - AI-Powered Virtual Tours | Reservatior",
  description: "Browse AI-powered property video tours with ML-enhanced virtual walkthroughs of premium real estate listings. Cinematic 4K virtual tours of luxury properties.",
  openGraph: {
    title: "Property Video Tours - AI-Powered Virtual Tours | Reservatior",
    description: "Browse AI-powered property video tours with ML-enhanced virtual walkthroughs of premium real estate listings.",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Property Video Tours - AI-Powered Virtual Tours | Reservatior",
    description: "Browse AI-powered property video tours with ML-enhanced virtual walkthroughs of premium real estate listings.",
  }
};


export default function VideosPage() {
  return (
    <div className="flex flex-col h-screen bg-background overflow-hidden">
      <AppHeader />
      <main className="flex-1 relative overflow-hidden">
        <Videos />
      </main>
    </div>
  );
}
