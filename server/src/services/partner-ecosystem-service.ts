import { prisma } from "../lib/prisma";

export class PartnerEcosystemService {
  async getDashboard(orgId: string) {
    const [totalPartners, activeAgreements, topVendors, pendingAgreements, totalRevenue] = await Promise.all([
      prisma.vendorProfile.count({ where: { orgId } }),
      prisma.partnerAgreement.count({ where: { status: "ACTIVE" } }),
      prisma.vendorProfile.findMany({ where: { orgId }, orderBy: { createdAt: "desc" }, take: 5 }),
      prisma.partnerAgreement.count({ where: { status: "PENDING" } }),
      prisma.partnershipEarning.aggregate({ _sum: { amount: true } }),
    ]);
    return { totalPartners, activeAgreements, topVendors, pendingAgreements, totalRevenue: totalRevenue._sum.amount ?? 0 };
  }

  async getPartnersByOrg(orgId: string, params?: { skip?: number; take?: number }) {
    return prisma.vendorProfile.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getAgreements(params?: { skip?: number; take?: number; status?: string }) {
    return prisma.partnerAgreement.findMany({
      where: { ...(params?.status && { status: params.status }) },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getAgreementStats() {
    const [total, byStatus] = await Promise.all([
      prisma.partnerAgreement.count(),
      prisma.partnerAgreement.groupBy({ by: ["status"], _count: { id: true } }),
    ]);
    return { total, byStatus: byStatus.map(s => ({ status: s.status, count: s._count.id })) };
  }

  async getSuppliers(params?: { skip?: number; take?: number }) {
    return prisma.supplier.findMany({
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getVendorReviews(orgId: string) {
    return prisma.vendorQualityReview.findMany({
      where: { vendor: { orgId } },
      orderBy: { createdAt: "desc" },
      take: 50,
    });
  }

  async createPartner(data: { orgId: string; legalName: string; serviceAreas?: string; defaultCommissionBps?: number }) {
    return prisma.vendorProfile.create({
      data: {
        ...data,
        serviceAreas: data.serviceAreas ?? "[]",
        defaultCommissionBps: data.defaultCommissionBps ?? 250,
        createdAt: new Date(),
      },
    });
  }

  async createAgreement(data: { partnerId: string; type: string; terms?: any }) {
    return prisma.partnerAgreement.create({
      data: {
        partnerId: data.partnerId,
        type: data.type,
        terms: data.terms ?? {},
        status: "CREATED",
        createdAt: new Date(),
      },
    });
  }
}

export const partnerEcosystemService = new PartnerEcosystemService();
