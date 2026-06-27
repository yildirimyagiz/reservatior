import { PrismaClient, MemberRoleKey } from '@prisma/client';
import * as crypto from 'crypto';

const prisma = new PrismaClient();

async function run() {
  console.log('🏢 MEGA PROJE YÖNETİM (FACILITY MANAGER) HESAPLARI OLUŞTURULUYOR...');

  // Ana Organizasyonu al veya oluştur
  const org = await prisma.organization.upsert({
    where: { id: 'tr_residence_org' },
    update: {},
    create: {
      id: 'tr_residence_org',
      name: 'Reservatior Turkey - Premium Residences',
      type: 'AGENCY',
      region: 'TR',
      defaultCurrency: 'TRY',
      defaultLocale: 'tr-TR',
    }
  });

  // Admin Rolünü Bul Veya Yarat
  const adminRole = await prisma.role.upsert({
    where: { orgId_key: { orgId: org.id, key: MemberRoleKey.ORG_ADMIN } },
    update: {},
    create: {
      orgId: org.id,
      key: MemberRoleKey.ORG_ADMIN,
      name: 'Organization Admin'
    }
  });

  const managementTeams = [
    { name: 'Quasar İstanbul Yönetimi', email: 'yonetim@quasaristanbul.com', project: 'Quasar' },
    { name: 'Büyükyalı Tesis Yönetimi', email: 'yonetim@buyukyali.com', project: 'Büyükyalı' },
    { name: 'Acarkent Boğazüstü Yönetim', email: 'yonetim@acarkent.com', project: 'Acarkent' },
    { name: 'İstinye Park Residans Yönetimi', email: 'yonetim@istinyepark.com.tr', project: 'İstinye Park' },
    { name: 'Validebağ Konakları Yönetimi', email: 'yonetim@validebag.com', project: 'Validebağ Konakları' },
    { name: 'Skyland İstanbul Yönetimi', email: 'yonetim@skyland.com', project: 'Skyland' },
    { name: 'Sinpaş Queen Bomonti Yönetimi', email: 'yonetim@queenbomonti.com', project: 'Sinpaş Queen' },
    { name: 'Vadi İstanbul Yönetimi', email: 'yonetim@vadiistanbul.com', project: 'Vadi İstanbul' },
    { name: 'Ulus Lotus Sitesi Yönetimi', email: 'yonetim@uluslotus.com', project: 'Ulus Lotus' },
    { name: 'Upcity Yönetimi', email: 'yonetim@upcity.com', project: 'Upcity' },
    { name: 'Polat Tower Yönetimi', email: 'yonetim@polattower.com', project: 'Polat Tower' },
    { name: 'Nish Adalar Yönetimi', email: 'yonetim@nishadalar.com', project: 'Nish Adalar' },
  ];

  for (const team of managementTeams) {
    // Sadece Kullanıcıyı Yarat
    const user = await prisma.user.upsert({
      where: { email: team.email },
      update: {
        name: team.name,
      },
      create: {
        email: team.email,
        name: team.name,
      }
    });

    // Kullanıcıyı Organizasyon Üyesi Olarak Admin Rolüyle Ata
    await prisma.organizationMember.upsert({
      where: { userId_orgId: { userId: user.id, orgId: org.id } },
      update: { roleId: adminRole.id },
      create: {
        userId: user.id,
        orgId: org.id,
        roleId: adminRole.id
      }
    });

    console.log(`✅ [${team.project}] için Yönetici Hesabı Aktif: ${user.email} (Rol: ORG_ADMIN)`);
  }

  console.log('🎉 TÜM BİNA/TESİS YÖNETİM HESAPLARI BAŞARIYLA OLUŞTURULDU VE DİJİTAL İKİZ YETKİLERİ ATANDI.');
}

run()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
