import { useTranslation } from "react-i18next";
import React from "react";
import { Helmet } from "react-helmet-async";
import { generateSchema, SEOData } from "@/lib/seo/schema-generator";
interface SEOMetadataProps {
  data: SEOData;
  noIndex?: boolean;
}

/**
 * Premium SEO Metadata Component for AI-Integrated Search Engines.
 * Injects OpenGraph, Twitter, and Schema.org JSON-LD tags into the head.
 * Emphasizes Direct Booking benefits to outrank aggregators.
 */
export const SEOMetadata: React.FC<SEOMetadataProps> = ({
  data,
  noIndex = false
}) => {
  const {
    t
  } = useTranslation();
  const schemaJson = generateSchema(data);

  // Fallback description for Social
  const metaDescription = data.description || "The premium destination for direct bookings and exclusive real estate listings. Better prices, direct from owners.";
  return <Helmet>
      {/* Basic Meta Tags */}
      <title>{data.title}{t("client.src.reservatior_direct")}</title>
      <meta name="description" content={metaDescription} />
      {noIndex && <meta name="robots" content="noindex, nofollow" />}
      {!noIndex && <meta name="robots" content="index, follow" />}

      {/* Structured Data (JSON-LD) for Google Hotels and SGE */}
      <script type="application/ld+json">{schemaJson}</script>

      {/* OpenGraph (Facebook / WhatsApp / LinkedIn) */}
      <meta property="og:type" content={data.type === 'HOTEL' ? 'hotel' : 'website'} />
      <meta property="og:title" content={data.title} />
      <meta property="og:description" content={metaDescription} />
      <meta property="og:image" content={data.image || "https://reservatior.com/default-og.jpg"} />
      <meta property="og:url" content={data.url} />
      <meta property="og:site_name" content="Reservatior" />

      {/* Twitter Card Details */}
      <meta name="twitter:card" content="summary_large_image" />
      <meta name="twitter:title" content={data.title} />
      <meta name="twitter:description" content={metaDescription} />
      <meta name="twitter:image" content={data.image || "https://reservatior.com/default-og.jpg"} />

      {/* Special Tags for AI Search Agents (SGE/Perplexity) */}
      <meta name="keywords" content={data.amenities?.join(', ') || "real estate, booking, direct prices, hotel, property, luxury"} />
      <meta name="author" content="Reservatior" />
      <meta name="price" content={`${data.price || '0.00'}`} />
      <meta name="priceCurrency" content={data.currency || 'USD'} />
      
      {/* Dynamic Canonical URL to avoid Duplicates */}
      <link rel="canonical" href={data.url} />

      {/* Price Guarantee Announcement (invisible to users, readable by agents) */}
      <meta name="availability-note" content="Direct price match guarantee. Exclusive rates only available here." />
    </Helmet>;
};
export default SEOMetadata;