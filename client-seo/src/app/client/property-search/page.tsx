import type { Metadata } from "next";
import { PropertySearchContent } from "@/app/[locale]/client/property-search/PropertySearchContent";
import { propertiesApi } from "@/lib/api/properties";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Property Search - Find Your Perfect Property | Reservatior",
  description: "Search through thousands of properties for sale and rent. Find your perfect home with AI-powered property search, advanced filters, and real-time listings.",
  keywords: ["property search", "real estate", "homes for sale", "rentals", "property listings", "find property"],
  openGraph: {
    title: "Property Search - Find Your Perfect Property | Reservatior",
    description: "Search through thousands of properties for sale and rent. Find your perfect home with AI-powered property search.",
    type: "website",
  },
  alternates: {
    canonical: "/client/property-search",
  },
};

export const revalidate = 3600;

export default async function PropertySearchPage({
  searchParams,
}: {
  searchParams: { [key: string]: string | string[] | undefined }
}) {
  let initialProperties: any[] = [];
  
  try {
    // Convert searchParams to appropriate format
    const location = typeof searchParams.location === 'string' ? searchParams.location : undefined;
    const listingType = typeof searchParams.type === 'string' ? searchParams.type : undefined;
    
    // Fetch real properties server-side for SEO and instant render
    const data = await propertiesApi.getAll({ 
      limit: 50,
      search: location, // Pass the location search param if it exists
    });
    
    if (data) {
      // Filter by type manually if API doesn't support it directly in getAll, or pass it if it does
      initialProperties = listingType && listingType !== 'all' 
        ? data.filter((p: any) => p.listingType === listingType)
        : data;
    }
  } catch (error) {
    console.error("Failed to fetch search properties server-side:", error);
  }

  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Property Search", url: "/client/property-search" },
      ]} />
      <PropertySearchContent initialProperties={initialProperties} />
    </>
  );
}
