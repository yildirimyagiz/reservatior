import { create } from "zustand";
import { devtools, persist } from "zustand/middleware";
import type {
  PropertyROIInput,
  PropertyROIOutput,
  RentalYieldInput,
  RentalYieldOutput,
  InvestmentReport,
  PropertyComparisonItem,
  InvestorProfile,
  LeadCaptureData,
} from "@/types/investment-intelligence";
import { calculateROI, calculateRentalYield, compareProperties } from "@/lib/investment-engine";
import { investmentIntelligenceApi } from "@/lib/api/investment-intelligence";
import { generateId } from "@/lib/seo/market-data";

interface InvestmentIntelligenceState {
  roiInput: PropertyROIInput;
  roiOutput: PropertyROIOutput | null;
  yieldInput: RentalYieldInput;
  yieldOutput: RentalYieldOutput | null;
  report: InvestmentReport | null;
  comparisonItems: PropertyComparisonItem[];
  investorProfile: InvestorProfile | null;
  isCalculating: boolean;
  isGeneratingReport: boolean;
  sessionId: string;
  calculatorUsageCount: number;
  recentCalculations: Array<{
    id: string;
    city: string;
    timestamp: string;
    type: "roi" | "yield";
    score: number;
  }>;

  setROIInput: (input: Partial<PropertyROIInput>) => void;
  setYieldInput: (input: Partial<RentalYieldInput>) => void;
  calculatePropertyROI: () => void;
  calculatePropertyYield: () => void;
  generateInvestmentReport: (email?: string) => Promise<void>;
  addToComparison: (item: Omit<PropertyComparisonItem, "id" | "overallScore" | "grossYield" | "netYield" | "roi">) => void;
  removeFromComparison: (id: string) => void;
  clearComparison: () => void;
  setInvestorProfile: (profile: InvestorProfile) => void;
  captureLead: (data: LeadCaptureData) => Promise<void>;
  trackCalculationEvent: (type: string) => void;
  getDefaultInput: (city: string) => PropertyROIInput;
}

const defaultDubaiROIInput: PropertyROIInput = {
  purchasePrice: 1500000,
  downPaymentPercent: 20,
  mortgageAmount: 1200000,
  interestRate: 4.99,
  monthlyRent: 9500,
  annualMaintenance: 5000,
  serviceCharges: 15000,
  vacancyRate: 8,
  appreciationRate: 8,
  holdingPeriodYears: 10,
  currency: "AED",
  city: "dubai",
  propertyType: "apartment",
};

const defaultYieldInput: RentalYieldInput = {
  city: "dubai",
  propertyType: "apartment",
  bedrooms: 2,
  purchasePrice: 1500000,
  monthlyRent: 9500,
  serviceCharges: 15000,
};

const defaultDubaiInputs: Record<string, PropertyROIInput> = {
  dubai: defaultDubaiROIInput,
  istanbul: {
    ...defaultDubaiROIInput,
    purchasePrice: 2000000,
    mortgageAmount: 1600000,
    monthlyRent: 12000,
    currency: "TRY",
    city: "istanbul",
    appreciationRate: 25,
  },
  london: {
    ...defaultDubaiROIInput,
    purchasePrice: 800000,
    mortgageAmount: 640000,
    monthlyRent: 3200,
    currency: "GBP",
    city: "london",
    appreciationRate: 5,
    vacancyRate: 5,
    interestRate: 5.5,
  },
  miami: {
    ...defaultDubaiROIInput,
    purchasePrice: 450000,
    mortgageAmount: 360000,
    monthlyRent: 3500,
    currency: "USD",
    city: "miami",
    appreciationRate: 8,
    vacancyRate: 10,
  },
};

export const useInvestmentIntelligenceStore = create<InvestmentIntelligenceState>()(
  devtools(
    persist(
      (set, get) => ({
        roiInput: defaultDubaiROIInput,
        roiOutput: null,
        yieldInput: defaultYieldInput,
        yieldOutput: null,
        report: null,
        comparisonItems: [],
        investorProfile: null,
        isCalculating: false,
        isGeneratingReport: false,
        sessionId: generateId(),
        calculatorUsageCount: 0,
        recentCalculations: [],

        setROIInput: (input) =>
          set((state) => ({ roiInput: { ...state.roiInput, ...input } })),

        setYieldInput: (input) =>
          set((state) => ({ yieldInput: { ...state.yieldInput, ...input } })),

        calculatePropertyROI: () => {
          const { roiInput } = get();
          set({ isCalculating: true });
          try {
            const output = calculateROI(roiInput);
            set((state) => ({
              roiOutput: output,
              isCalculating: false,
              calculatorUsageCount: state.calculatorUsageCount + 1,
              recentCalculations: [
                {
                  id: generateId(),
                  city: roiInput.city,
                  timestamp: new Date().toISOString(),
                  type: "roi",
                  score: output.totalROI,
                },
                ...state.recentCalculations.slice(0, 19),
              ],
            }));
            investmentIntelligenceApi.trackEvent({
              type: "InvestmentCalculationCreated",
              payload: { input: roiInput, output, sessionId: get().sessionId, timestamp: new Date().toISOString() },
            });
          } catch {
            set({ isCalculating: false });
          }
        },

        calculatePropertyYield: () => {
          const { yieldInput } = get();
          set({ isCalculating: true });
          try {
            const output = calculateRentalYield(yieldInput);
            set((state) => ({
              yieldOutput: output,
              isCalculating: false,
              calculatorUsageCount: state.calculatorUsageCount + 1,
              recentCalculations: [
                {
                  id: generateId(),
                  city: yieldInput.city,
                  timestamp: new Date().toISOString(),
                  type: "yield",
                  score: output.investorScore,
                },
                ...state.recentCalculations.slice(0, 19),
              ],
            }));
          } catch {
            set({ isCalculating: false });
          }
        },

        generateInvestmentReport: async (email?: string) => {
          const { roiInput, roiOutput } = get();
          if (!roiOutput) return;
          set({ isGeneratingReport: true });
          try {
            const report = await investmentIntelligenceApi.generateReport({
              input: roiInput,
              output: roiOutput,
              email,
            });
            set({ report, isGeneratingReport: false });
            if (email) {
              investmentIntelligenceApi.captureLead({
                name: "",
                email,
                source: "investment_report",
                intent: "high",
                calculatorType: "roi",
                city: roiInput.city,
                budget: roiInput.purchasePrice,
              });
            }
            investmentIntelligenceApi.trackEvent({
              type: "InvestmentReportGenerated",
              payload: { reportId: report.id, city: roiInput.city, investmentScore: report.investmentScore, leadEmail: email, timestamp: new Date().toISOString() },
            });
          } catch {
            set({ isGeneratingReport: false });
          }
        },

        addToComparison: (item) => {
          const annualRent = item.monthlyRent * 12;
          const grossYield = (annualRent / item.purchasePrice) * 100;
          const netYield = grossYield * 0.85;
          const roi = grossYield * 1.2;
          const overallScore = Math.round((grossYield * 2 + roi + item.locationScore + item.liquidityScore + item.appreciationPotential) / 6);

          set((state) => ({
            comparisonItems: [
              ...state.comparisonItems,
              {
                ...item,
                id: generateId(),
                grossYield: Math.round(grossYield * 100) / 100,
                netYield: Math.round(netYield * 100) / 100,
                roi: Math.round(roi * 100) / 100,
                overallScore,
              },
            ],
          }));
        },

        removeFromComparison: (id) =>
          set((state) => ({
            comparisonItems: state.comparisonItems.filter((i) => i.id !== id),
          })),

        clearComparison: () => set({ comparisonItems: [] }),

        setInvestorProfile: (profile) => set({ investorProfile: profile }),

        captureLead: async (data) => {
          try {
            await investmentIntelligenceApi.captureLead(data);
          } catch {
            // silent fail for lead capture
          }
        },

        trackCalculationEvent: (type) => {
          investmentIntelligenceApi.trackEvent({
            type,
            payload: { sessionId: get().sessionId, timestamp: new Date().toISOString() },
          });
        },

        getDefaultInput: (city: string) => {
          return defaultDubaiInputs[city.toLowerCase()] || defaultDubaiROIInput;
        },
      }),
      { name: "investment-intelligence-store" }
    ),
    { name: "investment-intelligence" }
  )
);
