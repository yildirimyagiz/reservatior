/**
 * Document OS Service
 * Enterprise document management platform
 */

import { prisma } from '../lib/prisma';
import { eventBus } from '../core/events/event-bus';
import { GeminiService } from './gemini';

export interface Document {
  id: string;
  documentType: 'contract' | 'invoice' | 'receipt' | 'escrow' | 'property' | 'maintenance' | 'insurance' | 'identity' | 'investment' | 'ai_report';
  title: string;
  description?: string;
  fileUrl: string;
  fileName: string;
  fileSize: number;
  mimeType: string;
  status: 'draft' | 'pending_review' | 'approved' | 'rejected' | 'archived';
  version: number;
  parentId?: string;
  organizationId: string;
  createdBy: string;
  metadata?: Record<string, any>;
  tags?: string[];
  aiSummary?: string;
  ocrData?: Record<string, any>;
  signedAt?: Date;
  expiresAt?: Date;
  countryCode?: string;
  language?: string;
  currency?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface DocumentTemplate {
  id: string;
  name: string;
  description: string;
  documentType: string;
  templateData: Record<string, any>;
  variables: Array<{
    name: string;
    type: string;
    required: boolean;
    defaultValue?: any;
  }>;
  organizationId: string;
  isActive: boolean;
}

export interface DocumentApproval {
  id: string;
  documentId: string;
  approverId: string;
  status: 'pending' | 'approved' | 'rejected';
  comments?: string;
  approvedAt?: Date;
}

class DocumentOSService {
  /**
   * Upload and process document
   */
  async uploadDocument(data: Partial<Document>, file: Uint8Array) {
    // Store file (would use cloud storage in production)
    const fileUrl = await this.storeFile(file, data.fileName ?? 'document');
    
    const document = await prisma.document.create({
      data: {
        ...data,
        fileUrl,
        version: 1,
        status: 'draft' as const
      }
    });

    // Process with OCR
    const ocrData = await this.processOCR(file, data.mimeType ?? 'application/octet-stream');
    if (ocrData) {
      await prisma.document.update({
        where: { id: document.id },
        data: { ocrData }
      });
    }

    // Generate AI summary
    const aiSummary = await this.generateAISummary(document);
    if (aiSummary) {
      await prisma.document.update({
        where: { id: document.id },
        data: { aiSummary }
      });
    }

    // Auto-classify
    const classification = await this.classifyDocument(document);
    if (classification) {
      await prisma.document.update({
        where: { id: document.id },
        data: { 
          documentType: classification.type,
          tags: classification.tags
        }
      });
    }

    await eventBus.publish('document.uploaded', document, 'DocumentOS');

    return document;
  }

  /**
   * Create document from template
   */
  async createFromTemplate(templateId: string, variables: Record<string, any>, orgId: string) {
    const template = await prisma.documentTemplate.findUnique({
      where: { id: templateId }
    });

    if (!template) {
      throw new Error('Template not found');
    }

    // Generate document from template
    const content = this.renderTemplate(template.templateData, variables);
    
    const document = await prisma.document.create({
      data: {
        documentType: template.documentType as any,
        title: template.name,
        description: template.description,
        fileUrl: '', // Would generate PDF
        fileName: `${template.name}.pdf`,
        fileSize: 0,
        mimeType: 'application/pdf' as const,
        status: 'draft',
        version: 1,
        organizationId: orgId,
        createdBy: variables.createdBy || 'system',
        metadata: { templateId, variables }
      }
    });

    await eventBus.publish('document.created', document, 'DocumentOS');

    return document;
  }

  /**
   * Request digital signature
   */
  async requestSignature(documentId: string, signers: Array<{ email: string; name: string }>) {
    const document = await prisma.document.findUnique({
      where: { id: documentId }
    });

    if (!document) {
      throw new Error('Document not found');
    }

    // Create signature requests
    const signatureRequests = await Promise.all(
      signers.map(signer =>
        prisma.signatureRequest.create({
          data: {
            documentId,
            signerEmail: signer.email,
            signerName: signer.name,
            status: 'pending'
          }
        })
      )
    );

    // Send notifications (would integrate with Notification OS)
    await eventBus.publish('document.signature_requested', {
      documentId,
      signers
    }, 'DocumentOS');

    return signatureRequests;
  }

  /**
   * Approve document
   */
  async approveDocument(documentId: string, approverId: string, comments?: string) {
    const document = await prisma.document.findUnique({
      where: { id: documentId }
    });

    if (!document) {
      throw new Error('Document not found');
    }

    await prisma.documentApproval.create({
      data: {
        documentId,
        approverId,
        status: 'approved',
        comments,
        approvedAt: new Date()
      }
    });

    const updated = await prisma.document.update({
      where: { id: documentId },
      data: { status: 'approved' }
    });

    await eventBus.publish('document.approved', updated, 'DocumentOS');

    return updated;
  }

  /**
   * Create new version of document
   */
  async createVersion(documentId: string, file: Uint8Array) {
    const current = await prisma.document.findUnique({
      where: { id: documentId }
    });

    if (!current) {
      throw new Error('Document not found');
    }

    const fileUrl = await this.storeFile(file, current.fileName);
    
    const newVersion = await prisma.document.create({
      data: {
        ...current,
        id: undefined,
        fileUrl,
        version: current.version + 1,
        parentId: current.id,
        status: 'draft'
      }
    });

    await eventBus.publish('document.version_created', newVersion, 'DocumentOS');

    return newVersion;
  }

  /**
   * Search documents
   */
  async searchDocuments(query: string, filters: {
    documentType?: string;
    status?: string;
    organizationId: string;
    tags?: string[];
  }) {
    const where: any = {
      organizationId: filters.organizationId
    };

    if (filters.documentType) {
      where.documentType = filters.documentType;
    }

    if (filters.status) {
      where.status = filters.status;
    }

    if (filters.tags && filters.tags.length > 0) {
      where.tags = {
        hasSome: filters.tags
      };
    }

    // Full-text search
    if (query) {
      where.OR = [
        { title: { contains: query, mode: 'insensitive' } },
        { description: { contains: query, mode: 'insensitive' } },
        { aiSummary: { contains: query, mode: 'insensitive' } }
      ];
    }

    return prisma.document.findMany({
      where,
      orderBy: { createdAt: 'desc' }
    });
  }

  /**
   * Get document timeline
   */
  async getDocumentTimeline(documentId: string) {
    const document = await prisma.document.findUnique({
      where: { id: documentId },
      include: {
        approvals: true,
        signatureRequests: true
      }
    });

    if (!document) {
      throw new Error('Document not found');
    }

    const versions = await prisma.document.findMany({
      where: { parentId: documentId }
    });

    return {
      current: document,
      versions,
      approvals: document.approvals,
      signatureRequests: document.signatureRequests,
      activity: await this.getDocumentActivity(documentId)
    };
  }

  /**
   * Store file (mock implementation)
   */
  private async storeFile(file: Uint8Array, fileName: string): Promise<string> {
    // In production, this would upload to GCS, S3, etc.
    const fileId = crypto.randomUUID();
    return `https://storage.reservatior.com/documents/${fileId}/${fileName}`;
  }

  /**
   * Process OCR on document
   */
  private async processOCR(file: Uint8Array, mimeType: string): Promise<Record<string, any> | null> {
    // In production, integrate with OCR service (Google Vision, Tesseract, etc.)
    try {
      // Mock OCR data
      return {
        text: 'Extracted text from document',
        confidence: 0.95,
        pages: 1
      };
    } catch (error) {
      console.error('OCR processing failed:', error);
      return null;
    }
  }

  /**
   * Generate AI summary
   */
  private async generateAISummary(document: Document): Promise<string | null> {
    try {
      const prompt = `
        Summarize this document:
        Title: ${document.title}
        Type: ${document.documentType}
        Description: ${document.description || 'N/A'}
        OCR Data: ${JSON.stringify(document.ocrData)}
        
        Provide a concise summary (max 200 words) highlighting key points, dates, amounts, and action items.
      `;

      const summary = await GeminiService.processHubSearch(prompt, { role: 'ADMIN' });
      return summary;
    } catch (error) {
      console.error('AI summary generation failed:', error);
      return null;
    }
  }

  /**
   * Classify document using AI
   */
  private async classifyDocument(document: Document): Promise<{ type: string; tags: string[] } | null> {
    try {
      const prompt = `
        Classify this document:
        Title: ${document.title}
        Type: ${document.documentType}
        Description: ${document.description || 'N/A'}
        
        Suggest:
        1. Document type (contract, invoice, receipt, escrow, property, maintenance, insurance, identity, investment, ai_report)
        2. Relevant tags (3-5 tags)
        
        Return as JSON: { type: string, tags: string[] }
      `;

      const response = await GeminiService.processHubSearch(prompt, { role: 'ADMIN' });
      return JSON.parse(response);
    } catch (error) {
      console.error('Document classification failed:', error);
      return null;
    }
  }

  /**
   * Render template with variables
   */
  private renderTemplate(template: Record<string, any>, variables: Record<string, any>): string {
    // Simple template rendering (would use proper template engine in production)
    let content = JSON.stringify(template);
    
    Object.entries(variables).forEach(([key, value]) => {
      content = content.replace(new RegExp(`{{${key}}}`, 'g'), String(value));
    });

    return content;
  }

  /**
   * Get document activity
   */
  private async getDocumentActivity(documentId: string) {
    // Would query audit logs or activity table
    return [];
  }

  /**
   * Archive document
   */
  async archiveDocument(documentId: string) {
    return prisma.document.update({
      where: { id: documentId },
      data: { status: 'archived' }
    });
  }

  /**
   * Delete document
   */
  async deleteDocument(documentId: string) {
    return prisma.document.delete({
      where: { id: documentId }
    });
  }
}

export const documentOSService = new DocumentOSService();
