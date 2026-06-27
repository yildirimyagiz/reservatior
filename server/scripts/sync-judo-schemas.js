const fs = require('fs');
const path = require('path');

const prismaDir = path.join(__dirname, '../prisma');
const files = fs.readdirSync(prismaDir).filter(f => f.startsWith('schema_') && f.endsWith('.prisma') && f !== 'schema.prisma');

const MODELS_TO_APPEND = `
model VrpMandate {
  id                String       @id @default(cuid())
  orgId             String
  tenantId          String
  leaseId           String?      @unique
  bankId            String       // Hangi banka üzerinden yetki verildi (örn: garanti_bbva)
  consentId         String       // PSD2 Consent ID
  status            MandateStatus @default(PENDING) // PENDING, ACTIVE, REVOKED, EXPIRED
  maxAmountPerMonth Decimal      @db.Decimal(14, 2) // Maksimum çekilebilecek ceza/kira limiti
  currency          String       @default("TRY")
  validUntil        DateTime
  lastUsedAt        DateTime?
  createdAt         DateTime     @default(now())
  updatedAt         DateTime     @updatedAt

  tenant            Tenant       @relation(fields: [tenantId], references: [id])
  lease             Lease?       @relation(fields: [leaseId], references: [id])
  org               Organization @relation(fields: [orgId], references: [id])

  @@index([orgId])
  @@index([tenantId])
  @@index([status])
}

enum MandateStatus {
  PENDING
  ACTIVE
  REVOKED
  EXPIRED
}

model IotAccessLog {
  id                String       @id @default(cuid())
  orgId             String
  smartLockId       String
  leaseId           String?
  action            LockAction   // LOCK, UNLOCK, SUSPEND, RESTORE
  triggerSource     String       // SYSTEM_VRP_FAIL, MANUAL, TENANT_APP
  status            String       // SUCCESS, FAILED
  reason            String?      // "VRP tahsilatı yapılamadı, EVICTION_PENDING devreye girdi"
  createdAt         DateTime     @default(now())

  smartLock         SmartLock    @relation(fields: [smartLockId], references: [id])
  lease             Lease?       @relation(fields: [leaseId], references: [id])
  org               Organization @relation(fields: [orgId], references: [id])

  @@index([smartLockId])
  @@index([leaseId])
}

enum LockAction {
  LOCK
  UNLOCK
  SUSPEND
  RESTORE
}

enum LeaseContractType {
  STANDARD_LEASE
  MASTER_LEASE
  SUBSCRIPTION
}
`;

const LEASE_FIELDS = `
  // PROPTECH & FINTECH HUKUK DIŞI TAHLİYE SİSTEMİ (GOD-TIER)
  contractType              LeaseContractType          @default(STANDARD_LEASE)
  isUtilityManaged          Boolean                    @default(false) // Elektrik, Su, İnternet platform üzerinde mi?
  smartLockId               String?                    // IoT Akıllı kilit entegrasyonu (Tahliye için erişim engeli)
  autoEvictionEnabled       Boolean                    @default(false) // Sözleşme bittiğinde otomatik kısıtlamaları aç
  vrpPenaltyRate            Decimal?                   @db.Decimal(5, 2) // Sözleşme bitiminde hesaptan çekilecek ceza katsayısı (Örn: 3.00x)
  evictionUndertakingDate   DateTime?                  // Tahliye Taahhütnamesi tarihi (Göç idaresi ve hukuk kalkanı)

  vrpMandate                VrpMandate?
  iotAccessLogs             IotAccessLog[]
`;

let updatedCount = 0;

for (const file of files) {
  const filePath = path.join(prismaDir, file);
  let content = fs.readFileSync(filePath, 'utf-8');

  if (content.includes('model VrpMandate')) {
    console.log("Skipping " + file + " (already updated)");
    continue;
  }

  // 1. Update model Lease
  const leaseRegex = /(model Lease \{[\s\S]*?deletedAt\s+DateTime\?)/;
  if (leaseRegex.test(content)) {
    content = content.replace(leaseRegex, "$1\n" + LEASE_FIELDS);
  }

  // 2. Update model Tenant
  const tenantRegex = /(model Tenant \{[\s\S]*?Lease\s+Lease\[\])/;
  if (tenantRegex.test(content)) {
    content = content.replace(tenantRegex, "$1\n  vrpMandates          VrpMandate[]");
  }

  // 3. Update model Organization
  const orgRegex = /(model Organization \{[\s\S]*?smartLocks\s+SmartLock\[\])/;
  if (orgRegex.test(content)) {
    content = content.replace(orgRegex, "$1\n  vrpMandates                VrpMandate[]\n  iotAccessLogs              IotAccessLog[]");
  }

  // 4. Update model SmartLock
  const smartLockRegex = /(model SmartLock \{[\s\S]*?accessCodes\s+AccessCode\[\])/;
  if (smartLockRegex.test(content)) {
    content = content.replace(smartLockRegex, "$1\n  iotAccessLogs   IotAccessLog[]");
  }

  // 5. Append models
  content += '\n' + MODELS_TO_APPEND;

  fs.writeFileSync(filePath, content, 'utf-8');
  updatedCount++;
  console.log("Updated " + file);
}

console.log("\\nDone! Successfully injected Judo strategy models to " + updatedCount + " schema files.");
