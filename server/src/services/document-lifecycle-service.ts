import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class DocumentLifecycleService {
  async getDashboard(orgId: string) {
    const [totalDocuments, activeContracts, pendingSignatures, templates, recentActivity] = await Promise.all([
      prisma.document.count({ where: { orgId } }),
      prisma.contract.count({ where: { status: "ACTIVE" } }),
      prisma.signatureRequest.count({ where: { status: "PENDING" } }),
      prisma.documentTemplate.count({ where: { isActive: true } }),
      prisma.document.findMany({ where: { orgId }, orderBy: { createdAt: "desc" }, take: 10 }),
    ]);
    return { totalDocuments, activeContracts, pendingSignatures, templates, recentActivity };
  }

  async getDocuments(orgId: string, params?: { skip?: number; take?: number; documentType?: string }) {
    return prisma.document.findMany({
      where: {
        orgId,
        ...(params?.documentType && { documentType: params.documentType }),
      },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getDocumentStats(orgId: string) {
    const [total, byType, withAnalysis] = await Promise.all([
      prisma.document.count({ where: { orgId } }),
      prisma.document.groupBy({ by: ["documentType"], where: { orgId }, _count: { id: true } }),
      prisma.document.count({ where: { orgId, hasAnalysis: true } }),
    ]);
    return { total, withAnalysis, byType: byType.map(t => ({ type: t.documentType, count: t._count.id })) };
  }

  async getContracts(orgId: string, params?: { skip?: number; take?: number; status?: string }) {
    return prisma.contract.findMany({
      where: {
        orgId,
        ...(params?.status && { status: params.status }),
      },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getContractStats() {
    const [total, byStatus] = await Promise.all([
      prisma.contract.count(),
      prisma.contract.groupBy({ by: ["status"], _count: { id: true } }),
    ]);
    return { total, byStatus: byStatus.map(s => ({ status: s.status, count: s._count.id })) };
  }

  async getContractVersions(contractId: string) {
    return prisma.contractVersion.findMany({
      where: { contractId },
      orderBy: { createdAt: "desc" },
    });
  }

  async getSignatureRequests(orgId: string) {
    return prisma.signatureRequest.findMany({
      orderBy: { createdAt: "desc" },
      take: 50,
    });
  }

  async getSignatureStats() {
    const [total, byStatus] = await Promise.all([
      prisma.signatureRequest.count(),
      prisma.signatureRequest.groupBy({ by: ["status"], _count: { id: true } }),
    ]);
    return { total, byStatus: byStatus.map(s => ({ status: s.status, count: s._count.id })) };
  }

  async getTemplates() {
    return prisma.documentTemplate.findMany({
      where: { isActive: true },
      orderBy: { createdAt: "desc" },
    });
  }

  async createDocument(data: { orgId: string; documentType: string; fileUrl?: string; name?: string; metadata?: any }) {
    const result = await prisma.document.create({
      data: {
        orgId: data.orgId,
        documentType: data.documentType,
        fileUrl: data.fileUrl ?? "",
        name: data.name ?? "Untitled",
        metadata: data.metadata ?? {},
        createdAt: new Date(),
      },
    });
    await eventBus.publish({
      type: DomainEvents.DOCUMENT_UPLOADED,
      payload: { id: result.id, documentType: data.documentType },
      source: "DocumentOS",
    });
    return result;
  }

  async createContract(data: { orgId: string; type: string; title?: string; documentUrl?: string }) {
    const result = await prisma.contract.create({
      data: {
        orgId: data.orgId,
        type: data.type,
        title: data.title ?? "New Contract",
        status: "DRAFT",
        documentUrl: data.documentUrl ?? "",
        createdAt: new Date(),
      },
    });
    await eventBus.publish({
      type: DomainEvents.CONTRACT_CREATED,
      payload: { id: result.id, type: data.type },
      source: "DocumentOS",
    });
    return result;
  }
}

export const documentLifecycleService = new DocumentLifecycleService();
