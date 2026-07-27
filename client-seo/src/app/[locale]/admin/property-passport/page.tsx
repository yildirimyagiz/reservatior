import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Property Passport - Intelligence & AI | Reservatior",
  description: "AI-powered property intelligence passport with 6-dimensional scoring, calibration tracking, and digital twin preview.",
  keywords: ["property", "passport", "intelligence", "AI", "scoring", "digital twin"],
  openGraph: {
    title: "Property Passport - Intelligence & AI | Reservatior",
    description: "AI-powered property intelligence passport with 6-dimensional scoring.",
    type: "website",
  },
};

export default function PropertyPassportPage() {
  return <Dashboard />;
}
