import type { Metadata, ResolvingMetadata } from "next";
import { propertiesApi } from "@/lib/api/properties-eden";
import { RealEstateListingSchema } from "@/components/seo/SchemaScript";
import { notFound } from "next/navigation";
import { MapPin, Bed, Bath, Maximize, ArrowLeft } from "lucide-react";
import Link from "next/link";

type Props = {
  params: { id: string };
};

// Next.js dynamic metadata generation (SSR)
export async function generateMetadata(
  { params }: Props,
  _parent: ResolvingMetadata
): Promise<Metadata> {
  const id = params.id;
  
  try {
    const { data: property, error } = await propertiesApi.getById(id);
    
    if (error || !property) {
      return {
        title: "Property Not Found | Reservatior",
      };
    }

    const title = `${property.name} - ${property.city} | Reservatior`;
    const description = property.aiSummary || property.notes || `View details for ${property.name} located in ${property.city}, ${property.country}.`;
    
    const formatPrice = (price: number = 0, currency = "USD") => {
      return new Intl.NumberFormat("en-US", {
        style: "currency",
        currency: currency,
        maximumFractionDigits: 0,
      }).format(price);
    };

    const priceText = formatPrice(property.price, property.currency);
    const ogUrl = new URL(`${process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com'}/api/og/property`);
    ogUrl.searchParams.set('title', property.name);
    ogUrl.searchParams.set('price', priceText);
    ogUrl.searchParams.set('location', `${property.city}, ${property.country}`);
    if (property.listings?.[0]?.pricingRules?.[0]?.discountRules?.image) {
      ogUrl.searchParams.set('image', property.listings[0].pricingRules[0].discountRules.image);
    }
    const imageUrl = ogUrl.toString();

    return {
      title,
      description,
      openGraph: {
        title,
        description,
        images: [
          { 
            url: imageUrl, 
            width: 1200, 
            height: 630, 
            alt: title 
          }
        ],
        type: "website",
      },
      twitter: {
        card: "summary_large_image",
        title,
        description,
        images: [imageUrl],
      },
      alternates: {
        canonical: `/client/properties/${id}`,
      }
    };
  } catch (_error) {
    return {
      title: "Property | Reservatior",
    };
  }
}

// React Server Component for the public listing
export default async function PublicPropertyPage({ params }: Props) {
  const id = params.id;
  
  // Note: in Next.js App router, fetch is deduped, 
  // so calling propertiesApi.getById again here is cached automatically!
  const { data: property, error } = await propertiesApi.getById(id);
  
  if (error || !property) {
    notFound();
  }

  // Format currency
  const formatPrice = (price: number = 0, currency = "USD") => {
    return new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: currency,
      maximumFractionDigits: 0,
    }).format(price);
  };

  return (
    <div className="min-h-screen bg-[#fafafa] dark:bg-[#0a0a0c] pt-24 pb-20">
      
      {/* JSON-LD Schema for Google SEO */}
      <RealEstateListingSchema 
        name={property.name}
        description={property.aiSummary || property.notes || ""}
        url={`/client/properties/${id}`}
        address={{ city: property.city, country: property.country }}
      />

      <main className="container max-w-6xl mx-auto px-4">
        {/* Back navigation */}
        <Link 
          href="/client/property-search" 
          className="inline-flex items-center text-sm text-muted-foreground hover:text-primary mb-6 transition-colors"
        >
          <ArrowLeft className="w-4 h-4 mr-2" />
          Back to properties
        </Link>

        {/* Hero Section */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          
          {/* Main Info */}
          <div className="lg:col-span-2 space-y-8">
            <div>
              <div className="flex items-center gap-2 text-sm text-muted-foreground mb-3 uppercase tracking-wider font-semibold">
                <span className="px-2 py-1 bg-primary/10 text-primary rounded-md">
                  {property.listingType === 'SALE' ? 'For Sale' : 'For Rent'}
                </span>
                <span>•</span>
                <span>{property.propertyCategory}</span>
              </div>
              <h1 className="text-4xl lg:text-5xl font-bold tracking-tight mb-4 text-foreground">
                {property.name}
              </h1>
              <div className="flex items-center text-muted-foreground">
                <MapPin className="w-5 h-5 mr-2" />
                <span className="text-lg">
                  {property.addressLine1}, {property.city} {property.stateCode}, {property.country}
                </span>
              </div>
            </div>

            {/* Quick Stats */}
            <div className="grid grid-cols-3 gap-4 border-y border-border py-6">
              <div className="flex flex-col items-center justify-center p-4 bg-white/5 rounded-2xl border border-white/10">
                <Bed className="w-6 h-6 text-blue-400 mb-2" />
                <span className="text-xl font-bold">{property.bedrooms}</span>
                <span className="text-xs text-muted-foreground uppercase tracking-widest font-semibold mt-1">Bedrooms</span>
              </div>
              <div className="flex flex-col items-center justify-center p-4 bg-white/5 rounded-2xl border border-white/10">
                <Bath className="w-6 h-6 text-blue-400 mb-2" />
                <span className="text-xl font-bold">{property.bathrooms}</span>
                <span className="text-xs text-muted-foreground uppercase tracking-widest font-semibold mt-1">Bathrooms</span>
              </div>
              <div className="flex flex-col items-center justify-center p-4 bg-white/5 rounded-2xl border border-white/10">
                <Maximize className="w-6 h-6 text-blue-400 mb-2" />
                <span className="text-xl font-bold">{property.areaSqm}</span>
                <span className="text-xs text-muted-foreground uppercase tracking-widest font-semibold mt-1">Square Meters</span>
              </div>
            </div>

            {/* AI Summary Section */}
            {property.aiSummary && (
              <div>
                <h3 className="text-xl font-bold mb-4 flex items-center">
                  <div className="flex items-center gap-2">
                    <span className="relative flex h-3 w-3">
                      <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-blue-400 opacity-75"></span>
                      <span className="relative inline-flex rounded-full h-3 w-3 bg-blue-500"></span>
                    </span>
                    View AI Valuation
                  </div>
                </h3>
                <p className="text-muted-foreground leading-relaxed text-lg">
                  {property.aiSummary}
                </p>
              </div>
            )}
            
            {/* Details section */}
            <div className="bg-white/5 rounded-[2rem] p-8 border border-white/10">
              <h3 className="text-xl font-bold mb-4">Property Details</h3>
              <div className="prose prose-invert max-w-none">
                <p className="text-muted-foreground leading-relaxed">
                  {property.notes || "No additional details available."}
                </p>
              </div>
            </div>
          </div>

          {/* Sticky Sidebar */}
          <div className="lg:col-span-1">
            <div className="sticky top-24 bg-card rounded-3xl p-6 border border-border shadow-sm">
              <div className="mb-6">
                <p className="text-sm text-muted-foreground mb-1 uppercase tracking-wider font-semibold">
                  {property.listingType === 'SALE' ? 'Asking Price' : 'Monthly Rent'}
                </p>
                {/* Assuming there's a price field, fallback to static if not present in schema snapshot */}
                <h2 className="text-4xl font-bold text-foreground">
                  {formatPrice(property.price || 0, property.currency || 'USD')}
                </h2>
              </div>
              
              <button className="w-full bg-primary text-primary-foreground font-semibold py-4 rounded-xl hover:opacity-90 transition-opacity mb-4">
                Contact Agent
              </button>
              <button className="w-full bg-secondary text-secondary-foreground font-semibold py-4 rounded-xl hover:opacity-90 transition-opacity">
                Schedule Tour
              </button>
            </div>
          </div>

        </div>
      </main>
    </div>
  );
}
