export interface ExecutionLockConfig {
  forceEscrow: boolean;
  forceContractStateMachine: boolean;
  forceDisputeResolution: boolean;
  forcePaymentThroughEscrow: boolean;
  requireSignatureBeforeActive: boolean;
  disputeConfidenceThreshold: number; // 0-1, AI kararı için minimum güven skoru
}

const DEFAULT_CONFIG: ExecutionLockConfig = {
  forceEscrow: false,
  forceContractStateMachine: false,
  forceDisputeResolution: false,
  forcePaymentThroughEscrow: false,
  requireSignatureBeforeActive: false,
  disputeConfidenceThreshold: 0.85,
};

const REGION_LOCKS: Record<string, Partial<ExecutionLockConfig>> = {
  TR: {
    forceEscrow: true,
    forceContractStateMachine: true,
    forceDisputeResolution: true,
    forcePaymentThroughEscrow: true,
    requireSignatureBeforeActive: true,
    disputeConfidenceThreshold: 0.90,
  },
  AE: {
    forceEscrow: true,
    forceContractStateMachine: true,
    forceDisputeResolution: true,
    forcePaymentThroughEscrow: true,
    requireSignatureBeforeActive: true,
    disputeConfidenceThreshold: 0.90,
  },
  US: {
    forceEscrow: false,
    forceContractStateMachine: false,
    forceDisputeResolution: false,
    forcePaymentThroughEscrow: false,
    requireSignatureBeforeActive: false,
    disputeConfidenceThreshold: 0.85,
  },
  UK: {
    forceEscrow: true,
    forceContractStateMachine: true,
    forceDisputeResolution: true,
    forcePaymentThroughEscrow: true,
    requireSignatureBeforeActive: true,
    disputeConfidenceThreshold: 0.90,
  },
  DE: {
    forceEscrow: true,
    forceContractStateMachine: true,
    forceDisputeResolution: true,
    forcePaymentThroughEscrow: true,
    requireSignatureBeforeActive: true,
    disputeConfidenceThreshold: 0.90,
  },
  FR: {
    forceEscrow: true,
    forceContractStateMachine: true,
    forceDisputeResolution: true,
    forcePaymentThroughEscrow: true,
    requireSignatureBeforeActive: true,
    disputeConfidenceThreshold: 0.90,
  },
  SA: {
    forceEscrow: true,
    forceContractStateMachine: true,
    forceDisputeResolution: true,
    forcePaymentThroughEscrow: true,
    requireSignatureBeforeActive: true,
    disputeConfidenceThreshold: 0.90,
  },
};

export function getExecutionLockConfig(region: string): ExecutionLockConfig {
  const normalized = region.toUpperCase().trim();
  const regionConfig = REGION_LOCKS[normalized];
  if (!regionConfig) return DEFAULT_CONFIG;
  return { ...DEFAULT_CONFIG, ...regionConfig };
}

export function isExecutionLocked(region: string, lockKey: keyof ExecutionLockConfig): boolean {
  const config = getExecutionLockConfig(region);
  return config[lockKey] === true;
}
