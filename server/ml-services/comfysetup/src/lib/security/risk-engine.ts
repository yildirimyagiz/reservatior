import prisma from "@/lib/prisma";
import { RiskEventType } from "@prisma/client";

export enum RiskLevel {
  LOW = "LOW",       // < 20
  MEDIUM = "MEDIUM", // 20-60
  HIGH = "HIGH",     // 60-99
  CRITICAL = "CRITICAL" // 100+
}

import { RiskAnalysisInput, RiskAnalysisResult } from "./types";

interface RiskContext {
  ipAddress?: string;
  fingerprintId?: string;
  email?: string;
  isDisposableEmail?: boolean;
}

export class RiskEngine {
  
  static async analyze(input: RiskAnalysisInput): Promise<RiskAnalysisResult> {
    // 1. Basic Checks
    const factors: string[] = [];
    let score = 0;

    // Check disposable email (Mock)
    if (input.email.endsWith("@tempmail.com")) {
        score += 100;
        factors.push("DISPOSABLE_EMAIL");
    }

    // Check Fingerprint Reuse
    if (input.fingerprintId) {
        const reuseCount = await prisma.user.count({
            where: {
                fingerprints: {
                    some: { visitorId: input.fingerprintId }
                }
            }
        });
        if (reuseCount > 0) {
            score += 40 * reuseCount;
            factors.push("FINGERPRINT_REUSE");
        }
    }

    // Check IP
    // (Simplified logic re-using existing logic concept)
    
    // Determine Level & Action
    const level = this.getRiskLevel(score);
    let action: RiskAnalysisResult["action"] = "ALLOW";
    
    if (level === "CRITICAL") action = "BLOCK";
    else if (level === "HIGH") action = "CHALLENGE_PAYMENT";
    else if (level === "MEDIUM") action = "CHALLENGE_CAPTCHA";

    return {
        score,
        level,
        action,
        factors
    };
  }

  static async logEvent(userId: string | null, type: string, score: number, details: { ip?: string; fingerprintId?: string; [key: string]: unknown }) {
    // Log to DB
    await prisma.riskEvent.create({
        data: {
            userId,
            type: type as RiskEventType,
            severity: this.getRiskLevel(score),
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            details: details as any,
            ipAddress: details.ip,
            fingerprintId: details.fingerprintId
        }
    });
  }

  static async calculateRiskScore(userId: string, context: RiskContext): Promise<{score: number, level: RiskLevel}> {
    let score = 0;
    
    // 1. Email Check
    if (context.isDisposableEmail) {
      score += 100; // Immediate block
    }
    
    // 2. Fingerprint Reuse
    if (context.fingerprintId) {
      const reuseCount = await prisma.user.count({
        where: {
          fingerprints: {
            some: {
              visitorId: context.fingerprintId,
              userId: {
                not: userId 
              }
            }
          }
        }
      });
      
      if (reuseCount > 0) {
        score += 40 * reuseCount;
      }
    }
    
    // 3. IP History Check
    if (context.ipAddress) {
      // Check if IP has been used by other users recently
      const ipUsage = await prisma.userIpHistory.count({
        where: {
          ipAddress: context.ipAddress,
          userId: {
            not: userId
          },
          createdAt: {
            gte: new Date(Date.now() - 24 * 60 * 60 * 1000) // Last 24h
          }
        }
      });
      
      if (ipUsage > 2) score += 30; // 3+ users same IP in 24h
      if (ipUsage > 5) score += 60;
    }

    // 4. Persistence
    await prisma.trialProfile.update({
      where: { userId },
      data: {
        riskScore: score,
        riskLevel: this.getRiskLevel(score)
      }
    });

    return {
      score,
      level: this.getRiskLevel(score)
    };
  }

  static getRiskLevel(score: number): RiskLevel {
    if (score < 20) return RiskLevel.LOW;
    if (score <= 60) return RiskLevel.MEDIUM;
    if (score < 100) return RiskLevel.HIGH;
    return RiskLevel.CRITICAL;
  }
}
