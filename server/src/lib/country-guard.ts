import { Prisma } from '@prisma/client';
import fs from 'fs';
import path from 'path';

let countryRules: { models: Record<string, Record<string, string[]>> } | null = null;

try {
  const rulesPath = path.join(process.cwd(), 'prisma', 'country-rules.json');
  if (fs.existsSync(rulesPath)) {
    countryRules = JSON.parse(fs.readFileSync(rulesPath, 'utf8'));
  } else {
    console.warn('⚠️ PrismaManager: country-rules.json not found. Country-Aware protections are disabled.');
  }
} catch (e) {
  console.error('Error loading country-rules.json:', e);
}

export class CountryGuardError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'CountryGuardError';
  }
}

import { GoogleGenAI } from "@google/genai";

const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY || "" });

async function auditRegulatoryCompliance(model: string, data: any, region: string) {
  try {
    const response = await ai.models.generateContent({
      model: "gemini-2.5-flash",
      contents: `
        You are a global real estate compliance auditor.
        Analyze this database write payload for compliance with local regulations in region: '${region}'.
        
        Model: ${model}
        Write Payload: ${JSON.stringify(data)}
        
        Regulations to verify based on region:
        - EU/DE/FR/ES/IT/NL: GDPR (biometric data, national ids, marketing consent).
        - TR: KVKK and Turkish Tax Law (tax configuration, Turkish billing fields).
        - US: CCPA and Fair Housing Act (discrimination, marketing, privacy).
        
        Determine if there is a compliance violation. Return a JSON object with:
        1. "isViolation": true or false.
        2. "violatedRegulation": Name of regulation violated (e.g. GDPR Art 6, KVKK Madde 5, Fair Housing Act).
        3. "description": Why this is a violation.
        4. "remedy": How to fix this data entry.
        
        Return ONLY valid JSON.
      `
    });

    const text = response.text?.trim() || "{}";
    const cleanJson = text.replace(/```json/g, "").replace(/```/g, "").trim();
    const analysis = JSON.parse(cleanJson);

    if (analysis.isViolation) {
      console.warn(`🚨 [Compliance Guard] REGULATORY BREACH DETECTED on ${model} in ${region}: ${analysis.description}`);
      const { EventDispatcher } = await import("../core/events/event-dispatcher");
      EventDispatcher.emit("COMPLIANCE_ALERT", {
        model,
        region,
        violatedRegulation: analysis.violatedRegulation,
        description: analysis.description,
        remedy: analysis.remedy,
        timestamp: new Date()
      }).catch(err => console.error("Failed to emit compliance alert:", err));
    }
  } catch (err) {
    console.error("Gemini Compliance Auditing failed:", err);
  }
}

export const countryGuardExtension = (region: string) => {
  return Prisma.defineExtension({
    name: `CountryGuard-${region}`,
    query: {
      $allModels: {
        async $allOperations({ model, operation, args, query }) {
          // Asynchronously trigger AI compliance audit for writes
          if (['create', 'update', 'upsert', 'createMany'].includes(operation) && (args as any).data) {
            auditRegulatoryCompliance(model, (args as any).data, region).catch(e => 
              console.error("[CountryGuard] Async audit error:", e)
            );
          }

          if (!countryRules) {
            return query(args);
          }

          const restrictedFields = countryRules.models[model];
          if (!restrictedFields) {
            return query(args);
          }

          // Check write operations
          if (['create', 'update', 'upsert', 'createMany'].includes(operation)) {
            const dataToInspect: any[] = [];
            
            if (operation === 'create' || operation === 'update') {
              if (args.data) dataToInspect.push(args.data);
            } else if (operation === 'upsert') {
              if ((args as any).create) dataToInspect.push((args as any).create);
              if ((args as any).update) dataToInspect.push((args as any).update);
            } else if (operation === 'createMany') {
              const data = args.data;
              if (Array.isArray(data)) {
                dataToInspect.push(...data);
              } else if (data) {
                dataToInspect.push(data);
              }
            }

            // Inspect keys recursively to find any forbidden keys
            const checkData = (data: any, pathStr: string = '') => {
              if (!data || typeof data !== 'object') return;

              for (const [key, value] of Object.entries(data)) {
                // If it's a field in the model, check restriction
                const allowedCountries = restrictedFields[key];
                if (allowedCountries && !allowedCountries.includes(region)) {
                  throw new CountryGuardError(
                    `[Country Guard] Rejected write to '${model}.${key}' on region '${region}'. This field is restricted to: ${allowedCountries.join(', ')}.`
                  );
                }
                
                // Don't traverse nested relations right now to keep it fast,
                // but ideally relation creations should also be checked.
                // For nested creates, Prisma wraps them in `create: {}`, we can recursively check if needed.
              }
            };

            for (const item of dataToInspect) {
              checkData(item);
            }
          }

          // Optionally, we could filter out restricted fields from `select` queries here,
          // but preventing writes is the primary security goal.

          return query(args);
        },
      },
    },
  });
};
