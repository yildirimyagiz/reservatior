import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

const anthillImages = [
  '/Users/os2026/Downloads/Reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL/Genel Görseller/3cdc6f475dcf4136adac6a50f408677a.medium.jpg',
  '/Users/os2026/Downloads/Reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL/Genel Görseller/Anthill_residence_with_flags.jpg',
  '/Users/os2026/Downloads/Reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL/Genel Görseller/project_top_image_318e7f19ac03bcd271d864e5f5a83aa8.jpg',
  '/Users/os2026/Downloads/Reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL/Genel Görseller/TURKECO-Yesil-Bina-Danismanligi-referanslar-Anthill-Residence-K-2-breeam-sertifikasi.webp',
];

async function addAnthillCoverImages() {
  try {
    console.log('Connecting to Turkish database...');
    console.log('Database URL:', trDatabaseUrl);
    
    // Test connection
    await prisma.$connect();
    console.log('Connected successfully');
    
    // Find Anthill properties
    const anthillProperties = await prisma.property.findMany({
      where: {
        OR: [
          { name: { contains: 'ANTHILL', mode: 'insensitive' } },
          { city: { contains: 'İSTANBUL', mode: 'insensitive' } },
          { addressLine1: { contains: 'ŞİSLİ', mode: 'insensitive' } },
        ],
      },
      take: 10,
    });

    console.log(`Found ${anthillProperties.length} Anthill properties`);

    if (anthillProperties.length === 0) {
      console.log('No Anthill properties found. Searching for properties in Istanbul, Şişli...');
      
      const istanbulProperties = await prisma.property.findMany({
        where: {
          AND: [
            { city: { contains: 'İSTANBUL', mode: 'insensitive' } },
            { addressLine1: { contains: 'ŞİSLİ', mode: 'insensitive' } },
          ],
        },
        take: 10,
      });

      console.log(`Found ${istanbulProperties.length} properties in Istanbul, Şişli`);

      if (istanbulProperties.length === 0) {
        console.log('No matching properties found. Please check the database.');
        return;
      }

      for (let i = 0; i < istanbulProperties.length; i++) {
        const property = istanbulProperties[i];
        console.log(`Processing property: ${property.name} (${property.id})`);
        await addImagesToProperty(property.id, property.orgId, i);
      }
    } else {
      for (let i = 0; i < anthillProperties.length; i++) {
        const property = anthillProperties[i];
        console.log(`Processing Anthill property: ${property.name} (${property.id})`);
        await addImagesToProperty(property.id, property.orgId, i);
      }
    }

    console.log('Successfully added Anthill cover images');
  } catch (error) {
    console.error('Error adding Anthill cover images:', error);
  } finally {
    await prisma.$disconnect();
  }
}

async function addImagesToProperty(propertyId: string, orgId: string, imageIndex: number) {
  // Remove existing primary photos for this property
  await prisma.propertyPhoto.updateMany({
    where: {
      propertyId: propertyId,
      isPrimary: true,
    },
    data: {
      isPrimary: false,
    },
  });

  // Assign a single image based on the property index
  const imageUrl = anthillImages[imageIndex % anthillImages.length];
  
  const existingPhoto = await prisma.propertyPhoto.findFirst({
    where: {
      propertyId: propertyId,
      url: imageUrl,
    },
  });

  if (existingPhoto) {
    console.log(`Photo already exists, updating to primary: ${imageUrl}`);
    await prisma.propertyPhoto.update({
      where: { id: existingPhoto.id },
      data: {
        isPrimary: true,
        sortOrder: 0,
      },
    });
  } else {
    console.log(`Adding new photo: ${imageUrl}`);
    await prisma.propertyPhoto.create({
      data: {
        orgId,
        propertyId: propertyId,
        url: imageUrl,
        caption: `Anthill Residence - Görsel ${imageIndex + 1}`,
        isPrimary: true,
        sortOrder: 0,
      },
    });
  }
}

addAnthillCoverImages();
