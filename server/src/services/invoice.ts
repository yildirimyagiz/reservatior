import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export interface InvoiceData {
  id: string;
  customerId: string;
  customerName: string;
  customerEmail: string;
  amount: number;
  currency: string;
  dueDate: string;
  status: 'DRAFT' | 'SENT' | 'PAID' | 'OVERDUE' | 'CANCELLED';
  items: InvoiceItem[];
  taxRate?: number;
  discountAmount?: number;
  notes?: string;
  createdAt: string;
  updatedAt: string;
}

export interface InvoiceItem {
  id: string;
  description: string;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
  itemType: 'SERVICE' | 'PRODUCT' | 'RENT' | 'COMMISSION' | 'PENALTY';
  taxRate?: number;
}

export interface InvoiceTemplate {
  id: string;
  name: string;
  description: string;
  items: InvoiceItem[];
  defaultTaxRate: number;
  defaultDueDays: number;
  currency: string;
  isActive: boolean;
}

export class InvoiceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.invoice, "invoice");
  }

  async createInvoice(data: Omit<InvoiceData, 'id' | 'createdAt' | 'updatedAt'>): Promise<InvoiceData> {
    try {
      const invoice = await prisma.invoice.create({
        data: {
          ...data,
          id: this.generateId(),
          createdAt: new Date(),
          updatedAt: new Date(),
        }
      });

      return invoice;
    } catch (error) {
      throw new Error(`Failed to create invoice: ${error}`);
    }
  }

  async getInvoices(filters?: {
    status?: string;
    customerId?: string;
    dateFrom?: string;
    dateTo?: string;
  }): Promise<InvoiceData[]> {
    try {
      const where: any = {};

      if (filters?.status) {
        where.status = filters.status;
      }

      if (filters?.customerId) {
        where.customerId = filters.customerId;
      }

      if (filters?.dateFrom || filters?.dateTo) {
        where.dueDate = {};
        if (filters.dateFrom) {
          where.dueDate.gte = filters.dateFrom;
        }
        if (filters.dateTo) {
          where.dueDate.lte = filters.dateTo;
        }
      }

      const invoices = await prisma.invoice.findMany({
        where,
        orderBy: { dueDate: 'desc' }
      });

      return invoices;
    } catch (error) {
      throw new Error(`Failed to fetch invoices: ${error}`);
    }
  }

  async updateInvoiceStatus(invoiceId: string, status: InvoiceData['status']): Promise<InvoiceData> {
    try {
      const updatedInvoice = await prisma.invoice.update({
        where: { id: invoiceId },
        data: { 
          status,
          updatedAt: new Date()
        }
      });

      return updatedInvoice;
    } catch (error) {
      throw new Error(`Failed to update invoice status: ${error}`);
    }
  }

  async generateInvoiceNumber(): Promise<string> {
    const year = new Date().getFullYear();
    const month = new Date().getMonth() + 1;
    const count = await this.getInvoiceCountForMonth(year, month);
    
    return `INV-${year}-${month.toString().padStart(2, '0')}-${(count + 1).toString().padStart(4, '0')}`;
  }

  async getInvoiceCountForMonth(year: number, month: number): Promise<number> {
    try {
      const startDate = new Date(year, month - 1, 1);
      const endDate = new Date(year, month, 0, 23, 59, 59, 999);
      
      const count = await prisma.invoice.count({
        where: {
          createdAt: {
            gte: startDate,
            lte: endDate
          }
        }
      });

      return count;
    } catch (error) {
      return 0;
    }
  }

  async calculateInvoiceTotals(invoiceId: string): Promise<{
    subtotal: number;
    taxAmount: number;
    discountAmount: number;
    totalAmount: number;
  }> {
    try {
      const invoice = await prisma.invoice.findUnique({
        where: { id: invoiceId },
        include: { items: true }
      });

      if (!invoice) {
        throw new Error('Invoice not found');
      }

      const subtotal = invoice.items.reduce((sum, item) => sum + item.totalPrice, 0);
      const taxAmount = subtotal * (invoice.taxRate || 0.18); // Default 18% tax
      const discountAmount = invoice.discountAmount || 0;
      const totalAmount = subtotal + taxAmount - discountAmount;

      return {
        subtotal,
        taxAmount,
        discountAmount,
        totalAmount
      };
    } catch (error) {
      throw new Error(`Failed to calculate invoice totals: ${error}`);
    }
  }

  async sendInvoiceEmail(invoiceId: string): Promise<void> {
    try {
      const invoice = await prisma.invoice.findUnique({
        where: { id: invoiceId },
        include: { 
          customer: {
            select: { email: true, name: true }
          }
        }
      });

      if (!invoice) {
        throw new Error('Invoice not found');
      }

      // Mock email sending - integrate with email service
      console.log(`Invoice ${invoiceId} sent to ${invoice.customer.email}`);
      
      // Update invoice status to SENT
      await this.updateInvoiceStatus(invoiceId, 'SENT');
    } catch (error) {
      throw new Error(`Failed to send invoice email: ${error}`);
    }
  }

  async generateInvoicePDF(invoiceId: string): Promise<Buffer> {
    try {
      const invoice = await prisma.invoice.findUnique({
        where: { id: invoiceId },
        include: { items: true, customer: true }
      });

      if (!invoice) {
        throw new Error('Invoice not found');
      }

      // Mock PDF generation - integrate with PDF service
      const pdfContent = this.generatePDFContent(invoice);
      
      return Buffer.from(pdfContent);
    } catch (error) {
      throw new Error(`Failed to generate invoice PDF: ${error}`);
    }
  }

  private generatePDFContent(invoice: any): string {
    return `
      <html>
        <head>
          <title>Invoice ${invoice.id}</title>
          <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            .header { border-bottom: 2px solid #333; padding-bottom: 20px; margin-bottom: 20px; }
            .invoice-details { margin-bottom: 30px; }
            .items { margin-bottom: 20px; }
            .item { display: flex; justify-content: space-between; margin-bottom: 10px; }
            .total { text-align: right; font-weight: bold; margin-top: 20px; }
          </style>
        </head>
        <body>
          <div class="header">
            <h1>Invoice #${invoice.id}</h1>
            <div>
              <h2>${invoice.customer.name}</h2>
              <p>${invoice.customer.email}</p>
              <p>Date: ${new Date(invoice.createdAt).toLocaleDateString()}</p>
            </div>
          </div>
          
          <div class="invoice-details">
            <p><strong>Due Date:</strong> ${new Date(invoice.dueDate).toLocaleDateString()}</p>
            <p><strong>Status:</strong> ${invoice.status}</p>
          </div>
          
          <div class="items">
            <h3>Items</h3>
            ${invoice.items.map((item: any) => `
              <div class="item">
                <span>${item.description} x ${item.quantity}</span>
                <span>$${item.totalPrice.toFixed(2)}</span>
              </div>
            `).join('')}
          </div>
          
          <div class="total">
            <p>Subtotal: $${invoice.items.reduce((sum, item: any) => sum + item.totalPrice, 0).toFixed(2)}</p>
            <p>Tax (18%): $${(invoice.items.reduce((sum, item: any) => sum + item.totalPrice, 0) * 0.18).toFixed(2)}</p>
            <p><strong>Total: $${invoice.amount.toFixed(2)}</strong></p>
          </div>
        </body>
      </html>
    `;
  }

  async getInvoiceTemplates(): Promise<InvoiceTemplate[]> {
    try {
      const templates = await prisma.invoiceTemplate.findMany({
        where: { isActive: true }
      });

      return templates;
    } catch (error) {
      throw new Error(`Failed to fetch invoice templates: ${error}`);
    }
  }

  async createInvoiceFromTemplate(templateId: string, customerId: string, customizations?: Partial<InvoiceData>): Promise<InvoiceData> {
    try {
      const template = await prisma.invoiceTemplate.findUnique({
        where: { id: templateId }
      });

      if (!template) {
        throw new Error('Template not found');
      }

      const invoiceData: Omit<InvoiceData, 'id' | 'createdAt' | 'updatedAt'> = {
        customerId,
        amount: template.items.reduce((sum, item) => sum + item.totalPrice, 0),
        currency: template.currency,
        dueDate: new Date(Date.now() + template.defaultDueDays * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        status: 'DRAFT',
        items: template.items,
        taxRate: template.defaultTaxRate,
        notes: `Generated from template: ${template.name}`,
        ...customizations
      };

      return await this.createInvoice(invoiceData);
    } catch (error) {
      throw new Error(`Failed to create invoice from template: ${error}`);
    }
  }

  async getOverdueInvoices(): Promise<InvoiceData[]> {
    try {
      const overdueInvoices = await prisma.invoice.findMany({
        where: {
          status: 'OVERDUE',
          dueDate: { lt: new Date() }
        },
        orderBy: { dueDate: 'asc' }
      });

      return overdueInvoices;
    } catch (error) {
      throw new Error(`Failed to fetch overdue invoices: ${error}`);
    }
  }

  async getInvoiceStatistics(): Promise<{
    totalInvoices: number;
    paidInvoices: number;
    unpaidInvoices: number;
    overdueInvoices: number;
    totalRevenue: number;
    averageInvoiceAmount: number;
  }> {
    try {
      const [total, paid, unpaid, overdue] = await Promise.all([
        prisma.invoice.count(),
        prisma.invoice.count({ where: { status: 'PAID' } }),
        prisma.invoice.count({ where: { status: { in: ['DRAFT', 'SENT', 'OVERDUE'] } } }),
        prisma.invoice.count({ where: { status: 'OVERDUE', dueDate: { lt: new Date() } } })
      ]);

      const revenueResult = await prisma.invoice.aggregate({
        where: { status: 'PAID' },
        _sum: { amount: true }
      });

      return {
        totalInvoices: total,
        paidInvoices: paid,
        unpaidInvoices: unpaid,
        overdueInvoices: overdue,
        totalRevenue: revenueResult._sum.amount || 0,
        averageInvoiceAmount: revenueResult._sum.amount ? revenueResult._sum.amount / paid : 0
      };
    } catch (error) {
      throw new Error(`Failed to fetch invoice statistics: ${error}`);
    }
  }

  private generateId(): string {
    return `inv_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }
}

export const invoiceService = new InvoiceService();
