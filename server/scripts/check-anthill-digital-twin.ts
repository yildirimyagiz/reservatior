import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function checkAnthillDigitalTwinCompatibility() {
  try {
    console.log('Checking Anthill digital twin compatibility...');
    await prisma.$connect();
    
    // Get Anthill property
    const property = await prisma.property.findUnique({
      where: { id: 'anthill_tr_1' },
    });
    
    console.log('\n=== PROPERTY STRUCTURE ===');
    console.log('ID:', property?.id);
    console.log('Name:', property?.name);
    console.log('Type:', property?.type);
    console.log('Region:', property?.region);
    console.log('Currency:', property?.currency);
    console.log('Legal Compliance:', property?.legalComplianceStatus);
    console.log('Address:', property?.addressLine1, property?.city, property?.country);
    
    // Check listing
    const listing = await prisma.listing.findFirst({
      where: { propertyId: 'anthill_tr_1' },
    });
    
    console.log('\n=== LISTING STRUCTURE ===');
    console.log('Type:', listing?.type);
    console.log('Status:', listing?.status);
    console.log('Price:', listing?.price, listing?.priceCurrency);
    console.log('Strategy:', listing?.strategy);
    
    // Check photos
    const photos = await prisma.propertyPhoto.findMany({
      where: { propertyId: 'anthill_tr_1' },
    });
    
    console.log('\n=== DIGITAL TWIN FEATURES ===');
    console.log('Photos:', photos.length, '✓');
    console.log('Legal Compliance:', property?.legalComplianceStatus, '✓');
    console.log('Region Support:', property?.region, '✓');
    console.log('Currency Support:', property?.currency, '✓');
    console.log('Listing Type:', listing?.type, '✓');
    
    // Check for digital twin specific fields
    console.log('\n=== DIGITAL TWIN COMPATIBILITY ===');
    const compatibility = {
      basicStructure: !!property?.id && !!property?.name,
      listingSupport: !!listing?.type && ['SALE', 'RENT'].includes(listing?.type),
      mediaSupport: photos.length > 0,
      legalSupport: !!property?.legalComplianceStatus,
      regionSupport: !!property?.region,
      currencySupport: !!property?.currency,
      addressSupport: !!property?.addressLine1 && !!property?.city,
    };
    
    console.log('Basic Structure:', compatibility.basicStructure ? '✓' : '✗');
    console.log('Listing Support:', compatibility.listingSupport ? '✓' : '✗');
    console.log('Media Support:', compatibility.mediaSupport ? '✓' : '✗');
    console.log('Legal Support:', compatibility.legalSupport ? '✓' : '✗');
    console.log('Region Support:', compatibility.regionSupport ? '✓' : '✗');
    console.log('Currency Support:', compatibility.currencySupport ? '✓' : '✗');
    console.log('Address Support:', compatibility.addressSupport ? '✓' : '✗');
    
    const isCompatible = Object.values(compatibility).every(v => v === true);
    console.log('\n=== RESULT ===');
    console.log('Digital Twin Compatible:', isCompatible ? '✓ YES' : '✗ NO');
    
    if (!isCompatible) {
      console.log('\nMissing features:');
      Object.entries(compatibility).forEach(([key, value]) => {
        if (!value) console.log(`- ${key}`);
      });
    }
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

checkAnthillDigitalTwinCompatibility();
