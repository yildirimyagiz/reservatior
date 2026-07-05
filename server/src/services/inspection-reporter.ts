import { prisma } from "../lib/prisma";
import { v4 as uuid } from "uuid";

interface InspectionItem {
  id: string;
  label: string;
  result: "pass" | "fail";
  notes: string;
}

interface InspectionReport {
  propertyId: string;
  agentId: string;
  orgId: string;
  items: InspectionItem[];
  location: { lat: number; lng: number };
  score: number;
}

export class InspectionReporter {
  static async submitReport(report: InspectionReport) {
    const record = await prisma.propertyCompliance.create({
      data: {
        id: uuid(),
        orgId: report.orgId,
        propertyId: report.propertyId,
        type: "INSPECTION",
        status: report.score >= 75 ? "passed" : "failed",
        data: {
          items: report.items,
          location: report.location,
          score: report.score,
          inspectorId: report.agentId,
          inspectedAt: new Date().toISOString(),
        },
      },
    });

    return record;
  }

  static async getRecentInspections(orgId: string, limit = 10) {
    return prisma.propertyCompliance.findMany({
      where: { orgId, type: "INSPECTION" },
      orderBy: { createdAt: "desc" },
      take: limit,
      include: {
        property: { select: { id: true, name: true } },
        inspector: { select: { id: true, name: true } },
      },
    });
  }
}
