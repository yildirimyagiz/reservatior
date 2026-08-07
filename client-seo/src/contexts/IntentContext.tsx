"use client";

import React, { createContext, useContext, useState, ReactNode } from 'react';

export type UserIntent = 'BUY' | 'RENT' | 'STAY' | 'INVEST' | 'UNKNOWN';

export interface IntentState {
  intent: UserIntent;
  trustScore: number;
  marketHeat: 'COLD' | 'WARM' | 'HOT';
  budget?: number;
}

interface IntentContextType {
  state: IntentState;
  setIntent: (intent: UserIntent) => void;
  updateState: (newState: Partial<IntentState>) => void;
}

const IntentContext = createContext<IntentContextType | undefined>(undefined);

export const IntentProvider = ({ children }: { children: ReactNode }) => {
  const [state, setState] = useState<IntentState>({
    intent: 'UNKNOWN',
    trustScore: 85, // Default/Mock trust score
    marketHeat: 'WARM'
  });

  const setIntent = (intent: UserIntent) => {
    setState(prev => ({ ...prev, intent }));
  };

  const updateState = (newState: Partial<IntentState>) => {
    setState(prev => ({ ...prev, ...newState }));
  };

  return (
    <IntentContext.Provider value={{ state, setIntent, updateState }}>
      {children}
    </IntentContext.Provider>
  );
};

export const useIntent = () => {
  const context = useContext(IntentContext);
  if (context === undefined) {
    throw new Error('useIntent must be used within an IntentProvider');
  }
  return context;
};
