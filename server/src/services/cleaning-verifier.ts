import { prisma } from "../lib/prisma";

interface PhotoCheckpoint {
  checkpoint: string;
  passed: boolean;
  confidence: number;
  defects: string[];
}

interface AnalysisResult {
  overall_pass: boolean;
  overall_score: number;
  checkpoint_results: PhotoCheckpoint[];
  summary: string;
  suggested_actions: string[];
}

export class CleaningVerifier {
  static async analyzePhotos(
    orgId: string,
    propertyId: string,
    bookingId: string,
    photos: { checkpoint: string; base64: string }[]
  ): Promise<AnalysisResult> {
    const mlUrl = process.env.ML_SERVICE_URL || "http://localhost:8000";
    
    const formData = new FormData();
    for (const photo of photos) {
      const blob = new Blob([Buffer.from(photo.base64, "base64")], { type: "image/jpeg" });
      formData.append("files", blob, `${photo.checkpoint}.jpg`);
    }
    formData.append("property_id", propertyId);
    formData.append("booking_id", bookingId);

    const res = await fetch(`${mlUrl}/api/v1/cleaning/analyze`, {
      method: "POST",
      body: formData,
    });

    if (!res.ok) {
      throw new Error(`ML service error: ${res.statusText}`);
    }

    const analysis: AnalysisResult = await res.json();

    await prisma.propertyCompliance.create({
      data: {
        orgId,
        propertyId,
        type: "CLEANING",
        status: analysis.overall_pass ? "passed" : "failed",
        data: {
          analysis,
          bookingId,
          photoCount: photos.length,
        },
      },
    });

    return analysis;
  }

  static async getLastInspection(propertyId: string) {
    return prisma.propertyCompliance.findFirst({
      where: { propertyId, type: "CLEANING" },
      orderBy: { createdAt: "desc" },
    });
  }
}
