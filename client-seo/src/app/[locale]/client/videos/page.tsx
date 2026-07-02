import type { Metadata } from "next";
import VideosPage from "./VideosPage";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Property Video Tours - AI-Powered Virtual Tours | Reservatior",
  description: "Browse AI-powered property video tours with ML-enhanced virtual walkthroughs of premium real estate listings.",
  keywords: ["property videos","virtual tours","AI video","real estate tours","ML neural engine"],
  openGraph: {
    title: "Property Video Tours - AI-Powered Virtual Tours | Reservatior",
    description: "Browse AI-powered property video tours with ML-enhanced virtual walkthroughs of premium real estate listings.",
    type: "website",
  },
  alternates: {
    canonical: "/client/videos",
  },
};

export const revalidate = 3600;

export default function VideosPageWrapper() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Video Tours", url: "/client/videos" },
      ]} />
      <VideosPage />
    </>
  );
}
