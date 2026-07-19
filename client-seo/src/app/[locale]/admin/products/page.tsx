import type { Metadata } from "next";
import ProductsPage from "./ProductsPage";

export const metadata: Metadata = {
  title: "Products - Admin Panel | Reservatior",
  description: "Manage your product catalog, categories, and pricing",
  keywords: ["products", "catalog", "commerce", "admin"],
  openGraph: {
    title: "Products - Admin Panel | Reservatior",
    description: "Manage your product catalog, categories, and pricing",
    type: "website",
  },
};

export default function ProductsPageWrapper() {
  return <ProductsPage />;
}
