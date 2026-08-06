/**
 * src/hooks/useKeywordCapture.ts
 * ─────────────────────────────────────────────────────────────────────────────
 * React Hook for SEO Keyword Capture
 * ─────────────────────────────────────────────────────────────────────────────
 * Captures user input from search forms, URL parameters, and filter changes,
 * then dispatches them as KeywordSignals to the useKeywordStore.
 */

import { useEffect, useCallback } from "react";
import { useKeywordStore } from "@/lib/seo/keyword-store";
import { type SignalSource } from "@/lib/seo/keyword-engine";

interface UseKeywordCaptureOptions {
  locale?: string;
  source?: SignalSource;
  city?: string;
  district?: string;
  propertyType?: string;
  listingType?: "sale" | "rent";
}

export function useKeywordCapture(options: UseKeywordCaptureOptions = {}) {
  const capture = useKeywordStore((state) => state.capture);
  const locale = options.locale || "tr";
  const defaultSource = options.source || "search_box";

  /**
   * Manually capture a search term or keyword query.
   */
  const captureTerm = useCallback(
    (term: string, source: SignalSource = defaultSource) => {
      if (!term || !term.trim()) return;

      capture(term, source, locale, {
        city: options.city,
        district: options.district,
        propertyType: options.propertyType,
        listingType: options.listingType,
      });
    },
    [capture, locale, defaultSource, options.city, options.district, options.propertyType, options.listingType]
  );

  /**
   * Auto-capture keywords from current URL search parameters on mount or URL change.
   */
  useEffect(() => {
    if (typeof window === "undefined") return;

    const urlParams = new URLSearchParams(window.location.search);
    const query = urlParams.get("q") || urlParams.get("query") || urlParams.get("search") || urlParams.get("k");

    if (query && query.trim()) {
      capture(query.trim(), "url_param", locale, {
        city: options.city || urlParams.get("city") || undefined,
        district: options.district || urlParams.get("district") || undefined,
        propertyType: options.propertyType || urlParams.get("type") || undefined,
        listingType: (options.listingType || urlParams.get("listingType")) as "sale" | "rent" | undefined,
      });
    }
  }, [capture, locale, options.city, options.district, options.propertyType, options.listingType]);

  return { captureTerm };
}
