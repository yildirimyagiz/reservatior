/**
 * Country Context Model
 * 
 * Country-specific rules and context for agent decision making
 * Agents use this to adapt their logic per country without knowing database schemas
 */

export interface CountryContext {
  country_code: string;
  country_name: string;
  currency: string;
  timezone: string;
  
  // Legal Framework
  legal_framework: {
    property_ownership: {
      foreign_ownership_allowed: boolean;
      restrictions: string[];
      minimum_investment: number;
      ownership_types: string[];
    };
    rental_regulations: {
      rent_control: boolean;
      max_rent_increase: number; // percentage
      eviction_rules: string[];
      tenant_protections: string[];
    };
    taxation: {
      property_tax_rate: number;
      capital_gains_tax: number;
      rental_income_tax: number;
      vat_rate: number;
      stamp_duty: number;
    };
  };
  
  // Market Specifics
  market_specifics: {
    primary_cities: string[];
    market_trends: string[];
    demand_factors: string[];
    risk_factors: string[];
  };
  
  // Agent-Specific Rules
  agent_rules: {
    valuation: {
      models: string[];
      factors: string[];
      adjustments: Record<string, number>;
    };
    acquisition: {
      yield_thresholds: {
        minimum: number;
        good: number;
        excellent: number;
      };
      risk_factors: string[];
      opportunity_factors: string[];
    };
    communication: {
      preferred_channels: string[];
      language: string;
      cultural_considerations: string[];
    };
  };
}

export class CountryContextRegistry {
  private contexts: Map<string, CountryContext>;

  constructor() {
    this.contexts = new Map();
    this.initializeDefaultContexts();
  }

  /**
   * Initialize default country contexts
   */
  private initializeDefaultContexts() {
    // Turkey Context
    this.registerContext({
      country_code: 'TR',
      country_name: 'Turkey',
      currency: 'TRY',
      timezone: 'Europe/Istanbul',
      legal_framework: {
        property_ownership: {
          foreign_ownership_allowed: true,
          restrictions: ['military zones', 'strategic areas'],
          minimum_investment: 0,
          ownership_types: ['freehold', 'leasehold']
        },
        rental_regulations: {
          rent_control: false,
          max_rent_increase: 25, // 25% annual limit
          eviction_rules: ['contract-based', 'court-order'],
          tenant_protections: ['security deposit', 'notice period']
        },
        taxation: {
          property_tax_rate: 0.002, // 0.2% annually
          capital_gains_tax: 0.20, // 20%
          rental_income_tax: 0.15, // 15%
          vat_rate: 0.20, // 20%
          stamp_duty: 0.04 // 4%
        }
      },
      market_specifics: {
        primary_cities: ['Istanbul', 'Ankara', 'Izmir', 'Antalya', 'Bursa'],
        market_trends: ['urbanization', 'tourism growth', 'foreign investment'],
        demand_factors: ['population growth', 'tourism', 'industrial development'],
        risk_factors: ['earthquake risk', 'currency volatility', 'political stability']
      },
      agent_rules: {
        valuation: {
          models: ['tr-yield-model', 'tr-location-model', 'tr-market-model'],
          factors: ['earthquake_zone', 'urban_transformation', 'tourism_potential'],
          adjustments: {
            earthquake_risk: -0.15,
            tourism_potential: 0.10,
            urban_transformation: 0.08
          }
        },
        acquisition: {
          yield_thresholds: {
            minimum: 0.04, // 4%
            good: 0.06, // 6%
            excellent: 0.08 // 8%
          },
          risk_factors: ['earthquake_zone', 'building_age', 'legal_status'],
          opportunity_factors: ['urban_transformation', 'tourism_demand', 'foreign_investment']
        },
        communication: {
          preferred_channels: ['whatsapp', 'email', 'phone'],
          language: 'tr',
          cultural_considerations: ['formal address', 'relationship building', 'trust importance']
        }
      }
    });

    // UAE Context
    this.registerContext({
      country_code: 'AE',
      country_name: 'United Arab Emirates',
      currency: 'AED',
      timezone: 'Asia/Dubai',
      legal_framework: {
        property_ownership: {
          foreign_ownership_allowed: true,
          restrictions: ['designated areas only'],
          minimum_investment: 0,
          ownership_types: ['freehold', 'leasehold']
        },
        rental_regulations: {
          rent_control: false,
          max_rent_increase: 0, // No limit
          eviction_rules: ['contract-based', 'court-order'],
          tenant_protections: ['security deposit', 'contract terms']
        },
        taxation: {
          property_tax_rate: 0, // No property tax
          capital_gains_tax: 0, // No capital gains tax
          rental_income_tax: 0, // No rental income tax
          vat_rate: 0.05, // 5%
          stamp_duty: 0.04 // 4%
        }
      },
      market_specifics: {
        primary_cities: ['Dubai', 'Abu Dhabi', 'Sharjah', 'Ajman'],
        market_trends: ['luxury market', 'foreign investment', 'tourism'],
        demand_factors: ['expat population', 'tourism', 'business hub'],
        risk_factors: ['oil dependency', 'market volatility', 'regulatory changes']
      },
      agent_rules: {
        valuation: {
          models: ['ae-yield-model', 'ae-location-model', 'ae-luxury-model'],
          factors: ['freehold_status', 'location_premium', 'amenities'],
          adjustments: {
            freehold_premium: 0.15,
            location_premium: 0.20,
            luxury_premium: 0.25
          }
        },
        acquisition: {
          yield_thresholds: {
            minimum: 0.05, // 5%
            good: 0.07, // 7%
            excellent: 0.09 // 9%
          },
          risk_factors: ['location_quality', 'developer_reputation', 'market_saturation'],
          opportunity_factors: ['tourism_growth', 'expat_demand', 'business_activity']
        },
        communication: {
          preferred_channels: ['whatsapp', 'email', 'phone'],
          language: 'en',
          cultural_considerations: ['relationship building', 'respect hierarchy', 'hospitality']
        }
      }
    });

    // USA Context
    this.registerContext({
      country_code: 'US',
      country_name: 'United States',
      currency: 'USD',
      timezone: 'America/New_York',
      legal_framework: {
        property_ownership: {
          foreign_ownership_allowed: true,
          restrictions: [],
          minimum_investment: 0,
          ownership_types: ['fee_simple', 'condo', 'co-op']
        },
        rental_regulations: {
          rent_control: true, // Varies by state/city
          max_rent_increase: 0, // Varies by jurisdiction
          eviction_rules: ['state-specific', 'federal guidelines'],
          tenant_protections: ['security deposit', 'habitability standards']
        },
        taxation: {
          property_tax_rate: 0.012, // 1.2% average
          capital_gains_tax: 0.20, // 20% (long-term)
          rental_income_tax: 0.25, // 25% average
          vat_rate: 0, // No VAT
          stamp_duty: 0 // No stamp duty
        }
      },
      market_specifics: {
        primary_cities: ['New York', 'Los Angeles', 'Chicago', 'Miami', 'San Francisco'],
        market_trends: ['remote work impact', 'urban-to-suburban shift', 'interest rate sensitivity'],
        demand_factors: ['job growth', 'population migration', 'interest rates'],
        risk_factors: ['interest rate risk', 'economic cycles', 'regulatory changes']
      },
      agent_rules: {
        valuation: {
          models: ['us-avm-model', 'us-market-model', 'us-location-model'],
          factors: ['school_district', 'crime_rate', 'transportation'],
          adjustments: {
            school_quality: 0.12,
            crime_rate: -0.10,
            transportation: 0.08
          }
        },
        acquisition: {
          yield_thresholds: {
            minimum: 0.03, // 3%
            good: 0.05, // 5%
            excellent: 0.07 // 7%
          },
          risk_factors: ['neighborhood_trend', 'economic_indicators', 'interest_rates'],
          opportunity_factors: ['job_growth', 'population_growth', 'development_plans']
        },
        communication: {
          preferred_channels: ['email', 'phone', 'sms'],
          language: 'en',
          cultural_considerations: ['professional communication', 'data-driven decisions', 'time efficiency']
        }
      }
    });

    console.log('[CountryContextRegistry] Initialized default country contexts');
  }

  /**
   * Register country context
   */
  registerContext(context: CountryContext): void {
    this.contexts.set(context.country_code, context);
    console.log(`[CountryContextRegistry] Registered context for ${context.country_code}`);
  }

  /**
   * Get country context
   */
  getContext(countryCode: string): CountryContext | undefined {
    return this.contexts.get(countryCode);
  }

  /**
   * Get all contexts
   */
  getAllContexts(): CountryContext[] {
    return Array.from(this.contexts.values());
  }

  /**
   * Get country-specific valuation factors
   */
  getValuationFactors(countryCode: string): string[] {
    const context = this.getContext(countryCode);
    return context?.agent_rules.valuation.factors || [];
  }

  /**
   * Get country-specific acquisition thresholds
   */
  getAcquisitionThresholds(countryCode: string) {
    const context = this.getContext(countryCode);
    return context?.agent_rules.acquisition.yield_thresholds || {
      minimum: 0.03,
      good: 0.05,
      excellent: 0.07
    };
  }

  /**
   * Get country-specific risk factors
   */
  getRiskFactors(countryCode: string): string[] {
    const context = this.getContext(countryCode);
    return context?.agent_rules.acquisition.risk_factors || [];
  }

  /**
   * Get country-specific opportunity factors
   */
  getOpportunityFactors(countryCode: string): string[] {
    const context = this.getContext(countryCode);
    return context?.agent_rules.acquisition.opportunity_factors || [];
  }

  /**
   * Get country-specific valuation adjustments
   */
  getValuationAdjustments(countryCode: string): Record<string, number> {
    const context = this.getContext(countryCode);
    return context?.agent_rules.valuation.adjustments || {};
  }

  /**
   * Check if foreign ownership is allowed
   */
  isForeignOwnershipAllowed(countryCode: string): boolean {
    const context = this.getContext(countryCode);
    return context?.legal_framework.property_ownership.foreign_ownership_allowed || false;
  }

  /**
   * Get country-specific communication preferences
   */
  getCommunicationPreferences(countryCode: string) {
    const context = this.getContext(countryCode);
    return context?.agent_rules.communication || {
      preferred_channels: ['email'],
      language: 'en',
      cultural_considerations: []
    };
  }
}

export const countryContextRegistry = new CountryContextRegistry();
