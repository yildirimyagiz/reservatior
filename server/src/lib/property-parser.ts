export interface PropertyDetails {
    country: string;
    city: string;
    district: string;
    projectName: string;
    block: string;
    floor: string;
    roomType: string;
    grossArea: string;
    netArea: string;
    citizenship: string;
    status: string;
    price?: string;
    contactName: string;
    contactPhone: string;
}

export function parsePropertyDetails(text: string, groupOrChannelName: string): PropertyDetails {
    let country = "TURKİYE";
    let city = "İSTANBUL";
    let district = "BİLİNMEYEN_İLÇE";
    let projectName = "";
    let block = "";
    let floor = "";
    let price = "";
    let roomType = "";
    let grossArea = "";
    let netArea = "";
    let citizenship = "Bilinmiyor";
    let status = "Bilinmiyor";
    let contactName = "";
    let contactPhone = "";

    const nameLower = groupOrChannelName.toLowerCase();
    const textLower = text.toLowerCase();

    // 1. Ülke / Şehir / İlçe Çıkarımı (Grup adından veya metinden)
    if (nameLower.includes('dubai') || textLower.includes('dubai') || nameLower.includes('ghurair')) {
        country = "BAE";
        city = "DUBAİ";
        district = "MERKEZ";
    } else {
        if (nameLower.includes('beylikdüzü') || textLower.includes('beylikdüzü')) district = "BEYLİKDÜZÜ";
        else if (nameLower.includes('vadistanbul') || textLower.includes('vadistanbul')) district = "SARIYER";
        else if (nameLower.includes('şişli') || textLower.includes('şişli')) district = "ŞİŞLİ";
        else if (nameLower.includes('beşiktaş') || textLower.includes('beşiktaş')) district = "BEŞİKTAŞ";
        else if (nameLower.includes('beyoğlu') || textLower.includes('beyoğlu')) district = "BEYOĞLU";
        else if (nameLower.includes('sarıyer') || textLower.includes('sarıyer')) district = "SARIYER";
        else if (nameLower.includes('kağıthane') || textLower.includes('kağıthane')) district = "KAĞITHANE";
        else if (nameLower.includes('eyüpsultan') || textLower.includes('eyüpsultan') || textLower.includes('eyüp')) district = "EYÜPSULTAN";
        else if (nameLower.includes('fatih') || textLower.includes('fatih')) district = "FATİH";
        else if (nameLower.includes('güzelyalı') || textLower.includes('güzelyalı')) district = "PENDİK";
    }

    const lines = text.split('\n').map(l => l.trim()).filter(l => l.length > 0);
    
    // 2. Detay Çıkarımı
    for (const line of lines) {
        const l = line.toLowerCase();
        
        // Fiyat
        if (l.includes('fiyat') || l.includes('usd') || l.includes('$') || l.includes('tl') || l.includes('₺')) {
            if (!price) {
                if (l.includes('fiyat')) {
                    price = line.split(/fiyat/i)[1]?.replace(/[:=\-]/g, '').trim();
                } else if (/[0-9.,]+/.test(line)) {
                    price = line.trim();
                }
            }
        }
        
        // Kat
        if (l.includes('kat:')) {
            floor = line.split(/kat:/i)[1]?.trim();
        } else if (l.match(/^kat\s+\d+/)) {
            floor = line.split(/kat\s+/i)[1]?.trim();
        } else if (l.includes(' kat ')) {
            const match = line.match(/(\d+)\.?\s*kat/i);
            if (match) floor = match[1];
        }

        // Blok
        if (l.includes('blok')) {
            const parts = line.split(/blok/i);
            if (parts.length > 1 && parts[1].trim()) {
                block = parts[1].replace(/[:=\-]/g, '').trim();
            } else {
                const match = line.match(/([A-Za-z0-9]+)\s+blok/i);
                if (match) block = match[1];
            }
        }

        // Daire Tipi
        if (l.includes('daire tipi') || l.match(/\d\s*\+\s*\d/)) {
            const match = line.match(/\d\s*\+\s*\d/);
            if (match) roomType = match[0];
            else roomType = line.split(/daire tipi/i)[1]?.replace(/[:=\-]/g, '').trim() || "";
        }

        // Brüt / Net
        if (l.includes('brüt')) {
            grossArea = line.split(/brüt/i)[1]?.replace(/[:=\-]/g, '').trim() || "";
        }
        if (l.includes('net') && !l.includes('internet')) {
            netArea = line.split(/net/i)[1]?.replace(/[:=\-]/g, '').trim() || "";
        }

        // Vatandaşlık
        if (l.includes('vatandaşlık') || l.includes('citizenship') || l.includes('ikamet')) {
            if (l.includes('uygun değil') || l.includes('vermiyor') || l.includes('not suitable') || l.includes('no citizenship')) {
                citizenship = "Uygun Değil";
            } else {
                citizenship = "Uygun";
            }
        }

        // Proje İsmi (Satılık, kiralık vb. olmayan ilk makul satır)
        if (!projectName && !isSeparator(line) && !isStatusCheck(line)) {
            if (!l.includes('daire tipi') && !l.includes('brüt') && !l.includes('kat:') && !l.includes('fiyat')) {
                projectName = line.replace(/[/\\?%*:|"<>]/g, '-').substring(0, 60).trim();
            }
        }
    }

    if (textLower.includes('kiralık') || textLower.includes('kiralik') || textLower.includes('rent')) {
        status = "Kiralık";
    } else if (textLower.includes('satılık') || textLower.includes('satilik') || textLower.includes('sale') || textLower.includes('fiyat')) {
        status = "Satılık";
    }

    if (!projectName) {
        // Eğer gruptan proje adını çıkaramadıysak en azından ilçe adını koyalım
        projectName = `Proje_${Date.now()}`;
    }

    return {
        country, city, district, projectName, block, floor, price, roomType, grossArea, netArea, citizenship, status, contactName, contactPhone
    };
}

function isSeparator(line: string) {
    return line.includes('🔘') || line.includes('---') || line.length < 3 || line.includes('📍');
}

function isStatusCheck(line: string) {
    const l = line.toLowerCase();
    return l.includes('satılık') || l.includes('kiralık') || l.includes('kelepir') || l.includes('acil') || l.includes('fırsat') || l.includes('portföy');
}

export function isPropertyListing(text: string, mediaCount: number): boolean {
    if (mediaCount > 0) return true;

    const l = text.toLowerCase();
    const keywords = ['fiyat', 'satılık', 'kiralık', 'usd', '₺', '$', 'aed', 'daire', 'villa', 'arsa', 'kat:', 'brüt', 'net', 'm2', 'metrekare', 'residence', 'proje', '+1', '+2'];
    
    for (const kw of keywords) {
        if (l.includes(kw)) return true;
    }

    if (l.includes('maps.app.goo.gl') || l.includes('google.com/maps')) return true;

    return false;
}

// ─── Buyer Demand Detection ───────────────────────────────────────────────────

export interface BuyerDemand {
    city: string;
    district: string;
    roomType: string;
    budget: string;
    budgetCurrency: string;
    listingType: 'SALE' | 'RENT';
    propertyType: string;
    notes: string;
    contactPhone: string;
    contactName: string;
    rawText: string;
    groupName: string;
    intentScore: 'HOT' | 'WARM' | 'COLD';
}

export function isDemandMessage(text: string): boolean {
    if (!text) return false;
    const l = text.toLowerCase();
    const demandKeywords = [
        'arıyorum', 'arıyoruz', 'arıyor', 'aranıyor',
        'bütçem', 'bütçemiz', 'bütçeli',
        'almak istiyorum', 'kiralamak istiyorum',
        'müşterim var', 'alıcım var', 'ihtiyacım var',
        'looking for', 'searching for', 'ararım',
    ];
    const propertyKeywords = [
        'daire', 'villa', 'ofis', 'arsa', 'konut', 'residence',
        '1+1', '2+1', '3+1', '4+1', '5+1', 'm2', 'usd', 'tl', '₺', '$',
    ];
    return demandKeywords.some(kw => l.includes(kw)) && propertyKeywords.some(kw => l.includes(kw));
}

export function parseDemand(text: string, groupName: string, contactName: string, contactPhone: string): BuyerDemand {
    const l = text.toLowerCase();
    let city = 'İSTANBUL', district = '', roomType = '', budget = '', budgetCurrency = 'TRY';
    let listingType: 'SALE' | 'RENT' = 'SALE', propertyType = 'APARTMENT';
    let intentScore: 'HOT' | 'WARM' | 'COLD' = 'WARM';

    if (l.includes('ankara')) city = 'ANKARA';
    else if (l.includes('antalya')) city = 'ANTALYA';
    else if (l.includes('izmir')) city = 'İZMİR';
    else if (l.includes('bursa')) city = 'BURSA';
    else if (l.includes('dubai') || l.includes('bae')) city = 'DUBAİ';

    const districtMap: Record<string, string> = {
        'şişli': 'Şişli', 'beşiktaş': 'Beşiktaş', 'beyoğlu': 'Beyoğlu', 'sarıyer': 'Sarıyer',
        'kağıthane': 'Kağıthane', 'eyüpsultan': 'Eyüpsultan', 'fatih': 'Fatih',
        'beylikdüzü': 'Beylikdüzü', 'esenyurt': 'Esenyurt', 'bakırköy': 'Bakırköy',
        'kadıköy': 'Kadıköy', 'üsküdar': 'Üsküdar', 'maltepe': 'Maltepe',
        'kartal': 'Kartal', 'ataşehir': 'Ataşehir', 'ümraniye': 'Ümraniye',
        'beykoz': 'Beykoz', 'zeytinburnu': 'Zeytinburnu', 'bağcılar': 'Bağcılar',
    };
    for (const [k, v] of Object.entries(districtMap)) { if (l.includes(k)) { district = v; break; } }

    const rm = text.match(/(\d)\s*\+\s*(\d)/);
    if (rm) roomType = rm[0];

    const budgetPatterns: Array<{ re: RegExp; currency: string }> = [
        { re: /(\d[\d.,\s]*(?:milyon)?)\s*(usd|dolar|\$)/i, currency: 'USD' },
        { re: /(\d[\d.,\s]*(?:milyon)?)\s*(aed|dirhem)/i, currency: 'AED' },
        { re: /(\d[\d.,\s]*(?:milyon)?)\s*(tl|₺|lira)/i, currency: 'TRY' },
        { re: /(\d[\d.,\s]*)\s*milyon/i, currency: 'TRY' },
    ];
    for (const p of budgetPatterns) {
        const m = text.match(p.re);
        if (m) { budget = m[0].trim(); budgetCurrency = p.currency; break; }
    }
    if (!budget) {
        const bm = text.match(/(\d[\d.,\s]*(?:milyon)?)\s*(usd|tl|₺|\$|aed)?.*?bütçe/i);
        if (bm) budget = bm[0].trim();
    }

    if (l.includes('kiralamak') || l.includes('kiralık') || l.includes('kiralayacak')) listingType = 'RENT';
    if (l.includes('villa')) propertyType = 'VILLA';
    else if (l.includes('ofis') || l.includes('plaza')) propertyType = 'OFFICE';
    else if (l.includes('arsa') || l.includes('tarla')) propertyType = 'LAND';
    else if (l.includes('dükkan') || l.includes('ticari')) propertyType = 'RETAIL';
    
    // Intent Scoring
    const hotKeywords = ['acil', 'hemen', 'nakit hazır', 'nakiti hazır', 'bugün', 'yarın', 'ciddi', 'hazır müşteri', 'urgent', 'cash buyer'];
    const coldKeywords = ['düşünüyor', 'soruşturuyor', 'bilgi almak', 'piyasa araştırması', 'merak', 'gelecek ay'];

    if (hotKeywords.some(k => l.includes(k))) {
        intentScore = 'HOT';
    } else if (coldKeywords.some(k => l.includes(k))) {
        intentScore = 'COLD';
    }

    return { city, district, roomType, budget, budgetCurrency, listingType, propertyType,
        notes: text.substring(0, 500), contactPhone, contactName, rawText: text, groupName, intentScore };
}
