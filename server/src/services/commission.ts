import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

interface SplitInput {
  partyType: 'PLATFORM' | 'AGENCY' | 'AGENT' | 'CO_AGENCY' | 'CO_AGENT' | 'PROPERTY_OWNER';
  partyId?: string;
  partyName?: string;
  rate: number;
}

interface CreateSubscriptionCommissionInput {
  orgId: string;
  leaseId?: string;
  listingId?: string;
  agentId?: string;
  agencyId?: string;
  monthlyRent: number;
  currency?: string;
  frequency?: 'MONTHLY' | 'QUARTERLY' | 'YEARLY';
  totalInstallments?: number;
  splits: SplitInput[];
}

export class CommissionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.commission, "commission");
  }

  async createSubscriptionCommission(input: CreateSubscriptionCommissionInput) {
    const { orgId, leaseId, listingId, agentId, agencyId, monthlyRent, currency = 'USD', frequency = 'MONTHLY', totalInstallments, splits: inputSplits } = input;

    const agentSplit = inputSplits.find(s => s.partyType === 'AGENT');
    const agencySplit = inputSplits.find(s => s.partyType === 'AGENCY');
    const platformSplit = inputSplits.find(s => s.partyType === 'PLATFORM');
    const coAgencySplit = inputSplits.find(s => s.partyType === 'CO_AGENCY');
    const coAgentSplit = inputSplits.find(s => s.partyType === 'CO_AGENT');
    const hasCoParties = !!coAgencySplit || !!coAgentSplit;
    const hasExplicitCoRates = (coAgencySplit && coAgencySplit.rate > 0) || (coAgentSplit && coAgentSplit.rate > 0);

    // Auto 50/50 split when co-brokerage detected but no explicit co rates
    let splits = inputSplits;
    if (hasCoParties && !hasExplicitCoRates && agencySplit && agentSplit) {
      const halfAgency = agencySplit.rate / 2;
      const halfAgent = agentSplit.rate / 2;
      splits = [
        { ...platformSplit!, rate: platformSplit?.rate ?? 0 },
        { ...agencySplit, rate: halfAgency },
        { ...agentSplit, rate: halfAgent },
        { partyType: 'CO_AGENCY' as const, partyId: coAgencySplit?.partyId, partyName: coAgencySplit?.partyName, rate: halfAgency },
        { partyType: 'CO_AGENT' as const, partyId: coAgentSplit?.partyId, partyName: coAgentSplit?.partyName, rate: halfAgent },
      ].filter(s => s.rate > 0);
    }

    const totalRate = splits.reduce((sum, s) => sum + s.rate, 0);
    const amountBase = monthlyRent;
    const commissionAmount = (amountBase * totalRate) / 100;

    const finalAgentSplit = splits.find(s => s.partyType === 'AGENT');
    const finalAgencySplit = splits.find(s => s.partyType === 'AGENCY');
    const finalPlatformSplit = splits.find(s => s.partyType === 'PLATFORM');
    const finalCoAgencySplit = splits.find(s => s.partyType === 'CO_AGENCY');
    const finalCoAgentSplit = splits.find(s => s.partyType === 'CO_AGENT');
    const isCoBrokerage = !!finalCoAgencySplit || !!finalCoAgentSplit;

    const commission = await prisma.commission.create({
      data: {
        orgId,
        leaseId,
        listingId,
        agentId,
        agencyId,
        amountBase,
        commissionRate: totalRate,
        agentRate: finalAgentSplit?.rate ?? 0,
        agencyRate: finalAgencySplit?.rate ?? 0,
        platformRate: finalPlatformSplit?.rate ?? 0,
        coAgencyRate: finalCoAgencySplit?.rate ?? 0,
        coAgentRate: finalCoAgentSplit?.rate ?? 0,
        isCoBrokerage,
        commissionAmount,
        taxAmount: 0,
        currency,
        type: 'SUBSCRIPTION_COMMISSION',
        frequency,
        totalInstallments: totalInstallments ?? 1,
        completedInstallments: 0,
        partnerFee: 0,
        platformFee: finalPlatformSplit ? (amountBase * finalPlatformSplit.rate) / 100 : 0,
        partnerRate: (finalAgencySplit?.rate ?? 0) + (finalCoAgencySplit?.rate ?? 0),
        status: 'PENDING',
        splits: {
          create: splits.map(s => ({
            partyType: s.partyType,
            partyId: s.partyId,
            partyName: s.partyName,
            rate: s.rate,
            amount: (amountBase * s.rate) / 100,
            currency
          }))
        }
      },
      include: { splits: true }
    });

    return commission;
  }

  async billRecurringCommission(commissionId: string) {
    const commission = await prisma.commission.findUnique({
      where: { id: commissionId },
      include: { splits: true }
    });

    if (!commission) throw new Error('Commission not found');
    if (commission.frequency === 'ONE_TIME') throw new Error('Not a recurring commission');
    if (commission.status !== 'PENDING' && commission.status !== 'CALCULATED') throw new Error('Commission not billable');

    const completed = (commission.completedInstallments ?? 0) + 1;
    const amountBase = commission.amountBase;

    const splitPayments = commission.splits.map(split => ({
      splitId: split.id,
      partyType: split.partyType,
      amount: (amountBase * split.rate) / 100
    }));

    await prisma.commission.update({
      where: { id: commissionId },
      data: {
        completedInstallments: completed,
        lastBilledDate: new Date(),
        nextBillingDate: completed < (commission.totalInstallments ?? 1)
          ? this.calculateNextBillingDate(commission.frequency as any)
          : null,
        status: completed >= (commission.totalInstallments ?? 1) ? 'PAID' : 'CALCULATED',
        splits: {
          updateMany: commission.splits.map(split => ({
            where: { id: split.id },
            data: {
              status: completed >= (commission.totalInstallments ?? 1) ? 'PAID' : 'CALCULATED',
              paidAt: completed >= (commission.totalInstallments ?? 1) ? new Date() : null,
              paidAmount: split.amount ?? (amountBase * split.rate) / 100
            }
          }))
        }
      }
    });

    return { completed, totalInstallments: commission.totalInstallments, splitPayments };
  }

  private calculateNextBillingDate(frequency: string): Date {
    const now = new Date();
    switch (frequency) {
      case 'MONTHLY': return new Date(now.getFullYear(), now.getMonth() + 1, now.getDate());
      case 'QUARTERLY': return new Date(now.getFullYear(), now.getMonth() + 3, now.getDate());
      case 'YEARLY': return new Date(now.getFullYear() + 1, now.getMonth(), now.getDate());
      default: return now;
    }
  }
}

export const commissionService = new CommissionService();
