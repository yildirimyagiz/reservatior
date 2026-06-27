import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const anthillImages = [
  'http://localhost:3000/uploads/anthill/3cdc6f475dcf4136adac6a50f408677a.medium.jpg',
  'http://localhost:3000/uploads/anthill/Anthill_residence_with_flags.jpg',
  'http://localhost:3000/uploads/anthill/project_top_image_318e7f19ac03bcd271d864e5f5a83aa8.jpg',
  'http://localhost:3000/uploads/anthill/TURKECO-Yesil-Bina-Danismanligi-referanslar-Anthill-Residence-K-2-breeam-sertifikasi.webp',
];

async function addAnthillPhotosToUS() {
  try {
    console.log('Connecting to US database...');
    await prisma.$connect();
    
    // Find Anthill properties in US database
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

    console.log(`Found ${anthillProperties.length} Anthill properties in US database`);

    if (anthillProperties.length === 0) {
      console.log('No Anthill properties found in US database');
      return;
    }

    for (let i = 0; i < anthillProperties.length; i++) {
      const property = anthillProperties[i];
      console.log(`Processing property: ${property.name} (${property.id})`);
      await addImagesToProperty(property.id, property.orgId, i);
    }

    console.log('Successfully added Anthill cover images to US database');
  } catch (error) {
    console.error('Error adding Anthill cover images to US database:', error);
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

addAnthillPhotosToUS();
