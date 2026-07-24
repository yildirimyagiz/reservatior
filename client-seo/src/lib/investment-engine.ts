import type {
  PropertyROIInput,
  PropertyROIOutput,
  YearProjection,
  RentalYieldInput,
  RentalYieldOutput,
  DistrictComparison,
} from "@/types/investment-intelligence";

export function calculateROI(input: PropertyROIInput): PropertyROIOutput {
  const downPayment = input.purchasePrice * (input.downPaymentPercent / 100);
  const mortgageAmount = input.mortgageAmount || (input.purchasePrice - downPayment);
  const monthlyMortgageRate = input.interestRate / 100 / 12;
  const totalMonths = input.holdingPeriodYears * 12;

  const monthlyMortgagePayment =
    mortgageAmount > 0 && monthlyMortgageRate > 0
      ? (mortgageAmount * monthlyMortgageRate * Math.pow(1 + monthlyMortgageRate, totalMonths)) /
        (Math.pow(1 + monthlyMortgageRate, totalMonths) - 1)
      : mortgageAmount / totalMonths;

  const annualMortgagePayment = monthlyMortgagePayment * 12;
  const annualRent = input.monthlyRent * 12;
  const effectiveAnnualRent = annualRent * (1 - input.vacancyRate / 100);
  const annualOperatingCosts = input.annualMaintenance + input.serviceCharges;
  const annualCashFlow = effectiveAnnualRent - annualMortgagePayment - annualOperatingCosts;
  const monthlyCashFlow = annualCashFlow / 12;

  const grossRentalYield = (effectiveAnnualRent / input.purchasePrice) * 100;
  const netOperatingIncome = effectiveAnnualRent - annualOperatingCosts;
  const netRentalYield = (netOperatingIncome / input.purchasePrice) * 100;
  const capRate = (netOperatingIncome / input.purchasePrice) * 100;

  const totalInvestment = downPayment + input.annualMaintenance * input.holdingPeriodYears +
    input.serviceCharges * input.holdingPeriodYears;

  const yearByYear: YearProjection[] = [];
  let cumulativeCashFlow = 0;
  let currentMortgageBalance = mortgageAmount;
  let totalEquity = downPayment;

  for (let year = 1; year <= input.holdingPeriodYears; year++) {
    const propertyValue =
      input.purchasePrice * Math.pow(1 + input.appreciationRate / 100, year);
    const yearRent = annualRent * Math.pow(1 + 0.03, year - 1);
    const effectiveRent = yearRent * (1 - input.vacancyRate / 100);
    const yearMortgage = annualMortgagePayment;
    const yearNetIncome = effectiveRent - yearMortgage - annualOperatingCosts;
    cumulativeCashFlow += yearNetIncome;

    let yearPrincipal = 0;
    for (let m = 0; m < 12; m++) {
      const interestPart = currentMortgageBalance * monthlyMortgageRate;
      const principalPart = monthlyMortgagePayment - interestPart;
      yearPrincipal += principalPart;
      currentMortgageBalance = Math.max(0, currentMortgageBalance - principalPart);
    }
    totalEquity += yearPrincipal;

    const totalReturn =
      cumulativeCashFlow + (propertyValue - input.purchasePrice);
    const totalROI = (totalReturn / totalInvestment) * 100;

    yearByYear.push({
      year,
      propertyValue: Math.round(propertyValue),
      annualRent: Math.round(effectiveRent),
      mortgagePayment: Math.round(yearMortgage),
      netIncome: Math.round(yearNetIncome),
      cumulativeCashFlow: Math.round(cumulativeCashFlow),
      equityBuilt: Math.round(totalEquity),
      totalROI: Math.round(totalROI * 100) / 100,
    });
  }

  const finalValue = yearByYear[yearByYear.length - 1]?.propertyValue || input.purchasePrice;
  const totalReturn =
    cumulativeCashFlow + (finalValue - input.purchasePrice);
  const totalROI = (totalReturn / totalInvestment) * 100;
  const annualROI = totalROI / input.holdingPeriodYears;

  let breakEvenMonths = -1;
  for (const yp of yearByYear) {
    if (yp.cumulativeCashFlow >= totalInvestment * 0.1) {
      breakEvenMonths = yp.year * 12;
      break;
    }
  }
  if (breakEvenMonths === -1 && totalROI > 0) {
    breakEvenMonths = Math.round((totalInvestment * 0.1) / (annualCashFlow || 1)) * 12;
  }

  const profitAfterHolding = totalReturn;

  const riskScore = calculateRiskScore({
    vacancyRate: input.vacancyRate,
    interestRate: input.interestRate,
    appreciationRate: input.appreciationRate,
    netYield: netRentalYield,
    capRate,
  });

  const investmentGrade = getInvestmentGrade(totalROI, riskScore);

  return {
    grossRentalYield: Math.round(grossRentalYield * 100) / 100,
    netRentalYield: Math.round(netRentalYield * 100) / 100,
    annualCashFlow: Math.round(annualCashFlow),
    monthlyCashFlow: Math.round(monthlyCashFlow),
    totalROI: Math.round(totalROI * 100) / 100,
    annualROI: Math.round(annualROI * 100) / 100,
    capRate: Math.round(capRate * 100) / 100,
    breakEvenMonths,
    totalInvestment: Math.round(totalInvestment),
    totalReturn: Math.round(totalReturn),
    profitAfterHolding: Math.round(profitAfterHolding),
    yearByYear,
    riskScore,
    investmentGrade,
  };
}

function calculateRiskScore(params: {
  vacancyRate: number;
  interestRate: number;
  appreciationRate: number;
  netYield: number;
  capRate: number;
}): number {
  let score = 50;
  if (params.vacancyRate < 5) score += 10;
  else if (params.vacancyRate > 15) score -= 15;
  if (params.netYield > 6) score += 15;
  else if (params.netYield > 4) score += 5;
  else if (params.netYield < 2) score -= 15;
  if (params.interestRate < 4) score += 5;
  else if (params.interestRate > 7) score -= 10;
  if (params.appreciationRate > 5) score += 10;
  else if (params.appreciationRate < 1) score -= 10;
  if (params.capRate > 7) score += 10;
  else if (params.capRate < 3) score -= 10;
  return Math.max(0, Math.min(100, score));
}

function getInvestmentGrade(
  totalROI: number,
  riskScore: number
): "A+" | "A" | "B+" | "B" | "C+" | "C" | "D" {
  const composite = totalROI * 0.6 + riskScore * 0.4;
  if (composite >= 80) return "A+";
  if (composite >= 65) return "A";
  if (composite >= 55) return "B+";
  if (composite >= 40) return "B";
  if (composite >= 25) return "C+";
  if (composite >= 10) return "C";
  return "D";
}

export function calculateRentalYield(input: RentalYieldInput): RentalYieldOutput {
  const annualRent = input.monthlyRent * 12;
  const grossYield = (annualRent / input.purchasePrice) * 100;
  const serviceCharges = input.serviceCharges || 0;
  const netAnnualRent = annualRent - serviceCharges;
  const netYield = (netAnnualRent / input.purchasePrice) * 100;

  const investorScore = Math.round(
    grossYield * 2 + netYield * 1.5 + (100 - serviceCharges / input.monthlyRent * 100) * 0.5
  );

  const riskLevel: "LOW" | "MEDIUM" | "HIGH" =
    netYield > 6 ? "LOW" : netYield > 4 ? "MEDIUM" : "HIGH";

  return {
    grossYield: Math.round(grossYield * 100) / 100,
    netYield: Math.round(netYield * 100) / 100,
    investorScore: Math.min(100, Math.max(0, investorScore)),
    marketComparison: [],
    historicalAppreciation: [],
    rentalDemandIndex: Math.round(50 + netYield * 5),
    liquidityScore: Math.round(60 + grossYield * 3),
    riskLevel,
  };
}

export function compareProperties(
  properties: Array<{ name: string; city: string; district: string; purchasePrice: number; monthlyRent: number }>
) {
  return properties.map((p) => {
    const annualRent = p.monthlyRent * 12;
    const grossYield = (annualRent / p.purchasePrice) * 100;
    const netYield = grossYield * 0.85;
    const roi = grossYield * 1.2;
    const locationScore = Math.round(50 + Math.random() * 40);
    const liquidityScore = Math.round(50 + Math.random() * 40);
    const appreciationPotential = Math.round(30 + Math.random() * 60);
    const overallScore = Math.round(
      (grossYield * 2 + roi + locationScore + liquidityScore + appreciationPotential) / 6
    );

    return {
      id: `prop-${Date.now()}-${Math.random().toString(36).slice(2, 8)}`,
      ...p,
      grossYield: Math.round(grossYield * 100) / 100,
      netYield: Math.round(netYield * 100) / 100,
      roi: Math.round(roi * 100) / 100,
      locationScore,
      liquidityScore,
      appreciationPotential,
      overallScore,
    };
  });
}
