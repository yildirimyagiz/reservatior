import type { Metadata } from "next";
import BundlesPage from "./BundlesPage";

export const metadata: Metadata = {
  title: "Product Bundles - Admin Panel | Reservatior",
  description: "Create and manage staging bundles for properties",
  keywords: ["bundles", "staging", "packages", "admin"],
  openGraph: {
    title: "Product Bundles - Admin Panel | Reservatior",
    description: "Create and manage staging bundles for properties",
    type: "website",
  },
};

export default function BundlesPageWrapper() {
  return <BundlesPage />;
}
