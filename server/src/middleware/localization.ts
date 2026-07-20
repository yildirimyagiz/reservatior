import { Elysia } from "elysia";

const DEFAULT_COUNTRY = "US";
const DEFAULT_LANGUAGE = "en";
const DEFAULT_CURRENCY = "USD";
const DEFAULT_TIMEZONE = "America/New_York";

export const localizationMiddleware = new Elysia({ name: "localization-middleware" })
  .derive({ as: "scoped" }, async ({ headers, set }) => {
    // Get localization context from headers or use defaults
    const countryCode = headers["x-country-code"] as string || DEFAULT_COUNTRY;
    const language = headers["x-language"] as string || DEFAULT_LANGUAGE;
    const currency = headers["x-currency"] as string || DEFAULT_CURRENCY;
    const timezone = headers["x-timezone"] as string || DEFAULT_TIMEZONE;

    // Validate country code (ISO 3166-1 alpha-2)
    const validCountryCode = /^[A-Z]{2}$/.test(countryCode) ? countryCode : DEFAULT_COUNTRY;
    
    // Validate language code (ISO 639-1)
    const validLanguage = /^[a-z]{2}$/.test(language) ? language : DEFAULT_LANGUAGE;
    
    // Validate currency code (ISO 4217)
    const validCurrency = /^[A-Z]{3}$/.test(currency) ? currency : DEFAULT_CURRENCY;

    return {
      localization: {
        countryCode: validCountryCode,
        language: validLanguage,
        currency: validCurrency,
        timezone: timezone || DEFAULT_TIMEZONE,
      },
    };
  });

export const optionalLocalizationMiddleware = new Elysia({ name: "optional-localization-middleware" })
  .derive({ as: "scoped" }, async ({ headers }) => {
    const countryCode = headers["x-country-code"] as string;
    const language = headers["x-language"] as string;
    const currency = headers["x-currency"] as string;
    const timezone = headers["x-timezone"] as string;

    return {
      localization: countryCode || language || currency || timezone ? {
        countryCode: countryCode || DEFAULT_COUNTRY,
        language: language || DEFAULT_LANGUAGE,
        currency: currency || DEFAULT_CURRENCY,
        timezone: timezone || DEFAULT_TIMEZONE,
      } : null,
    };
  });
