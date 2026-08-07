import React from 'react';
import { RuleEngineConfigurator } from '../../../../components/policy/RuleEngineConfigurator';

export default function PolicyOSPage() {
  return (
    <div className="p-8 max-w-7xl mx-auto space-y-8">
      <div>
        <h1 className="text-3xl font-bold text-gray-900 mb-2">Policy OS Control Center</h1>
        <p className="text-gray-600">Central nervous system for REOS business rules, taxes, and compliance routing.</p>
      </div>
      
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2">
          <RuleEngineConfigurator />
        </div>
        <div className="space-y-6">
          <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
            <h3 className="font-semibold text-lg mb-4">Simulation Engine</h3>
            <p className="text-sm text-gray-500 mb-4">Run a test payload against the active ruleset to verify Policy OS routing.</p>
            <div className="bg-gray-900 text-gray-200 p-4 rounded text-sm font-mono mb-4">
              {`{
  "event": "intent.search.submitted",
  "countryCode": "DE",
  "userId": "usr_992"
}`}
            </div>
            <button className="w-full py-2 bg-gray-100 hover:bg-gray-200 text-gray-800 rounded font-medium">
              Run Simulation
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
