import type { Metadata } from "next";
import { SpaClient } from "./SpaClient";

export const metadata: Metadata = {
  title: "Reservatior - AI-Powered Real Estate Platform",
  description: "Find your perfect property with Reservatior's premium real estate platform. AI-powered property search, valuations, and automated workflows.",
  openGraph: {
    title: "Reservatior - AI-Powered Real Estate Platform",
    description: "Premium platform for direct bookings, AI valuations, and smart property management.",
    type: "website",
  },
};

export default function SpaPageWrapper() {
  return <SpaClient />;
}
