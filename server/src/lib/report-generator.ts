import { prisma } from "./prisma";

import fs from 'fs/promises';
import path from 'path';
import puppeteer from 'puppeteer';

export interface ReportConfig {
  includeRevenue?: boolean;
  includeExpenses?: boolean;
  includeProfit?: boolean;
  includeOccupancy?: boolean;
  includeMaintenance?: boolean;
  includePaymentHistory?: boolean;
  includeLeaseDetails?: boolean;
  includeIssues?: boolean;
  includeExpired?: boolean;
  includeExpiring?: boolean;
  includeMissing?: boolean;
  dateRange?: string;
  groupBy?: string;
  status?: string;
}

export interface ReportResult {
  fileUrl: string;
  fileName: string;
  size: number;
  generatedAt: Date;
}

export async function generateReport(report: any, parameters: any = {}): Promise<ReportResult> {
  const config = { ...report.config, ...parameters } as ReportConfig;
  
  try {
    // Generate HTML content
    const htmlContent = await generateReportHTML(report.reportType, config, report.orgId);
    
    // Generate PDF
    const pdfBuffer = await generatePDF(htmlContent);
    
    // Save file
    const fileName = `${report.name}_${new Date().toISOString().split('T')[0]}.pdf`;
    const filePath = `./reports/${fileName}`;
    
    await fs.mkdir('./reports', { recursive: true });
    await fs.writeFile(filePath, pdfBuffer);
    
    return {
      fileUrl: `/reports/${fileName}`,
      fileName,
      size: pdfBuffer.length,
      generatedAt: new Date()
    };
  } catch (error) {
    console.error('Report generation failed:', error);
    throw error;
  }
}

async function generateReportHTML(reportType: string, config: ReportConfig, orgId: string): Promise<string> {
  const data = await fetchReportData(reportType, config, orgId);
  
  const html = `
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <title>${reportType.replace('_', ' ')} Report</title>
      <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .header { text-align: center; margin-bottom: 30px; }
        .header h1 { color: #333; margin-bottom: 10px; }
        .header p { color: #666; }
        .section { margin-bottom: 30px; }
        .section h2 { color: #333; border-bottom: 2px solid #007bff; padding-bottom: 5px; }
        .table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        .table th, .table td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        .table th { background-color: #f8f9fa; }
        .summary { background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .summary-item { display: inline-block; margin-right: 30px; }
        .summary-label { font-weight: bold; color: #333; }
        .summary-value { color: #007bff; font-size: 1.2em; }
        .status-badge { padding: 4px 8px; border-radius: 3px; font-size: 0.8em; }
        .status-active { background-color: #d4edda; color: #155724; }
        .status-inactive { background-color: #f8d7da; color: #721c24; }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .footer { margin-top: 40px; text-align: center; color: #666; font-size: 0.9em; }
      </style>
    </head>
    <body>
      <div class="header">
        <h1>${reportType.replace('_', ' ').toUpperCase()} REPORT</h1>
        <p>Generated on ${new Date().toLocaleDateString()} at ${new Date().toLocaleTimeString()}</p>
      </div>
      
      ${await generateReportSections(reportType, data, config)}
      
      <div class="footer">
        <p>This report was generated automatically by the Property Management System</p>
      </div>
    </body>
    </html>
  `;
  
  return html;
}

async function generateReportSections(reportType: string, data: any, config: ReportConfig): Promise<string> {
  switch (reportType) {
    case 'FINANCIAL':
      return generateFinancialSections(data, config);
    case 'PROPERTY':
      return generatePropertySections(data, config);
    case 'TENANT':
      return generateTenantSections(data, config);
    case 'COMPLIANCE':
      return generateComplianceSections(data, config);
    default:
      return '<div class="section"><h2>Report Data</h2><pre>' + JSON.stringify(data, null, 2) + '</pre></div>';
  }
}

async function generateFinancialSections(data: any, config: ReportConfig): Promise<string> {
  let sections = '';
  
  // Summary Section
  sections += `
    <div class="section">
      <h2>Financial Summary</h2>
      <div class="summary">
        <div class="summary-item">
          <span class="summary-label">Total Revenue:</span>
          <span class="summary-value">$${data.totalRevenue?.toLocaleString() || 0}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Total Expenses:</span>
          <span class="summary-value">$${data.totalExpenses?.toLocaleString() || 0}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Net Profit:</span>
          <span class="summary-value">$${data.netProfit?.toLocaleString() || 0}</span>
        </div>
      </div>
    </div>
  `;
  
  // Revenue Details
  if (config.includeRevenue && data.revenueDetails) {
    sections += `
      <div class="section">
        <h2>Revenue Details</h2>
        <table class="table">
          <thead>
            <tr>
              <th>Property</th>
              <th>Type</th>
              <th>Amount</th>
              <th>Date</th>
            </tr>
          </thead>
          <tbody>
            ${data.revenueDetails.map((item: any) => `
              <tr>
                <td>${item.propertyName || 'N/A'}</td>
                <td>${item.type || 'N/A'}</td>
                <td>$${item.amount?.toLocaleString() || 0}</td>
                <td>${new Date(item.date).toLocaleDateString()}</td>
              </tr>
            `).join('')}
          </tbody>
        </table>
      </div>
    `;
  }
  
  // Expense Details
  if (config.includeExpenses && data.expenseDetails) {
    sections += `
      <div class="section">
        <h2>Expense Details</h2>
        <table class="table">
          <thead>
            <tr>
              <th>Category</th>
              <th>Description</th>
              <th>Amount</th>
              <th>Date</th>
            </tr>
          </thead>
          <tbody>
            ${data.expenseDetails.map((item: any) => `
              <tr>
                <td>${item.category || 'N/A'}</td>
                <td>${item.description || 'N/A'}</td>
                <td>$${item.amount?.toLocaleString() || 0}</td>
                <td>${new Date(item.date).toLocaleDateString()}</td>
              </tr>
            `).join('')}
          </tbody>
        </table>
      </div>
    `;
  }
  
  return sections;
}

async function generatePropertySections(data: any, config: ReportConfig): Promise<string> {
  let sections = '';
  
  // Summary Section
  sections += `
    <div class="section">
      <h2>Property Performance Summary</h2>
      <div class="summary">
        <div class="summary-item">
          <span class="summary-label">Total Properties:</span>
          <span class="summary-value">${data.totalProperties || 0}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Occupancy Rate:</span>
          <span class="summary-value">${data.occupancyRate || 0}%</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Total Revenue:</span>
          <span class="summary-value">$${data.totalRevenue?.toLocaleString() || 0}</span>
        </div>
      </div>
    </div>
  `;
  
  // Property Details
  if (data.propertyDetails) {
    sections += `
      <div class="section">
        <h2>Property Details</h2>
        <table class="table">
          <thead>
            <tr>
              <th>Property Name</th>
              <th>Occupancy</th>
              <th>Revenue</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            ${data.propertyDetails.map((item: any) => `
              <tr>
                <td>${item.name || 'N/A'}</td>
                <td>${item.occupancy || 0}%</td>
                <td>$${item.revenue?.toLocaleString() || 0}</td>
                <td><span class="status-badge status-${item.status?.toLowerCase() || 'active'}">${item.status || 'Active'}</span></td>
              </tr>
            `).join('')}
          </tbody>
        </table>
      </div>
    `;
  }
  
  return sections;
}

async function generateTenantSections(data: any, config: ReportConfig): Promise<string> {
  let sections = '';
  
  // Summary Section
  sections += `
    <div class="section">
      <h2>Tenant Summary</h2>
      <div class="summary">
        <div class="summary-item">
          <span class="summary-label">Total Tenants:</span>
          <span class="summary-value">${data.totalTenants || 0}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Active Tenants:</span>
          <span class="summary-value">${data.activeTenants || 0}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Late Payments:</span>
          <span class="summary-value">${data.latePayments || 0}</span>
        </div>
      </div>
    </div>
  `;
  
  // Tenant Details
  if (config.includePaymentHistory && data.tenantDetails) {
    sections += `
      <div class="section">
        <h2>Tenant Details</h2>
        <table class="table">
          <thead>
            <tr>
              <th>Tenant Name</th>
              <th>Property</th>
              <th>Payment Status</th>
              <th>Lease End</th>
            </tr>
          </thead>
          <tbody>
            ${data.tenantDetails.map((item: any) => `
              <tr>
                <td>${item.name || 'N/A'}</td>
                <td>${item.propertyName || 'N/A'}</td>
                <td><span class="status-badge status-${item.paymentStatus?.toLowerCase() || 'pending'}">${item.paymentStatus || 'Pending'}</span></td>
                <td>${new Date(item.leaseEnd).toLocaleDateString()}</td>
              </tr>
            `).join('')}
          </tbody>
        </table>
      </div>
    `;
  }
  
  return sections;
}

async function generateComplianceSections(data: any, config: ReportConfig): Promise<string> {
  let sections = '';
  
  // Summary Section
  sections += `
    <div class="section">
      <h2>Compliance Summary</h2>
      <div class="summary">
        <div class="summary-item">
          <span class="summary-label">Total Documents:</span>
          <span class="summary-value">${data.totalDocuments || 0}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Compliant:</span>
          <span class="summary-value">${data.compliantDocuments || 0}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Expiring Soon:</span>
          <span class="summary-value">${data.expiringSoon || 0}</span>
        </div>
      </div>
    </div>
  `;
  
  // Compliance Details
  if (data.complianceDetails) {
    sections += `
      <div class="section">
        <h2>Compliance Details</h2>
        <table class="table">
          <thead>
            <tr>
              <th>Document</th>
              <th>Type</th>
              <th>Status</th>
              <th>Expiry Date</th>
            </tr>
          </thead>
          <tbody>
            ${data.complianceDetails.map((item: any) => `
              <tr>
                <td>${item.title || 'N/A'}</td>
                <td>${item.type || 'N/A'}</td>
                <td><span class="status-badge status-${item.status?.toLowerCase() || 'pending'}">${item.status || 'Pending'}</span></td>
                <td>${item.expiryDate ? new Date(item.expiryDate).toLocaleDateString() : 'N/A'}</td>
              </tr>
            `).join('')}
          </tbody>
        </table>
      </div>
    `;
  }
  
  return sections;
}

async function fetchReportData(reportType: string, config: ReportConfig, orgId: string): Promise<any> {
  const dateFilter = getDateFilter(config.dateRange);
  
  switch (reportType) {
    case 'FINANCIAL':
      return await fetchFinancialData(orgId, config, dateFilter);
    case 'PROPERTY':
      return await fetchPropertyData(orgId, config, dateFilter);
    case 'TENANT':
      return await fetchTenantData(orgId, config, dateFilter);
    case 'COMPLIANCE':
      return await fetchComplianceData(orgId, config, dateFilter);
    default:
      return {};
  }
}

function getDateFilter(dateRange?: string): any {
  if (!dateRange) return {};
  
  const now = new Date();
  switch (dateRange) {
    case 'last_month':
      return {
        gte: new Date(now.getFullYear(), now.getMonth() - 1, 1),
        lte: new Date(now.getFullYear(), now.getMonth(), 0)
      };
    case 'this_month':
      return {
        gte: new Date(now.getFullYear(), now.getMonth(), 1),
        lte: new Date(now.getFullYear(), now.getMonth() + 1, 0)
      };
    case 'last_30_days':
      return {
        gte: new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000),
        lte: now
      };
    case 'last_90_days':
      return {
        gte: new Date(now.getTime() - 90 * 24 * 60 * 60 * 1000),
        lte: now
      };
    default:
      return {};
  }
}

async function fetchFinancialData(orgId: string, config: ReportConfig, dateFilter: any): Promise<any> {
  // Mock data - replace with actual database queries
  return {
    totalRevenue: 125000,
    totalExpenses: 85000,
    netProfit: 40000,
    revenueDetails: [
      { propertyName: 'Sunset Villa', type: 'Rent', amount: 25000, date: new Date() },
      { propertyName: 'Ocean View', type: 'Rent', amount: 22000, date: new Date() }
    ],
    expenseDetails: [
      { category: 'Maintenance', description: 'Pool cleaning', amount: 5000, date: new Date() },
      { category: 'Utilities', description: 'Electricity', amount: 3000, date: new Date() }
    ]
  };
}

async function fetchPropertyData(orgId: string, config: ReportConfig, dateFilter: any): Promise<any> {
  // Mock data - replace with actual database queries
  return {
    totalProperties: 15,
    occupancyRate: 85,
    totalRevenue: 125000,
    propertyDetails: [
      { name: 'Sunset Villa', occupancy: 90, revenue: 25000, status: 'Active' },
      { name: 'Ocean View', occupancy: 80, revenue: 22000, status: 'Active' }
    ]
  };
}

async function fetchTenantData(orgId: string, config: ReportConfig, dateFilter: any): Promise<any> {
  // Mock data - replace with actual database queries
  return {
    totalTenants: 25,
    activeTenants: 23,
    latePayments: 2,
    tenantDetails: [
      { name: 'John Doe', propertyName: 'Sunset Villa', paymentStatus: 'Paid', leaseEnd: new Date() },
      { name: 'Jane Smith', propertyName: 'Ocean View', paymentStatus: 'Pending', leaseEnd: new Date() }
    ]
  };
}

async function fetchComplianceData(orgId: string, config: ReportConfig, dateFilter: any): Promise<any> {
  // Mock data - replace with actual database queries
  return {
    totalDocuments: 45,
    compliantDocuments: 42,
    expiringSoon: 3,
    complianceDetails: [
      { title: 'Fire Safety Certificate', type: 'SAFETY', status: 'Compliant', expiryDate: new Date() },
      { title: 'Insurance Policy', type: 'INSURANCE', status: 'Expiring', expiryDate: new Date() }
    ]
  };
}

async function generatePDF(htmlContent: string): Promise<Buffer> {
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });
  
  try {
    const page = await browser.newPage();
    await page.setContent(htmlContent, { waitUntil: 'networkidle0' });
    
    const pdfBuffer = await page.pdf({
      format: 'A4',
      printBackground: true,
      margin: {
        top: '20mm',
        right: '20mm',
        bottom: '20mm',
        left: '20mm'
      }
    });
    
    return pdfBuffer;
  } finally {
    await browser.close();
  }
}
