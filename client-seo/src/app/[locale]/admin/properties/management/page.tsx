import type { Metadata } from "next";
import PropertyManagementPage from "./PropertyManagementPage";

export const metadata: Metadata = {
  title: "Property Management - Overview & Tools | Reservatior",
  description: "Comprehensive property management tools for owners and managers.",
  keywords: ["property management","property tools","management overview"],
  openGraph: {
    title: "Property Management - Overview & Tools | Reservatior",
    description: "Comprehensive property management tools for owners and managers.",
    type: "website",
  },
};

export default function PropertyManagementPageWrapper() {
  return <PropertyManagementPage />;
}
