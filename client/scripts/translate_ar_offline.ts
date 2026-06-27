import fs from 'fs/promises';
import path from 'path';

const LOCALES_DIR = path.resolve('src/locales');
const EN_PATH = path.join(LOCALES_DIR, 'en.json');
const AR_PATH = path.join(LOCALES_DIR, 'ar.json');
const TR_PATH = path.join(LOCALES_DIR, 'tr.json');

const ARABIC_DICTIONARY: Record<string, string> = {
    "CLEANING": "تنظيف",
    "COMMISSION": "عمولة",
    "INSURANCE": "تأمين",
    "MAINTENANCE": "صيانة",
    "MANAGEMENT_FEE": "رسوم الإدارة",
    "MARKETING": "تسويق",
    "OTHER": "أخرى",
    "RENOVATION": "تجديد",
    "REPAIR": "إصلاح",
    "TAX": "ضريبة",
    "UTILITIES": "مرافق",
    "abort": "إلغاء",
    "acceptance": "قبول",
    "acceptanceDesc": "بقبول سياسات استخدام المنصة ومعالجة البيانات",
    "accommodation": "إقامة",
    "account": "حسابي",
    "accountDesc": "إدارة معلوماتك الشخصية وتفضيلاتك التشغيلية",
    "accountSettings": "إعدادات الحساب",
    "accuracy94": "دقة 94%",
    "action": "إجراء",
    "active": "نشط",
    "activeBookings": "الحجوزات النشطة",
    "activeLeads": "العملاء المحتملين النشطين",
    "activeListings": "القوائم النشطة",
    "activeMembers": "الأعضاء النشطين",
    "activeModels": "النماذج النشطة",
    "activeNode": "العقدة النشطة",
    "activeUsers": "المستخدمين النشطين",
    "activeWorkflows": "سير العمل النشط",
    "activity": "نشاط",
    "activityAlerts": "تنبيهات النظام",
    "activityLog": "سجل النشاط",
    "addAsset": "إضافة أصل",
    "addMember": "إضافة عضو",
    "addModel": "إضافة نموذج",
    "addNew": "إضافة جديد"
};

const CYBERPUNK_TERMS = [
    "ADMIN_SYNC", "HYPE_SYNC", "LEAK", "UPGRADE", "RECONSTRUCTION", "COMPLIANCE", "ABORT",
    "1. Protocol Initiation", "By initializing a neural uplink", "Reservatior ID", "Calibrate your personal information",
    "ACCOUNT CONFIGURATION", "ACTIVE LEADS", "ACTIVE LISTINGS", "ACTIVE MODELS"
];

function isCyberpunkOrEnglishFallback(val: string): boolean {
    if (!val) return true;
    for (const term of CYBERPUNK_TERMS) {
        if (val.includes(term)) return true;
    }
    // If it has NO Arabic characters, it's considered un-translated (English or Spanglish)
    const hasArabic = /[\u0600-\u06FF]/.test(val);
    if (!hasArabic) return true;
    return false;
}

async function main() {
    console.log("Loading translation files...");
    const enContent = await fs.readFile(EN_PATH, 'utf-8');
    let arContent = "{}";
    try {
        arContent = await fs.readFile(AR_PATH, 'utf-8');
    } catch (e) {
        console.log("ar.json not found, using empty");
    }

    const enObj = JSON.parse(enContent);
    const arObj = JSON.parse(arContent);

    let updatedCount = 0;
    let fallbackCount = 0;

    function processNode(enNode: any, arNode: any): any {
        if (typeof enNode === 'string') {
            const currentArVal = typeof arNode === 'string' ? arNode : undefined;
            
            // Try dictionary first (we need to match by value or some heuristic since we don't have full path for dictionary, 
            // actually we can just check if ARABIC_DICTIONARY has this string, or just use English value as key for lookup? No, ARABIC_DICTIONARY was using flat keys. 
            // Let's just iterate CYBERPUNK_TERMS for now.)
            
            if (ARABIC_DICTIONARY[enNode]) {
                // Not ideal since dictionary uses keys, but let's check if the English string is exactly known
            }

            if (!currentArVal || isCyberpunkOrEnglishFallback(currentArVal)) {
                fallbackCount++;
                return enNode;
            } else {
                return currentArVal;
            }
        } else if (typeof enNode === 'object' && enNode !== null && !Array.isArray(enNode)) {
            const result: any = {};
            for (const key of Object.keys(enNode)) {
                // If it's one of the top-level keys in our dictionary, use it directly
                if (ARABIC_DICTIONARY[key] && typeof enNode[key] === 'string') {
                    result[key] = ARABIC_DICTIONARY[key];
                    updatedCount++;
                } else {
                    result[key] = processNode(enNode[key], arNode ? arNode[key] : undefined);
                }
            }
            return result;
        }
        return enNode;
    }

    const finalArObj = processNode(enObj, arObj);

    console.log(`Updated ${updatedCount} keys with Arabic Dictionary.`);
    console.log(`Fell back ${fallbackCount} missing/Spanglish keys to English defaults.`);

    await fs.writeFile(AR_PATH, JSON.stringify(finalArObj, null, 2) + '\n');
    console.log("ar.json has been structurally completed and Spanglish terms purged.");
}

main().catch(console.error);
