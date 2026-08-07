import React from 'react';
import { SagaTimelineViewer, SagaStep } from '../../../../../components/workflow/SagaTimelineViewer';

export default function TransactionStatusPage({ params }: { params: { locale: string; id: string } }) {
  // Mock data representing a long-running "Commission Payment Saga"
  const mockSteps: SagaStep[] = [
    {
      id: 'step-1',
      name: 'Deal Closed Event Captured',
      description: 'The property sale was finalized and recorded in the Finance OS.',
      status: 'COMPLETED',
      timestamp: '2026-08-01T10:00:00Z'
    },
    {
      id: 'step-2',
      name: 'Policy OS Rule Evaluation',
      description: 'Evaluating commission rate based on agent tier and country rules.',
      status: 'COMPLETED',
      timestamp: '2026-08-01T10:00:05Z'
    },
    {
      id: 'step-3',
      name: 'Identity Verification (KYC)',
      description: 'Checking agent compliance status before payment release.',
      status: 'IN_PROGRESS',
    },
    {
      id: 'step-4',
      name: 'Funds Escrow Release',
      description: 'Transferring funds from buyer escrow to commission holding account.',
      status: 'PENDING'
    },
    {
      id: 'step-5',
      name: 'Bank Transfer Dispatch',
      description: 'Final API call to payment gateway to disburse funds.',
      status: 'PENDING'
    }
  ];

  return (
    <div className="p-4 md:p-8">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">Transaction Status Tracker</h1>
        <p className="text-gray-600 mb-8">Powered by Workflow OS</p>
        
        <SagaTimelineViewer 
          transactionId={params.id || 'TXN-99421A'} 
          workflowName="Commission Disbursement Saga"
          steps={mockSteps}
        />
      </div>
    </div>
  );
}
