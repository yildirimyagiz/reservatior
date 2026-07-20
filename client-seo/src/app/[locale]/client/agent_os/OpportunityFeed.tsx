"use client";

import React, { useEffect, useState } from 'react';

import { RefreshCw, Zap, TrendingUp } from 'lucide-react';
import { apiClient } from '@/lib/api';

export interface OpportunityAction {
  action: string;
  priority: number;
  expectedGain: number;
}

export interface OpportunityTask {
  id: string;
  sourceEvent: string;
  decisionReason: string;
  opportunityScore: number;
  action: OpportunityAction;
  status: string;
  createdAt: string;
}

export function OpportunityFeed() {
  const [tasks, setTasks] = useState<OpportunityTask[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchOpportunities = async () => {
    setLoading(true);
    try {
      const res: any = await apiClient.get('/telemetry/opportunities');
      if (res.data?.opportunities) {
        setTasks(res.data.opportunities);
      }
    } catch (err) {
      console.error("Failed to load opportunities:", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchOpportunities();
    // Poll every 30 seconds for the "best current hypothesis"
    const interval = setInterval(fetchOpportunities, 30000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="bg-slate-900/50 rounded-xl shadow-sm border border-slate-800 overflow-hidden flex flex-col h-full">
      <div className="p-4 border-b border-slate-800 flex items-center justify-between bg-gradient-to-r from-slate-800/50 to-slate-900/50">
        <div className="flex items-center gap-2">
          <Zap className="w-5 h-5 text-emerald-500" />
          <h2 className="font-semibold text-slate-100">AI Opportunity Feed</h2>
        </div>
        <button 
          onClick={fetchOpportunities} 
          className="p-2 text-slate-400 hover:text-emerald-500 hover:bg-slate-800 rounded-full transition-colors"
        >
          <RefreshCw className={`w-4 h-4 ${loading ? 'animate-spin' : ''}`} />
        </button>
      </div>

      <div className="p-4 flex-1 overflow-y-auto">
        {tasks.length === 0 && !loading ? (
          <div className="text-center py-8 text-slate-500 text-sm">
            No pending opportunities. System is observing...
          </div>
        ) : (
          <div className="space-y-4">
            {tasks.map((task) => (
              <div key={task.id} className="p-4 rounded-lg border border-slate-700 bg-slate-800/30 hover:bg-slate-800/50 transition-colors">
                <div className="flex justify-between items-start mb-2">
                  <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                    {task.action?.action.replace(/_/g, ' ')}
                  </span>
                  <div className="flex items-center text-emerald-500 text-sm font-semibold">
                    <TrendingUp className="w-4 h-4 mr-1" />
                    +${task.action?.expectedGain || 0}
                  </div>
                </div>
                
                <p className="text-sm text-slate-200 font-medium mb-1">
                  Confidence Score: {task.opportunityScore}
                </p>
                <p className="text-xs text-slate-400">
                  {task.decisionReason}
                </p>
                
                <div className="mt-4 flex gap-2">
                  <button className="flex-1 bg-emerald-600 text-white px-3 py-1.5 rounded-lg text-sm font-medium hover:bg-emerald-700 transition-colors shadow-sm shadow-emerald-900/20">
                    Execute
                  </button>
                  <button className="px-3 py-1.5 rounded-lg text-sm font-medium text-slate-300 hover:bg-slate-700 hover:text-white transition-colors">
                    Dismiss
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
