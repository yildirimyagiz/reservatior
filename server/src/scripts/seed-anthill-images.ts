import prismaManager from '../lib/prisma';
import { PropertyCategory, ListingType, ListingStatus } from '@/schemas/generated';
import * as fs from 'fs';
import * as path from 'path';

async function run() {
  console.log('🌟 SEEDING ANTHILL IMAGES & PLANS 🌟');
  const prisma = prismaManager.getClient('TR');
  const orgId = 'tr_residence_org';
  const masterPropId = 'prop_ANTHILL_MASTER';
  const projectId = 'proj_ANTHILL';

  // 1. Project & Master Property Images
  const genelGorseller = [
    '/uploads/anthill/genel_gorseller/3cdc6f475dcf4136adac6a50f408677a.medium.jpg',
    '/uploads/anthill/genel_gorseller/Anthill_residence_with_flags.jpg',
    '/uploads/anthill/genel_gorseller/TURKECO-Yesil-Bina-Danismanligi-referanslar-Anthill-Residence-K-2-breeam-sertifikasi.webp',
    '/uploads/anthill/genel_gorseller/project_top_image_318e7f19ac03bcd271d864e5f5a83aa8.jpg'
  ];

  console.log('📸 Adding General Images to Master Property...');
  for (let i = 0; i < genelGorseller.length; i++) {
    const url = genelGorseller[i];
    await prisma.propertyPhoto.create({
      data: {
        orgId,
        propertyId: masterPropId,
        url,
        isPrimary: i === 0, // First image is primary
        sortOrder: i,
        caption: 'Anthill Residence Genel Görsel'
      }
    });
  }

  // 2. Floor Plans
  const planlar = [
    { url: '/uploads/anthill/planlar/1.jpg', name: 'Plan 1', level: 1 },
    { url: '/uploads/anthill/planlar/2.jpg', name: 'Plan 2', level: 2 },
    { url: '/uploads/anthill/planlar/35-39 Floors 3,4+1.jpg', name: '35-39 Floors (3+1, 4+1)', level: 35 },
    { url: '/uploads/anthill/planlar/35-39 Floors.jpg', name: '35-39 Floors', level: 35 },
    { url: '/uploads/anthill/planlar/6-14-19 Floors.jpg', name: '6-14-19 Floors', level: 6 },
    { url: '/uploads/anthill/planlar/6-14-19-24 Floors.jpg', name: '6-14-19-24 Floors', level: 6 }
  ];

  console.log('📐 Adding Floor Plans to Master Property...');
  for (const plan of planlar) {
    await prisma.floorPlan.create({
      data: {
        orgId,
        propertyId: masterPropId,
        name: plan.name,
        floorLevel: plan.level,
        imageUrl: plan.url,
        description: 'Anthill Residence Kat Planı'
      }
    });
  }

  console.log('✅ IMAGES & PLANS SUCCESSFULLY SEEDED!');
}

run()
  .catch(console.error)
  .finally(() => prismaManager.disconnectAll());
