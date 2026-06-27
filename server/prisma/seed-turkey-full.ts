import { PrismaClient, ListingType, ListingStatus, EarningStrategy, PhotoType } from "@prisma/client";
import prismaManager from "../src/lib/prisma";

const ORG_ID = "tr_residence_org";

const PROJECTS = [
  // ISTANBUL
  { id: "tr-res-zorlu", name: "Zorlu Center Residences", addr: "Levazım, Koru Sok. No:2, Beşiktaş", city: "Istanbul", zip: "34340", lat: 41.0664, lng: 29.0163, beds: 3, baths: 3, sqft: 2700, year: 2013, price: 52000000, desc: "Emre Arolat mimarisi, Raffles Hotel, PSM, lüks AVM ile entegre İstanbul'un en prestijli karma yaşam projesi.", facilities: ["Raffles Hotel","PSM Sahne","Lüks AVM","Kapalı Havuz","Fitness & Spa","Metro Bağlantısı","Dikey Bahçeler","7/24 Concierge"], photos: ["https://emre-arolat.fra1.digitaloceanspaces.com/wp-content/uploads/2022/04/02-46-scaled.jpg","https://emre-arolat.fra1.digitaloceanspaces.com/wp-content/uploads/2022/04/01-49-scaled.jpg","https://emre-arolat.fra1.digitaloceanspaces.com/wp-content/uploads/2022/04/05-39-scaled.jpg"], floors: [{name:"Executive 1+1",level:5,area:117},{name:"Family Suite 2+1",level:12,area:185},{name:"Panorama 3+1",level:18,area:260},{name:"Grand Penthouse",level:22,area:735}] },
  { id: "tr-res-sapphire", name: "Istanbul Sapphire", addr: "Büyükdere Cd. No:1, Kâğıthane", city: "Istanbul", zip: "34410", lat: 41.0775, lng: 28.9893, beds: 2, baths: 2, sqft: 1600, year: 2010, price: 28000000, desc: "Avrupa'nın en yüksek konut kulesi, 54 kat, 360° gözlem terası ve dikey bahçeler.", facilities: ["Gözlem Terası","Golf Simülatörü","Sinema","AVM","Dikey Bahçeler","Helipad"], photos: ["https://upload.wikimedia.org/wikipedia/commons/e/e8/Istanbul_Sapphire_2014.jpg"], floors: [{name:"Sky Loft 1+1",level:20,area:120},{name:"Panorama 3+1",level:40,area:245}] },
  { id: "tr-res-skyland", name: "Skyland Istanbul", addr: "Huzur, Cendere Cd. No:114, Sarıyer", city: "Istanbul", zip: "34485", lat: 41.1070, lng: 28.9897, beds: 3, baths: 2, sqft: 1800, year: 2018, price: 35000000, desc: "Türkiye'nin en yüksek kuleleri (284m). Broadway Malyan tasarımı, HOM Design Center.", facilities: ["HOM Design Center","Smart Home 2.0","Wellness & Spa","Heliport","65. Kat Lounge","Belgrad Ormanı Manzarası"], photos: ["https://upload.wikimedia.org/wikipedia/commons/7/7b/Skyland_Istanbul_CP.jpg"], floors: [{name:"Sky View 1+1",level:10,area:85},{name:"Horizon 2+1",level:30,area:145},{name:"Executive 3+1",level:50,area:210},{name:"Tower Penthouse",level:65,area:460}] },
  { id: "tr-res-emaar", name: "Emaar Square Istanbul", addr: "Ünalan, Libadiye Cd. No:82, Üsküdar", city: "Istanbul", zip: "34700", lat: 41.0105, lng: 29.0571, beds: 3, baths: 2, sqft: 2100, year: 2017, price: 32000000, desc: "Address Hotel, dev AVM ve akvaryum ile entegre lüks yaşam projesi.", facilities: ["Address Hotel","Akvaryum & Sualtı Hayvanat Bahçesi","Lüks Perakende","Sinemalar","Açık Havuzlar"], photos: ["https://upload.wikimedia.org/wikipedia/commons/2/2c/Emaar_Square_Mall_Istanbul.jpg"], floors: [{name:"Address Residence 1+1",level:8,area:88},{name:"Family Loft 3+1",level:20,area:210}] },
  { id: "tr-res-vadi", name: "Vadistanbul", addr: "Ayazağa, Cendere Cd. No:109, Sarıyer", city: "Istanbul", zip: "34485", lat: 41.1053, lng: 28.9852, beds: 3, baths: 2, sqft: 1850, year: 2016, price: 25000000, desc: "Teras, Bulvar ve Park fazları. Türkiye'nin ilk özel monorayı (Havaray). Radisson Blu Hotel.", facilities: ["Havaray Monoray","Vadistanbul AVM","Radisson Blu Hotel","Boğaz Su Simülasyonu","Orman Koşu Parkurları","760m Alışveriş Caddesi"], photos: ["https://upload.wikimedia.org/wikipedia/commons/e/e4/Vadi_Istanbul_Shopping_Mall.jpg"], floors: [{name:"Park Residence 2+1",level:5,area:135},{name:"Teras Forest 3+1",level:12,area:185},{name:"Bulvar Office Suite",level:8,area:120}] },
  { id: "tr-res-galataport", name: "Galataport Istanbul", addr: "Kılıçali Paşa, Meclis-i Mebusan Cd. No:2, Beyoğlu", city: "Istanbul", zip: "34433", lat: 41.0235, lng: 28.9828, beds: 2, baths: 2, sqft: 1900, year: 2021, price: 68000000, desc: "Boğaz kıyısında dünya standartlarında kruvaziyer limanı ve The Peninsula Hotel ile entegre lüks yaşam.", facilities: ["Kruvaziyer Terminali","Yeraltı Otoparkı","Müzeler","Sahil Promenadı","Lüks Perakende","The Peninsula Hotel"], photos: ["https://upload.wikimedia.org/wikipedia/commons/d/da/Galataport_Istanbul_2021.jpg"], floors: [{name:"Bosphorus Suite",level:3,area:180},{name:"Garden Loft",level:2,area:150}] },
  { id: "tr-res-seapearl", name: "SeaPearl Ataköy", addr: "Ataköy 1. Kısım Mah. Rauf Orbay Cad., Bakırköy", city: "Istanbul", zip: "34158", lat: 40.9755, lng: 28.8576, beds: 4, baths: 3, sqft: 3100, year: 2021, price: 55000000, desc: "Deniz manzaralı lüks rezidans, marina ve AVM entegrasyonu. İstanbul'un batı yakasının incisi.", facilities: ["Marina","AVM","Infinity Havuz","SPA","Çocuk Kulübü","Koşu Parkuru"], photos: [], floors: [{name:"Sea View 2+1",level:10,area:140},{name:"Panoramic 3+1",level:25,area:220},{name:"Penthouse 5+1",level:40,area:450}] },
  { id: "tr-res-maslak1453", name: "Maslak 1453", addr: "Maslak, Atatürk Oto Sanayi Sit. Yolu, Sarıyer", city: "Istanbul", zip: "34485", lat: 41.1089, lng: 29.0208, beds: 3, baths: 2, sqft: 1650, year: 2014, price: 18000000, desc: "Türkiye'nin en büyük karma yaşam projesi, 4.500+ konut, AVM, okul, hastane.", facilities: ["Dev AVM","Okul","Hastane","Spor Merkezi","Yüzme Havuzu","Çocuk Parkları","Cami"], photos: [], floors: [{name:"Studio 1+0",level:3,area:55},{name:"Standart 2+1",level:10,area:110},{name:"Geniş 3+1",level:20,area:165}] },
  { id: "tr-res-trump", name: "Trump Towers Istanbul", addr: "Kuştepe, Mecidiyeköy Yolu Cd. No:12, Şişli", city: "Istanbul", zip: "34387", lat: 41.0665, lng: 28.9891, beds: 3, baths: 3, sqft: 2400, year: 2012, price: 22000000, desc: "İstanbul Mecidiyeköy'de ikiz kule rezidans ve ofis projesi.", facilities: ["AVM","Fitness","Kapalı Havuz","SPA","Business Center","Concierge"], photos: [], floors: [{name:"Executive 2+1",level:15,area:150},{name:"Luxury 3+1",level:25,area:240}] },
  { id: "tr-res-nidapark", name: "Nidapark İstinye", addr: "İstinye, Sarıyer", city: "Istanbul", zip: "34460", lat: 41.1113, lng: 29.0581, beds: 4, baths: 3, sqft: 2800, year: 2018, price: 38000000, desc: "İstinye Park AVM yanında, yeşillikler içinde ultra lüks rezidans.", facilities: ["İstinye Park AVM","Yeşil Peyzaj","Havuzlar","Fitness","Tenis Kortu","Çocuk Kulübü"], photos: [], floors: [{name:"Garden 2+1",level:2,area:145},{name:"Forest View 3+1",level:8,area:210},{name:"Penthouse 4+1",level:15,area:380}] },
  { id: "tr-res-acibadem", name: "Acıbadem Life Istanbul", addr: "Acıbadem, Kadıköy", city: "Istanbul", zip: "34718", lat: 41.0012, lng: 29.0476, beds: 3, baths: 2, sqft: 1750, year: 2019, price: 20000000, desc: "Anadolu yakasında lüks yaşam, yeşil alan ve şehir manzarası.", facilities: ["Havuz","SPA","Spor Salonu","Çocuk Oyun Alanı","Güvenlik"], photos: [], floors: [{name:"Standart 2+1",level:5,area:120},{name:"Geniş 3+1",level:12,area:175}] },
  { id: "tr-res-batisehir", name: "Batışehir", addr: "Başakşehir, İkitelli Cd.", city: "Istanbul", zip: "34494", lat: 41.0948, lng: 28.7813, beds: 4, baths: 2, sqft: 2000, year: 2015, price: 12000000, desc: "Başakşehir'in en büyük konut projesi, 5.000+ daire, AVM ve yeşil alanlar.", facilities: ["AVM","Cami","Okul","Sağlık Merkezi","Havuzlar","Yeşil Alanlar"], photos: [], floors: [{name:"Standart 3+1",level:8,area:145},{name:"Dublex 4+1",level:18,area:230}] },
  // ANKARA
  { id: "tr-res-altinoran", name: "Sinpaş Altınoran", addr: "Turan Güneş Blv. İlkbahar Mah., Çankaya", city: "Ankara", zip: "06550", lat: 39.8519, lng: 32.8550, beds: 4, baths: 2, sqft: 1950, year: 2016, price: 12000000, desc: "Ankara Çankaya'da göl manzaralı premium kule rezidans.", facilities: ["Göl Manzarası","SPA","Fitness","Çocuk Alanları","Yeşil Peyzaj","Market"], photos: [], floors: [{name:"Göl View 2+1",level:5,area:130},{name:"Premium 3+1",level:15,area:195}] },
  { id: "tr-res-ankapark", name: "Anka Park Residence", addr: "Yenimahalle", city: "Ankara", zip: "06170", lat: 39.9700, lng: 32.8097, beds: 3, baths: 2, sqft: 1500, year: 2017, price: 8000000, desc: "Ankara'nın batısında modern tasarımlı aile rezidansı.", facilities: ["Havuz","Fitness","Çocuk Parkı","Güvenlik","Otopark"], photos: [], floors: [{name:"Standart 2+1",level:4,area:105},{name:"Geniş 3+1",level:10,area:155}] },
  // IZMIR
  { id: "tr-res-folkart", name: "Folkart Towers", addr: "Adalet Mah. Manas Blv. No:47, Bayraklı", city: "Izmir", zip: "35530", lat: 38.4524, lng: 27.1751, beds: 3, baths: 2, sqft: 2200, year: 2014, price: 18000000, desc: "İzmir'in simgesi, ikiz kuleler, deniz manzarası, 5 yıldızlı otel entegrasyonu.", facilities: ["Hilton Hotel","SPA","Infinity Pool","Sky Lounge","Business Center","AVM"], photos: [], floors: [{name:"Sea View 2+1",level:15,area:140},{name:"Panoramic 3+1",level:30,area:220}] },
  { id: "tr-res-mistral", name: "Mistral İzmir", addr: "Mavişehir, Karşıyaka", city: "Izmir", zip: "35590", lat: 38.4682, lng: 27.0851, beds: 3, baths: 2, sqft: 1800, year: 2015, price: 14000000, desc: "Mavişehir'de deniz kenarında modern rezidans yaşamı.", facilities: ["Deniz Kenarı","Havuz","Fitness","Çocuk Kulübü","Marina"], photos: [], floors: [{name:"Marina View 2+1",level:8,area:130},{name:"Sea Front 3+1",level:18,area:185}] },
  // ANTALYA
  { id: "tr-res-lara", name: "Lara Yalı Residence", addr: "Şirinyalı Mah. Lara Cad., Muratpaşa", city: "Antalya", zip: "07160", lat: 36.8617, lng: 30.7451, beds: 4, baths: 3, sqft: 2800, year: 2012, price: 22000000, desc: "Antalya Lara'da denize sıfır lüks rezidans.", facilities: ["Özel Plaj","Havuz","SPA","Restoran","Spor Salonu","Çocuk Aqua Park"], photos: [], floors: [{name:"Garden 2+1",level:1,area:130},{name:"Sea Front 3+1",level:10,area:210},{name:"Penthouse 4+1",level:20,area:350}] },
  { id: "tr-res-terra", name: "Terra City Antalya", addr: "Fener Mah. Tekelioglu Cd., Muratpaşa", city: "Antalya", zip: "07160", lat: 36.8590, lng: 30.7312, beds: 3, baths: 2, sqft: 1600, year: 2016, price: 15000000, desc: "Antalya'nın merkezinde AVM entegrasyonlu modern rezidans.", facilities: ["Terra City AVM","Havuz","Fitness","SPA","Çocuk Alanı"], photos: [], floors: [{name:"City View 2+1",level:5,area:110},{name:"Premium 3+1",level:15,area:165}] },
  // BODRUM
  { id: "tr-res-yalikavak", name: "Yalıkavak Marina Villas", addr: "Yalıkavak, Çökertme Cd., Bodrum", city: "Mugla", zip: "48990", lat: 37.1042, lng: 27.2872, beds: 6, baths: 6, sqft: 6500, year: 2019, price: 165000000, desc: "Bodrum Yalıkavak Marina'da özel havuzlu ultra lüks villalar.", facilities: ["Özel Havuz","Marina","Özel İskele","SPA","Helipad","Concierge"], photos: [], floors: [{name:"Master Villa",level:1,area:400},{name:"Pool Level",level:0,area:250}] },
  { id: "tr-res-mandarin", name: "Mandarin Oriental Bodrum Residences", addr: "Cennet Koyu, Göltürkbükü", city: "Mugla", zip: "48483", lat: 37.0843, lng: 27.3928, beds: 5, baths: 5, sqft: 5500, year: 2014, price: 120000000, desc: "Mandarin Oriental otel kalitesinde lüks konut deneyimi, özel koy.", facilities: ["Özel Koy","6 Restoran","SPA","Beach Club","Su Sporları","Butler Servisi"], photos: [], floors: [{name:"Sea Suite 3+1",level:1,area:280},{name:"Royal Villa 5+1",level:1,area:550}] },
  // BURSA
  { id: "tr-res-mudanya", name: "Mudanya Sahil Residence", addr: "Mudanya Sahil Yolu", city: "Bursa", zip: "16940", lat: 40.3753, lng: 28.8820, beds: 3, baths: 2, sqft: 1600, year: 2020, price: 8000000, desc: "Bursa Mudanya sahilinde huzurlu rezidans yaşamı.", facilities: ["Sahil","Havuz","Fitness","Çocuk Parkı","Market"], photos: [], floors: [{name:"Sea View 2+1",level:4,area:115},{name:"Terrace 3+1",level:10,area:165}] },
  // TRABZON
  { id: "tr-res-trabzon", name: "Boztepe Panorama Residence", addr: "Boztepe, Ortahisar", city: "Trabzon", zip: "61040", lat: 41.0015, lng: 39.7178, beds: 3, baths: 2, sqft: 1500, year: 2021, price: 6000000, desc: "Trabzon Boztepe'de Karadeniz manzaralı modern rezidans.", facilities: ["Deniz Manzarası","Fitness","Çocuk Parkı","Güvenlik","Otopark"], photos: [], floors: [{name:"Standart 2+1",level:3,area:105},{name:"Manzara 3+1",level:8,area:155}] },
  // GAZIANTEP
  { id: "tr-res-gaziantep", name: "Şehitkamil Premium Residence", addr: "Şehitkamil", city: "Gaziantep", zip: "27090", lat: 37.0662, lng: 37.3833, beds: 4, baths: 2, sqft: 1800, year: 2019, price: 5500000, desc: "Gaziantep'te premium aile rezidansı, şehir manzarası.", facilities: ["Havuz","Fitness","Çocuk Parkı","Otopark","Güvenlik","Market"], photos: [], floors: [{name:"Aile 3+1",level:5,area:145},{name:"Geniş 4+1",level:12,area:185}] },
];

async function main() {
  console.log("🏙️ TÜRKİYE KAPSAMLI REZİDANS PROJELERİ + DİJİTAL İKİZLER\n");

  const prisma = prismaManager.getClient("TR");

  // 1. Organization
  const org = await prisma.organization.upsert({
    where: { id: ORG_ID },
    update: {},
    create: {
      id: ORG_ID,
      name: "Reservatior Turkey - Premium Residences",
      type: "AGENCY",
      region: "TR",
      defaultCurrency: "TRY",
      defaultLocale: "tr-TR",
      taxReportingEnabled: true,
      complianceTracking: true,
      contactEmail: "tr@reservatior.com",
      address: "Büyükdere Cad. No:199, Levent, Istanbul 34394",
    },
  });
  console.log(`✅ Organizasyon: ${org.name}\n`);

  for (const p of PROJECTS) {
    const propId = `tr_prop_${p.id}`;

    // 2. Property
    const property = await prisma.property.upsert({
      where: { id: propId },
      update: {},
      create: {
        id: propId,
        orgId: org.id,
        name: p.name,
        type: "APARTMENT",
        region: "TR",
        currency: "TRY",
        addressLine1: p.addr,
        city: p.city,
        state: p.city,
        zip: p.zip,
        country: "TR",
        lat: p.lat,
        lng: p.lng,
        propertyCategory: "RESIDENTIAL",
        listingType: "SALE",
        listingStatus: "AVAILABLE",
        yearBuilt: p.year,
        livingAreaSqFt: p.sqft,
        bedrooms: p.beds,
        bathrooms: p.baths,
        assessedValue: p.price,
        marketValue: Math.round(p.price * 1.10),
      },
    });

    // 3. Listing
    await prisma.listing.upsert({
      where: { id: `tr_list_${p.id}` },
      update: {},
      create: {
        id: `tr_list_${p.id}`,
        orgId: org.id,
        propertyId: property.id,
        type: ListingType.SALE,
        status: ListingStatus.AVAILABLE,
        strategy: EarningStrategy.LONG_TERM_STABLE,
        title: p.name,
        description: p.desc,
        price: Math.round(p.price * 1.10),
        priceCurrency: "TRY",
      },
    }).catch(() => {});

    // 4. Photos
    for (let i = 0; i < p.photos.length; i++) {
      await prisma.photo.upsert({
        where: { url: p.photos[i] },
        update: {},
        create: {
          id: `tr_photo_${p.id}_${i}`,
          url: p.photos[i],
          propertyId: property.id,
          type: i === 0 ? PhotoType.COVER : PhotoType.GALLERY,
          caption: `${p.name} - Görsel ${i + 1}`,
          featured: i === 0,
        },
      }).catch(() => {});
    }

    // 5. FloorPlans
    for (let i = 0; i < p.floors.length; i++) {
      const f = p.floors[i];
      await prisma.floorPlan.upsert({
        where: { id: `tr_floor_${p.id}_${i}` },
        update: {},
        create: {
          id: `tr_floor_${p.id}_${i}`,
          orgId: org.id,
          propertyId: property.id,
          name: f.name,
          description: `${f.area} m² - Kat ${f.level}`,
          floorLevel: f.level,
          imageUrl: `https://cdn.reservatior.com/floorplans/${p.id}_${i}.svg`,
        },
      }).catch(() => {});
    }

    // 6. Facilities
    for (let i = 0; i < p.facilities.length; i++) {
      await prisma.facility.upsert({
        where: { id: `tr_fac_${p.id}_${i}` },
        update: {},
        create: {
          id: `tr_fac_${p.id}_${i}`,
          orgId: org.id,
          propertyId: property.id,
          name: p.facilities[i],
        },
      }).catch(() => {});
    }

    // 7. VirtualTour
    await prisma.virtualTour.upsert({
      where: { id: `tr_vt_${p.id}` },
      update: {},
      create: {
        id: `tr_vt_${p.id}`,
        orgId: org.id,
        propertyId: property.id,
        name: `${p.name} - 360° Sanal Tur`,
        tourType: "360_PANORAMIC",
        thumbnailUrl: p.photos[0] || `https://cdn.reservatior.com/tours/${p.id}_thumb.jpg`,
        isActive: true,
      },
    }).catch(() => {});

    console.log(`  ✅ ${p.name.padEnd(40)} | ${p.city.padEnd(10)} | ₺${p.price.toLocaleString().padStart(15)} | ${p.floors.length} kat planı | ${p.facilities.length} tesis`);
  }

  console.log(`\n🎉 ${PROJECTS.length} Türkiye rezidans projesi başarıyla eklendi!`);
  console.log(`   📸 Fotoğraflar, 📐 Kat planları, 🏊 Tesisler, 🎥 Sanal turlar dahil.\n`);
}

main()
  .catch((e) => { console.error(e); process.exit(1); })
  .finally(async () => { await prismaManager.disconnectAll(); });
