import { prismaManager } from '../lib/prisma';
import * as dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.join(__dirname, '../../../.env') });

async function main() {
  const prisma = prismaManager.getClient('TR');
  
  const deleteResult = await prisma.property.deleteMany({
    where: {
      id: { startsWith: 'prop_ROTANABOMONTI_' },
      NOT: { id: 'prop_ROTANABOMONTI_MASTER' }
    }
  });

  console.log(`🧹 Deleted ${deleteResult.count} old properties to prepare for a fresh import.`);
}

main()
  .catch((e) => console.error("Hata:", e))
  .finally(() => process.exit(0));
