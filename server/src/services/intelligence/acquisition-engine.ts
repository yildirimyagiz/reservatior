import { PropertyInputData, hybridRentalEngine } from "./hybrid-rental-engine";

export interface AcquisitionTarget {
  targetId: string;
  propertyTitle: string;
  neighbourhood: string;
  sizeSqm: number;
  accommodates: number;
  potentialScore: number; // 0 - 100
  estimatedRevenueLiftPct: number; // e.g. +42%
  classicMonthlyRentTRY: number;
  projectedMonthlyRevenueTRY: number;
  outreachChannel: 'WHATSAPP' | 'EMAIL' | 'CRM_CALL_CENTER' | 'RESERVATIOR_DIRECT';
  outreachStatus: 'DISCOVERED' | 'OUTREACH_SENT' | 'ENGAGED' | 'PROPOSAL_ACCEPTED';
  recommendedStrategy: string;
}

export interface AcquisitionScanResult {
  scanId: string;
  scannedCount: number;
  qualifiedTargetsCount: number;
  targets: AcquisitionTarget[];
  scannedAt: string;
}

export class AcquisitionEngine {
  private static instance: AcquisitionEngine;

  public static getInstance(): AcquisitionEngine {
    if (!AcquisitionEngine.instance) {
      AcquisitionEngine.instance = new AcquisitionEngine();
    }
    return AcquisitionEngine.instance;
  }

  public discoverAcquisitionTargets(neighbourhoodFilter?: string): AcquisitionScanResult {
    const mockDiscoveries = [
      { neighbourhood: "Kadıköy", sizeSqm: 85, accommodates: 4, title: "Moda Caferağa 2+1 Lüks Daire" },
      { neighbourhood: "Beyoğlu", sizeSqm: 95, accommodates: 5, title: "Cihangir Tarihi 2+1 Rezidans" },
      { neighbourhood: "Beşiktaş", sizeSqm: 110, accommodates: 6, title: "Levent Metro Yanı 3+1 Executive" },
      { neighbourhood: "Şişli", sizeSqm: 75, accommodates: 3, title: "Nişantaşı Abdi İpekçi 1+1 Lux" },
      { neighbourhood: "Sarıyer", sizeSqm: 140, accommodates: 6, title: "Maslak 1453 3+1 Dubleks" },
      { neighbourhood: "Ataşehir", sizeSqm: 80, accommodates: 4, title: "Finans Merkezi Metropol 2+1" }
    ];

    const targets: AcquisitionTarget[] = mockDiscoveries
      .filter(d => !neighbourhoodFilter || d.neighbourhood.toLowerCase() === neighbourhoodFilter.toLowerCase())
      .map((item, idx) => {
        const evalResult = hybridRentalEngine.evaluateProperty({
          neighbourhood: item.neighbourhood,
          roomType: "Entire home/apt",
          accommodates: item.accommodates,
          bedrooms: 2,
          bathrooms: 1,
          sizeSqm: item.sizeSqm,
          buildingAge: 4,
          isFurnished: true,
          hasElevator: true,
          hasParking: true,
          hasPoolOrGym: false,
          proximityToMetroMins: 5,
          proximityToAirportMins: 30,
          hasBuildingConsent100Pct: true,
          hasTourismResidenceLicense: true,
          hasKabisRegistration: true
        });

        const classicAnnual = evalResult.ownerOffer.classicLongTermAnnualNetTRY;
        const hybridAnnual = evalResult.ownerOffer.hybridEstimatedAnnualRevenueTRY;
        const liftPct = Math.round(((hybridAnnual - classicAnnual) / classicAnnual) * 100);

        const channels: ('WHATSAPP' | 'EMAIL' | 'CRM_CALL_CENTER')[] = ['WHATSAPP', 'EMAIL', 'CRM_CALL_CENTER'];

        return {
          targetId: `TARGET-${1000 + idx}`,
          propertyTitle: item.title,
          neighbourhood: item.neighbourhood,
          sizeSqm: item.sizeSqm,
          accommodates: item.accommodates,
          potentialScore: evalResult.scoreBreakdown.totalScore,
          estimatedRevenueLiftPct: liftPct,
          classicMonthlyRentTRY: evalResult.currentMarketMonthlyRentTRY,
          projectedMonthlyRevenueTRY: Math.round(hybridAnnual / 12),
          outreachChannel: channels[idx % channels.length],
          outreachStatus: idx === 0 ? 'ENGAGED' : idx === 1 ? 'OUTREACH_SENT' : 'DISCOVERED',
          recommendedStrategy: evalResult.recommendedModelLabel
        };
      });

    return {
      scanId: `SCAN-${Math.floor(100000 + Math.random() * 900000)}`,
      scannedCount: 1420,
      qualifiedTargetsCount: targets.length,
      targets,
      scannedAt: new Date().toISOString()
    };
  }
}

export const acquisitionEngine = AcquisitionEngine.getInstance();
