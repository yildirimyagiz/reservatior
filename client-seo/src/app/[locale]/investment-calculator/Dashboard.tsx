"use client";

import { useLocalization } from "@/contexts/LocalizationContext";
import { useState, useMemo } from "react";
import {
  DollarSign, TrendingUp, Target, Calculator, BarChart3,
  Brain, ArrowUpRight, Shield, PiggyBank, Clock, Zap, Building2
} from "lucide-react";

export default function InvestmentCalculatorDashboard() {
  const { language, currency } = useLocalization();

  // ─── Inputs ────────────────────────────────────────────────────────────
  const [purchasePrice, setPurchasePrice] = useState(500000);
  const [downPaymentPct, setDownPaymentPct] = useState(25);
  const [interestRate, setInterestRate] = useState(5.5);
  const [loanTermYears, setLoanTermYears] = useState(25);
  const [monthlyRent, setMonthlyRent] = useState(2200);
  const [annualAppreciation, setAnnualAppreciation] = useState(5);
  const [annualExpenses, setAnnualExpenses] = useState(3000);
  const [vacancyRatePct, setVacancyRatePct] = useState(5);

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  // ─── Calculations ──────────────────────────────────────────────────────
  const results = useMemo(() => {
    const downPayment = purchasePrice * (downPaymentPct / 100);
    const loanAmount = purchasePrice - downPayment;
    const monthlyRate = interestRate / 100 / 12;
    const totalPayments = loanTermYears * 12;

    const monthlyMortgage = loanAmount > 0 && monthlyRate > 0
      ? (loanAmount * monthlyRate * Math.pow(1 + monthlyRate, totalPayments)) / (Math.pow(1 + monthlyRate, totalPayments) - 1)
      : 0;

    const annualRentGross = monthlyRent * 12;
    const vacancyLoss = annualRentGross * (vacancyRatePct / 100);
    const annualRentNet = annualRentGross - vacancyLoss - annualExpenses;
    const annualMortgage = monthlyMortgage * 12;
    const annualCashflow = annualRentNet - annualMortgage;
    const monthlyCashflow = annualCashflow / 12;

    const grossYield = (annualRentGross / purchasePrice) * 100;
    const netYield = (annualRentNet / purchasePrice) * 100;
    const capRate = ((annualRentGross - annualExpenses) / purchasePrice) * 100;
    const cashOnCash = downPayment > 0 ? (annualCashflow / downPayment) * 100 : 0;

    // 5-year projection
    const projection = [];
    let cumulativeCashflow = 0;
    let propertyValue = purchasePrice;
    for (let year = 1; year <= 10; year++) {
      propertyValue *= (1 + annualAppreciation / 100);
      const yearCashflow = annualCashflow * Math.pow(1.02, year - 1); // 2% rent growth
      cumulativeCashflow += yearCashflow;
      const equity = propertyValue - loanAmount + cumulativeCashflow;
      const totalReturn = ((equity - downPayment) / downPayment) * 100;
      projection.push({ year, propertyValue, yearCashflow, cumulativeCashflow, equity, totalReturn });
    }

    const paybackYears = annualCashflow > 0 ? downPayment / annualCashflow : Infinity;

    return {
      downPayment, loanAmount, monthlyMortgage, annualRentGross, annualRentNet,
      annualCashflow, monthlyCashflow, grossYield, netYield, capRate, cashOnCash,
      projection, paybackYears,
    };
  }, [purchasePrice, downPaymentPct, interestRate, loanTermYears, monthlyRent, annualAppreciation, annualExpenses, vacancyRatePct]);

  const kpis = [
    { title: "Gross Yield", value: `${results.grossYield.toFixed(1)}%`, icon: BarChart3, color: "text-blue-600", bg: "bg-blue-50" },
    { title: "Net Yield", value: `${results.netYield.toFixed(1)}%`, icon: Target, color: "text-blue-600", bg: "bg-blue-50" },
    { title: "Cap Rate", value: `${results.capRate.toFixed(1)}%`, icon: TrendingUp, color: "text-purple-600", bg: "bg-purple-50" },
    { title: "Cash-on-Cash", value: `${results.cashOnCash.toFixed(1)}%`, icon: DollarSign, color: "text-orange-600", bg: "bg-orange-50" },
    { title: "Monthly Cashflow", value: formatCurrency(results.monthlyCashflow), icon: PiggyBank, color: results.monthlyCashflow >= 0 ? "text-blue-600" : "text-red-600", bg: results.monthlyCashflow >= 0 ? "bg-blue-50" : "bg-red-50" },
    { title: "Payback Period", value: results.paybackYears < 100 ? `${results.paybackYears.toFixed(1)} yrs` : "N/A", icon: Clock, color: "text-indigo-600", bg: "bg-indigo-50" },
  ];

  return (
    <div className="max-w-6xl mx-auto px-4 py-8 space-y-8">
      <div className="text-center">
        <h1 className="text-4xl font-bold text-gray-900">Investment Calculator</h1>
        <p className="text-gray-600 mt-2 text-lg">AI-powered ROI projections and risk analysis</p>
      </div>

      {/* Input Panel */}
      <div className="bg-white rounded-2xl shadow-lg p-6">
        <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-6">
          <Calculator className="w-5 h-5 text-blue-600" /> Investment Parameters
        </h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
          {[
            { label: "Purchase Price", value: purchasePrice, setter: setPurchasePrice, prefix: currency, step: 10000 },
            { label: `Down Payment (${downPaymentPct}%)`, value: downPaymentPct, setter: setDownPaymentPct, suffix: "%", step: 5, max: 100 },
            { label: "Interest Rate", value: interestRate, setter: setInterestRate, suffix: "%", step: 0.25, max: 15 },
            { label: "Loan Term", value: loanTermYears, setter: setLoanTermYears, suffix: "yrs", step: 5, max: 40 },
            { label: "Monthly Rent", value: monthlyRent, setter: setMonthlyRent, prefix: currency, step: 100 },
            { label: "Annual Appreciation", value: annualAppreciation, setter: setAnnualAppreciation, suffix: "%", step: 0.5, max: 20 },
            { label: "Annual Expenses", value: annualExpenses, setter: setAnnualExpenses, prefix: currency, step: 500 },
            { label: `Vacancy (${vacancyRatePct}%)`, value: vacancyRatePct, setter: setVacancyRatePct, suffix: "%", step: 1, max: 30 },
          ].map((input, i) => (
            <div key={i}>
              <label className="block text-sm text-gray-600 mb-1">{input.label}</label>
              <input
                type="number"
                value={input.value}
                onChange={(e) => input.setter(Number(e.target.value))}
                step={input.step}
                min={0}
                max={input.max}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-right font-mono"
              />
            </div>
          ))}
        </div>
      </div>

      {/* KPIs */}
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-white rounded-xl shadow-sm p-5 border border-gray-100 text-center">
              <div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color} inline-block mb-2`}><Icon className="w-5 h-5" /></div>
              <p className="text-2xl font-bold text-gray-900">{kpi.value}</p>
              <p className="text-xs text-gray-500 mt-1">{kpi.title}</p>
            </div>
          );
        })}
      </div>

      {/* Financial Summary */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white rounded-2xl shadow-lg p-6">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
            <DollarSign className="w-5 h-5 text-blue-600" /> Monthly Breakdown
          </h2>
          <div className="space-y-3">
            {[
              { label: "Gross Rent", value: monthlyRent, positive: true },
              { label: "Vacancy Loss", value: -(monthlyRent * vacancyRatePct / 100), positive: false },
              { label: "Expenses", value: -(annualExpenses / 12), positive: false },
              { label: "Mortgage Payment", value: -results.monthlyMortgage, positive: false },
            ].map((row, i) => (
              <div key={i} className="flex items-center justify-between py-2 border-b border-gray-50">
                <span className="text-sm text-gray-600">{row.label}</span>
                <span className={`text-sm font-mono font-bold ${row.positive ? 'text-blue-600' : 'text-red-600'}`}>
                  {formatCurrency(row.value)}
                </span>
              </div>
            ))}
            <div className="flex items-center justify-between py-3 border-t-2 border-gray-200">
              <span className="font-semibold text-gray-900">Net Monthly Cashflow</span>
              <span className={`text-xl font-bold font-mono ${results.monthlyCashflow >= 0 ? 'text-blue-600' : 'text-red-600'}`}>
                {formatCurrency(results.monthlyCashflow)}
              </span>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-2xl shadow-lg p-6">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
            <Brain className="w-5 h-5 text-purple-600" /> AI Risk Assessment
          </h2>
          <div className="space-y-3">
            {[
              { label: "Market Risk", level: annualAppreciation >= 5 ? "LOW" : annualAppreciation >= 3 ? "MEDIUM" : "HIGH" },
              { label: "Cashflow Risk", level: results.monthlyCashflow > 500 ? "LOW" : results.monthlyCashflow > 0 ? "MEDIUM" : "HIGH" },
              { label: "Leverage Risk", level: downPaymentPct >= 30 ? "LOW" : downPaymentPct >= 20 ? "MEDIUM" : "HIGH" },
              { label: "Interest Rate Risk", level: interestRate <= 4 ? "LOW" : interestRate <= 6 ? "MEDIUM" : "HIGH" },
              { label: "Vacancy Risk", level: vacancyRatePct <= 5 ? "LOW" : vacancyRatePct <= 10 ? "MEDIUM" : "HIGH" },
            ].map((r, i) => (
              <div key={i} className="flex items-center justify-between py-2">
                <span className="text-sm text-gray-600">{r.label}</span>
                <span className={`px-3 py-1 rounded-full text-xs font-bold ${
                  r.level === "LOW" ? "bg-blue-100 text-blue-700" :
                  r.level === "MEDIUM" ? "bg-yellow-100 text-yellow-700" :
                  "bg-red-100 text-red-700"
                }`}>{r.level}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* 10-Year Projection */}
      <div className="bg-white rounded-2xl shadow-lg p-6 overflow-x-auto">
        <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
          <TrendingUp className="w-5 h-5 text-indigo-600" /> 10-Year Projection
        </h2>
        <table className="w-full">
          <thead className="bg-gray-50 text-left">
            <tr>
              <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Year</th>
              <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Property Value</th>
              <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Annual Cashflow</th>
              <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Cumulative Cashflow</th>
              <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Total Equity</th>
              <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Total Return</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100">
            {results.projection.map((p) => (
              <tr key={p.year} className="hover:bg-gray-50 transition">
                <td className="px-4 py-3 text-sm font-medium text-gray-900">Year {p.year}</td>
                <td className="px-4 py-3 text-sm text-gray-700">{formatCurrency(p.propertyValue)}</td>
                <td className="px-4 py-3 text-sm font-mono text-blue-600">{formatCurrency(p.yearCashflow)}</td>
                <td className="px-4 py-3 text-sm font-mono text-blue-600">{formatCurrency(p.cumulativeCashflow)}</td>
                <td className="px-4 py-3 text-sm font-bold text-gray-900">{formatCurrency(p.equity)}</td>
                <td className="px-4 py-3">
                  <span className={`text-sm font-bold ${p.totalReturn >= 0 ? 'text-blue-600' : 'text-red-600'}`}>
                    {p.totalReturn >= 0 ? '+' : ''}{p.totalReturn.toFixed(1)}%
                  </span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
