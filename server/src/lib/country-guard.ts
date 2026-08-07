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

export const countryGuardExtension = (region: string) => {
  return Prisma.defineExtension({
    name: `CountryGuard-${region}`,
    query: {
      $allModels: {
        async $allOperations({ model, operation, args, query }) {
          // NOTE (audit §6.D.14): the previous implementation fire-and-forget
          // exported every write payload to Gemini 2.5-flash for "regulatory
          // auditing". That was an unconsented, unbounded data egress (GDPR/KVKK/
          // CCPA exposure) and has been removed. Enforcement is done locally via
          // country-rules.json below — no external service receives write data.

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
