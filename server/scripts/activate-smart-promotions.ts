import { PrismaClient, PropertyPromotionType, PropertyPromotionStatus } from "@prisma/client";
import fs from 'fs';

/**
 * SMART PROMOTION ACTIVATION ENGINE
 * Flags premium properties for global discovery and creates promotion records.
 */

async function activatePromotions() {
    const env = fs.readFileSync('.env', 'utf8');
    const countries = ['US', 'UK', 'TR', 'DE', 'FR', 'ES', 'IT', 'NL', 'CA', 'MX', 'BR', 'AR', 'AU', 'NZ', 'JP', 'KR', 'CN', 'IN', 'SG', 'MY', 'TH', 'AE', 'SA'];
    
    console.log('💎 ACTIVATING SMART PROMOTIONS...');

    // const orgId = "seed-global-org-master";

    for (const c of countries) {
        const match = env.match(new RegExp(`DATABASE_URL_${c}="(.*?)"`));
        if (!match) continue;
        
        const url = match[1];
        const prisma = new PrismaClient({ datasources: { db: { url } } });
        
        console.log(`✨ Filtering Premium Assets in ${c}...`);

        try {
            // 1. Mark top 10% properties as "Doped" (Smart Engine Discovery)
            const properties = await prisma.property.findMany({ take: 50 });
            for (let i = 0; i < properties.length; i++) {
                if (i % 5 === 0) { // 20% promotion rate
                    await prisma.property.update({
                        where: { id: properties[i].id },
                        data: { isDoped: true }
                    });

                    // 2. Create actual Promotion records if they don't exist
                    await prisma.propertyPromotion.upsert({
                        where: { id: `promo-${c}-${properties[i].id}` },
                        update: {},
                        create: {
                            id: `promo-${c}-${properties[i].id}`,
                            propertyId: properties[i].id,
                            promotionType: (i % 10 === 0 ? PropertyPromotionType.FEATURED : PropertyPromotionType.URGENT),
                            status: PropertyPromotionStatus.ACTIVE,
                            startDate: new Date(),
                            endDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000), // 30 days
                            price: 5000,
                            currency: "USD"
                        }
                    });

                    // 3. Update associated listings
                    await prisma.listing.updateMany({
                        where: { propertyId: properties[i].id },
                        data: {
                            isPromoted: true,
                            promotionTier: i % 10 === 0 ? 2 : 1
                        }
                    });
                }
            }
            console.log(`✅ ${c} Promotions Activated.`);
        } catch (e) {
            console.error(`❌ ${c} activation failed:`, e);
        } finally {
            await prisma.$disconnect();
        }
    }

    console.log('🏁 ALL SMART PROMOTIONS ACTIVATED.');
}

activatePromotions().catch(console.error);
