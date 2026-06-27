import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

const imageMapping: Record<string, string> = {
  '/uploads/anthill/3cdc6f475dcf4136adac6a50f408677a.medium.jpg': 'http://localhost:3000/uploads/anthill/3cdc6f475dcf4136adac6a50f408677a.medium.jpg',
  '/uploads/anthill/Anthill_residence_with_flags.jpg': 'http://localhost:3000/uploads/anthill/Anthill_residence_with_flags.jpg',
  '/uploads/anthill/project_top_image_318e7f19ac03bcd271d864e5f5a83aa8.jpg': 'http://localhost:3000/uploads/anthill/project_top_image_318e7f19ac03bcd271d864e5f5a83aa8.jpg',
  '/uploads/anthill/TURKECO-Yesil-Bina-Danismanligi-referanslar-Anthill-Residence-K-2-breeam-sertifikasi.webp': 'http://localhost:3000/uploads/anthill/TURKECO-Yesil-Bina-Danismanligi-referanslar-Anthill-Residence-K-2-breeam-sertifikasi.webp',
};

async function updateAnthillPhotoUrls() {
  try {
    console.log('Connecting to Turkish database...');
    await prisma.$connect();
    
    // Get all photos with relative paths
    const photos = await prisma.propertyPhoto.findMany({
      where: {
        url: {
          startsWith: '/uploads/anthill/',
        },
      },
    });

    console.log(`Found ${photos.length} photos to update`);

    for (const photo of photos) {
      const newUrl = imageMapping[photo.url];
      if (newUrl) {
        console.log(`Updating: ${photo.url} -> ${newUrl}`);
        await prisma.propertyPhoto.update({
          where: { id: photo.id },
          data: { url: newUrl },
        });
      } else {
        console.log(`No mapping found for: ${photo.url}`);
      }
    }

    console.log('Successfully updated Anthill photo URLs to full URLs');
  } catch (error) {
    console.error('Error updating Anthill photo URLs:', error);
  } finally {
    await prisma.$disconnect();
  }
}

updateAnthillPhotoUrls();
