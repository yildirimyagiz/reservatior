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
    const invoice = await prisma.invoice.create({
      data: {
        customerId: data.customerId,
        customerName: data.customerName,
        customerEmail: data.customerEmail,
        amount: data.amount,
        currency: data.currency || "USD",
        dueDate: new Date(data.dueDate),
        status: data.status || "DRAFT",
        items: data.items as any,
        taxRate: data.taxRate,
        discountAmount: data.discountAmount,
        notes: data.notes,
      }
    });
    return toInvoiceData(invoice);
  }

  async getInvoices(filters?: {
    status?: string;
    customerId?: string;
    dateFrom?: string;
    dateTo?: string;
  }): Promise<InvoiceData[]> {
    const where: any = { deletedAt: null };
    if (filters?.status) where.status = filters.status;
    if (filters?.customerId) where.customerId = filters.customerId;
    if (filters?.dateFrom || filters?.dateTo) {
      where.dueDate = {};
      if (filters.dateFrom) where.dueDate.gte = new Date(filters.dateFrom);
      if (filters.dateTo) where.dueDate.lte = new Date(filters.dateTo);
    }
    const invoices = await prisma.invoice.findMany({ where, orderBy: { dueDate: 'desc' } });
    return invoices.map(toInvoiceData);
  }

  async getById(id: string): Promise<InvoiceData | null> {
    const invoice = await prisma.invoice.findFirst({ where: { id, deletedAt: null } });
    return invoice ? toInvoiceData(invoice) : null;
  }

  async updateInvoiceStatus(invoiceId: string, status: InvoiceData['status']): Promise<InvoiceData | null> {
    const invoice = await prisma.invoice.findFirst({ where: { id: invoiceId, deletedAt: null } });
    if (!invoice) return null;
    const updated = await prisma.invoice.update({ where: { id: invoiceId }, data: { status } });
    return toInvoiceData(updated);
  }

  async generateInvoiceNumber(): Promise<string> {
    const year = new Date().getFullYear();
    const month = new Date().getMonth() + 1;
    const count = await this.getInvoiceCountForMonth(year, month);
    return `INV-${year}-${String(month).padStart(2, '0')}-${String(count + 1).padStart(4, '0')}`;
  }

  async getInvoiceCountForMonth(year: number, month: number): Promise<number> {
    const start = new Date(year, month - 1, 1);
    const end = new Date(year, month, 0, 23, 59, 59, 999);
    return prisma.invoice.count({ where: { createdAt: { gte: start, lte: end }, deletedAt: null } });
  }

  async calculateInvoiceTotals(invoiceId: string) {
    const invoice = await prisma.invoice.findUnique({ where: { id: invoiceId } });
    if (!invoice) return null;
    const items = invoice.items as any as InvoiceItem[];
    const subtotal = items.reduce((s, i) => s + i.totalPrice, 0);
    const taxAmount = subtotal * ((invoice.taxRate || 18) / 100);
    const discountAmount = invoice.discountAmount || 0;
    return { subtotal, taxAmount, discountAmount, totalAmount: subtotal + taxAmount - discountAmount };
  }

  async sendInvoiceEmail(invoiceId: string): Promise<void> {
    const invoice = await prisma.invoice.findUnique({ where: { id: invoiceId } });
    if (!invoice) throw new Error('Invoice not found');
    console.log(`Invoice ${invoiceId} sent to ${invoice.customerEmail}`);
    await prisma.invoice.update({ where: { id: invoiceId }, data: { status: 'SENT' } });
  }

  async generateInvoicePDF(invoiceId: string): Promise<Buffer> {
    const invoice = await prisma.invoice.findUnique({ where: { id: invoiceId } });
    if (!invoice) throw new Error('Invoice not found');
    const items = invoice.items as any as InvoiceItem[];
    const subtotal = items.reduce((s, i) => s + i.totalPrice, 0);
    const taxAmount = subtotal * ((invoice.taxRate || 18) / 100);
    const content = `<html><head><style>
      body{font-family:Arial,sans-serif;margin:20px}
      h1{color:#333;border-bottom:2px solid #333;padding-bottom:10px}
      table{width:100%;border-collapse:collapse;margin:20px 0}
      th,td{padding:10px;text-align:left;border-bottom:1px solid #ddd}
      .total{text-align:right;font-size:18px;font-weight:bold;margin-top:20px}
    </style></head><body>
      <h1>Invoice #${invoice.id.slice(0, 8)}</h1>
      <p><strong>Customer:</strong> ${invoice.customerName} (${invoice.customerEmail})</p>
      <p><strong>Due Date:</strong> ${invoice.dueDate.toLocaleDateString()}</p>
      <p><strong>Status:</strong> ${invoice.status}</p>
      <table><tr><th>Item</th><th>Qty</th><th>Price</th><th>Total</th></tr>
      ${items.map(i => `<tr><td>${i.description}</td><td>${i.quantity}</td><td>$${i.unitPrice.toFixed(2)}</td><td>$${i.totalPrice.toFixed(2)}</td></tr>`).join('')}
      </table>
      <div class="total">
        <p>Subtotal: $${subtotal.toFixed(2)}</p>
        <p>Tax (${invoice.taxRate || 18}%): $${taxAmount.toFixed(2)}</p>
        <p>Total: <strong>$${invoice.amount.toFixed(2)}</strong></p>
      </div>
    </body></html>`;
    return Buffer.from(content);
  }

  async getInvoiceTemplates(): Promise<InvoiceTemplate[]> {
    const templates = await prisma.invoiceTemplate.findMany({ where: { isActive: true } });
    return templates.map(t => ({
      id: t.id, name: t.name, description: t.description || '',
      items: t.items as any as InvoiceItem[],
      defaultTaxRate: t.defaultTaxRate, defaultDueDays: t.defaultDueDays,
      currency: t.currency, isActive: t.isActive,
    }));
  }

  async createInvoiceFromTemplate(templateId: string, customerId: string, customizations?: Partial<InvoiceData>) {
    const template = await prisma.invoiceTemplate.findUnique({ where: { id: templateId } });
    if (!template) return null;
    const items = template.items as any as InvoiceItem[];
    const total = items.reduce((s, i) => s + i.totalPrice, 0);
    return this.createInvoice({
      customerId, customerName: '', customerEmail: '',
      amount: total, currency: template.currency,
      dueDate: new Date(Date.now() + template.defaultDueDays * 86400000).toISOString().split('T')[0],
      status: 'DRAFT', items, taxRate: template.defaultTaxRate,
      notes: `Generated from template: ${template.name}`,
      ...customizations
    });
  }

  async getOverdueInvoices(): Promise<InvoiceData[]> {
    const overdue = await prisma.invoice.findMany({
      where: { status: 'OVERDUE', dueDate: { lt: new Date() }, deletedAt: null },
      orderBy: { dueDate: 'asc' }
    });
    return overdue.map(toInvoiceData);
  }

  async getInvoiceStatistics() {
    const [total, paid, overdue, revenue] = await Promise.all([
      prisma.invoice.count({ where: { deletedAt: null } }),
      prisma.invoice.count({ where: { status: 'PAID', deletedAt: null } }),
      prisma.invoice.count({ where: { status: 'OVERDUE', dueDate: { lt: new Date() }, deletedAt: null } }),
      prisma.invoice.aggregate({ where: { status: 'PAID', deletedAt: null }, _sum: { amount: true } })
    ]);
    const totalRevenue = revenue._sum.amount || 0;
    return {
      totalInvoices: total, paidInvoices: paid,
      unpaidInvoices: total - paid, overdueInvoices: overdue,
      totalRevenue, averageInvoiceAmount: paid > 0 ? totalRevenue / paid : 0,
    };
  }
}

function toInvoiceData(invoice: any): InvoiceData {
  return {
    id: invoice.id, customerId: invoice.customerId,
    customerName: invoice.customerName, customerEmail: invoice.customerEmail,
    amount: invoice.amount, currency: invoice.currency,
    dueDate: invoice.dueDate.toISOString(), status: invoice.status,
    items: invoice.items as InvoiceItem[],
    taxRate: invoice.taxRate ?? undefined,
    discountAmount: invoice.discountAmount ?? undefined,
    notes: invoice.notes ?? undefined,
    createdAt: invoice.createdAt.toISOString(), updatedAt: invoice.updatedAt.toISOString(),
  };
}

export const invoiceService = new InvoiceService();
