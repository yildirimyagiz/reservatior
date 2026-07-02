import { generateOrganizationSchema } from "@/lib/seo/schema-generator";

const siteUrl = "https://reservatior.com";

export function OrganizationSchema() {
  const schema = generateOrganizationSchema("Reservatior", `${siteUrl}/logo.png`);
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: schema }}
    />
  );
}

export function WebsiteSchema() {
  const schema = JSON.stringify({
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: "Reservatior",
    url: siteUrl,
    potentialAction: {
      "@type": "SearchAction",
      target: {
        "@type": "EntryPoint",
        urlTemplate: `${siteUrl}/client/property-search?q={search_term_string}`,
      },
      "query-input": "required name=search_term_string",
    },
  });
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: schema }}
    />
  );
}

export function BreadcrumbSchema({ items }: { items: { name: string; url: string }[] }) {
  const schema = JSON.stringify({
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: items.map((item, index) => ({
      "@type": "ListItem",
      position: index + 1,
      name: item.name,
      item: `${siteUrl}${item.url}`,
    })),
  });
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: schema }}
    />
  );
}

export function RealEstateListingSchema({
  name,
  description,
  url,
  image,
  price,
  currency,
  address,
}: {
  name: string;
  description: string;
  url: string;
  image?: string;
  price?: number;
  currency?: string;
  address?: { city: string; country: string };
}) {
  const schema: Record<string, unknown> = {
    "@context": "https://schema.org",
    "@type": "RealEstateListing",
    name,
    description,
    url: `${siteUrl}${url}`,
  };
  if (image) schema.image = image;
  if (price && currency) {
    schema.offers = {
      "@type": "Offer",
      price,
      priceCurrency: currency,
    };
  }
  if (address) {
    schema.address = {
      "@type": "PostalAddress",
      addressLocality: address.city,
      addressCountry: address.country,
    };
  }
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(schema) }}
    />
  );
}

export function FAQPageSchema({ questions }: { questions: { question: string; answer: string }[] }) {
  const schema = JSON.stringify({
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: questions.map(q => ({
      "@type": "Question",
      name: q.question,
      acceptedAnswer: {
        "@type": "Answer",
        text: q.answer,
      },
    })),
  });
  return (
    <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: schema }} />
  );
}

export function VideoObjectSchema({ name, description, thumbnailUrl, contentUrl, uploadDate, duration }: {
  name: string;
  description: string;
  thumbnailUrl: string;
  contentUrl?: string;
  uploadDate?: string;
  duration?: string;
}) {
  const schema: Record<string, unknown> = {
    "@context": "https://schema.org",
    "@type": "VideoObject",
    name,
    description,
    thumbnailUrl,
  };
  if (contentUrl) schema.contentUrl = contentUrl;
  if (uploadDate) schema.uploadDate = uploadDate;
  if (duration) schema.duration = duration;
  return (
    <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(schema) }} />
  );
}

export function ProductSchema({ name, description, image, url, price, currency, address, bedrooms, bathrooms, area }: {
  name: string;
  description: string;
  image?: string;
  url: string;
  price?: number;
  currency?: string;
  address?: { street?: string; city: string; state?: string; zip?: string; country: string };
  bedrooms?: number;
  bathrooms?: number;
  area?: { value: number; unit: string };
}) {
  const schema: Record<string, unknown> = {
    "@context": "https://schema.org",
    "@type": ["Product", "Place"],
    name,
    description,
    url,
  };
  if (image) schema.image = image;
  if (price && currency) {
    schema.offers = {
      "@type": "Offer",
      price,
      priceCurrency: currency,
      availability: "https://schema.org/InStock",
    };
  }
  if (address) {
    schema.address = {
      "@type": "PostalAddress",
      ...(address.street && { streetAddress: address.street }),
      addressLocality: address.city,
      ...(address.state && { addressRegion: address.state }),
      ...(address.zip && { postalCode: address.zip }),
      addressCountry: address.country,
    };
  }
  if (bedrooms || bathrooms || area) {
    const additionalProps: Record<string, unknown> = {};
    if (bedrooms) additionalProps.numberOfBedrooms = bedrooms;
    if (bathrooms) additionalProps.numberOfBathrooms = bathrooms;
    if (area) {
      additionalProps.floorSize = {
        "@type": "QuantitativeValue",
        value: area.value,
        unitCode: area.unit === "m²" ? "MTK" : "SQFT",
      };
    }
    schema.additionalProperty = Object.entries(additionalProps).map(([key, value]) => ({
      "@type": "PropertyValue",
      name: key,
      value,
    }));
  }
  return (
    <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(schema) }} />
  );
}

export function LocalBusinessSchema({ name, image, url, telephone, address }: {
  name: string;
  image?: string;
  url: string;
  telephone?: string;
  address?: { street?: string; city: string; state?: string; zip?: string; country: string };
}) {
  const schema: Record<string, unknown> = {
    "@context": "https://schema.org",
    "@type": "LocalBusiness",
    name,
    url,
  };
  if (image) schema.image = image;
  if (telephone) schema.telephone = telephone;
  if (address) {
    schema.address = {
      "@type": "PostalAddress",
      ...(address.street && { streetAddress: address.street }),
      addressLocality: address.city,
      ...(address.state && { addressRegion: address.state }),
      ...(address.zip && { postalCode: address.zip }),
      addressCountry: address.country,
    };
  }
  return (
    <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(schema) }} />
  );
}
