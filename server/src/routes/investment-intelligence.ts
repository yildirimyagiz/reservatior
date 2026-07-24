import { Elysia, t } from "elysia";

const inMemoryLeads: any[] = [];
const inMemoryReports: any[] = [];
const inMemoryEvents: any[] = [];

function generateId(): string {
  return `ii-${Date.now()}-${Math.random().toString(36).slice(2, 10)}`;
}

function getLeadScore(data: any): "HIGH" | "MEDIUM" | "LOW" {
  let score = 0;
  if (data.email) score += 2;
  if (data.phone) score += 1;
  if (data.budget && data.budget > 1000000) score += 2;
  if (data.source === "investment_report") score += 3;
  if (data.intent === "high") score += 2;
  return score >= 5 ? "HIGH" : score >= 3 ? "MEDIUM" : "LOW";
}

function generateMarketAnalysis(input: any, output: any): string {
  const city = input.city || "Dubai";
  const yield_ = output.grossRentalYield;
  const grade = output.investmentGrade;

  return `This ${input.propertyType || "apartment"} in ${city.charAt(0).toUpperCase() + city.slice(1)} presents a ${yield_}% gross rental yield, placing it ${yield_ > 7 ? "above" : yield_ > 5 ? "at" : "below"} the market average. With an investment grade of ${grade}, the property demonstrates ${grade.startsWith("A") ? "strong" : grade.startsWith("B") ? "moderate" : "below-average"} fundamentals for long-term wealth building. The ${input.appreciationRate || 8}% projected annual appreciation combined with ${output.netRentalYield}% net yield creates a compelling total return profile. Key considerations include the ${input.vacancyRate || 8}% vacancy assumption and ${input.interestRate || 5}% mortgage rate environment.`;
}

function generateRecommendations(input: any, output: any): string[] {
  const recs: string[] = [];
  if (output.grossRentalYield > 7) {
    recs.push("Strong rental yield indicates good cash flow potential. Consider leveraging with a mortgage to maximize returns.");
  } else if (output.grossRentalYield > 5) {
    recs.push("Moderate yield. Focus on capital appreciation and consider value-add renovations to increase rental income.");
  } else {
    recs.push("Below-average yield. This may be a appreciation-focused investment. Consider alternative districts for better cash flow.");
  }
  if (input.vacancyRate > 10) {
    recs.push("High vacancy rate detected. Research local demand drivers and consider furnished/short-term rental strategies.");
  }
  if (output.capRate > 7) {
    recs.push("Excellent cap rate above 7%. This property outperforms most market benchmarks.");
  }
  if (input.appreciationRate > 8) {
    recs.push("Strong appreciation forecast. Long-term holding (7-10 years) will maximize capital gains.");
  }
  recs.push("Consider connecting with Reservatior's Rental Management OS for hands-off property management after purchase.");
  recs.push("Create an investor profile to receive personalized property recommendations matching your strategy.");
  return recs;
}

export const investmentIntelligenceRoutes = new Elysia({ prefix: "/investment-intelligence" })

  .post("/calculate", async ({ body, set }) => {
    try {
      const input = body as any;
      const downPayment = input.purchasePrice * (input.downPaymentPercent / 100);
      const mortgageAmount = input.mortgageAmount || (input.purchasePrice - downPayment);
      const monthlyMortgageRate = input.interestRate / 100 / 12;
      const totalMonths = (input.holdingPeriodYears || 10) * 12;

      const monthlyMortgagePayment =
        mortgageAmount > 0 && monthlyMortgageRate > 0
          ? (mortgageAmount * monthlyMortgageRate * Math.pow(1 + monthlyMortgageRate, totalMonths)) /
            (Math.pow(1 + monthlyMortgageRate, totalMonths) - 1)
          : mortgageAmount / totalMonths;

      const annualRent = input.monthlyRent * 12;
      const effectiveAnnualRent = annualRent * (1 - (input.vacancyRate || 8) / 100);
      const annualOperatingCosts = (input.annualMaintenance || 0) + (input.serviceCharges || 0);
      const annualCashFlow = effectiveAnnualRent - monthlyMortgagePayment * 12 - annualOperatingCosts;
      const grossRentalYield = (effectiveAnnualRent / input.purchasePrice) * 100;
      const netOperatingIncome = effectiveAnnualRent - annualOperatingCosts;
      const netRentalYield = (netOperatingIncome / input.purchasePrice) * 100;
      const capRate = netRentalYield;

      let cumulativeCashFlow = 0;
      const yearByYear = [];
      for (let year = 1; year <= (input.holdingPeriodYears || 10); year++) {
        const propertyValue = input.purchasePrice * Math.pow(1 + (input.appreciationRate || 8) / 100, year);
        const yearRent = effectiveAnnualRent * Math.pow(1.03, year - 1);
        const yearNet = yearRent - monthlyMortgagePayment * 12 - annualOperatingCosts;
        cumulativeCashFlow += yearNet;
        const totalReturn = cumulativeCashFlow + (propertyValue - input.purchasePrice);
        const totalROI = (totalReturn / (downPayment + annualOperatingCosts * year)) * 100;
        yearByYear.push({ year, propertyValue: Math.round(propertyValue), netIncome: Math.round(yearNet), cumulativeCashFlow: Math.round(cumulativeCashFlow), totalROI: Math.round(totalROI * 100) / 100 });
      }

      const totalROI = yearByYear.length > 0 ? yearByYear[yearByYear.length - 1].totalROI : 0;
      const riskScore = Math.max(0, Math.min(100, 50 + (netRentalYield > 6 ? 15 : -5) + ((input.appreciationRate || 8) > 5 ? 10 : -10) + ((input.vacancyRate || 8) < 10 ? 5 : -10)));
      const composite = totalROI * 0.6 + riskScore * 0.4;
      const investmentGrade = composite >= 80 ? "A+" : composite >= 65 ? "A" : composite >= 55 ? "B+" : composite >= 40 ? "B" : composite >= 25 ? "C+" : composite >= 10 ? "C" : "D";

      return {
        grossRentalYield: Math.round(grossRentalYield * 100) / 100,
        netRentalYield: Math.round(netRentalYield * 100) / 100,
        annualCashFlow: Math.round(annualCashFlow),
        monthlyCashFlow: Math.round(annualCashFlow / 12),
        totalROI: Math.round(totalROI * 100) / 100,
        annualROI: Math.round((totalROI / (input.holdingPeriodYears || 10)) * 100) / 100,
        capRate: Math.round(capRate * 100) / 100,
        breakEvenMonths: annualCashFlow > 0 ? Math.round((downPayment * 0.1) / (annualCashFlow / 12)) : -1,
        totalInvestment: Math.round(downPayment + annualOperatingCosts * (input.holdingPeriodYears || 10)),
        totalReturn: Math.round(cumulativeCashFlow + (yearByYear.length > 0 ? yearByYear[yearByYear.length - 1].propertyValue - input.purchasePrice : 0)),
        profitAfterHolding: Math.round(cumulativeCashFlow),
        yearByYear,
        riskScore,
        investmentGrade,
      };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      purchasePrice: t.Number(),
      downPaymentPercent: t.Number(),
      mortgageAmount: t.Number(),
      interestRate: t.Number(),
      monthlyRent: t.Number(),
      annualMaintenance: t.Number(),
      serviceCharges: t.Number(),
      vacancyRate: t.Number(),
      appreciationRate: t.Number(),
      holdingPeriodYears: t.Number(),
      currency: t.String(),
      city: t.String(),
      district: t.Optional(t.String()),
      propertyType: t.Optional(t.String()),
    }),
    detail: { summary: "Calculate Property ROI", tags: ["Investment Intelligence"] },
  })

  .post("/reports", async ({ body, set }) => {
    try {
      const { input, output, email } = body as any;
      const reportId = generateId();
      const report = {
        id: reportId,
        title: `${(input.district || input.city || "Property").replace(/-/g, " ").replace(/\b\w/g, (l: string) => l.toUpperCase())} Investment Report`,
        city: input.city,
        district: input.district || input.city,
        propertyType: input.propertyType || "apartment",
        investmentScore: Math.round(output.totalROI),
        riskLevel: output.riskScore > 70 ? "LOW" : output.riskScore > 40 ? "MEDIUM" : "HIGH",
        expectedReturn: output.totalROI,
        rentalPotential: `With ${output.grossRentalYield}% gross yield and ${output.netRentalYield}% net yield, this property generates ${input.currency} ${output.monthlyCashFlow.toLocaleString()}/month net cash flow. The ${output.investmentGrade} grade indicates ${output.investmentGrade.startsWith("A") ? "excellent" : "solid"} investment fundamentals.`,
        marketAnalysis: generateMarketAnalysis(input, output),
        comparableProperties: [
          { name: "Market Average", price: input.purchasePrice, rent: input.monthlyRent * 0.9, yield: output.grossYield * 0.9, district: input.district || "Area" },
          { name: "Premium Comparable", price: input.purchasePrice * 1.2, rent: input.monthlyRent * 1.15, yield: output.grossYield * 0.85, district: input.district || "Area" },
        ],
        recommendations: generateRecommendations(input, output),
        generatedAt: new Date().toISOString(),
        roi: output,
        leadEmail: email,
      };
      inMemoryReports.push(report);
      return report;
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      input: t.Any(),
      output: t.Any(),
      email: t.Optional(t.String()),
    }),
    detail: { summary: "Generate Investment Report", tags: ["Investment Intelligence"] },
  })

  .get("/reports/:id", async ({ params, set }) => {
    const report = inMemoryReports.find((r) => r.id === params.id);
    if (!report) { set.status = 404; return { error: "Report not found" }; }
    return report;
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Get Investment Report", tags: ["Investment Intelligence"] },
  })

  .get("/reports/:id/pdf", async ({ params, set }) => {
    const report = inMemoryReports.find((r) => r.id === params.id);
    if (!report) { set.status = 404; return { error: "Report not found" }; }
    const html = `<!DOCTYPE html><html><head><title>${report.title}</title><style>body{font-family:sans-serif;padding:40px;}table{width:100%;border-collapse:collapse;}th,td{border:1px solid #ddd;padding:8px;text-align:right;}th{text-align:left;background:#f5f5f5;}</style></head><body><h1>${report.title}</h1><p>Investment Score: ${report.investmentScore}/100 | Grade: ${report.roi.investmentGrade} | Risk: ${report.riskLevel}</p><h2>Market Analysis</h2><p>${report.marketAnalysis}</h2><h2>Rental Potential</h2><p>${report.rentalPotential}</p><h2>Year-by-Year</h2><table><tr><th>Year</th><th>Value</th><th>Net Income</th><th>Cash Flow</th><th>ROI</th></tr>${report.roi.yearByYear.map((y: any) => `<tr><td>${y.year}</td><td>${y.propertyValue.toLocaleString()}</td><td>${y.netIncome.toLocaleString()}</td><td>${y.cumulativeCashFlow.toLocaleString()}</td><td>${y.totalROI}%</td></tr>`).join("")}</table><h2>Recommendations</h2><ul>${report.recommendations.map((r: string) => `<li>${r}</li>`).join("")}</ul><p style="color:#888;font-size:12px;margin-top:40px;">Generated by Reservatior Investment Intelligence</p></body></html>`;
    return new Response(html, { headers: { "Content-Type": "text/html", "Content-Disposition": `attachment; filename="${report.title.replace(/\s+/g, "-").toLowerCase()}-report.html"` } });
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Export Report as HTML/PDF", tags: ["Investment Intelligence"] },
  })

  .post("/leads", async ({ body, set }) => {
    try {
      const data = body as any;
      const lead = {
        id: generateId(),
        ...data,
        score: getLeadScore(data),
        createdAt: new Date().toISOString(),
      };
      inMemoryLeads.push(lead);

      inMemoryEvents.push({
        type: "LeadQualified",
        payload: { email: data.email, score: lead.score, source: data.source, timestamp: new Date().toISOString() },
      });

      set.status = 201;
      return { id: lead.id, score: lead.score };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      name: t.String(),
      email: t.String(),
      phone: t.Optional(t.String()),
      source: t.String(),
      intent: t.String(),
      calculatorType: t.String(),
      city: t.Optional(t.String()),
      budget: t.Optional(t.Number()),
      investmentGoal: t.Optional(t.String()),
    }),
    detail: { summary: "Capture Investment Lead", tags: ["Investment Intelligence"] },
  })

  .get("/leads", async ({ query, set }) => {
    const { page = "1", limit = "20", score } = query as any;
    let filtered = [...inMemoryLeads];
    if (score) filtered = filtered.filter((l) => l.score === score);
    const total = filtered.length;
    const start = ((parseInt(page) - 1) || 0) * parseInt(limit);
    const items = filtered.slice(start, start + parseInt(limit));
    return { data: items, total, page: parseInt(page), limit: parseInt(limit) };
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      score: t.Optional(t.String()),
    }),
    detail: { summary: "List Investment Leads", tags: ["Investment Intelligence"] },
  })

  .post("/profiles", async ({ body, set }) => {
    try {
      const profile = { id: generateId(), ...body, createdAt: new Date().toISOString(), lastActivity: new Date().toISOString() };
      inMemoryEvents.push({ type: "InvestorProfileCreated", payload: { profileId: profile.id, leadScore: profile.leadScore, timestamp: new Date().toISOString() } });
      set.status = 201;
      return profile;
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Any(),
    detail: { summary: "Create Investor Profile", tags: ["Investment Intelligence"] },
  })

  .patch("/profiles/:id", async ({ params, body, set }) => {
    return { ...body, id: params.id, updatedAt: new Date().toISOString() };
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Any(),
    detail: { summary: "Update Investor Profile", tags: ["Investment Intelligence"] },
  })

  .get("/profiles/:id", async ({ params, set }) => {
    return { id: params.id, message: "Profile retrieved" };
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Get Investor Profile", tags: ["Investment Intelligence"] },
  })

  .post("/events", async ({ body }) => {
    const event = { ...body, timestamp: new Date().toISOString() };
    inMemoryEvents.push(event);
    return { success: true };
  }, {
    body: t.Object({ type: t.String(), payload: t.Any() }),
    detail: { summary: "Track Investment Event", tags: ["Investment Intelligence"] },
  })

  .get("/analytics", async ({ query }) => {
    const { startDate, endDate, city } = query as any;
    const totalLeads = inMemoryLeads.length;
    const highLeads = inMemoryLeads.filter((l) => l.score === "HIGH").length;
    const reports = inMemoryReports.length;
    const events = inMemoryEvents.length;
    const calculators = inMemoryEvents.filter((e) => e.type === "InvestmentCalculationCreated").length;

    return {
      totalLeads,
      highIntentLeads: highLeads,
      reportsGenerated: reports,
      totalEvents: events,
      calculationsRun: calculators,
      conversionRate: totalLeads > 0 ? Math.round((highLeads / totalLeads) * 100) : 0,
      recentEvents: inMemoryEvents.slice(-20),
      topCities: [
        { city: "Dubai", count: inMemoryLeads.filter((l) => l.city === "dubai").length },
        { city: "Istanbul", count: inMemoryLeads.filter((l) => l.city === "istanbul").length },
        { city: "London", count: inMemoryLeads.filter((l) => l.city === "london").length },
      ],
    };
  }, {
    query: t.Object({
      startDate: t.Optional(t.String()),
      endDate: t.Optional(t.String()),
      city: t.Optional(t.String()),
    }),
    detail: { summary: "Get Investment Intelligence Analytics", tags: ["Investment Intelligence"] },
  });
