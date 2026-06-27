import { PrismaClient, MemberRoleKey } from "@prisma/client";
import { default as bun } from "bun";

const prisma = new PrismaClient();

async function hashPassword(password: string) {
  return Bun.password.hash(password, { algorithm: "bcrypt", cost: 10 });
}

async function createOrUpdateUser(email: string, name: string, roleName: MemberRoleKey) {
  try {
    let user = await prisma.user.findUnique({ where: { email } });

    if (!user) {
      user = await prisma.user.create({
        data: {
          email,
          name,
          phone: '+1234567890',
        },
      });
      console.log(`Created user: ${email}`);
    } else {
      console.log(`User already exists: ${email}. Updating password...`);
    }

    const passwordHash = await hashPassword('Parola341');

    const existingAccount = await prisma.account.findFirst({
      where: { userId: user.id, providerId: 'credentials' }
    });

    if (existingAccount) {
      await prisma.account.update({
        where: { id: existingAccount.id },
        data: { accessToken: passwordHash }
      });
    } else {
      await prisma.account.create({
        data: {
          userId: user.id,
          type: 'CREDENTIALS',
          providerId: 'credentials',
          accountId: email,
          accessToken: passwordHash,
        },
      });
    }

    // Role linking Logic (if required by auth.ts)
    // Create an organization if one doesn't exist to bind roles
    let defaultOrg = await prisma.organization.findFirst({ where: { name: 'Reservatior Demo Org' } });
    if (!defaultOrg) {
      defaultOrg = await prisma.organization.create({
        data: {
          name: 'Reservatior Demo Org',
          type: 'AGENCY',
          region: 'USA_NORTHEAST',
          defaultCurrency: 'USD',
          defaultLocale: 'en-US'
        }
      });
    }

    let role = await prisma.role.findFirst({ where: { key: roleName, orgId: defaultOrg.id } });
    if (!role) {
      role = await prisma.role.create({
        data: {
          key: roleName,
          name: roleName,
          orgId: defaultOrg.id,
          isSystem: false
        }
      });
    }

    let membership = await prisma.organizationMember.findFirst({
        where: { userId: user.id, orgId: defaultOrg.id }
    });

    if (!membership) {
        await prisma.organizationMember.create({
            data: {
                userId: user.id,
                orgId: defaultOrg.id,
                roleId: role.id
            }
        });
    } else {
        await prisma.organizationMember.update({
            where: { id: membership.id },
            data: { roleId: role.id }
        });
    }

    console.log(`✅ Success for ${email} as ${roleName}`);
  } catch (err) {
    console.error(`❌ Error for ${email}:`, err);
  }
}

async function main() {
  console.log('Seeding test users...');
  
  await createOrUpdateUser('info@reservatior.com', 'Admin User', 'OWNER');
  await createOrUpdateUser('agent@reservatior.com', 'Agent User', 'AGENT');
  await createOrUpdateUser('customer@reservatior.com', 'Customer User', 'USER');

  console.log('Done.');
  process.exit(0);
}

main();
