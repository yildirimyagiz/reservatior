export interface PropertyROIInput {
  purchasePrice: number;
  downPaymentPercent: number;
  mortgageAmount: number;
  interestRate: number;
  monthlyRent: number;
  annualMaintenance: number;
  serviceCharges: number;
  vacancyRate: number;
  appreciationRate: number;
  holdingPeriodYears: number;
  currency: string;
  city: string;
  district?: string;
  propertyType?: string;
}

export interface PropertyROIOutput {
  grossRentalYield: number;
  netRentalYield: number;
  annualCashFlow: number;
  monthlyCashFlow: number;
  totalROI: number;
  annualROI: number;
  capRate: number;
  breakEvenMonths: number;
  totalInvestment: number;
  totalReturn: number;
  profitAfterHolding: number;
  yearByYear: YearProjection[];
  riskScore: number;
  investmentGrade: "A+" | "A" | "B+" | "B" | "C+" | "C" | "D";
}

export interface YearProjection {
  year: number;
  propertyValue: number;
  annualRent: number;
  mortgagePayment: number;
  netIncome: number;
  cumulativeCashFlow: number;
  equityBuilt: number;
  totalROI: number;
}

export interface RentalYieldInput {
  city: string;
  district?: string;
  propertyType: string;
  bedrooms?: number;
  purchasePrice: number;
  monthlyRent: number;
  serviceCharges?: number;
}

export interface RentalYieldOutput {
  grossYield: number;
  netYield: number;
  investorScore: number;
  marketComparison: DistrictComparison[];
  historicalAppreciation: number[];
  rentalDemandIndex: number;
  liquidityScore: number;
  riskLevel: "LOW" | "MEDIUM" | "HIGH";
}

export interface DistrictComparison {
  district: string;
  avgPrice: number;
  avgRent: number;
  grossYield: number;
  netYield: number;
  appreciation: number;
  demandIndex: number;
}

export interface InvestmentReport {
  id: string;
  title: string;
  city: string;
  district: string;
  propertyType: string;
  investmentScore: number;
  riskLevel: "LOW" | "MEDIUM" | "HIGH" | "VERY_HIGH";
  expectedReturn: number;
  rentalPotential: string;
  marketAnalysis: string;
  comparableProperties: ComparableProperty[];
  recommendations: string[];
  generatedAt: string;
  roi: PropertyROIOutput;
  leadEmail?: string;
  pdfUrl?: string;
}

export interface ComparableProperty {
  name: string;
  price: number;
  rent: number;
  yield: number;
  district: string;
}

export interface PropertyComparisonItem {
  id: string;
  name: string;
  city: string;
  district: string;
  purchasePrice: number;
  monthlyRent: number;
  grossYield: number;
  netYield: number;
  roi: number;
  locationScore: number;
  liquidityScore: number;
  appreciationPotential: number;
  overallScore: number;
}

export interface InvestorProfile {
  id: string;
  name: string;
  email: string;
  preferredCountries: string[];
  budgetRange: { min: number; max: number };
  investmentStrategy: "cashflow" | "appreciation" | "balanced";
  riskProfile: "conservative" | "moderate" | "aggressive";
  preferredPropertyTypes: string[];
  rentalPreference: "short-term" | "long-term" | "mixed";
  calculatorUsageCount: number;
  reportsGenerated: number;
  propertiesSaved: string[];
  leadScore: "HIGH" | "MEDIUM" | "LOW";
  createdAt: string;
  lastActivity: string;
}

export interface LeadCaptureData {
  name: string;
  email: string;
  phone?: string;
  source: string;
  intent: "high" | "medium" | "low";
  calculatorType: string;
  city?: string;
  budget?: number;
  investmentGoal?: string;
}

export interface MarketData {
  city: string;
  country: string;
  currency: string;
  avgPricePerSqm: number;
  avgMonthlyRent: number;
  grossYield: number;
  netYield: number;
  annualAppreciation: number;
  vacancyRate: number;
  priceToRentRatio: number;
  districts: DistrictData[];
}

export interface DistrictData {
  name: string;
  avgPricePerSqm: number;
  avgMonthlyRent: number;
  grossYield: number;
  appreciation: number;
  walkabilityScore: number;
  investmentGrade: string;
}

export interface CityComparisonData {
  city: string;
  country: string;
  currency: string;
  grossYield: number;
  netYield: number;
  appreciation: number;
  totalReturn: number;
  riskLevel: string;
  liquidityScore: number;
  investorFriendly: boolean;
  taxRate: number;
  residencyByInvestment: boolean;
}

export type InvestmentCalculationEvent = {
  type: "InvestmentCalculationCreated";
  payload: {
    input: PropertyROIInput;
    output: PropertyROIOutput;
    sessionId: string;
    timestamp: string;
  };
};

export type InvestmentReportEvent = {
  type: "InvestmentReportGenerated";
  payload: {
    reportId: string;
    city: string;
    investmentScore: number;
    leadEmail?: string;
    timestamp: string;
  };
};

export type PropertyComparisonEvent = {
  type: "PropertyComparisonCreated";
  payload: {
    comparisonId: string;
    propertyCount: number;
    sessionId: string;
    timestamp: string;
  };
};

export type InvestorProfileEvent = {
  type: "InvestorProfileCreated";
  payload: {
    profileId: string;
    leadScore: string;
    timestamp: string;
  };
};

export type LeadQualifiedEvent = {
  type: "LeadQualified";
  payload: {
    email: string;
    score: "HIGH" | "MEDIUM" | "LOW";
    source: string;
    timestamp: string;
  };
};

export type RentalOpportunityEvent = {
  type: "RentalOpportunityCreated";
  payload: {
    propertyId: string;
    city: string;
    expectedYield: number;
    timestamp: string;
  };
};
