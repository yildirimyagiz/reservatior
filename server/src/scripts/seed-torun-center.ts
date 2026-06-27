import prismaManager from '../lib/prisma';
import * as fs from 'fs';
import * as path from 'path';

const prisma = prismaManager.getClient('TR');
const ORG_ID = 'tr_residence_org';

async function run() {
  console.log('🌟 SEEDING TORUN CENTER PROJECT & CATALOG 🌟');

  // 1. Ensure Organization exists
  const org = await prisma.organization.upsert({
    where: { id: ORG_ID },
    update: {},
    create: {
      id: ORG_ID,
      name: 'Reservatior Turkey - Premium Residences',
      type: 'AGENCY',
      region: 'TR',
      defaultCurrency: 'TRY',
      defaultLocale: 'tr-TR',
    }
  });

  console.log(`🏢 Organization verified: ${org.name}`);

  // 2. Create Torun Center Master Property
  const masterPropId = 'prop_TORUN_CENTER_MASTER';
  const property = await prisma.property.upsert({
    where: { id: masterPropId },
    update: {
      name: 'Torun Center (Master Project Building)',
      addressLine1: 'Fulya, Büyükdere Cd. No: 74, Mecidiyeköy',
      city: 'Istanbul',
      state: 'Şişli',
      country: 'TR',
      lat: 41.0652,
      lng: 29.0016,
      yearBuilt: 2016,
      notes: 'Master Building for Torun Center project.'
    },
    create: {
      id: masterPropId,
      orgId: org.id,
      name: 'Torun Center (Master Project Building)',
      type: 'APARTMENT',
      region: 'TR',
      currency: 'TRY',
      addressLine1: 'Fulya, Büyükdere Cd. No: 74, Mecidiyeköy',
      city: 'Istanbul',
      state: 'Şişli',
      country: 'TR',
      lat: 41.0652,
      lng: 29.0016,
      propertyCategory: 'MIXED_USE',
      listingType: 'SALE',
      listingStatus: 'AVAILABLE',
      yearBuilt: 2016,
      notes: 'Master Building for Torun Center project.'
    }
  });

  console.log(`🏢 Master Property created: ${property.name}`);

  // 3. Create Project Entity
  const projectId = 'proj_TORUN_CENTER';
  const project = await prisma.project.upsert({
    where: { id: projectId },
    update: {
      name: 'Torun Center Mecidiyeköy',
      description: 'Torun Center offers high-end residential, office, and retail spaces in the heart of Istanbul Mecidiyeköy. Features modern design, state-of-the-art facilities, and central connectivity.',
      address: 'Fulya, Büyükdere Cd. No: 74, Mecidiyeköy, Şişli/İstanbul',
      propertyId: masterPropId,
      status: 'COMPLETED',
      budget: 150000000,
    },
    create: {
      id: projectId,
      orgId: org.id,
      name: 'Torun Center Mecidiyeköy',
      description: 'Torun Center offers high-end residential, office, and retail spaces in the heart of Istanbul Mecidiyeköy. Features modern design, state-of-the-art facilities, and central connectivity.',
      projectType: 'MIXED_USE',
      status: 'COMPLETED',
      address: 'Fulya, Büyükdere Cd. No: 74, Mecidiyeköy, Şişli/İstanbul',
      propertyId: masterPropId,
      budget: 150000000,
      currency: 'TRY'
    }
  });

  console.log(`🏗️ Project created: ${project.name}`);

  // 4. Attach PDF Catalog Document to the Master Property
  const docId = `doc_catalog_${projectId}`;
  const catalogUrl = '/uploads/projects/catalogs/Katalog.pdf';

  await prisma.document.upsert({
    where: { id: docId },
    update: {
      fileUrl: catalogUrl,
      title: 'Torun Center Proje Kataloğu (PDF)',
    },
    create: {
      id: docId,
      orgId: org.id,
      propertyId: masterPropId,
      title: 'Torun Center Proje Kataloğu (PDF)',
      documentType: 'CERTIFICATE',
      fileUrl: catalogUrl,
      fileName: 'Katalog.pdf',
      mimeType: 'application/pdf',
      fileSize: 4047481,
      checksum: 'placeholder_catalog_pdf',
    }
  });

  console.log(`📄 Catalog Document attached: ${catalogUrl}`);

  // 5. Add default Floor Plans (Tip 1, Tip 2, Tip 3)
  const floorPlans = [
    { name: '1+1 Residence Suite', desc: '85 m² - Cozy and luxurious residential suite', level: 10, img: 'https://cdn.reservatior.com/floorplans/torun_1.svg' },
    { name: '2+1 Luxury Residence', desc: '145 m² - Panorama skyline view residence', level: 25, img: 'https://cdn.reservatior.com/floorplans/torun_2.svg' },
    { name: '3+1 Executive Suite', desc: '210 m² - Grand layout with balcony and skyline terrace', level: 35, img: 'https://cdn.reservatior.com/floorplans/torun_3.svg' },
  ];

  for (let i = 0; i < floorPlans.length; i++) {
    const f = floorPlans[i];
    await prisma.floorPlan.upsert({
      where: { id: `fp_torun_${i}` },
      update: {},
      create: {
        id: `fp_torun_${i}`,
        orgId: org.id,
        propertyId: masterPropId,
        name: f.name,
        description: f.desc,
        floorLevel: f.level,
        imageUrl: f.img,
        isActive: true,
      }
    });
  }

  console.log(`📐 floor plans seeded for Torun Center.`);
  console.log('🏆 SEEDING FOR TORUN CENTER COMPLETED!');
}

run()
  .catch(console.error)
  .finally(() => prismaManager.disconnectAll());
