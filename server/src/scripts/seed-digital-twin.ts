import { PrismaClient, Region, PropertyCategory, ListingType, ListingStatus, PropertyType } from '@prisma/client';
import * as fs from 'fs';
import * as path from 'path';

const prisma = new PrismaClient();

// ---------------------------------------------------------
// 1. CONFIGURATION (ESNEK YAPI)
// ---------------------------------------------------------
const DIGITAL_TWIN_PROJECTS = [
  {
    projectName: 'Anthill Residence',
    region: 'TR' as Region,
    country: 'Turkey',
    city: 'Istanbul',
    state: 'Sisli',
    addressLine1: 'Cumhuriyet Mah. İncirlidede Cad.',
    blocks: [
      {
        name: 'A Blok',
        csvPath: path.resolve(__dirname, '../../data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL/A Blok Anthill Haziran 2018.csv'),
        totalFloors: 54,
        apartmentsPerFloor: 9,
      },
      {
        name: 'B Blok',
        csvPath: path.resolve(__dirname, '../../data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL/B Blok Güncel Düzenlenmiş.csv'),
        totalFloors: 54,
        apartmentsPerFloor: 9,
      }
    ]
  }
  // İleride buraya Divan, Bomonti Residence by Rotana gibi projeler eklenebilir.
];

// ---------------------------------------------------------
// 2. MAPPING LOGIC (BRÜT M2 -> DAİRE TİPİ VE PLANI)
// ---------------------------------------------------------
function getLayoutFromM2(m2: number): { type: string, plan: string, bedrooms: number, balkon: boolean } {
  if (m2 === 86) return { type: '1+1', plan: 'Tip 3/C1/I1', bedrooms: 1, balkon: false };
  if (m2 === 88) return { type: '1+1', plan: 'C2/C3', bedrooms: 1, balkon: false };
  if (m2 === 95) return { type: '1+1', plan: 'I4', bedrooms: 1, balkon: false };
  if (m2 === 96) return { type: '2+1', plan: 'H1', bedrooms: 2, balkon: false };
  if (m2 === 98) return { type: '2+1', plan: 'K1', bedrooms: 2, balkon: false };
  if (m2 === 100) return { type: '2+1', plan: 'H2', bedrooms: 2, balkon: false };
  if (m2 === 102) return { type: '2+1', plan: 'K2', bedrooms: 2, balkon: false };
  if (m2 === 109) return { type: '2+1', plan: 'J1', bedrooms: 2, balkon: false };
  if (m2 === 110) return { type: '2+1', plan: 'B1', bedrooms: 2, balkon: false };
  if (m2 === 111) return { type: '2+1', plan: 'Unknown', bedrooms: 2, balkon: false };
  if (m2 === 112) return { type: '2+1', plan: 'D3/B3', bedrooms: 2, balkon: false };
  if (m2 === 113) return { type: '2+1', plan: 'Unknown', bedrooms: 2, balkon: false };
  if (m2 === 118) return { type: '2+1', plan: 'J1/J4 (Balkonlu)', bedrooms: 2, balkon: true };
  if (m2 === 121) return { type: '2+1', plan: 'D3/D4 (Balkonlu)', bedrooms: 2, balkon: true };
  if (m2 >= 180 && m2 < 200) return { type: '3+1', plan: 'A1/A4', bedrooms: 3, balkon: true };
  if (m2 >= 200) return { type: '4+1', plan: 'E1/E4', bedrooms: 4, balkon: true };

  return { type: '1+1', plan: 'Standart', bedrooms: 1, balkon: false }; // Varsayılan boş daire
}

// ---------------------------------------------------------
// 3. PARSING CSV
// ---------------------------------------------------------
function parseCSV(filePath: string) {
  if (!fs.existsSync(filePath)) {
    console.warn(`CSV dosyası bulunamadı: ${filePath}`);
    return [];
  }

  const fileContent = fs.readFileSync(filePath, 'utf-8');
  const lines = fileContent.split('\n');
  const records = [];

  // İlk satır başlıklar olduğu için i=1'den başlıyoruz
  for (let i = 1; i < lines.length; i++) {
    const line = lines[i].trim();
    if (!line) continue;

    const columns = line.split(';');
    // CSV Kolonları: KAT;NO;M2;EV SAHİBİ;TELEFON;MAİL;DURUM;KİRACI;Tarih;TELEFON;
    // Bazen yapı değişebiliyor ama genel olarak indeksler:
    // A Blok: 0:KAT, 1:NO, 2:M2, 3:Ev Sahibi, 4:MAİL, 5:DURUM, 6:TELEFON, 9:KİRACI (Yaklaşık)
    // B Blok: 0:KAT, 1:NO, 2:M2, 3:EV SAHİBİ, 4:TELEFON, 5:MAİL, 6:DURUM, 7:KİRACI

    const katStr = columns[0]?.trim();
    const noStr = columns[1]?.trim();
    const m2Str = columns[2]?.trim();
    const evSahibi = columns[3]?.trim() || '';

    // Boş satırları atla
    if (!katStr && !noStr && !evSahibi) continue;

    const kat = parseInt(katStr, 10);
    const no = parseInt(noStr, 10);
    const m2 = parseFloat(m2Str);

    if (!isNaN(no)) {
      records.push({ kat, no, m2: isNaN(m2) ? null : m2, owner: evSahibi, rawData: line });
    }
  }

  return records;
}

// ---------------------------------------------------------
// 4. MAIN SEED PROCESS
// ---------------------------------------------------------
async function main() {
  console.log('Digital Twin Seed işlemi başlatılıyor...');

  // Organizasyon bul veya oluştur
  let org = await prisma.organization.findFirst();
  if (!org) {
    org = await prisma.organization.create({
      data: {
        name: 'Digital Twin Default Org',
        email: 'admin@digitaltwin.com'
      }
    });
    console.log(`Yeni organizasyon oluşturuldu: ${org.name}`);
  }

  for (const project of DIGITAL_TWIN_PROJECTS) {
    console.log(`\n===========================================`);
    console.log(`Proje İşleniyor: ${project.projectName}`);
    
    // Facility Bul veya Oluştur
    let facility = await prisma.facility.findFirst({
      where: { name: project.projectName, orgId: org.id }
    });

    if (!facility) {
      // Dummy bir property oluşturup facility'ye bağlamak gerekebilir,
      // ancak Schema'ya göre Facility'nin bir property'e ait olması gerekiyor.
      // `propertyId String`
      
      const parentProperty = await prisma.property.create({
        data: {
          orgId: org.id,
          name: `${project.projectName} - Ana Tesis`,
          type: PropertyType.APARTMENT,
          region: project.region,
          country: project.country,
          city: project.city,
          state: project.state,
          addressLine1: project.addressLine1,
          propertyCategory: PropertyCategory.COMMERCIAL,
        }
      });

      facility = await prisma.facility.create({
        data: {
          orgId: org.id,
          name: project.projectName,
          propertyId: parentProperty.id,
        }
      });
      console.log(`Ana tesis (Facility) oluşturuldu: ${facility.name}`);
    }

    for (const block of project.blocks) {
      console.log(`\nBlok İşleniyor: ${block.name}`);
      const csvData = parseCSV(block.csvPath);
      console.log(`CSV'den ${csvData.length} daire kaydı okundu.`);

      let createdCount = 0;
      let matchedCount = 0;

      // 54 kat ve her katta 9 daire için tam matris oluşturma
      for (let floor = 1; floor <= block.totalFloors; floor++) {
        for (let idx = 1; idx <= block.apartmentsPerFloor; idx++) {
          
          // Daire numarası hesaplama: (kat - 1) * 9 + idx
          const expectedNo = (floor - 1) * block.apartmentsPerFloor + idx;

          // CSV'de bu daire var mı?
          const csvRecord = csvData.find(c => c.no === expectedNo);

          // Bilgileri ayarla
          let m2 = csvRecord?.m2 || 86; // Eğer csv'de yoksa varsayılan 86 m2 kabul et
          let owner = csvRecord?.owner || null;
          let layout = getLayoutFromM2(m2);

          let notes = '';
          if (csvRecord) {
             matchedCount++;
             notes = `Mal Sahibi: ${owner}\nVeri kaynağı: CSV\nOrijinal Satır: ${csvRecord.rawData}`;
          } else {
             notes = 'Sistem tarafından otomatik üretilen sahipsiz daire.';
          }

          // Veritabanında kontrol et (unique anahtar varsa upsert, yoksa create)
          // Property modeli locationId'de unique ama binaNo ve daireNo için unique index yok.
          // Bu yüzden findFirst ile arıyoruz.
          const existingProp = await prisma.property.findFirst({
            where: {
              orgId: org.id,
              binaNo: block.name,
              daireNo: expectedNo.toString(),
            }
          });

          if (!existingProp) {
            await prisma.property.create({
              data: {
                orgId: org.id,
                name: `${project.projectName} ${block.name} Daire ${expectedNo}`,
                type: PropertyType.APARTMENT,
                propertyCategory: PropertyCategory.RESIDENTIAL,
                region: project.region,
                country: project.country,
                city: project.city,
                state: project.state,
                addressLine1: project.addressLine1,
                
                binaNo: block.name,
                daireNo: expectedNo.toString(),
                kat: floor,
                toplamKat: block.totalFloors,
                
                areaSqm: m2,
                bedrooms: layout.bedrooms,
                balkon: layout.balkon,
                tapu_tasinmaz_tipi: `${layout.type} - ${layout.plan}`,
                
                notes: notes,
                listingStatus: ListingStatus.AVAILABLE,
                listingType: ListingType.SALE, // veya RENT, varsayılan SALE
                
                // Aidat otomasyonu: m2 başı ortalama 50 TL baz alınabilir.
                aidat: m2 * 50,
                aidatTipi: "Aylık",
              }
            });
            createdCount++;
          }
        }
      }

      console.log(`[Sonuç] ${block.name}: CSV'den ${matchedCount} daire eşleştirildi. Veritabanına toplam ${createdCount} YENİ daire eklendi.`);
    }
  }

  console.log('\nSeed işlemi başarıyla tamamlandı!');
}

main()
  .catch(e => {
    console.error('HATA:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
