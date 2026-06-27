"use client";

import React from 'react';
import { Calculator, Lightbulb } from 'lucide-react';

interface PipelineDecision {
  selected_pipeline: string;
  models_used: string[];
  expected_video_quality: string;
  estimated_gpu_cost_usd: string;
  recommended_use_case: string;
  notes: string;
  requires_premium?: boolean;
}

interface CostEstimatorProps {
  decision: PipelineDecision | null;
}

const CostEstimator: React.FC<CostEstimatorProps> = ({ decision }) => {
  if (!decision) return null;

  const cost = parseFloat(decision.estimated_gpu_cost_usd);
  const maxCost = 2.00;
  const percentage = Math.min((cost / maxCost) * 100, 100);

  return (
    <div className="bg-white dark:bg-slate-900 rounded-lg border border-slate-200 dark:border-slate-800 p-6 mt-6">
      <h3 className="text-lg font-semibold mb-4 flex items-center gap-2">
        <Calculator size={20} className="text-blue-500" />
        Cost Estimator
      </h3>
      
      <div className="flex items-end justify-between mb-2">
        <div className="text-3xl font-bold text-slate-900 dark:text-white">
          ${decision.estimated_gpu_cost_usd}
        </div>
        <div className="text-sm text-slate-500 uppercase font-medium">
          {decision.expected_video_quality} Quality
        </div>
      </div>

      <div className="h-2 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden mb-4">
        <div 
          className="h-full bg-gradient-to-r from-blue-500 to-purple-500 transition-all duration-500"
          style={{ width: `${percentage}%` }}
        />
      </div>
      
      {cost > 0.50 && (
         <div className="flex items-start gap-2 text-sm text-slate-500 bg-slate-50 dark:bg-slate-800/50 p-3 rounded-lg">
           <Lightbulb size={16} className="text-yellow-500 mt-0.5 flex-shrink-0" />
           <p>Tip: Simplify to InstantNGP by reducing photos (under 15) to save ~60%.</p>
         </div>
      )}
    </div>
  );
};

export default CostEstimator;
