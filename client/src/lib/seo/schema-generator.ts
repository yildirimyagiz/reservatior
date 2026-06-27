/**
 * SEO Schema Generator for Google Hotels, Real Estate, and AI Search Engines.
 * Following Schema.org standards for maximum visibility in Google Search Generative Experience (SGE).
 */

export interface SEOData {
  type: 'HOTEL' | 'REAL_ESTATE' | 'LISTING' | 'ORGANIZATION';
  title: string;
  description: string;
  image?: string;
  url: string;
  price?: number;
  currency?: string;
  address?: {
    street?: string;
    city: string;
    state?: string;
    zip?: string;
    country: string;
  };
  geo?: {
    lat: number;
    lng: number;
  };
  amenities?: string[];
  rating?: number;
  reviewCount?: number;
}

export const generateSchema = (data: SEOData) => {
  const baseSchema = {
    "@context": "https://schema.org",
    "@type": data.type === 'HOTEL' ? 'Hotel' : data.type === 'REAL_ESTATE' ? 'RealEstateListing' : 'Product',
    "name": data.title,
    "description": data.description,
    "url": data.url,
    "image": data.image || "https://reservatior.com/default-og.jpg", // Replace with real default
  };

  if (data.address) {
    (baseSchema as any).address = {
      "@type": "PostalAddress",
      "streetAddress": data.address.street,
      "addressLocality": data.address.city,
      "addressRegion": data.address.state,
      "postalCode": data.address.zip,
      "addressCountry": data.address.country,
    };
  }

  if (data.geo) {
    (baseSchema as any).geo = {
      "@type": "GeoCoordinates",
      "latitude": data.geo.lat,
      "longitude": data.geo.lng,
    };
  }

  if (data.price && data.currency) {
    (baseSchema as any).offers = {
      "@type": "Offer",
      "price": data.price,
      "priceCurrency": data.currency,
      "availability": "https://schema.org/InStock",
      "seller": {
        "@type": "Organization",
        "name": "Reservatior Direct"
      },
      "priceValidUntil": new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0], // 30 days from now
      "description": "Direct Booking Price - Lowest Guarantee"
    };
  }

  if (data.amenities?.length) {
     (baseSchema as any).amenityFeature = data.amenities.map(name => ({
       "@type": "LocationFeatureSpecification",
       "name": name,
       "value": true
     }));
  }

  return JSON.stringify(baseSchema);
};

export const generateOrganizationSchema = (orgName: string, logo?: string) => {
  return JSON.stringify({
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": orgName,
    "logo": logo || "https://reservatior.com/logo.png",
    "url": "https://reservatior.com",
    "contactPoint": {
      "@type": "ContactPoint",
      "telephone": "+1-800-RESERV",
      "contactType": "customer service"
    }
  });
};
