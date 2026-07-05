import type { Metadata, ResolvingMetadata } from "next";
import { propertiesApi } from "@/lib/api/properties-eden";
import { PropertySearchContent } from "../../../../property-search/PropertySearchContent";
import { notFound } from "next/navigation";
import { OrganizationSchema } from "@/components/seo/SchemaScript";

type Props = {
  params: { locale: string; country: string; city: string };
};

// Capitalize helper
const capitalize = (s: string) => s.charAt(0).toUpperCase() + s.slice(1).toLowerCase();

export async function generateMetadata(
  { params }: Props,
  _parent: ResolvingMetadata
): Promise<Metadata> {
  const countryName = capitalize(params.country);
  const cityName = capitalize(params.city);
  
  const title = `Properties in ${cityName}, ${countryName} - Real Estate & Rentals | Reservatior`;
  const description = `Discover premium real estate, apartments, and luxury villas in ${cityName}, ${countryName}. Browse verified listings for sale and rent on Reservatior.`;

  return {
    title,
    description,
    openGraph: {
      title,
      description,
      type: "website",
    },
    alternates: {
      canonical: `/${params.locale}/client/properties/${params.country.toLowerCase()}/${params.city.toLowerCase()}`,
    }
  };
}

export default async function LocationPropertiesPage({ params }: Props) {
  const countryName = capitalize(params.country);
  const cityName = capitalize(params.city);

  let properties = [];
  
  try {
    // We pass city as the search query. The backend should ideally support exact matching for city/country
    // Here we use the search parameter as a generic filter.
    const data = await propertiesApi.getAll({ 
      limit: 50,
      search: cityName,
    });
    
    if (data) {
      properties = data;
    }
  } catch (error) {
    console.error("Failed to fetch location properties:", error);
  }

  return (
    <div className="min-h-screen bg-background">
      {/* Location Specific Header SEO */}
      <div className="bg-gradient-to-r from-blue-900 to-indigo-900 py-16 px-4 pt-24 text-center">
        <h1 className="text-4xl md:text-5xl font-bold text-white mb-4">
          Properties in {cityName}, {countryName}
        </h1>
        <p className="text-lg text-blue-100 max-w-2xl mx-auto">
          Explore real estate listings and luxury homes in {cityName}.
        </p>
      </div>
      
      {/* Reuse the PropertySearchContent but pass the location pre-filtered data */}
      <div className="-mt-8">
        <PropertySearchContent initialProperties={properties} />
      </div>
    </div>
  );
}
