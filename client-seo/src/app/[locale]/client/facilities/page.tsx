import type { Metadata } from "next";
import { FacilitiesContent } from "./FacilitiesContent";

export const metadata: Metadata = {
  title: "Facilities - Facility Management | Reservatior",
  description: "Manage property facilities and amenities. Track maintenance and availability.",
  keywords: ["facilities", "amenities", "facility management", "property features"],
  openGraph: {
    title: "Facilities - Facility Management | Reservatior",
    description: "Manage property facilities and amenities.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function FacilitiesPage() {
  return <FacilitiesContent />;
}
