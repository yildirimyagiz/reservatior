import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class IncomeCertificateService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.incomeReadyCertificate, "incomeReadyCertificate");
  }

  async issueCertificate(propertyId: string, tier: string, orgId: string) {
    const count = await prisma.incomeReadyCertificate.count();
    const certificateNumber = `IRC-${new Date().getFullYear()}-${String(count + 1).padStart(6, '0')}`;

    const tierFlags: any = {};
    if (tier === "MOVE_IN_READY") tierFlags.moveInReady = true;
    if (tier === "INCOME_READY") { tierFlags.moveInReady = true; tierFlags.incomeReady = true; }
    if (tier === "INVESTMENT_READY") { tierFlags.moveInReady = true; tierFlags.incomeReady = true; tierFlags.investmentReady = true; }

    return prisma.incomeReadyCertificate.create({
      data: {
        orgId,
        propertyId,
        tier: tier as any,
        status: "ISSUED",
        certificateNumber,
        issuedAt: new Date(),
        expiresAt: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000),
        ...tierFlags,
      }
    });
  }

  async verify(certificateNumber: string) {
    const cert = await prisma.incomeReadyCertificate.findUnique({
      where: { certificateNumber }
    });
    if (!cert) return null;
    if (cert.expiresAt && cert.expiresAt < new Date()) {
      return { ...cert, status: "EXPIRED" };
    }
    return cert;
  }

  async upgradeTier(certificateId: string, newTier: string) {
    const updates: any = { tier: newTier };
    if (newTier === "INCOME_READY") { updates.incomeReady = true; updates.incomeReadyAt = new Date(); }
    if (newTier === "INVESTMENT_READY") { updates.investmentReady = true; updates.investmentReadyAt = new Date(); }

    return prisma.incomeReadyCertificate.update({
      where: { id: certificateId },
      data: updates
    });
  }
}

export const incomeCertificateService = new IncomeCertificateService();
