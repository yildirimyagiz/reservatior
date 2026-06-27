"use client";

import React from 'react';
import { Cpu, Sparkles, Box, Layers, Gem, ImageOff } from 'lucide-react';


interface PipelineDecision {
  selected_pipeline: string;
  models_used: string[];
  expected_video_quality: string;
  estimated_gpu_cost_usd: string;
  recommended_use_case: string;
  notes: string;
  requires_premium?: boolean;
}

interface PipelineSelectorProps {
  decision: PipelineDecision | null;
  isLoading: boolean;
  luxuryFlag: boolean;
  onLuxuryFlagChange: (value: boolean) => void;
  currentPlan: string;
}

const PipelineSelector: React.FC<PipelineSelectorProps> = ({
  decision,
  isLoading,
  luxuryFlag,
  onLuxuryFlagChange,
  // currentPlan // Unused
}) => {
  const getPipelineStyle = (pipeline: string) => {
    if (pipeline.includes('Gaussian')) {
      return {
        icon: Sparkles,
        bg: 'bg-purple-50 dark:bg-purple-900/20',
        border: 'border-purple-200 dark:border-purple-800',
        text: 'text-purple-700 dark:text-purple-300',
        iconColor: 'text-purple-500'
      };
    }
    if (pipeline.includes('InstantNGP')) {
      return {
        icon: Box,
        bg: 'bg-blue-50 dark:bg-blue-900/20',
        border: 'border-blue-200 dark:border-blue-800',
        text: 'text-blue-700 dark:text-blue-300',
        iconColor: 'text-blue-500'
      };
    }
    return {
      icon: Layers,
      bg: 'bg-orange-50 dark:bg-orange-900/20',
      border: 'border-orange-200 dark:border-orange-800',
      text: 'text-orange-700 dark:text-orange-300',
      iconColor: 'text-orange-500'
    };
  };

  return (
    <div className="bg-white dark:bg-slate-900 rounded-lg border border-slate-200 dark:border-slate-800 p-6">
      <h3 className="text-lg font-semibold mb-4 flex items-center gap-2">
        <Cpu size={20} className="text-blue-500" />
        Selected Pipeline
      </h3>

      {isLoading ? (
        <div className="flex items-center justify-center py-8">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500" />
        </div>
      ) : decision ? (
        <div className="space-y-4">
          {(() => {
             const style = getPipelineStyle(decision.selected_pipeline);
             const Icon = style.icon;
             
             return (
               <div className={`rounded-lg p-4 border ${style.bg} ${style.border}`}>
                 <div className="flex items-start gap-3">
                   <Icon className={`mt-1 ${style.iconColor}`} size={20} />
                   <div>
                     <h4 className={`font-semibold ${style.text}`}>{decision.selected_pipeline}</h4>
                     <p className="text-sm text-slate-600 dark:text-slate-400 mt-1">{decision.recommended_use_case}</p>
                     <div className="flex items-center gap-2 mt-3">
                        <span className="text-xs font-medium bg-white/50 dark:bg-black/20 px-2 py-1 rounded">
                          Quality: {decision.expected_video_quality}
                        </span>
                        <span className="text-xs font-medium bg-white/50 dark:bg-black/20 px-2 py-1 rounded">
                          Cost: ${decision.estimated_gpu_cost_usd}
                        </span>
                     </div>
                   </div>
                 </div>
               </div>
             );
          })()}

          <div className="pt-3 border-t border-slate-200 dark:border-slate-800">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Gem size={16} className="text-purple-500" />
                <span className="text-sm font-medium">Luxury Mode</span>
              </div>
              <button
                onClick={() => onLuxuryFlagChange(!luxuryFlag)}
                className={`w-11 h-6 rounded-full transition-colors relative ${luxuryFlag ? 'bg-purple-500' : 'bg-slate-200 dark:bg-slate-700'}`}
              >
                <div className={`absolute top-1 w-4 h-4 rounded-full bg-white transition-transform ${luxuryFlag ? 'translate-x-6' : 'translate-x-1'}`} />
              </button>
            </div>
            <p className="text-xs text-slate-500 mt-2">
              Forces Nerfstudio Gaussian Splatting for premium results (increases cost).
            </p>
          </div>
        </div>
      ) : (
        <div className="flex flex-col items-center justify-center py-8 text-center">
          <ImageOff size={32} className="text-slate-300 mb-2" />
          <p className="text-sm text-slate-500">Add photos to see recommended pipeline</p>
        </div>
      )}
    </div>
  );
};

export default PipelineSelector;
