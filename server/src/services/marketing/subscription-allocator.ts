import { getWhatsAppService } from '../whatsapp-service';

export interface UserSubscriptionBudget {
  userId: string;
  userPhone: string;
  totalMonthlyBudget: number; // e.g. 500.00
  allocatedSpend: number; // e.g. 200.00
  remainingBudget: number; // e.g. 300.00
  currency: string;
}

export class SubscriptionAllocator {
  // In-memory mock database for budgets
  private budgets: Map<string, UserSubscriptionBudget> = new Map();

  constructor() {
    // Mock user for testing
    this.budgets.set('user_123', {
      userId: 'user_123',
      userPhone: '905551234567',
      totalMonthlyBudget: 1000.0,
      allocatedSpend: 0.0,
      remainingBudget: 1000.0,
      currency: 'USD'
    });
  }

  async checkAndAllocateBudget(userId: string, requestedAmount: number): Promise<{ approved: boolean; reason?: string }> {
    const budget = this.budgets.get(userId);
    
    if (!budget) {
      return { approved: false, reason: 'No active subscription budget found.' };
    }

    if (budget.remainingBudget < requestedAmount) {
      // Trigger WhatsApp notification for insufficient funds
      await this.notifyUserOfLowBudget(budget, requestedAmount);
      return { approved: false, reason: `Insufficient remaining budget. You have ${budget.remainingBudget} ${budget.currency} left.` };
    }

    // Allocate funds
    budget.allocatedSpend += requestedAmount;
    budget.remainingBudget -= requestedAmount;
    this.budgets.set(userId, budget);

    console.log(`[SubscriptionAllocator] Allocated ${requestedAmount} for user ${userId}. Remaining: ${budget.remainingBudget}`);

    return { approved: true };
  }

  private async notifyUserOfLowBudget(budget: UserSubscriptionBudget, requestedAmount: number): Promise<void> {
    const whatsapp = getWhatsAppService();
    try {
      await whatsapp.sendMessage({
        to: budget.userPhone,
        body: `🤖 Reservatior Uyarı:\nReklam kampanyanız için yeterli bütçeniz bulunmamaktadır.\nİstenen: ${requestedAmount} ${budget.currency}\nKalan: ${budget.remainingBudget} ${budget.currency}\n\nLütfen paketinizi yükseltin veya bütçe ekleyin.`
      });
    } catch (error) {
      console.error('[SubscriptionAllocator] Failed to send WhatsApp notification:', error);
    }
  }

  async getBudgetSummary(userId: string): Promise<UserSubscriptionBudget | null> {
    return this.budgets.get(userId) || null;
  }
}

export const subscriptionAllocator = new SubscriptionAllocator();
