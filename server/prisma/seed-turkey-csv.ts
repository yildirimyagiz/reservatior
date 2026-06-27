import { PrismaClient, MemberRoleKey, PermissionKey } from "@prisma/client";
import * as fs from "fs";
import * as path from "path";

const prisma = new PrismaClient();
const ORG_ID = "tr_residence_org";

const DATA_DIR = process.env.SEED_DATA_DIR || "/app/data/TURKİYE/ISTANBUL/SİSLİ";

function detectDelimiter(line: string): string {
  const semicolons = (line.match(/;/g) || []).length;
  const commas = (line.match(/,/g) || []).length;
  return semicolons >= commas ? ";" : ",";
}

function parseCSV(filePath: string): string[][] {
  const raw = fs.readFileSync(filePath, "utf8");
  const lines = raw.replace(/\r/g, "").split("\n").filter(Boolean);
  const delim = detectDelimiter(lines[0] || "");
  return lines.map((l) => {
    const row: string[] = [];
    let current = "";
    let inQuotes = false;
    for (const ch of l) {
      if (ch === '"') { inQuotes = !inQuotes; continue; }
      if (ch === delim && !inQuotes) { row.push(current.trim()); current = ""; continue; }
      current += ch;
    }
    row.push(current.trim());
    return row;
  });
}

function cleanPhone(phone: string): string {
  return phone.replace(/[^\d+]/g, "").trim();
}

function extractUnitNumber(block: string, row: string[]): string {
  const kat = row[0]?.trim().replace(/^0+/, "") || "0";
  const no = row[1]?.trim() || "0";
  return `${block}${kat.padStart(2, "0")}${no.padStart(2, "0")}`;
}

async function main() {
  console.log("🌱 TURKEY CSV SEED STARTING...\n");

  // ════════════════════════════════════════════════════════
  // 1. ADMIN USER
  // ════════════════════════════════════════════════════════
  console.log("📋 Creating admin user...");
  const adminPasswordHash = await Bun.password.hash("Parola341", { algorithm: "bcrypt", cost: 10 });
  const adminEmail = "info@reservatior.com";

  let adminUser = await prisma.user.findUnique({ where: { email: adminEmail } });
  if (!adminUser) {
    adminUser = await prisma.user.create({
      data: {
        email: adminEmail,
        name: "Reservatior Admin",
        originRegion: "TR",
      },
    });
    await prisma.account.create({
      data: {
        userId: adminUser.id,
        type: "CREDENTIALS" as any,
        providerId: "credentials",
        accountId: adminEmail,
        accessToken: adminPasswordHash,
      },
    });
    console.log("  ✅ Admin user created: info@reservatior.com / Parola341");
  } else {
    console.log("  ℹ️ Admin user already exists");
  }

  // ════════════════════════════════════════════════════════
  // 2. ORGANIZATION
  // ════════════════════════════════════════════════════════
  console.log("\n📋 Creating organization...");
  const org = await prisma.organization.upsert({
    where: { id: ORG_ID },
    update: {},
    create: {
      id: ORG_ID,
      name: "Reservatior Turkey - Premium Residences",
      type: "AGENCY" as any,
      region: "TR" as any,
      defaultCurrency: "TRY",
      defaultLocale: "tr-TR",
      contactEmail: "tr@reservatior.com",
      address: "Büyükdere Cad. No:199, Levent, Istanbul 34394",
      taxReportingEnabled: true,
      complianceTracking: true,
    },
  });
  console.log(`  ✅ Organization: ${org.id}`);

  // ════════════════════════════════════════════════════════
  // 3. ROLES + PERMISSIONS
  // ════════════════════════════════════════════════════════
  console.log("\n📋 Seeding roles & permissions...");

  const allPermissions = Object.values(PermissionKey);
  const permissionMap = new Map<string, string>();

  for (const permKey of allPermissions) {
    const perm = await prisma.permission.upsert({
      where: { key: permKey },
      update: {},
      create: { key: permKey, name: permKey.replace(/_/g, " ").toLowerCase() },
    });
    permissionMap.set(permKey, perm.id);
  }

  const roleKeys = [
    MemberRoleKey.OWNER,
    MemberRoleKey.ORG_ADMIN,
    MemberRoleKey.AGENCY_ADMIN,
    MemberRoleKey.AGENT,
    MemberRoleKey.VENDOR_MANAGER,
    MemberRoleKey.ACCOUNTANT,
    MemberRoleKey.MAINTENANCE,
    MemberRoleKey.TENANT_GUEST,
    MemberRoleKey.READ_ONLY,
  ];

  for (const roleKey of roleKeys) {
    const role = await prisma.role.upsert({
      where: { orgId_key: { orgId: org.id, key: roleKey } },
      update: {},
      create: {
        orgId: org.id,
        key: roleKey,
        name: roleKey.charAt(0) + roleKey.slice(1).toLowerCase().replace(/_/g, " "),
      },
    });

    if (roleKey === MemberRoleKey.OWNER || roleKey === MemberRoleKey.ORG_ADMIN) {
      for (const permKey of allPermissions) {
        const permId = permissionMap.get(permKey);
        if (permId) {
          await prisma.rolePermission.upsert({
            where: { roleId_permissionId: { roleId: role.id, permissionId: permId } },
            update: {},
            create: { roleId: role.id, permissionId: permId },
          });
        }
      }
    }
  }

  // Admin -> Owner role
  const ownerRole = await prisma.role.findFirst({
    where: { orgId: org.id, key: MemberRoleKey.OWNER },
  });
  if (ownerRole) {
    await prisma.organizationMember.upsert({
      where: { userId_orgId: { userId: adminUser.id, orgId: org.id } },
      update: { roleId: ownerRole.id },
      create: { userId: adminUser.id, orgId: org.id, roleId: ownerRole.id },
    });
  }
  console.log("  ✅ Roles, permissions, and admin membership created");

  // ════════════════════════════════════════════════════════
  // 4. PROJECTS
  // ════════════════════════════════════════════════════════
  console.log("\n📋 Creating projects...");

  const anthillProject = await prisma.project.upsert({
    where: { id: "project-anthill-residence" },
    update: {},
    create: {
      id: "project-anthill-residence",
      name: "Anthill Residence",
      description: "Luxury twin towers in Bomonti, Istanbul with 880 units.",
      projectType: "RESIDENTIAL_COMPLEX",
      status: "COMPLETED",
      orgId: org.id,
    },
  });

  const queenProject = await prisma.project.upsert({
    where: { id: "project-queen-bomonti" },
    update: {},
    create: {
      id: "project-queen-bomonti",
      name: "Sinpaş Queen Bomonti",
      description: "Sinpaş Queen Bomonti residence and commercial units.",
      projectType: "RESIDENTIAL_COMPLEX",
      status: "COMPLETED",
      orgId: org.id,
    },
  });

  const rotanaProject = await prisma.project.upsert({
    where: { id: "project-rotana-bomonti" },
    update: {},
    create: {
      id: "project-rotana-bomonti",
      name: "Bomonti Residences By Rotana",
      description: "Bomonti Residences by Rotana hotel-branded residences.",
      projectType: "RESIDENTIAL_COMPLEX",
      status: "COMPLETED",
      orgId: org.id,
    },
  });
  console.log("  ✅ 3 projects created");

  // ════════════════════════════════════════════════════════
  // 5. ANTHILL A BLOCK
  // ════════════════════════════════════════════════════════
  console.log("\n📋 Seeding Anthill A Block...");
  const anthillAPath = path.join(DATA_DIR, "CUMHURİYET MAH", "ANTHİLL", "A Blok Anthill Haziran 2018.csv");
  const anthillAData = parseCSV(anthillAPath);

  let aCount = 0;
  let aContactCount = 0;
  for (let i = 1; i < anthillAData.length; i++) {
    const row = anthillAData[i];
    if (row.length < 2) continue;
    const unitNumber = extractUnitNumber("A", row);
    const areaStr = row[2]?.replace(",", ".") || "";
    const area = areaStr ? parseFloat(areaStr) : null;
    const ownerName = row[3] || null;
    const ownerEmail = row[4] || null;
    const status = row[5] || null;
    const ownerPhone = cleanPhone(row[6] || "");
    const date = row[8] || null;
    const tenantName = row[9] || null;
    const tenantPhone = cleanPhone(row[10] || "");

    const propertyId = `property-anthill-${unitNumber}`;
    const propertyExists = await prisma.property.findUnique({ where: { id: propertyId } });
    if (!propertyExists) {
      await prisma.property.create({
        data: {
          id: propertyId,
          orgId: org.id,
          name: `Anthill Residence ${unitNumber}`,
          type: "APARTMENT" as any,
          region: "TR" as any,
          currency: "TRY",
          addressLine1: "Bomonti, Şişli",
          city: "Istanbul",
          country: "Turkey",
          areaSqm: area,
          notes: ownerName ? `Owner: ${ownerName}${status ? ` (${status})` : ""}${date ? ` | Since: ${date}` : ""}` : null,
          propertyCategory: "RESIDENTIAL" as any,
          listingType: "SALE" as any,
          listingStatus: ownerName ? "RENTED" as any : "AVAILABLE" as any,
          bedrooms: area && area >= 110 ? 3 : area && area >= 98 ? 2 : 1,
          bathrooms: area && area >= 110 ? 2 : 1,
        },
      });
      aCount++;

      if (ownerName) {
        await prisma.contact.upsert({
          where: { id: `contact-anthill-${unitNumber}-owner` },
          update: {},
          create: {
            id: `contact-anthill-${unitNumber}-owner`,
            orgId: org.id,
            type: "OWNER_CONTACT" as any,
            fullName: ownerName,
            email: ownerEmail || undefined,
            phone: ownerPhone || undefined,
          },
        });
        aContactCount++;
      }

      if (tenantName) {
        await prisma.contact.upsert({
          where: { id: `contact-anthill-${unitNumber}-tenant` },
          update: {},
          create: {
            id: `contact-anthill-${unitNumber}-tenant`,
            orgId: org.id,
            type: "TENANT" as any,
            fullName: tenantName,
            phone: tenantPhone || undefined,
          },
        });
      }
    }
  }
  console.log(`  ✅ Anthill A: ${aCount} properties, ${aContactCount} contacts`);

  // ════════════════════════════════════════════════════════
  // 6. ANTHILL B BLOCK
  // ════════════════════════════════════════════════════════
  console.log("\n📋 Seeding Anthill B Block...");
  const anthillBPath = path.join(DATA_DIR, "CUMHURİYET MAH", "ANTHİLL", "B Blok Güncel Düzenlenmiş.csv");
  const anthillBData = parseCSV(anthillBPath);

  let bCount = 0;
  let bContactCount = 0;
  for (let i = 1; i < anthillBData.length; i++) {
    const row = anthillBData[i];
    if (row.length < 2) continue;
    const unitNumber = extractUnitNumber("B", row);
    const areaStr = row[2]?.replace(",", ".") || "";
    const area = areaStr ? parseFloat(areaStr) : null;
    const ownerName = row[3] || null;
    const ownerPhone = cleanPhone(row[4] || "");
    const ownerEmail = row[5] || null;
    const status = row[6] || null;
    const tenantName = row[7] || null;
    const date = row[8] || null;
    const tenantPhone = cleanPhone(row[9] || "");

    const propertyId = `property-anthill-${unitNumber}`;
    const propertyExists = await prisma.property.findUnique({ where: { id: propertyId } });
    if (!propertyExists) {
      await prisma.property.create({
        data: {
          id: propertyId,
          orgId: org.id,
          name: `Anthill Residence ${unitNumber}`,
          type: "APARTMENT" as any,
          region: "TR" as any,
          currency: "TRY",
          addressLine1: "Bomonti, Şişli",
          city: "Istanbul",
          country: "Turkey",
          areaSqm: area,
          notes: ownerName ? `Owner: ${ownerName}${status ? ` (${status})` : ""}${date ? ` | Since: ${date}` : ""}` : null,
          propertyCategory: "RESIDENTIAL" as any,
          listingType: "SALE" as any,
          listingStatus: ownerName ? "RENTED" as any : "AVAILABLE" as any,
          bedrooms: area && area >= 110 ? 3 : area && area >= 98 ? 2 : 1,
          bathrooms: area && area >= 110 ? 2 : 1,
        },
      });
      bCount++;

      if (ownerName) {
        await prisma.contact.upsert({
          where: { id: `contact-anthill-${unitNumber}-owner` },
          update: {},
          create: {
            id: `contact-anthill-${unitNumber}-owner`,
            orgId: org.id,
            type: "OWNER_CONTACT" as any,
            fullName: ownerName,
            email: ownerEmail || undefined,
            phone: ownerPhone || undefined,
          },
        });
        bContactCount++;
      }

      if (tenantName) {
        await prisma.contact.upsert({
          where: { id: `contact-anthill-${unitNumber}-tenant` },
          update: {},
          create: {
            id: `contact-anthill-${unitNumber}-tenant`,
            orgId: org.id,
            type: "TENANT" as any,
            fullName: tenantName,
            phone: tenantPhone || undefined,
          },
        });
      }
    }
  }
  console.log(`  ✅ Anthill B: ${bCount} properties, ${bContactCount} contacts`);

  // ════════════════════════════════════════════════════════
  // 7. QUEEN
  // ════════════════════════════════════════════════════════
  console.log("\n📋 Seeding Queen Bomonti...");
  const queenPath = path.join(DATA_DIR, "CUMHURİYET MAH", "Queen", "queen_units.csv");
  const queenData = parseCSV(queenPath);

  let qCount = 0;
  for (let i = 1; i < queenData.length; i++) {
    const row = queenData[i];
    if (row.length < 3) continue;
    const bbNo = row[0]?.trim() || "";
    const tip = row[1]?.trim() || "";
    const floor = row[3]?.trim() || "";
    const areaStr = row[4]?.replace(",", ".") || "";
    const area = areaStr ? parseFloat(areaStr) : null;
    const unitType = row[5]?.trim() || "";
    const ownerName = row[7]?.trim() || null;

    if (tip !== "KONUT") continue;

    const unitId = `QUEEN-${bbNo.padStart(4, "0")}`;
    const propertyId = `property-queen-${unitId}`;
    const propertyExists = await prisma.property.findUnique({ where: { id: propertyId } });
    if (!propertyExists) {
      const bedroomMap: Record<string, number> = { "1+0": 0, "1+1": 1, "2+1": 2, "3+1": 3, "4+1": 4 };
      const beds = bedroomMap[unitType] ?? 1;

      await prisma.property.create({
        data: {
          id: propertyId,
          orgId: org.id,
          name: `Queen Bomonti ${unitId} (${unitType || "Unknown"})`,
          type: "APARTMENT" as any,
          region: "TR" as any,
          currency: "TRY",
          addressLine1: `Bomonti, Şişli - Unit ${bbNo}`,
          city: "Istanbul",
          country: "Turkey",
          areaSqm: area,
          notes: ownerName ? `Owner: ${ownerName}` : null,
          propertyCategory: "RESIDENTIAL" as any,
          listingType: "SALE" as any,
          listingStatus: ownerName ? "RENTED" as any : "AVAILABLE" as any,
          bedrooms: beds,
          bathrooms: beds > 1 ? 2 : 1,
        },
      });
      qCount++;

      if (ownerName) {
        await prisma.contact.upsert({
          where: { id: `contact-queen-${bbNo}-owner` },
          update: {},
          create: {
            id: `contact-queen-${bbNo}-owner`,
            orgId: org.id,
            type: "OWNER_CONTACT" as any,
            fullName: ownerName,
          },
        });
      }
    }
  }
  console.log(`  ✅ Queen: ${qCount} properties`);

  // ════════════════════════════════════════════════════════
  // 8. ROTANA BOMONTI
  // ════════════════════════════════════════════════════════
  console.log("\n📋 Seeding Rotana Bomonti...");
  const rotanaPath = path.join(DATA_DIR, "Merkez Mahallesi", "Bomonti Residences By Rotana", "ROTANA-BOMONTİ son (1) 2.csv");
  const rotanaData = parseCSV(rotanaPath);

  let rCount = 0;
  for (let i = 1; i < rotanaData.length; i++) {
    const row = rotanaData[i];
    if (row.length < 4) continue;

    const doorNo = row[3]?.trim() || "";
    const usage = row[4]?.trim() || "";
    const customerName = row[5]?.trim() || "";
    const taxId = row[6]?.trim() || "";
    const address = row[7]?.trim() || "";
    const phone1 = cleanPhone(row[10] || "");
    const phone2 = cleanPhone(row[11] || "");
    const email = row[12]?.trim() || "";

    if (usage !== "DAİRE" && usage !== "DUBLEKS DAİRE") continue;

    const unitId = `ROT-${doorNo.padStart(4, "0")}`;
    const propertyId = `property-rotana-${unitId}`;
    const propertyExists = await prisma.property.findUnique({ where: { id: propertyId } });
    if (!propertyExists) {
      await prisma.property.create({
        data: {
          id: propertyId,
          orgId: org.id,
          name: `Rotana Bomonti ${unitId}`,
          type: "APARTMENT" as any,
          region: "TR" as any,
          currency: "TRY",
          addressLine1: `Merkez Mahallesi, Şişli - No: ${doorNo}`,
          city: "Istanbul",
          country: "Turkey",
          notes: customerName ? `Customer: ${customerName}${taxId ? ` | Tax: ${taxId}` : ""}` : null,
          propertyCategory: "RESIDENTIAL" as any,
          listingType: "SALE" as any,
          listingStatus: customerName ? "RENTED" as any : "AVAILABLE" as any,
          bedrooms: 2,
          bathrooms: 1,
        },
      });
      rCount++;

      if (customerName) {
        await prisma.contact.upsert({
          where: { id: `contact-rotana-${doorNo}-owner` },
          update: {},
          create: {
            id: `contact-rotana-${doorNo}-owner`,
            orgId: org.id,
            type: "OWNER_CONTACT" as any,
            fullName: customerName,
            email: email || undefined,
            phone: phone1 || phone2 || undefined,
          },
        });
      }
    }
  }
  console.log(`  ✅ Rotana: ${rCount} properties`);

  console.log("\n🎉 TURKEY CSV SEED COMPLETE!");
  console.log(`    Admin: info@reservatior.com / Parola341`);
  console.log(`    Anthill A: ${aCount} properties`);
  console.log(`    Anthill B: ${bCount} properties`);
  console.log(`    Queen: ${qCount} properties`);
  console.log(`    Rotana: ${rCount} properties`);
  console.log(`    Organization: ${ORG_ID}`);
}

main()
  .catch((e) => {
    console.error("SEED FAILED:", e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
