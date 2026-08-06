import { prisma } from "../../lib/prisma";
import { TransactionTrustProfile } from "@prisma/client";

const TIER_THRESHOLDS = [
  { min: 90, tier: "DIAMOND" },
  { min: 75, tier: "PLATINUM" },
  { min: 55, tier: "GOLD" },
  { min: 35, tier: "SILVER" },
  { min: 0, tier: "BRONZE" },
];

const SIGNAL_WEIGHTS = {
  PARTY_VERIFICATION: { weight: 0.30 },
  PAYMENT_SECURITY: { weight: 0.25 },
  CONTRACT_ACCURACY: { weight: 0.20 },
  DOCUMENT_CONTROL: { weight: 0.15 },
  COMPLIANCE: { weight: 0.10 },
};

function assignTier(score: number): string {
  for (const { min, tier } of TIER_THRESHOLDS) {
    if (score >= min) return tier;
  }
  return "BRONZE";
}

async function fetchPartyVerificationSignals(transactionId: string, transactionType: string) {
  let tenantVerified = false;
  let landlordVerified = false;
  let agentVerified = false;
  let propertyVerified = false;

  if (transactionType === "RENTAL") {
    const lease = await prisma.lease.findFirst({
      where: { id: transactionId },
      include: { tenant: { include: { User: true } } },
    });

    if (lease?.tenant?.User?.emailVerified) tenantVerified = true;
  }

  // Check landlord verification
  const landlordEntity = await prisma.landlordEntity.findFirst();
  if (landlordEntity) {
    const user = await prisma.user.findUnique({ where: { id: landlordEntity.userId || "" } });
    if (user?.emailVerified) landlordVerified = true;
  }

  const verifiedCount = [tenantVerified, landlordVerified, agentVerified, propertyVerified].filter(Boolean).length;
  const partyScore = (verifiedCount / 4) * 100;

  return {
    partyScore: Math.round(partyScore * 100) / 100,
    tenantVerified,
    landlordVerified,
    agentVerified,
    propertyVerified,
  };
}

async function fetchPaymentSecuritySignals(transactionId: string) {
  const payment = await prisma.payment.findFirst({
    where: { id: transactionId },
  });

  const paymentMethodVerified = payment?.status === "PAID";
  const paymentEscrowEnabled = false; // Would check escrow status
  const paymentInsurance = false; // Would check insurance status

  const securityScore = (paymentMethodVerified ? 50 : 0) + (paymentEscrowEnabled ? 30 : 0) + (paymentInsurance ? 20 : 0);

  return {
    paymentScore: Math.round(securityScore * 100) / 100,
    paymentMethodVerified,
    paymentEscrowEnabled,
    paymentInsurance,
  };
}

async function fetchContractAccuracySignals(transactionId: string) {
  const contract = await prisma.contract.findFirst({
    where: { id: transactionId },
  });

  const contractTermsVerified = contract?.status === "ACTIVE";
  const contractCompliance = contract?.status === "ACTIVE";
  const contractFairness = 75; // Default fairness score

  const accuracyScore = (contractTermsVerified ? 40 : 0) + (contractCompliance ? 30 : 0) + contractFairness * 0.3;

  return {
    contractScore: Math.round(accuracyScore * 100) / 100,
    contractTermsVerified,
    contractCompliance,
    contractFairness,
  };
}

async function fetchDocumentControlSignals(transactionId: string) {
  const documents = await prisma.document.findMany({
    take: 10,
  });

  const documentsVerified = documents.length;
  const documentsComplete = documents.length >= 3;
  const documentAuthenticity = documents.length > 0 ? 75 : 0;

  const controlScore = (documentsComplete ? 40 : 0) + documentAuthenticity * 0.6;

  return {
    documentScore: Math.round(controlScore * 100) / 100,
    documentsVerified: documentsVerified >= documents.length / 2,
    documentsComplete,
    documentAuthenticity: Math.round(documentAuthenticity * 100) / 100,
  };
}

async function fetchComplianceSignals(transactionId: string) {
  const complianceRecords = await prisma.complianceRecord.findMany({
    where: { entityId: transactionId },
    take: 10,
  });

  const compliantCount = complianceRecords.length;
  const complianceScore = complianceRecords.length > 0 ? (compliantCount / complianceRecords.length) * 100 : 75;

  return {
    complianceScore: Math.round(complianceScore * 100) / 100,
    totalComplianceRecords: complianceRecords.length,
  };
}

export const transactionTrustScoreService = {
  async calculateTrustScore(transactionId: string, transactionType: string): Promise<TransactionTrustProfile> {
    const [partySignals, paymentSignals, contractSignals, documentSignals, complianceSignals] =
      await Promise.all([
        fetchPartyVerificationSignals(transactionId, transactionType),
        fetchPaymentSecuritySignals(transactionId),
        fetchContractAccuracySignals(transactionId),
        fetchDocumentControlSignals(transactionId),
        fetchComplianceSignals(transactionId),
      ]);

    const signalScores = {
      PARTY_VERIFICATION: partySignals.partyScore,
      PAYMENT_SECURITY: paymentSignals.paymentScore,
      CONTRACT_ACCURACY: contractSignals.contractScore,
      DOCUMENT_CONTROL: documentSignals.documentScore,
      COMPLIANCE: complianceSignals.complianceScore,
    };

    let weightedSum = 0;
    let totalWeight = 0;
    const breakdown: Record<string, number> = {};

    for (const [signal, score] of Object.entries(signalScores)) {
      const config = SIGNAL_WEIGHTS[signal as keyof typeof SIGNAL_WEIGHTS];
      if (config) {
        const normalized = Math.min(100, Math.max(0, score || 0));
        breakdown[signal] = Math.round(normalized * 100) / 100;
        weightedSum += normalized * config.weight;
        totalWeight += config.weight;
      }
    }

    const overallScore = totalWeight > 0 ? Math.round((weightedSum / totalWeight) * 100) / 100 : 0;
    const tier = assignTier(overallScore);

    const existingProfile = await prisma.transactionTrustProfile.findUnique({
      where: { transactionId },
    });

    const riskFactors: string[] = [];
    const positiveFactors: string[] = [];

    if (!partySignals.tenantVerified) riskFactors.push("Tenant not verified");
    if (!partySignals.landlordVerified) riskFactors.push("Landlord not verified");
    if (!paymentSignals.paymentMethodVerified) riskFactors.push("Payment method not verified");
    if (!contractSignals.contractTermsVerified) riskFactors.push("Contract terms not verified");

    if (partySignals.tenantVerified && partySignals.landlordVerified) positiveFactors.push("All parties verified");
    if (paymentSignals.paymentEscrowEnabled) positiveFactors.push("Payment escrow enabled");
    if (documentSignals.documentsComplete) positiveFactors.push("All documents complete");

    const profileData = {
      overallScore,
      partyScore: Math.round(partySignals.partyScore * 100) / 100,
      paymentScore: Math.round(paymentSignals.paymentScore * 100) / 100,
      contractScore: Math.round(contractSignals.contractScore * 100) / 100,
      documentScore: Math.round(documentSignals.documentScore * 100) / 100,
      tenantVerified: partySignals.tenantVerified,
      landlordVerified: partySignals.landlordVerified,
      agentVerified: partySignals.agentVerified,
      propertyVerified: partySignals.propertyVerified,
      paymentMethodVerified: paymentSignals.paymentMethodVerified,
      paymentEscrowEnabled: paymentSignals.paymentEscrowEnabled,
      paymentInsurance: paymentSignals.paymentInsurance,
      contractTermsVerified: contractSignals.contractTermsVerified,
      contractCompliance: contractSignals.contractCompliance,
      contractFairness: contractSignals.contractFairness,
      documentsVerified: documentSignals.documentsVerified,
      documentsComplete: documentSignals.documentsComplete,
      documentAuthenticity: documentSignals.documentAuthenticity,
      riskFactors,
      improvementSuggestions: positiveFactors,
      lastCalculatedAt: new Date(),
    };

    if (existingProfile) {
      return await prisma.transactionTrustProfile.update({
        where: { id: existingProfile.id },
        data: {
          ...profileData,
          calculationVersion: { increment: 1 },
        },
      });
    } else {
      return await prisma.transactionTrustProfile.create({
        data: {
          transactionId,
          transactionType,
          ...profileData,
          calculationVersion: 1,
        },
      });
    }
  },

  async getTrustProfile(transactionId: string): Promise<TransactionTrustProfile | null> {
    return await prisma.transactionTrustProfile.findUnique({
      where: { transactionId },
    });
  },

  async recordTrustEvent(
    transactionId: string,
    eventType: string,
    impact: number,
    metadata?: any
  ) {
    const profile = await prisma.transactionTrustProfile.findUnique({
      where: { transactionId },
    });

    if (!profile) {
      await this.calculateTrustScore(transactionId, "RENTAL");
      return;
    }

    const newScore = Math.min(100, Math.max(0, profile.overallScore + impact));
    const newTier = assignTier(newScore);

    await prisma.transactionTrustProfile.update({
      where: { transactionId },
      data: {
        overallScore: Math.round(newScore * 100) / 100,
        calculationVersion: { increment: 1 },
        lastCalculatedAt: new Date(),
      },
    });
  },

  async getTrustHistory(transactionId: string) {
    const profile = await prisma.transactionTrustProfile.findUnique({
      where: { transactionId },
    });

    if (!profile) return null;

    return [{ date: new Date().toISOString(), score: profile.overallScore }];
  },
};
