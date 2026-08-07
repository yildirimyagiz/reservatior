"use client";

import React, { useState } from 'react';

export interface PolicyRule {
  id: string;
  name: string;
  description: string;
  type: 'COMMISSION' | 'TAX' | 'COMPLIANCE' | 'FEATURE_FLAG';
  value: any;
  countryCode: string | 'GLOBAL';
  isActive: boolean;
}

export const RuleEngineConfigurator: React.FC = () => {
  const [rules, setRules] = useState<PolicyRule[]>([
    {
      id: 'rule-1',
      name: 'Standard Commission UK',
      description: 'Default commission rate for agents in the UK',
      type: 'COMMISSION',
      value: 0.03,
      countryCode: 'UK',
      isActive: true,
    },
    {
      id: 'rule-2',
      name: 'Luxury Surcharge Global',
      description: 'Additional fee for luxury properties',
      type: 'COMMISSION',
      value: 0.005,
      countryCode: 'GLOBAL',
      isActive: false,
    },
    {
      id: 'rule-3',
      name: 'Germany KYC Enforcement',
      description: 'Block listings without verified agent ID',
      type: 'COMPLIANCE',
      value: true,
      countryCode: 'DE',
      isActive: true,
    }
  ]);

  const toggleRule = (id: string) => {
    setRules(rules.map(r => r.id === id ? { ...r, isActive: !r.isActive } : r));
  };

  return (
    <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-semibold text-gray-800">Policy OS Rule Engine</h2>
        <button className="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">
          + Add New Rule
        </button>
      </div>

      <div className="overflow-x-auto">
        <table className="w-full text-left border-collapse">
          <thead>
            <tr className="border-b bg-gray-50 text-gray-600 text-sm">
              <th className="p-3">Rule Name</th>
              <th className="p-3">Type</th>
              <th className="p-3">Country</th>
              <th className="p-3">Value</th>
              <th className="p-3 text-right">Status</th>
            </tr>
          </thead>
          <tbody>
            {rules.map(rule => (
              <tr key={rule.id} className="border-b hover:bg-gray-50">
                <td className="p-3">
                  <div className="font-medium text-gray-800">{rule.name}</div>
                  <div className="text-xs text-gray-500">{rule.description}</div>
                </td>
                <td className="p-3">
                  <span className="px-2 py-1 bg-gray-100 rounded text-xs font-semibold">
                    {rule.type}
                  </span>
                </td>
                <td className="p-3">{rule.countryCode}</td>
                <td className="p-3 font-mono text-sm">{JSON.stringify(rule.value)}</td>
                <td className="p-3 text-right">
                  <button 
                    onClick={() => toggleRule(rule.id)}
                    className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors ${rule.isActive ? 'bg-green-500' : 'bg-gray-300'}`}
                  >
                    <span className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${rule.isActive ? 'translate-x-6' : 'translate-x-1'}`} />
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};
