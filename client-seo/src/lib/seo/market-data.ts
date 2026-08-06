import type { MarketData, CityComparisonData, DistrictData } from "@/types/investment-intelligence";

export const MARKET_DATA: Record<string, MarketData> = {
  dubai: {
    city: "Dubai",
    country: "UAE",
    currency: "AED",
    avgPricePerSqm: 15800,
    avgMonthlyRent: 95000,
    grossYield: 7.2,
    netYield: 5.8,
    annualAppreciation: 8.5,
    vacancyRate: 8,
    priceToRentRatio: 16.2,
    districts: [
      { name: "Dubai Marina", avgPricePerSqm: 18500, avgMonthlyRent: 120000, grossYield: 7.8, appreciation: 9.2, walkabilityScore: 88, investmentGrade: "A" },
      { name: "Business Bay", avgPricePerSqm: 16200, avgMonthlyRent: 105000, grossYield: 7.5, appreciation: 10.1, walkabilityScore: 82, investmentGrade: "A" },
      { name: "Downtown Dubai", avgPricePerSqm: 22000, avgMonthlyRent: 150000, grossYield: 6.8, appreciation: 7.5, walkabilityScore: 90, investmentGrade: "A-" },
      { name: "JVC", avgPricePerSqm: 10500, avgMonthlyRent: 62000, grossYield: 8.2, appreciation: 12.5, walkabilityScore: 65, investmentGrade: "B+" },
      { name: "Palm Jumeirah", avgPricePerSqm: 32000, avgMonthlyRent: 200000, grossYield: 5.5, appreciation: 6.8, walkabilityScore: 72, investmentGrade: "B+" },
      { name: "Dubai Hills", avgPricePerSqm: 14800, avgMonthlyRent: 88000, grossYield: 7.1, appreciation: 11.3, walkabilityScore: 70, investmentGrade: "A-" },
      { name: "DIFC", avgPricePerSqm: 25000, avgMonthlyRent: 165000, grossYield: 6.2, appreciation: 5.8, walkabilityScore: 85, investmentGrade: "B+" },
      { name: "Al Barsha", avgPricePerSqm: 12000, avgMonthlyRent: 75000, grossYield: 7.5, appreciation: 7.2, walkabilityScore: 75, investmentGrade: "B+" },
      { name: "JLT", avgPricePerSqm: 13500, avgMonthlyRent: 82000, grossYield: 7.3, appreciation: 8.8, walkabilityScore: 80, investmentGrade: "A-" },
      { name: "Motor City", avgPricePerSqm: 11000, avgMonthlyRent: 65000, grossYield: 7.1, appreciation: 9.5, walkabilityScore: 60, investmentGrade: "B+" },
    ],
  },
  istanbul: {
    city: "Istanbul",
    country: "Turkey",
    currency: "TRY",
    avgPricePerSqm: 45000,
    avgMonthlyRent: 18000,
    grossYield: 6.5,
    netYield: 5.2,
    annualAppreciation: 35.0,
    vacancyRate: 6,
    priceToRentRatio: 18.5,
    districts: [
      { name: "Beyoglu", avgPricePerSqm: 52000, avgMonthlyRent: 22000, grossYield: 7.2, appreciation: 38.0, walkabilityScore: 92, investmentGrade: "A" },
      { name: "Kadikoy", avgPricePerSqm: 48000, avgMonthlyRent: 20000, grossYield: 6.8, appreciation: 32.0, walkabilityScore: 90, investmentGrade: "A-" },
      { name: "Besiktas", avgPricePerSqm: 55000, avgMonthlyRent: 24000, grossYield: 6.5, appreciation: 30.0, walkabilityScore: 88, investmentGrade: "B+" },
      { name: "Sisli", avgPricePerSqm: 60000, avgMonthlyRent: 26000, grossYield: 6.2, appreciation: 28.0, walkabilityScore: 85, investmentGrade: "B+" },
      { name: "Fatih", avgPricePerSqm: 38000, avgMonthlyRent: 16000, grossYield: 7.0, appreciation: 40.0, walkabilityScore: 82, investmentGrade: "A-" },
      { name: "Uskudar", avgPricePerSqm: 42000, avgMonthlyRent: 18000, grossYield: 6.9, appreciation: 35.0, walkabilityScore: 86, investmentGrade: "A-" },
    ],
  },
  london: {
    city: "London",
    country: "UK",
    currency: "GBP",
    avgPricePerSqm: 12500,
    avgMonthlyRent: 2200,
    grossYield: 4.8,
    netYield: 3.5,
    annualAppreciation: 5.2,
    vacancyRate: 5,
    priceToRentRatio: 25.0,
    districts: [
      { name: "Zone 1 Central", avgPricePerSqm: 18000, avgMonthlyRent: 3200, grossYield: 3.8, appreciation: 4.5, walkabilityScore: 98, investmentGrade: "B+" },
      { name: "Canary Wharf", avgPricePerSqm: 14000, avgMonthlyRent: 2500, grossYield: 4.5, appreciation: 5.8, walkabilityScore: 90, investmentGrade: "B+" },
      { name: "Shoreditch", avgPricePerSqm: 13000, avgMonthlyRent: 2400, grossYield: 5.0, appreciation: 6.2, walkabilityScore: 92, investmentGrade: "A-" },
      { name: "Greenwich", avgPricePerSqm: 9500, avgMonthlyRent: 1800, grossYield: 5.5, appreciation: 7.0, walkabilityScore: 78, investmentGrade: "A-" },
      { name: "Clapham", avgPricePerSqm: 10500, avgMonthlyRent: 2000, grossYield: 5.2, appreciation: 6.5, walkabilityScore: 85, investmentGrade: "B+" },
    ],
  },
  miami: {
    city: "Miami",
    country: "USA",
    currency: "USD",
    avgPricePerSqm: 5800,
    avgMonthlyRent: 2800,
    grossYield: 5.8,
    netYield: 4.2,
    annualAppreciation: 8.0,
    vacancyRate: 10,
    priceToRentRatio: 21.0,
    districts: [
      { name: "Brickell", avgPricePerSqm: 7200, avgMonthlyRent: 3500, grossYield: 5.5, appreciation: 7.5, walkabilityScore: 90, investmentGrade: "B+" },
      { name: "Wynwood", avgPricePerSqm: 6500, avgMonthlyRent: 3200, grossYield: 6.0, appreciation: 9.0, walkabilityScore: 82, investmentGrade: "A-" },
      { name: "South Beach", avgPricePerSqm: 8500, avgMonthlyRent: 4000, grossYield: 5.2, appreciation: 6.0, walkabilityScore: 88, investmentGrade: "B+" },
      { name: "Downtown Miami", avgPricePerSqm: 6000, avgMonthlyRent: 2900, grossYield: 5.8, appreciation: 8.5, walkabilityScore: 85, investmentGrade: "B+" },
      { name: "Coconut Grove", avgPricePerSqm: 7000, avgMonthlyRent: 3300, grossYield: 5.6, appreciation: 7.2, walkabilityScore: 78, investmentGrade: "B+" },
    ],
  },
  paris: {
    city: "Paris",
    country: "France",
    currency: "EUR",
    avgPricePerSqm: 10800,
    avgMonthlyRent: 1800,
    grossYield: 3.8,
    netYield: 2.8,
    annualAppreciation: 4.5,
    vacancyRate: 4,
    priceToRentRatio: 28.0,
    districts: [
      { name: "Le Marais (3e/4e)", avgPricePerSqm: 13500, avgMonthlyRent: 2300, grossYield: 3.5, appreciation: 4.0, walkabilityScore: 96, investmentGrade: "B" },
      { name: "Bastille (11e)", avgPricePerSqm: 11000, avgMonthlyRent: 1900, grossYield: 4.0, appreciation: 5.0, walkabilityScore: 92, investmentGrade: "B+" },
      { name: "Montmartre (18e)", avgPricePerSqm: 9800, avgMonthlyRent: 1700, grossYield: 4.2, appreciation: 4.8, walkabilityScore: 88, investmentGrade: "B+" },
      { name: "Belleville (19e/20e)", avgPricePerSqm: 8200, avgMonthlyRent: 1500, grossYield: 4.5, appreciation: 5.5, walkabilityScore: 82, investmentGrade: "A-" },
    ],
  },
};

export const CITY_COMPARISONS: CityComparisonData[] = [
  { city: "Dubai", country: "UAE", currency: "AED", grossYield: 7.2, netYield: 5.8, appreciation: 8.5, totalReturn: 15.7, riskLevel: "MEDIUM", liquidityScore: 82, investorFriendly: true, taxRate: 0, residencyByInvestment: true },
  { city: "Istanbul", country: "Turkey", currency: "TRY", grossYield: 6.5, netYield: 5.2, appreciation: 35.0, totalReturn: 40.2, riskLevel: "HIGH", liquidityScore: 65, investorFriendly: true, taxRate: 15, residencyByInvestment: true },
  { city: "London", country: "UK", currency: "GBP", grossYield: 4.8, netYield: 3.5, appreciation: 5.2, totalReturn: 8.7, riskLevel: "LOW", liquidityScore: 90, investorFriendly: true, taxRate: 20, residencyByInvestment: false },
  { city: "Miami", country: "USA", currency: "USD", grossYield: 5.8, netYield: 4.2, appreciation: 8.0, totalReturn: 12.2, riskLevel: "MEDIUM", liquidityScore: 78, investorFriendly: true, taxRate: 25, residencyByInvestment: false },
  { city: "Paris", country: "France", currency: "EUR", grossYield: 3.8, netYield: 2.8, appreciation: 4.5, totalReturn: 7.3, riskLevel: "LOW", liquidityScore: 85, investorFriendly: true, taxRate: 20, residencyByInvestment: false },
  { city: "Lisbon", country: "Portugal", currency: "EUR", grossYield: 5.0, netYield: 3.8, appreciation: 7.0, totalReturn: 10.8, riskLevel: "LOW", liquidityScore: 72, investorFriendly: true, taxRate: 28, residencyByInvestment: true },
  { city: "Bangkok", country: "Thailand", currency: "THB", grossYield: 6.0, netYield: 4.5, appreciation: 5.5, totalReturn: 10.0, riskLevel: "MEDIUM", liquidityScore: 60, investorFriendly: true, taxRate: 15, residencyByInvestment: false },
  { city: "Barcelona", country: "Spain", currency: "EUR", grossYield: 4.5, netYield: 3.2, appreciation: 6.0, totalReturn: 9.2, riskLevel: "LOW", liquidityScore: 75, investorFriendly: true, taxRate: 24, residencyByInvestment: true },
];

export const SEO_LANDING_CONFIGS: Array<{
  slug: string;
  city: string;
  title: string;
  description: string;
  keywords: string[];
  h1: string;
  calculatorType: "roi" | "yield" | "comparison";
  faq: Array<{ question: string; answer: string }>;
}> = [
  {
    slug: "dubai-rental-yield-calculator",
    city: "dubai",
    title: "Dubai Rental Yield Calculator 2026 | Free Investment Analysis",
    description: "Calculate Dubai property rental yields instantly. Free ROI calculator with real market data for Dubai Marina, Business Bay, JVC and more.",
    keywords: ["dubai rental yield calculator", "dubai property yield", "dubai investment calculator", "rental yield dubai 2026"],
    h1: "Dubai Rental Yield Calculator",
    calculatorType: "yield",
    faq: [
      { question: "What is a good rental yield in Dubai?", answer: "A good rental yield in Dubai ranges from 6% to 8% gross. Areas like JVC and Dubai Hills offer higher yields around 7-8%, while premium areas like Downtown offer 5-7%." },
      { question: "How is rental yield calculated in Dubai?", answer: "Rental yield = (Annual Rental Income / Property Price) x 100. For example, a property bought for AED 1M renting at AED 80,000/year has an 8% gross yield." },
      { question: "Is Dubai property a good investment in 2026?", answer: "Dubai offers 0% income tax, high rental yields (6-8%), and strong capital appreciation (8-12% annually). The market is regulated by RERA and attracts global investors." },
    ],
  },
  {
    slug: "dubai-property-roi-calculator",
    city: "dubai",
    title: "Dubai Property ROI Calculator | Investment Returns Analysis",
    description: "Calculate your Dubai property investment ROI. Includes mortgage, vacancy, service charges and 10-year projections.",
    keywords: ["dubai property roi", "dubai investment roi", "property investment calculator dubai", "dubai real estate returns"],
    h1: "Dubai Property ROI Calculator",
    calculatorType: "roi",
    faq: [
      { question: "What ROI can I expect from Dubai property?", answer: "Dubai property typically delivers 8-15% total annual return combining rental income (5-8%) and capital appreciation (5-12%)." },
      { question: "How much do I need to invest in Dubai property?", answer: "Dubai property starts from AED 500,000 (~$136,000). A 20% down payment is required for non-residents, making entry possible from AED 100,000 (~$27,000)." },
    ],
  },
  {
    slug: "damac-investment-calculator",
    city: "dubai",
    title: "DAMAC Investment Calculator | ROI Analysis for DAMAC Properties",
    description: "Analyze DAMAC property investments with our free calculator. Compare DAMAC towers, villas and serviced apartments ROI.",
    keywords: ["damac investment calculator", "damac property roi", "damac towers investment", "damac hills roi"],
    h1: "DAMAC Property Investment Calculator",
    calculatorType: "roi",
    faq: [
      { question: "Are DAMAC properties a good investment?", answer: "DAMAC properties in prime Dubai locations offer competitive yields of 6-8%. Areas like DAMAC Hills and DAMAC Towers show strong appreciation potential." },
      { question: "What is the ROI for DAMAC serviced apartments?", answer: "DAMAC serviced apartments typically offer 7-9% guaranteed rental returns with hotel-managed operations." },
    ],
  },
  {
    slug: "dubai-marina-roi-analysis",
    city: "dubai",
    title: "Dubai Marina ROI Analysis 2026 | Investment Intelligence",
    description: "Complete ROI analysis for Dubai Marina properties. Rental yields, appreciation trends, and investment scores.",
    keywords: ["dubai marina roi", "dubai marina investment", "dubai marina rental yield", "dubai marina property analysis"],
    h1: "Dubai Marina Investment Analysis",
    calculatorType: "roi",
    faq: [
      { question: "What is the average rent in Dubai Marina?", answer: "Average rents in Dubai Marina range from AED 75,000 for studios to AED 180,000 for 3-bedroom apartments, depending on the tower and view." },
      { question: "Is Dubai Marina good for investment?", answer: "Dubai Marina is one of the most liquid investment areas in Dubai with 7-8% yields, high occupancy rates, and strong capital appreciation." },
    ],
  },
  {
    slug: "business-bay-property-investment",
    city: "dubai",
    title: "Business Bay Property Investment Guide | ROI Calculator",
    description: "Investment analysis for Business Bay Dubai. Free ROI calculator, rental yields, and market insights.",
    keywords: ["business bay investment", "business bay property roi", "business bay dubai investment"],
    h1: "Business Bay Property Investment Analysis",
    calculatorType: "roi",
    faq: [
      { question: "Why invest in Business Bay?", answer: "Business Bay offers 7-8% rental yields, central Dubai location, and 10%+ annual appreciation. It's becoming Dubai's business hub with major corporate tenants." },
    ],
  },
  {
    slug: "istanbul-property-roi-calculator",
    city: "istanbul",
    title: "Istanbul Property ROI Calculator | Turkish Real Estate Investment",
    description: "Calculate Istanbul property investment returns. Turkish citizenship by investment analysis with real market data.",
    keywords: ["istanbul property roi", "turkish property investment", "istanbul rental yield", "turkey citizenship by investment"],
    h1: "Istanbul Property Investment Calculator",
    calculatorType: "roi",
    faq: [
      { question: "Can I get Turkish citizenship by buying property?", answer: "Yes, Turkey offers citizenship for property purchases of $400,000+ (held for 3 years). This makes Istanbul property a dual-purpose investment." },
      { question: "What rental yield can I expect in Istanbul?", answer: "Istanbul offers 5-7% gross rental yields. Combined with 30%+ annual price appreciation (TRY-denominated), total returns can exceed 40%." },
    ],
  },
  {
    slug: "property-investment-calculator",
    city: "dubai",
    title: "Property Investment Calculator | Free ROI & Yield Analysis",
    description: "Universal property investment calculator. Calculate ROI, rental yield, cash flow, and mortgage analysis for any property worldwide.",
    keywords: ["property investment calculator", "real estate roi calculator", "property yield calculator", "investment property calculator"],
    h1: "Property Investment Calculator",
    calculatorType: "roi",
    faq: [
      { question: "How do I calculate property investment ROI?", answer: "ROI = (Net Annual Income + Appreciation) / Total Investment x 100. Factor in mortgage payments, vacancy rates, maintenance, and service charges." },
      { question: "What is a good rental yield?", answer: "A good rental yield depends on location. Generally, 5-8% gross is strong. Below 4% may indicate overpriced markets; above 10% may signal high risk." },
    ],
  },
  {
    slug: "rental-income-calculator",
    city: "dubai",
    title: "Rental Income Calculator | Property Rental Analysis Tool",
    description: "Calculate your potential rental income from any property. Includes vacancy adjustments, tax considerations, and net income projections.",
    keywords: ["rental income calculator", "rental income property", "calculate rental income", "property rental analysis"],
    h1: "Rental Income Calculator",
    calculatorType: "yield",
    faq: [
      { question: "How do I calculate net rental income?", answer: "Net Rental Income = Gross Annual Rent - Vacancy Losses - Maintenance - Service Charges - Mortgage Payments - Management Fees." },
    ],
  },
  {
    slug: "real-estate-cash-flow-calculator",
    city: "dubai",
    title: "Real Estate Cash Flow Calculator | Property Cash Flow Analysis",
    description: "Analyze real estate cash flow with our free calculator. Mortgage vs cash purchase comparison, 10-year projections included.",
    keywords: ["real estate cash flow calculator", "property cash flow", "cash flow analysis", "real estate cash flow analysis"],
    h1: "Real Estate Cash Flow Calculator",
    calculatorType: "roi",
    faq: [
      { question: "What is positive cash flow in real estate?", answer: "Positive cash flow means rental income exceeds all expenses (mortgage, maintenance, vacancy). A property generating AED 80,000 rent with AED 60,000 expenses has AED 20,000 positive cash flow." },
    ],
  },
  {
    slug: "dubai-vs-istanbul-investment-comparison",
    city: "dubai",
    title: "Dubai vs Istanbul Property Investment | Side-by-Side Comparison",
    description: "Compare Dubai and Istanbul property investments. Yields, appreciation, risk, and residency options analyzed.",
    keywords: ["dubai vs istanbul investment", "dubai or istanbul property", "which city to invest", "property investment comparison"],
    h1: "Dubai vs Istanbul Investment Comparison",
    calculatorType: "comparison",
    faq: [
      { question: "Dubai or Istanbul: which is better for investment?", answer: "Dubai offers stable currency, 0% income tax, and 7-8% yields. Istanbul offers higher total returns (30%+) but with currency risk. Choose Dubai for stability, Istanbul for high growth." },
    ],
  },
  {
    slug: "mortgage-vs-cash-purchase-calculator",
    city: "dubai",
    title: "Mortgage vs Cash Purchase Calculator | Investment Comparison",
    description: "Should you buy property with cash or mortgage? Compare returns, leverage effects, and opportunity costs.",
    keywords: ["mortgage vs cash purchase", "cash or mortgage property", "leverage real estate", "property financing calculator"],
    h1: "Mortgage vs Cash Purchase Calculator",
    calculatorType: "roi",
    faq: [
      { question: "Is it better to buy property with cash or mortgage?", answer: "Cash purchases offer higher ROI per dollar invested. Mortgages allow leverage to control more property. In low-rate environments, mortgages often produce better cash-on-cash returns." },
    ],
  },
  {
    slug: "property-appreciation-calculator",
    city: "dubai",
    title: "Property Appreciation Calculator | Real Estate Growth Forecast",
    description: "Calculate property appreciation and future value. Historical trends, market forecasts, and growth projections.",
    keywords: ["property appreciation calculator", "real estate appreciation", "property value forecast", "property growth calculator"],
    h1: "Property Appreciation Calculator",
    calculatorType: "roi",
    faq: [
      { question: "How much does property appreciate per year?", answer: "Average property appreciation varies by market. Dubai: 7-12%, London: 4-6%, Istanbul: 20-40% (TRY), Miami: 6-10% annually. Location and market cycle matter significantly." },
    ],
  },
];

export function getCityData(citySlug: string): MarketData | undefined {
  return ALL_MARKET_DATA[citySlug.toLowerCase()];
}

export function getCityComparison(city1: string, city2: string): CityComparisonData[] {
  return CITY_COMPARISONS.filter(
    (c) => c.city.toLowerCase() === city1.toLowerCase() || c.city.toLowerCase() === city2.toLowerCase()
  );
}

export function getDistricts(citySlug: string): DistrictData[] {
  return ALL_MARKET_DATA[citySlug.toLowerCase()]?.districts || [];
}

export function formatCurrency(amount: number, currency: string): string {
  const formatter = new Intl.NumberFormat("en-US", {
    style: "currency",
    currency,
    maximumFractionDigits: 0,
  });
  return formatter.format(amount);
}

export function generateId(): string {
  return `ii-${Date.now()}-${Math.random().toString(36).slice(2, 10)}`;
}

// Additional city data for global coverage
export const ADDITIONAL_CITY_DATA: Record<string, MarketData> = {
  lisbon: {
    city: "Lisbon",
    country: "Portugal",
    currency: "EUR",
    avgPricePerSqm: 5200,
    avgMonthlyRent: 1400,
    grossYield: 5.0,
    netYield: 3.8,
    annualAppreciation: 7.0,
    vacancyRate: 7,
    priceToRentRatio: 22.0,
    districts: [
      { name: "Alfama", avgPricePerSqm: 6500, avgMonthlyRent: 1800, grossYield: 5.2, appreciation: 6.5, walkabilityScore: 95, investmentGrade: "B+" },
      { name: "Bairro Alto", avgPricePerSqm: 5800, avgMonthlyRent: 1600, grossYield: 5.0, appreciation: 7.0, walkabilityScore: 92, investmentGrade: "B+" },
      { name: "Principe Real", avgPricePerSqm: 7200, avgMonthlyRent: 2000, grossYield: 4.8, appreciation: 6.0, walkabilityScore: 90, investmentGrade: "B" },
      { name: "Belem", avgPricePerSqm: 4200, avgMonthlyRent: 1200, grossYield: 5.5, appreciation: 8.0, walkabilityScore: 80, investmentGrade: "A-" },
    ],
  },
  bangkok: {
    city: "Bangkok",
    country: "Thailand",
    currency: "THB",
    avgPricePerSqm: 120000,
    avgMonthlyRent: 25000,
    grossYield: 6.0,
    netYield: 4.5,
    annualAppreciation: 5.5,
    vacancyRate: 10,
    priceToRentRatio: 20.0,
    districts: [
      { name: "Sukhumvit", avgPricePerSqm: 150000, avgMonthlyRent: 32000, grossYield: 5.8, appreciation: 5.0, walkabilityScore: 88, investmentGrade: "B+" },
      { name: "Silom", avgPricePerSqm: 140000, avgMonthlyRent: 28000, grossYield: 5.5, appreciation: 4.5, walkabilityScore: 85, investmentGrade: "B" },
      { name: "Ari", avgPricePerSqm: 110000, avgMonthlyRent: 25000, grossYield: 6.5, appreciation: 6.5, walkabilityScore: 80, investmentGrade: "A-" },
      { name: "Thonglor", avgPricePerSqm: 130000, avgMonthlyRent: 30000, grossYield: 6.2, appreciation: 5.5, walkabilityScore: 82, investmentGrade: "B+" },
    ],
  },
  barcelona: {
    city: "Barcelona",
    country: "Spain",
    currency: "EUR",
    avgPricePerSqm: 5500,
    avgMonthlyRent: 1500,
    grossYield: 4.5,
    netYield: 3.2,
    annualAppreciation: 6.0,
    vacancyRate: 6,
    priceToRentRatio: 25.0,
    districts: [
      { name: "Eixample", avgPricePerSqm: 6800, avgMonthlyRent: 1800, grossYield: 4.2, appreciation: 5.5, walkabilityScore: 92, investmentGrade: "B" },
      { name: "Gothic Quarter", avgPricePerSqm: 6200, avgMonthlyRent: 1700, grossYield: 4.5, appreciation: 5.0, walkabilityScore: 95, investmentGrade: "B+" },
      { name: "Gracia", avgPricePerSqm: 5500, avgMonthlyRent: 1500, grossYield: 4.8, appreciation: 6.5, walkabilityScore: 88, investmentGrade: "B+" },
      { name: "Poblenou", avgPricePerSqm: 4200, avgMonthlyRent: 1300, grossYield: 5.5, appreciation: 7.5, walkabilityScore: 82, investmentGrade: "A-" },
    ],
  },
};

export const ADDITIONAL_SEO_CONFIGS: Array<{
  slug: string;
  city: string;
  title: string;
  description: string;
  keywords: string[];
  h1: string;
  calculatorType: "roi" | "yield" | "comparison";
  faq: Array<{ question: string; answer: string }>;
}> = [
  {
    slug: "lisbon-property-investment-calculator",
    city: "lisbon",
    title: "Lisbon Property Investment Calculator | ROI Analysis 2026",
    description: "Calculate Lisbon property investment returns. Golden visa eligible areas, rental yields, and appreciation forecasts.",
    keywords: ["lisbon property investment", "lisbon roi calculator", "portugal investment property", "golden visa property"],
    h1: "Lisbon Property Investment Calculator",
    calculatorType: "roi",
    faq: [
      { question: "Can I get a golden visa by investing in Lisbon?", answer: "Portugal ended the Lisbon Golden Visa for residential property in 2023. However, you can still invest in commercial property or funds for residency." },
      { question: "What yield can I expect in Lisbon?", answer: "Lisbon offers 4-5.5% gross yields. Prime areas like Alfama and Belem offer higher yields with strong tourism demand." },
    ],
  },
  {
    slug: "bangkok-property-investment-calculator",
    city: "bangkok",
    title: "Bangkok Property Investment Calculator | Thai Real Estate ROI",
    description: "Calculate Bangkok property investment returns. Free ROI calculator with Sukhumvit, Silom, and Ari district data.",
    keywords: ["bangkok property investment", "thailand real estate roi", "bangkok rental yield", "sukhumvit investment"],
    h1: "Bangkok Property Investment Calculator",
    calculatorType: "roi",
    faq: [
      { question: "Can foreigners buy property in Thailand?", answer: "Foreigners can own condominiums in Thailand (freehold) but cannot own land. Condos must be in buildings where foreign ownership doesn't exceed 49% of total area." },
      { question: "What rental yield can I expect in Bangkok?", answer: "Bangkok offers 5-7% gross rental yields, with Sukhumvit and Ari being the most popular areas for rental investment." },
    ],
  },
  {
    slug: "barcelona-property-investment-calculator",
    city: "barcelona",
    title: "Barcelona Property Investment Calculator | Spanish ROI Analysis",
    description: "Calculate Barcelona property investment returns. Eixample, Gothic Quarter, and Gracia district analysis.",
    keywords: ["barcelona property investment", "spain real estate roi", "barcelona rental yield", "eixample investment"],
    h1: "Barcelona Property Investment Calculator",
    calculatorType: "roi",
    faq: [
      { question: "Is Barcelona good for property investment?", answer: "Barcelona offers 4-5.5% yields with strong tourism demand. Areas like Poblenou offer higher yields with emerging tech hub growth." },
      { question: "What are the restrictions on short-term rentals in Barcelona?", answer: "Barcelona has strict regulations on short-term rentals. New tourist apartment licenses are frozen in many areas. Check current regulations before investing." },
    ],
  },
  {
    slug: "dubai-vs-london-investment-comparison",
    city: "dubai",
    title: "Dubai vs London Property Investment | 2026 Comparison",
    description: "Compare Dubai and London property investments side by side. Yields, taxes, appreciation, and residency options.",
    keywords: ["dubai vs london investment", "dubai or london property", "property investment comparison uk uae"],
    h1: "Dubai vs London Investment Comparison",
    calculatorType: "comparison",
    faq: [
      { question: "Dubai or London: which has better rental yield?", answer: "Dubai offers 6-8% yields with 0% income tax. London offers 3-5% yields with higher tax burden. Dubai wins on net returns." },
      { question: "Which market is safer for investment?", answer: "London has deeper liquidity and regulatory maturity. Dubai offers higher returns with AED-USD peg stability. Both are considered safe havens." },
    ],
  },
  {
    slug: "dubai-vs-miami-investment-comparison",
    city: "dubai",
    title: "Dubai vs Miami Property Investment | Side-by-Side Analysis",
    description: "Compare Dubai and Miami property investments. Yields, appreciation, tax, and lifestyle factors analyzed.",
    keywords: ["dubai vs miami investment", "dubai or miami property", "real estate investment comparison"],
    h1: "Dubai vs Miami Investment Comparison",
    calculatorType: "comparison",
    faq: [
      { question: "Dubai or Miami: which is better for investment?", answer: "Dubai offers higher yields (7% vs 5.5%), 0% income tax, and residency by investment. Miami offers US exposure, easier financing, and lifestyle appeal. Choose based on your goals." },
    ],
  },
];

// Merge additional cities into MARKET_DATA
export const ALL_MARKET_DATA: Record<string, MarketData> = {
  ...MARKET_DATA,
  ...ADDITIONAL_CITY_DATA,
};

// Merge additional SEO configs
export const ALL_SEO_LANDING_CONFIGS = [...SEO_LANDING_CONFIGS, ...ADDITIONAL_SEO_CONFIGS];

// ─── Category Enrichment Integration ─────────────────────────────────────────

import {
  enrichCategory,
  enrichAll,
  getEnrichmentStats,
  getCategoryKeywords,
  getRotatingTitle,
  type PropertyCategory,
  type SupportedLocale,
} from "./category-enricher";

export {
  enrichCategory,
  enrichAll,
  getEnrichmentStats,
  getCategoryKeywords,
  getRotatingTitle,
  type PropertyCategory,
  type SupportedLocale,
};

/**
 * Mevcut SEO landing config'ini category enricher ile zenginleştir.
 * Mevcut keywords[] listesine category-enricher'dan gelen
 * long-tail keyword'leri ekler (deduplicated).
 *
 * @example
 * const enriched = getEnrichedLandingConfig("dubai-rental-yield-calculator");
 * // enriched.keywords artık 4 değil, 40+ keyword içeriyor
 */
export function getEnrichedLandingConfig(
  slug: string,
  locale: SupportedLocale = "tr"
): (typeof ALL_SEO_LANDING_CONFIGS)[0] & { enrichedKeywords: string[] } | undefined {
  const config = ALL_SEO_LANDING_CONFIGS.find((c) => c.slug === slug);
  if (!config) return undefined;

  // Şehre göre en uygun category'yi belirle
  const categoryMap: Record<string, PropertyCategory> = {
    "rental-yield": "INVESTMENT",
    "roi": "INVESTMENT",
    "sale": "SALE_APARTMENT",
    "rent": "RENT_APARTMENT",
    "luxury": "LUXURY",
    "citizenship": "CITIZENSHIP",
    "comparison": "INVESTMENT",
    "short-term": "SHORT_TERM",
  };

  let matchedCategory: PropertyCategory = "INVESTMENT";
  for (const [key, cat] of Object.entries(categoryMap)) {
    if (slug.includes(key)) {
      matchedCategory = cat;
      break;
    }
  }

  let enrichedKeywords: string[] = [...config.keywords];
  try {
    const extraKeywords = getCategoryKeywords(matchedCategory, config.city, locale);
    enrichedKeywords = [...new Set([...config.keywords, ...extraKeywords])];
  } catch {
    // city not in enricher catalogue — use original
  }

  return { ...config, enrichedKeywords };
}

/**
 * Tüm şehir × kategori kombinasyonları için otomatik SEO landing page
 * konfigürasyonu üret. Sitemap.ts ve otomatik route oluşturma için.
 *
 * Bu fonksiyon çağrıldığında:
 * - 6 şehir × 12 kategori = 72 sayfa
 * - Her sayfa 30+ keyword varyasyonu
 * - Her sayfa 3-7 FAQ sorusu
 */
export function generateAutoSEOConfigs(
  cities = ["istanbul", "dubai", "london", "barcelona", "lisbon", "miami"],
  locale: SupportedLocale = "tr"
) {
  const CATEGORY_TO_SLUG: Record<PropertyCategory, string> = {
    SALE_APARTMENT: "satilik-daire",
    RENT_APARTMENT: "kiralik-daire",
    SALE_VILLA: "satilik-villa",
    RENT_VILLA: "kiralik-villa",
    INVESTMENT: "yatirim-analizi",
    STUDENT_HOUSING: "ogrenci-evi",
    LUXURY: "lux-konut",
    SHORT_TERM: "kisa-donem-kiralama",
    CITIZENSHIP: "vatandaslik-yatirimi",
    COMMERCIAL: "ticari-gayrimenkul",
    NEW_DEVELOPMENT: "yeni-proje",
    DEPOSIT_FREE: "sifir-depozito",
  };

  const configs: Array<{
    slug: string;
    city: string;
    title: string;
    description: string;
    keywords: string[];
    h1: string;
    faq: Array<{ question: string; answer: string }>;
    anchorTexts: string[];
    estimatedMonthlySearches: number;
    competition: string;
    calculatorType: "roi" | "yield" | "comparison";
  }> = [];

  for (const city of cities) {
    const enrichedAll = enrichAll(
      Object.keys(CATEGORY_TO_SLUG) as PropertyCategory[],
      [city],
      locale
    );

    for (const enriched of enrichedAll) {
      const slug = `${city}-${CATEGORY_TO_SLUG[enriched.category]}`;
      const calcType = ["INVESTMENT", "CITIZENSHIP"].includes(enriched.category)
        ? "roi"
        : enriched.category.includes("RENT")
        ? "yield"
        : "roi";

      configs.push({
        slug,
        city,
        title: enriched.titles[0],
        description: enriched.descriptions[0],
        keywords: enriched.keywords,
        h1: enriched.titles[Math.min(1, enriched.titles.length - 1)],
        faq: enriched.faqs,
        anchorTexts: enriched.anchorTexts,
        estimatedMonthlySearches: enriched.estimatedMonthlySearches,
        competition: enriched.competition,
        calculatorType: calcType as "roi" | "yield" | "comparison",
      });
    }
  }

  return configs;
}

/**
 * Keyword zenginleştirme potansiyelini ve tahmini gelir etkisini hesapla.
 * Dashboard veya admin paneli için.
 */
export function getKeywordEnrichmentStats() {
  return getEnrichmentStats();
}
