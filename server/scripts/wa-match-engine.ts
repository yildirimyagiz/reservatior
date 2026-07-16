import * as fs from 'fs';
import * as path from 'path';
import { prismaManager } from '../src/lib/prisma';
import { Property, Lead } from '@prisma/client';

const DATA_ROOT = path.join(process.cwd(), 'data');
const OUTREACH_QUEUE_PATH = path.join(DATA_ROOT, 'outreach_queue.json');

interface OutreachMessage {
    to: string;
    text: string;
    type: 'LISTING_INVITE' | 'DEMAND_MATCH' | 'MISSING_INFO' | 'INFO_COMPLETE';
    propertyId?: string;
    leadId?: string;
    queuedAt: string;
    sentAt?: string;
    status: 'PENDING' | 'SENT' | 'FAILED';
}

function loadQueue(): OutreachMessage[] {
    if (!fs.existsSync(OUTREACH_QUEUE_PATH)) return [];
    try { return JSON.parse(fs.readFileSync(OUTREACH_QUEUE_PATH, 'utf-8')); } catch { return []; }
}

function saveQueue(queue: OutreachMessage[]) {
    fs.writeFileSync(OUTREACH_QUEUE_PATH, JSON.stringify(queue, null, 2), 'utf-8');
}

async function runMatchEngine() {
    console.log(`[${new Date().toISOString()}] 🔍 Starting Smart Matchmaking Engine...`);
    const prisma = prismaManager.getClient('TR');
    
    // Sadece statüsü NEW veya IN_PROGRESS olan leadleri al
    const activeLeads = await prisma.lead.findMany({
        where: {
            status: { in: ['NEW'] },
            budget: { not: null }
        },
        orderBy: { createdAt: 'desc' }
    });

    console.log(`[${new Date().toISOString()}] Bulunan aktif alıcı (Lead) sayısı: ${activeLeads.length}`);

    const queue = loadQueue();
    let matchCount = 0;

    for (const lead of activeLeads) {
        if (!lead.notes || !lead.phone) continue;
        
        // Extract basic data from notes using regex (this is a simplified approach, usually we should store these in JSON)
        // Format was: Şehir: İSTANBUL\nİlçe: Şişli\nOda: 2+1\nBütçe: 5000000 TRY\nTip: SALE
        const cityMatch = lead.notes.match(/Şehir:\s*([^\n]+)/);
        const districtMatch = lead.notes.match(/İlçe:\s*([^\n]+)/);
        const typeMatch = lead.notes.match(/Tip:\s*([^\n]+)/);
        
        const city = cityMatch ? cityMatch[1].trim() : null;
        const district = districtMatch ? districtMatch[1].trim() : null;
        const listingType = typeMatch ? typeMatch[1].trim() as 'SALE' | 'RENT' : 'SALE';

        if (!city) continue;

        const where: any = {
            listingStatus: { in: ['AVAILABLE', 'DRAFT'] },
            city: city,
            listingType: listingType,
            createdAt: { gte: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000) } // Sadece son 3 gündeki ilanlar
        };

        if (district && district !== 'BİLİNMEYEN_İLÇE') {
            where.addressLine1 = { contains: district, mode: 'insensitive' };
        }

        if (lead.budget) {
            const margin = 1.2; 
            where.listingPrice = { lte: Math.round(Number(lead.budget) * margin) };
        }

        const props = await prisma.property.findMany({ 
            where, 
            take: 3, 
            select: { id: true, name: true, listingPrice: true, currency: true, city: true, bedrooms: true } 
        });

        if (props.length > 0) {
            // Zaten bu lead'e bu ilanlardan gönderdik mi diye queue'ya bakıyoruz
            const alreadySent = queue.some(q => q.leadId === lead.id && q.type === 'DEMAND_MATCH');
            if (alreadySent) continue; // Şimdilik basitleştirmek için, o lead'e hiç DEMAND_MATCH atılmamışsa at

            const matchLines = props.map((p, i) => {
                const priceStr = p.listingPrice ? `${p.listingPrice.toString()} ${p.currency}` : 'Fiyat sorunuz';
                const roomStr = p.bedrooms ? `${p.bedrooms}+1` : '';
                return `${i + 1}️⃣ *${p.name}* — ${priceStr} ${roomStr}\n   👉 reservatior.com/en/property/${p.id}`;
            }).join('\n\n');

            const text = `👋 *Merhaba ${lead.firstName}!* Reservatior Akıllı Çöpçatan Sisteminden yazıyoruz.\n\n` +
                `${district ? district + ', ' : ''}${city}'de aradığınız kritere uygun *yeni ilanlar* sisteme düştü:\n\n${matchLines}\n\n` +
                `Daha fazla bilgi almak veya evi görmek isterseniz bizimle iletişime geçebilirsiniz! 🏠`;

            queue.push({
                to: lead.phone.replace(/[^0-9]/g, ''),
                text,
                type: 'DEMAND_MATCH',
                leadId: lead.id,
                queuedAt: new Date().toISOString(),
                status: 'PENDING'
            });
            matchCount++;
            console.log(`[${new Date().toISOString()}] ✅ Match bulundu: Lead ${lead.id} -> ${props.length} ilan`);
        }
    }

    if (matchCount > 0) {
        saveQueue(queue);
        console.log(`[${new Date().toISOString()}] 💾 ${matchCount} yeni eşleşme kuyruğa eklendi (outreach_queue.json).`);
    } else {
        console.log(`[${new Date().toISOString()}] 🤷 Yeni eşleşme bulunamadı.`);
    }
}

runMatchEngine().catch(e => console.error(e));
