import { prisma } from "../lib/prisma";

interface IssueReport {
  orgId: string;
  bookingId: string;
  propertyId: string;
  issueType: string;
  description: string;
  reportedBy: string;
}

export class CompensationEngine {
  static readonly COMPENSATION_TABLE: Record<string, number> = {
    cleanliness: 75,
    damage: 150,
    amenities: 50,
    odor: 60,
    pest: 200,
  };

  static async processIssue(report: IssueReport) {
    const amount = this.COMPENSATION_TABLE[report.issueType] || 75;

    const compensation = await prisma.financialRecord.create({
      data: {
        orgId: report.orgId,
        propertyId: report.propertyId,
        bookingId: report.bookingId,
        type: "COMPENSATION",
        amount,
        currency: "USD",
        description: `Auto-compensation for ${report.issueType}: ${report.description}`,
        category: "guest_compensation",
        paymentStatus: "UNPAID",
      },
    });

    const cleaningTask = await prisma.task.create({
      data: {
        orgId: report.orgId,
        title: `Re-cleaning: ${report.issueType} issue`,
        description: `Auto-dispatched after guest complaint: ${report.description}`,
        status: "OPEN",
        priority: "HIGH",
        propertyId: report.propertyId,
        bookingId: report.bookingId,
        createdBy: report.reportedBy,
      },
    });

    return { compensation, cleaningTask };
  }

  static async getCompensationHistory(orgId: string) {
    return prisma.financialRecord.findMany({
      where: { orgId, type: "COMPENSATION" },
      orderBy: { createdAt: "desc" },
      take: 20,
    });
  }
}
