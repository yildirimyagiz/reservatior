"use client";

import React, { useState, useEffect } from 'react';
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, ReferenceLine } from 'recharts';
import { motion, AnimatePresence } from 'framer-motion';
import { Activity, Zap, AlertTriangle, TrendingUp, Network } from 'lucide-react';

const mockChartData = [
  { time: '10:00', roi: 4000, commission: 10 },
  { time: '10:05', roi: 4200, commission: 10 },
  { time: '10:10', roi: 4100, commission: 10 },
  { time: '10:15', roi: 4300, commission: 10 },
  { time: '10:20', roi: 4250, commission: 10 },
  { time: '10:25', roi: 4400, commission: 10 },
  { time: '10:30', roi: 4350, commission: 10 },
];

type SystemEvent = {
  id: string;
  type: string;
  message: string;
  timestamp: string;
  icon: React.ElementType;
  color: string;
};

export function NetworkDashboard() {
  const [data, setData] = useState(mockChartData);
  const [events, setEvents] = useState<SystemEvent[]>([]);
  const [currentCommission, setCurrentCommission] = useState(10);
  const [systemState, setSystemState] = useState('MONITORING'); // MONITORING | ANALYZING | MUTATING

  // Simulate Live Backtesting Event Feed
  useEffect(() => {
    let step = 0;
    const addEvent = (type: string, message: string, icon: React.ElementType, color: string) => {
      setEvents(prev => [{
        id: Math.random().toString(36).substr(2, 9),
        type, message, icon, color, timestamp: new Date().toLocaleTimeString()
      }, ...prev].slice(0, 5));
    };

    const interval = setInterval(() => {
      step++;
      
      // Normal Traffic
      if (step % 3 === 1 && step < 10) {
        addEvent('TRAFFIC', 'LISTING_VIEWED (ID: 48373)', Activity, 'text-blue-400');
        setData(prev => [...prev.slice(1), { time: new Date().toLocaleTimeString().slice(0,5), roi: prev[prev.length-1].roi + Math.random() * 50, commission: currentCommission }]);
      }

      // Crisis Scenario
      if (step === 10) {
        setSystemState('ANALYZING');
        addEvent('SHOCK', 'MARKET_SUPPLY_DROPPED (Amsterdam -45%)', AlertTriangle, 'text-yellow-400');
      }

      // Decision and Mutation
      if (step === 12) {
        setSystemState('MUTATING');
        addEvent('DECISION', 'OPPORTUNITY: HIGH_DEMAND DETECTED', Zap, 'text-purple-400');
      }

      if (step === 14) {
        setSystemState('MONITORING');
        setCurrentCommission(15);
        addEvent('ACTUATOR', 'CONTRACT_MUTATED: Commission -> 15%', TrendingUp, 'text-emerald-400');
      }

      // Post-Mutation tracking
      if (step > 14) {
        setData(prev => {
          const lastRoi = prev[prev.length-1].roi;
          return [...prev.slice(1), { 
            time: new Date().toLocaleTimeString().slice(0,5), 
            roi: lastRoi + (Math.random() * 200 + 100), // Steeper ROI curve due to higher commission
            commission: 15 
          }];
        });
      }

    }, 2000);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="flex flex-col gap-4">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2 text-slate-200">
          <Network className="h-5 w-5 text-indigo-400" />
          <h3 className="font-semibold text-lg">Live AI Decision Graph</h3>
        </div>
        <div className={`px-3 py-1 rounded-full text-xs font-bold flex items-center gap-2 ${
          systemState === 'MONITORING' ? 'bg-blue-500/10 text-blue-400 border border-blue-500/20' :
          systemState === 'ANALYZING' ? 'bg-yellow-500/10 text-yellow-400 border border-yellow-500/20' :
          'bg-purple-500/10 text-purple-400 border border-purple-500/20 animate-pulse'
        }`}>
          <div className={`h-2 w-2 rounded-full ${
            systemState === 'MONITORING' ? 'bg-blue-400' :
            systemState === 'ANALYZING' ? 'bg-yellow-400' :
            'bg-purple-400'
          }`} />
          {systemState}
        </div>
      </div>

      <div className="grid grid-cols-3 gap-4">
        <div className="col-span-2 h-[280px] bg-slate-900/40 rounded-xl border border-slate-800 p-4 relative overflow-hidden">
          {/* Glassmorphism backdrop for chart */}
          <div className="absolute inset-0 bg-gradient-to-br from-indigo-500/5 to-purple-500/5 pointer-events-none" />
          
          <h4 className="text-sm font-medium text-slate-400 mb-4 flex justify-between">
            <span>Expected Systemic ROI ($)</span>
            <span className="text-emerald-400 font-mono flex items-center gap-1">
              <TrendingUp className="h-3 w-3" />
              Target Commission: {currentCommission}%
            </span>
          </h4>
          
          <ResponsiveContainer width="100%" height="100%">
            <AreaChart data={data} margin={{ top: 5, right: 0, left: -20, bottom: 0 }}>
              <defs>
                <linearGradient id="colorRoi" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="5%" stopColor="#818cf8" stopOpacity={0.3}/>
                  <stop offset="95%" stopColor="#818cf8" stopOpacity={0}/>
                </linearGradient>
              </defs>
              <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
              <XAxis dataKey="time" stroke="#475569" fontSize={12} tickLine={false} axisLine={false} />
              <YAxis stroke="#475569" fontSize={12} tickLine={false} axisLine={false} tickFormatter={(val) => '$' + val} />
              <Tooltip 
                contentStyle={{ backgroundColor: '#0f172a', borderColor: '#1e293b', borderRadius: '8px' }}
                itemStyle={{ color: '#818cf8' }}
              />
              {currentCommission === 15 && (
                 <ReferenceLine x={data.find(d => d.commission === 15)?.time} stroke="#a855f7" strokeDasharray="3 3" label={{ position: 'top', value: 'MUTATION TRIGGERED', fill: '#a855f7', fontSize: 10 }} />
              )}
              <Area 
                type="monotone" 
                dataKey="roi" 
                stroke="#818cf8" 
                strokeWidth={2}
                fillOpacity={1} 
                fill="url(#colorRoi)" 
                isAnimationActive={false}
              />
            </AreaChart>
          </ResponsiveContainer>
        </div>

        <div className="col-span-1 bg-slate-900/40 rounded-xl border border-slate-800 p-4 overflow-hidden flex flex-col">
          <h4 className="text-sm font-medium text-slate-400 mb-3 flex items-center gap-2">
            <Activity className="h-4 w-4" /> Live Event Stream
          </h4>
          <div className="flex-1 overflow-y-auto space-y-3 pr-2 custom-scrollbar">
            <AnimatePresence>
              {events.map((evt) => {
                const Icon = evt.icon;
                return (
                  <motion.div 
                    key={evt.id}
                    initial={{ opacity: 0, x: 20, scale: 0.95 }}
                    animate={{ opacity: 1, x: 0, scale: 1 }}
                    exit={{ opacity: 0, scale: 0.9 }}
                    transition={{ duration: 0.2 }}
                    className="flex items-start gap-3 p-2 rounded-lg bg-slate-800/50 border border-slate-700/50 backdrop-blur-sm"
                  >
                    <div className={`mt-0.5 p-1 rounded-md bg-slate-900 ${evt.color}`}>
                      <Icon className="h-4 w-4" />
                    </div>
                    <div>
                      <div className="text-xs text-slate-500 font-mono">{evt.timestamp}</div>
                      <div className="text-sm text-slate-200 leading-tight mt-0.5">{evt.message}</div>
                    </div>
                  </motion.div>
                );
              })}
            </AnimatePresence>
            {events.length === 0 && (
              <div className="text-center text-slate-500 text-sm mt-10">Awaiting Signals...</div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
