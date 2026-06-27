import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const anthillPhotos = [
  {
    name: '3cdc6f475dcf4136adac6a50f408677a.medium.jpg',
    caption: 'Anthill Exterior 1'
  },
  {
    name: 'Anthill_residence_with_flags.jpg',
    caption: 'Anthill Exterior with Flags'
  },
  {
    name: 'TURKECO-Yesil-Bina-Danismanligi-referanslar-Anthill-Residence-K-2-breeam-sertifikasi.webp',
    caption: 'Anthill BREEAM Certificate'
  },
  {
    name: 'project_top_image_318e7f19ac03bcd271d864e5f5a83aa8.jpg',
    caption: 'Anthill Project Top View'
  }
];

const basePath = '/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL/Genel Görseller';

async function updateAnthillPhotos() {
  try {
    console.log('Connecting to TR database...');
    await prisma.$connect();
    
    // Find all Anthill properties
    const anthillProperties = await prisma.$queryRaw`
      SELECT id, "orgId" FROM "Property" WHERE id ILIKE '%anthill%' OR name ILIKE '%anthill%'
    `;
    
    const properties = anthillProperties as any[];
    console.log(`Found ${properties.length} Anthill properties.`);
    
    let updatedCount = 0;

    for (const property of properties) {
      const propertyId = property.id;
      const orgId = property.orgId;
      
      // Delete existing photos
      const deleteRes = await prisma.propertyPhoto.deleteMany({
        where: { propertyId }
      });
      console.log(`Deleted ${deleteRes.count} existing photos for property: ${propertyId}`);
      
      // Add new local photos
      for (let i = 0; i < anthillPhotos.length; i++) {
        const photo = anthillPhotos[i];
        const url = encodeURI(`${basePath}/${photo.name}`);
        
        await prisma.propertyPhoto.create({
          data: {
            id: `photo_${propertyId}_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
            orgId: orgId,
            propertyId: propertyId,
            url: url,
            caption: photo.caption,
            isPrimary: i === 0, // make the first one primary
            sortOrder: i,
          }
        });
      }
      
      updatedCount++;
      console.log(`Added ${anthillPhotos.length} real local photos to property: ${propertyId}`);
    }
    
    console.log(`\nSuccessfully updated ${updatedCount} properties with real Anthill images.`);
  } catch (error) {
    console.error('Error updating Anthill photos:', error);
  } finally {
    await prisma.$disconnect();
  }
}

updateAnthillPhotos();
