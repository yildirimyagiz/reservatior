"use client";

import { useCallback, useRef } from 'react';
import { useAdRouterStore } from '@/lib/store/ad-router-store';
import type { AdBudgetShiftEvent, AdNetwork, NetworkPerformance } from '@/types/ad-router';

export function useArbitrageEngine() {
  const { addBudgetShift, setAutoArbitrage, autoArbitrageEnabled } = useAdRouterStore();
  const intervalRef = useRef<NodeJS.Timeout | null>(null);

  const calculateCPET = useCallback((networkPerf: NetworkPerformance[]) => {
    return networkPerf.map((n) => ({
      ...n,
      cpet: n.executedTransactions > 0 ? n.spend / n.executedTransactions : Infinity,
      cpql: n.qualifiedLeads > 0 ? n.spend / n.qualifiedLeads : Infinity,
    }));
  }, []);

  const evaluateShift = useCallback(
    (performances: NetworkPerformance[]): AdBudgetShiftEvent | null => {
      const scored = calculateCPET(performances);
      const worst = scored
        .filter((n) => n.spend > 0)
        .sort((a, b) => b.cpet - a.cpet)[0];
      const best = scored
        .filter((n) => n.cpet < Infinity)
        .sort((a, b) => a.cpet - b.cpet)[0];

      if (!worst || !best || worst.network === best.network) return null;
      if (best.cpet >= worst.cpet * 0.7) return null;

      return {
        id: `arb_${Date.now()}_${Math.random().toString(36).slice(2, 8)}`,
        campaignId: '',
        fromNetwork: worst.network,
        toNetwork: best.network,
        amount: Math.min(worst.spend * 0.15, 500),
        reason: `AI Arbitrage: ${best.network} CPET $${best.cpet.toFixed(2)} vs ${worst.network} $${worst.cpet.toFixed(2)}`,
        cpetBefore: worst.cpet,
        cpetAfter: best.cpet,
        triggeredBy: 'AI_ARBITRAGE',
        timestamp: new Date().toISOString(),
      };
    },
    [calculateCPET]
  );

  const executeAutoArbitrage = useCallback(
    (performances: NetworkPerformance[]) => {
      if (!autoArbitrageEnabled) return null;
      const shift = evaluateShift(performances);
      if (shift) addBudgetShift(shift);
      return shift;
    },
    [autoArbitrageEnabled, evaluateShift, addBudgetShift]
  );

  const startAutoArbitrage = useCallback(
    (performances: NetworkPerformance[], intervalMs = 300000) => {
      stopAutoArbitrage();
      setAutoArbitrage(true);
      intervalRef.current = setInterval(() => {
        executeAutoArbitrage(performances);
      }, intervalMs);
    },
    [executeAutoArbitrage, setAutoArbitrage]
  );

  const stopAutoArbitrage = useCallback(() => {
    if (intervalRef.current) {
      clearInterval(intervalRef.current);
      intervalRef.current = null;
    }
    setAutoArbitrage(false);
  }, [setAutoArbitrage]);

  return {
    calculateCPET,
    evaluateShift,
    executeAutoArbitrage,
    startAutoArbitrage,
    stopAutoArbitrage,
    autoArbitrageEnabled,
  };
}
