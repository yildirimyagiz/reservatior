import { useMemo } from 'react';
import countryRules from './country-rules.json';

type Models = keyof typeof countryRules.models;

export function useCountryGuard(activeCountry: string | undefined | null) {
  const isFieldAllowed = useMemo(() => {
    return (model: string, field: string): boolean => {
      // If no active country is defined, we can either restrict or allow everything.
      // Usually, we allow base fields if country is not yet known.
      if (!activeCountry) return true;

      const normalizedCountry = activeCountry.toUpperCase().trim();
      
      const modelRules = (countryRules.models as Record<string, Record<string, string[]>>)[model];
      if (!modelRules) return true; // Model not restricted
      
      const allowedCountries = modelRules[field];
      if (!allowedCountries) return true; // Field not restricted
      
      return allowedCountries.includes(normalizedCountry);
    };
  }, [activeCountry]);

  return { isFieldAllowed };
}
