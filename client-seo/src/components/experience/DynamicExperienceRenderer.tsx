"use client";

import React from 'react';
import { useIntent } from '../../contexts/IntentContext';

export interface DynamicComponentProps {
  id: string;
  type: 'HERO' | 'PROPERTY_GRID' | 'INVESTMENT_CALCULATOR' | 'TRUST_BADGE' | 'SAGA_TRACKER';
  data: any;
}

export interface ExperiencePayload {
  layout: DynamicComponentProps[];
}

export const DynamicExperienceRenderer: React.FC<{ payload: ExperiencePayload }> = ({ payload }) => {
  const { state } = useIntent();

  // In a real Server-Driven UI, this mapping would dynamically load actual components.
  // We use placeholders here to demonstrate the Experience OS architecture.
  const renderComponent = (comp: DynamicComponentProps) => {
    switch (comp.type) {
      case 'HERO':
        return (
          <div key={comp.id} className="p-8 mb-4 rounded-xl bg-gradient-to-r from-blue-900 to-indigo-800 text-white">
            <h1 className="text-4xl font-bold">{comp.data.title}</h1>
            <p className="mt-2 opacity-80">{comp.data.subtitle}</p>
          </div>
        );
      case 'PROPERTY_GRID':
        return (
          <div key={comp.id} className="mb-4">
            <h2 className="text-2xl font-semibold mb-4">Properties (Intent: {state.intent})</h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              {comp.data.items?.map((item: any) => (
                <div key={item.id} className="p-4 border rounded-lg shadow-sm">
                  <div className="h-40 bg-gray-200 rounded mb-2"></div>
                  <h3 className="font-bold">{item.title}</h3>
                  <p className="text-gray-600">{item.price}</p>
                </div>
              ))}
            </div>
          </div>
        );
      case 'INVESTMENT_CALCULATOR':
        if (state.intent !== 'INVEST') return null;
        return (
          <div key={comp.id} className="p-6 mb-4 rounded-lg bg-green-50 border border-green-200">
            <h2 className="text-xl font-bold text-green-800">Investment ROI Calculator</h2>
            <p className="text-green-700">Projected Yield: {comp.data.projectedYield}%</p>
          </div>
        );
      case 'TRUST_BADGE':
        return (
          <div key={comp.id} className="inline-block px-3 py-1 rounded-full bg-blue-100 text-blue-800 text-sm font-medium mb-4">
            Trust Score: {state.trustScore} - {state.trustScore > 80 ? 'Verified Buyer' : 'Pending Verification'}
          </div>
        );
      default:
        return <div key={comp.id} className="p-4 text-red-500">Unknown Component Type: {comp.type}</div>;
    }
  };

  return (
    <div className="w-full max-w-7xl mx-auto p-4">
      {payload.layout.map(renderComponent)}
    </div>
  );
};
