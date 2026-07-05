"use client";

import { useState, useEffect } from "react";
import { useSearchParams } from "@/lib/react-router-shim";
import { motion } from "framer-motion";

export const ROICalculator = () => {
  const [searchParams] = useSearchParams();
  const companyFromUrl = searchParams.get("company") || "Your Company";

  const [units, setUnits] = useState(10000);
  const [rent, setRent] = useState(1800);
  const [uplift, setUplift] = useState(2.0); // Percentage

  // Calculations
  const monthlyRevenue = units * rent;
  const annualRevenue = monthlyRevenue * 12;
  const annualUplift = annualRevenue * (uplift / 100);
  
  // Commercial Models (Dynamic based on units and uplift)
  // A) SaaS Fee: $2 / unit / month
  const costSaaS = 2 * units * 12;
  // B) Performance Fee: 10% of incremental uplift
  const costPerformance = annualUplift * 0.10;
  // C) Hybrid: $1 / unit / month + 8% of uplift
  const costHybrid = (1 * units * 12) + (annualUplift * 0.08);

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat("en-US", { style: "currency", currency: "USD", maximumFractionDigits: 0 }).format(val);

  return (
    <div className="min-h-screen bg-neutral-950 text-white selection:bg-indigo-500/30 flex flex-col items-center justify-center p-6 relative overflow-hidden">
      {/* Background Glow */}
      <div className="absolute top-[-20%] left-[-10%] w-96 h-96 bg-indigo-600/20 rounded-full blur-[120px] pointer-events-none" />
      <div className="absolute bottom-[-20%] right-[-10%] w-96 h-96 bg-purple-600/20 rounded-full blur-[120px] pointer-events-none" />

      <motion.div 
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8 }}
        className="max-w-4xl w-full z-10"
      >
        <div className="text-center mb-12">
          <h2 className="text-indigo-400 font-semibold tracking-wider uppercase text-sm mb-2">
            &quot;We turn every property into a continuously optimizing revenue engine&quot;
          </h2>
          <h1 className="text-4xl md:text-5xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-white via-neutral-200 to-neutral-400 mb-4">
            {companyFromUrl} Portfolio Optimization
          </h1>
          <p className="text-neutral-400 text-lg max-w-2xl mx-auto">
            Not selling AI — selling guaranteed Net Measurable Revenue Uplift. Our non-invasive mutation layer sits on top of your existing PMS.
          </p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
          
          {/* Controls */}
          <div className="lg:col-span-5 bg-white/[0.02] border border-white/[0.05] rounded-3xl p-8 backdrop-blur-xl">
            <h3 className="text-xl font-semibold mb-6">Portfolio Parameters</h3>
            
            <div className="space-y-8">
              {/* Units */}
              <div>
                <div className="flex justify-between mb-2">
                  <label className="text-sm text-neutral-400">Total Units Managed</label>
                  <span className="font-mono text-indigo-300">{units.toLocaleString()}</span>
                </div>
                <input 
                  type="range" 
                  min="500" max="100000" step="500"
                  value={units} 
                  onChange={(e) => setUnits(Number(e.target.value))}
                  className="w-full accent-indigo-500"
                />
              </div>

              {/* Avg Rent */}
              <div>
                <div className="flex justify-between mb-2">
                  <label className="text-sm text-neutral-400">Avg. Monthly Rent / Unit</label>
                  <span className="font-mono text-indigo-300">{formatCurrency(rent)}</span>
                </div>
                <input 
                  type="range" 
                  min="800" max="5000" step="50"
                  value={rent} 
                  onChange={(e) => setRent(Number(e.target.value))}
                  className="w-full accent-indigo-500"
                />
              </div>

              {/* Uplift */}
              <div>
                <div className="flex justify-between mb-2">
                  <label className="text-sm text-neutral-400">Est. NOI Uplift Target</label>
                  <span className="font-mono text-emerald-400">+{uplift.toFixed(1)}%</span>
                </div>
                <input 
                  type="range" 
                  min="0.5" max="10.0" step="0.1"
                  value={uplift} 
                  onChange={(e) => setUplift(Number(e.target.value))}
                  className="w-full accent-emerald-500"
                />
                <p className="text-xs text-neutral-500 mt-2">
                  Conservative estimates range from 1.5% to 3.0% based on reduced vacancy days and optimized lease timing.
                </p>
              </div>
            </div>
          </div>

          {/* Results */}
          <div className="lg:col-span-7 flex flex-col justify-center space-y-6">
            
            {/* The Big Number */}
            <motion.div 
              key={annualUplift}
              initial={{ scale: 0.95, opacity: 0.8 }}
              animate={{ scale: 1, opacity: 1 }}
              className="bg-gradient-to-br from-indigo-500/10 to-purple-500/10 border border-indigo-500/20 rounded-3xl p-8 relative overflow-hidden"
            >
              <div className="absolute top-0 right-0 p-6 opacity-10">
                <svg className="w-32 h-32" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1.41 16.09V20h-2.67v-1.93c-1.71-.36-3.11-1.36-3.11-2.92v-.03c0-1.52 1.35-2.58 3.11-2.96v-3.7c-1.07.24-1.7.96-1.7 1.76h-2.3c0-1.87 1.56-3.26 3.99-3.65V4.49h2.67v1.95c1.87.35 3.16 1.48 3.16 3.05v.03c0 1.63-1.46 2.62-3.16 2.99v3.94c1.23-.27 1.94-1.07 1.94-1.92h2.3c0 1.93-1.66 3.32-4.23 3.66z"/></svg>
              </div>
              <h4 className="text-indigo-200 text-lg mb-2">Incremental Annual Value</h4>
              <div className="text-5xl md:text-6xl font-black text-white tracking-tight">
                {formatCurrency(annualUplift)}
              </div>
              <p className="text-indigo-300 mt-4 text-sm">
                Pure Net Operating Income added directly to your bottom line, requiring zero operational overhaul.
              </p>
            </motion.div>

            {/* Core KPIs Expected */}
            <div className="bg-white/[0.02] border border-white/[0.05] rounded-2xl p-4 grid grid-cols-4 gap-4 divide-x divide-white/[0.05] text-center">
              <div>
                <div className="text-emerald-400 font-bold">+1-3%</div>
                <div className="text-[10px] text-neutral-500 uppercase tracking-wider mt-1">Occupancy</div>
              </div>
              <div>
                <div className="text-emerald-400 font-bold">-10-25%</div>
                <div className="text-[10px] text-neutral-500 uppercase tracking-wider mt-1">Vacancy Days</div>
              </div>
              <div>
                <div className="text-emerald-400 font-bold">+1-5%</div>
                <div className="text-[10px] text-neutral-500 uppercase tracking-wider mt-1">Rent Opt.</div>
              </div>
              <div>
                <div className="text-emerald-400 font-bold">-5-15%</div>
                <div className="text-[10px] text-neutral-500 uppercase tracking-wider mt-1">Concessions</div>
              </div>
            </div>

            {/* Commercial Packages */}
            <h4 className="text-neutral-400 text-sm font-semibold uppercase tracking-wider pt-4">Commercial Models</h4>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              
              {/* SaaS */}
              <div className="bg-white/[0.02] border border-white/[0.05] rounded-2xl p-5">
                <h4 className="text-neutral-300 text-sm font-semibold mb-1">A) SaaS Fee</h4>
                <div className="text-xs text-neutral-500 mb-4">$2 / unit / month</div>
                <div className="text-xl font-bold text-neutral-200 mb-2">
                  {formatCurrency(costSaaS)} <span className="text-xs font-normal text-neutral-500">/ yr</span>
                </div>
                <div className="text-xs text-indigo-400">ROI: {(annualUplift / costSaaS).toFixed(1)}x</div>
              </div>
              
              {/* Performance */}
              <div className="bg-white/[0.02] border border-white/[0.05] rounded-2xl p-5">
                <h4 className="text-neutral-300 text-sm font-semibold mb-1">B) Performance</h4>
                <div className="text-xs text-neutral-500 mb-4">10% of Incremental Uplift</div>
                <div className="text-xl font-bold text-neutral-200 mb-2">
                  {formatCurrency(costPerformance)} <span className="text-xs font-normal text-neutral-500">/ yr</span>
                </div>
                <div className="text-xs text-indigo-400">ROI: 10.0x (Fixed)</div>
              </div>

              {/* Hybrid */}
              <div className="bg-emerald-500/10 border border-emerald-500/30 rounded-2xl p-5 relative overflow-hidden">
                <div className="absolute top-0 right-0 bg-emerald-500 text-black text-[9px] font-bold px-2 py-1 rounded-bl-lg uppercase tracking-wider">Recommended</div>
                <h4 className="text-emerald-300 text-sm font-semibold mb-1">C) Hybrid</h4>
                <div className="text-xs text-emerald-500/70 mb-4">$1 / unit + 8% Uplift Share</div>
                <div className="text-xl font-bold text-emerald-400 mb-2">
                  {formatCurrency(costHybrid)} <span className="text-xs font-normal text-emerald-500/50">/ yr</span>
                </div>
                <div className="text-xs text-emerald-400">ROI: {(annualUplift / costHybrid).toFixed(1)}x</div>
              </div>

            </div>

          </div>
        </div>
        
        <div className="mt-12 text-center">
          <button className="bg-white text-black px-8 py-4 rounded-full font-semibold hover:bg-neutral-200 transition-colors shadow-[0_0_40px_rgba(255,255,255,0.2)]">
            Schedule a Demo for {companyFromUrl}
          </button>
          <p className="text-xs text-neutral-600 mt-6">
            Reservatior B2B Advisory Layer. We sit on top of your existing PMS.
          </p>
        </div>
      </motion.div>
    </div>
  );
};

export default ROICalculator;
