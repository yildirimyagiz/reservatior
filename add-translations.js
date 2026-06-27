const fs = require('fs');
const path = require('path');

const localesPath = path.join(__dirname, 'client/src/locales');
const enPath = path.join(localesPath, 'en.json');
const trPath = path.join(localesPath, 'tr.json');

const enKeys = {
    "trigger.offer_processing": "Offer analysis and negotiation is being prepared...",
    "trigger.offer_accepted": "Offer accepted as it matches market conditions.",
    "trigger.offer_countered": "Offer is significantly below market value. Auto counter-offer sent to buyer.",
    "trigger.vendor_dispatching": "Emergency vendor dispatch requested...",
    "trigger.vendor_dispatched": "An active emergency plumber was found in the area and the work order has been dispatched.",
    "trigger.tenant_analysis_started": "Tenant application analysis and OCR scan initiated...",
    "trigger.tenant_approved": "Financial documents verified. Risk score is very low. Approved.",
    "trigger.tenant_rejected": "Credit score is below the minimum threshold. System auto-rejected.",
    "trigger.tenant_review": "Credit score is borderline. Guarantor might be required.",
    "trigger.marketing_started": "Social media post (Reels & Post) is being written...",
    "trigger.marketing_completed": "Social media assets successfully created.",
    "trigger.smartkey_generating": "Generating one-time PIN for physical viewing...",
    "trigger.smartkey_generated": "Communicated with SmartLock. One-time PIN generated and sent to the door."
};

const trKeys = {
    "trigger.offer_processing": "Teklif analizi ve müzakere hazırlanıyor...",
    "trigger.offer_accepted": "Teklif piyasa şartlarına uygun bulundu, kabul edildi.",
    "trigger.offer_countered": "Teklif rayiç bedelin çok altında. Alıcıya otomatik karşı teklif (Counter-Offer) iletildi.",
    "trigger.vendor_dispatching": "Acil taşeron yönlendirmesi talep edildi...",
    "trigger.vendor_dispatched": "Bölgede 'Aktif' statüsünde bir acil tesisatçı bulundu ve iş emri iletildi.",
    "trigger.tenant_analysis_started": "Kiracı başvuru analizi ve OCR doküman taraması başlatıldı...",
    "trigger.tenant_approved": "Finansal dökümanlar doğrulandı. Risk skoru çok düşük. Onaylandı.",
    "trigger.tenant_rejected": "Kredi skoru asgari eşiğin altında. Sistem otomatik reddetti.",
    "trigger.tenant_review": "Kredi skoru sınırda. Kefil talep edilebilir.",
    "trigger.marketing_started": "Sosyal medya gönderisi (Reels & Post) yazılıyor...",
    "trigger.marketing_completed": "Sosyal medya metinleri ve medya varlıkları başarıyla oluşturuldu.",
    "trigger.smartkey_generating": "Fiziksel tur için kapı kilidi tek kullanımlık şifresi üretiliyor...",
    "trigger.smartkey_generated": "SmartLock ile iletişim kuruldu. Tek kullanımlık PIN Kodu üretildi ve kapıya tanımlandı."
};

function updateJson(filePath, newKeys) {
    if (fs.existsSync(filePath)) {
        let data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
        Object.assign(data, newKeys);
        // sort keys to keep it tidy if they want
        const sorted = Object.keys(data).sort().reduce((acc, key) => {
            acc[key] = data[key];
            return acc;
        }, {});
        fs.writeFileSync(filePath, JSON.stringify(sorted, null, 2), 'utf8');
        console.log(`Updated ${filePath}`);
    } else {
        console.log(`File not found: ${filePath}`);
    }
}

updateJson(enPath, enKeys);
updateJson(trPath, trKeys);
