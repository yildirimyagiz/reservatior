"use client";

import React from 'react';

export interface SagaStep {
  id: string;
  name: string;
  status: 'PENDING' | 'IN_PROGRESS' | 'COMPLETED' | 'FAILED' | 'COMPENSATED';
  timestamp?: string;
  description?: string;
}

export interface SagaTimelineViewerProps {
  transactionId: string;
  workflowName: string;
  steps: SagaStep[];
}

export const SagaTimelineViewer: React.FC<SagaTimelineViewerProps> = ({ transactionId, workflowName, steps }) => {
  return (
    <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 max-w-3xl mx-auto my-8">
      <div className="mb-8 border-b pb-4">
        <h2 className="text-xl font-bold text-gray-800">Workflow: {workflowName}</h2>
        <p className="text-gray-500 text-sm">Transaction ID: {transactionId}</p>
      </div>

      <div className="relative border-l-2 border-gray-200 ml-3 space-y-8">
        {steps.map((step, index) => {
          const isCompleted = step.status === 'COMPLETED';
          const isInProgress = step.status === 'IN_PROGRESS';
          const isFailed = step.status === 'FAILED' || step.status === 'COMPENSATED';

          return (
            <div key={step.id} className="relative pl-8">
              <span 
                className={`absolute -left-[9px] top-1 h-4 w-4 rounded-full border-2 bg-white
                  ${isCompleted ? 'border-green-500 bg-green-500' : ''}
                  ${isInProgress ? 'border-blue-500 border-t-transparent animate-spin' : ''}
                  ${isFailed ? 'border-red-500 bg-red-500' : ''}
                  ${step.status === 'PENDING' ? 'border-gray-300' : ''}
                `}
              />
              <div>
                <h3 className={`font-semibold text-lg 
                  ${isCompleted ? 'text-green-800' : ''}
                  ${isInProgress ? 'text-blue-800' : ''}
                  ${isFailed ? 'text-red-800' : ''}
                  ${step.status === 'PENDING' ? 'text-gray-500' : 'text-gray-800'}
                `}>
                  {step.name}
                </h3>
                {step.description && (
                  <p className="text-sm text-gray-500 mt-1">{step.description}</p>
                )}
                {step.timestamp && (
                  <p className="text-xs text-gray-400 mt-2">{new Date(step.timestamp).toLocaleString()}</p>
                )}
                {step.status === 'COMPENSATED' && (
                  <div className="mt-2 p-2 bg-red-50 border border-red-200 rounded text-sm text-red-700">
                    ⚠️ This step was rolled back by a compensating transaction.
                  </div>
                )}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
};
