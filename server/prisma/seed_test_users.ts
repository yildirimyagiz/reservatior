
import PrismaManager from "../src/lib/prisma";

import { MemberRoleKey, PermissionKey, OrgType, Region } from "@prisma/client";

async function seedForCountry(countryCode: string) {
  console.log(`\n🌱 Seeding test users for: ${countryCode} 🚀`);
  const prisma = PrismaManager.getClient(countryCode);
  const configs: Record<string, any> = {
    US: { currency: "USD", languageCode: "en-US" },
    TR: { currency: "TRY", languageCode: "tr-TR" }
  };
  const config = configs[countryCode];
  
  if (!config) {
    console.error(`❌ No config for ${countryCode}`);
    return;
  }

  const adminPassword = "Parola341";
  const passwordHash = await Bun.password.hash(adminPassword, { algorithm: "bcrypt", cost: 10 });

  // 1. Ensure Organization exists
  const orgId = `seed-${countryCode.toLowerCase()}-global-org-001-1`;
  const org = await prisma.organization.upsert({
    where: { id: orgId },
    update: {},
    create: {
      id: orgId,
      name: `Reservatior Global ${countryCode}`,
      type: OrgType.AGENCY,
      region: (Region[countryCode as keyof typeof Region] || Region.GLOBAL),
      defaultCurrency: config.currency,
      defaultLocale: config.languageCode,
    },
  });

  // 2. Ensure Permissions exist
  const allPermissions = Object.values(PermissionKey);
  const permissionIds: Record<string, string> = {};
  
  for (const permKey of allPermissions) {
    const perm = await prisma.permission.upsert({
      where: { key: permKey },
      update: {},
      create: {
        key: permKey,
        name: permKey.replace(/_/g, ' ').toLowerCase(),
      },
    });
    permissionIds[permKey] = perm.id;
  }

  // 3. Define Roles and assign Permissions
  const roles = Object.values(MemberRoleKey);
  for (const roleKey of roles) {
    const roleId = `seed-${countryCode.toLowerCase()}-role-${roleKey.toLowerCase()}-1`;
    const role = await prisma.role.upsert({
      where: { orgId_key: { orgId: org.id, key: roleKey } },
      update: {},
      create: {
        id: roleId,
        orgId: org.id,
        key: roleKey,
        name: roleKey.charAt(0) + roleKey.slice(1).toLowerCase().replace(/_/g, ' '),
      },
    });

    // Assign full permissions to most roles for testing purposes, or specific ones
    // For simplicity in testing RBAC logic, we'll follow the seed.ts pattern
    const permsToAssign = (roleKey === MemberRoleKey.OWNER || roleKey === MemberRoleKey.ORG_ADMIN) 
      ? allPermissions 
      : [PermissionKey.PROPERTIES_VIEW_ALL, PermissionKey.REPORTS_VIEW];

    for (const permKey of permsToAssign) {
      await prisma.rolePermission.upsert({
        where: { roleId_permissionId: { roleId: role.id, permissionId: permissionIds[permKey] } },
        update: {},
        create: {
          roleId: role.id,
          permissionId: permissionIds[permKey],
        },
      });
    }

    // 4. Create User for each role
    const email = roleKey === MemberRoleKey.OWNER ? `info@reservatior.com` : `${roleKey.toLowerCase()}@reservatior.com`;
    const user = await prisma.user.upsert({
      where: { email },
      update: { name: `${roleKey} Test User` },
      create: {
        email,
        name: `${roleKey} Test User`,
      },
    });

    // Create Account for credentials
    await prisma.account.upsert({
      where: { providerId_accountId: { providerId: "credentials", accountId: email } },
      update: { accessToken: passwordHash },
      create: {
        userId: user.id,
        type: "CREDENTIALS" as any,
        providerId: "credentials",
        accountId: email,
        accessToken: passwordHash,
      },
    });

    // Create Membership
    await prisma.organizationMember.upsert({
      where: { userId_orgId: { userId: user.id, orgId: org.id } },
      update: { roleId: role.id },
      create: {
        orgId: org.id,
        userId: user.id,
        roleId: role.id,
      },
    });

    console.log(`✅ Seeded User: ${email} | Role: ${roleKey} (${countryCode})`);
  }
}

async function main() {
  console.log("🚀 Starting Universal Test User Seeding...");
  
  const targetRegion = process.env.SEED_REGION || "ALL";
  if (targetRegion === "ALL") {
    // Seed for US and TR as base
    await seedForCountry("US");
    await seedForCountry("TR");
  } else {
    await seedForCountry(targetRegion);
  }
  
  console.log("\n✨ Universal Seeding Complete.");
  process.exit(0);
}

main().catch(err => {
  console.error("❌ Seeding failed:", err);
  process.exit(1);
});
