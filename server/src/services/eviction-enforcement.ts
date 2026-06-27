import { OpenBankingService } from './openbanking';
import { prismaManager } from "../lib/prisma";

// import { SmartLockService } from './smart-lock'; // Varsayımsal IoT servisimiz

const prisma = prismaManager.getDefault();

export class EvictionEnforcementService {
  
  /**
   * Cron-Job tarafından her gece 00:01'de tetiklenir.
   * Süresi dolmuş ancak kiracısı çıkmamış (ve otomatik tahliyesi aktif) abonelikleri bulur.
   */
  static async processExpiredLeases() {
    console.log('[EvictionEnforcement] Scanning for expired tech-managed leases...');

    const now = new Date();
    
    // Bitiş tarihi geçmiş, hala ACTIVE görünen ve Tech-Eviction açık olan kiralara bak
    const expiredLeases = await prisma.lease.findMany({
      where: {
        endDate: { lt: now },
        status: 'ACTIVE',
        OR: [
          { autoEvictionEnabled: true },
          { automatedEnforcement: true }
        ]
      },
      include: {
        tenant: true
      }
    });

    for (const lease of expiredLeases) {
      await this.enforceTechEviction(lease);
    }
  }

  /**
   * Süresi dolmamış ama ihlal olan kiralamalarda otomatik yaptırım.
   * Gecikmiş kira, depozit ihlali, sözleşme şartlarına uymama gibi durumlar.
   */
  static async processViolations() {
    console.log('[EvictionEnforcement] Scanning for active lease violations...');

    const now = new Date();
    const thirtyDaysAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);

    // automatedEnforcement açık olan aktif kiralamalarda gecikmiş ödemeleri kontrol et
    const violatingLeases = await prisma.lease.findMany({
      where: {
        status: 'ACTIVE',
        automatedEnforcement: true,
        endDate: { gt: now },
        rentSchedules: {
          some: {
            status: 'UNPAID',
            dueDate: { lt: now }
          }
        }
      },
      include: {
        tenant: true,
        rentSchedules: {
          where: { status: 'UNPAID', dueDate: { lt: now } },
          orderBy: { dueDate: 'asc' }
        }
      }
    });

    for (const lease of violatingLeases) {
      console.log(`[EvictionEnforcement] Violation detected for Lease ${lease.id}: ${lease.rentSchedules.length} unpaid schedules`);
      // TODO: Implement progressive enforcement:
      // 1. Uyarı bildirimi (e-posta/SMS)
      // 2. VRP ceza çekimi
      // 3. Gecikme faizi uygulama
      // 4. Depozit uyarısı
      // 5. Smart lock kısıtlama (aşamalı)
      // 6. Yasal süreç başlatma
    }
  }

  /**
   * Hukuksuz (Mahkeme dışı) tahliye mekanizmasını devreye sokar.
   */
  static async enforceTechEviction(lease: any) {
    console.log(`[EvictionEnforcement] Triggering tech-eviction for Lease ${lease.id}`);

    // 1. Durumu EVICTION_PENDING'e al
    await prisma.lease.update({
      where: { id: lease.id },
      data: { status: 'EVICTION_PENDING' }
    });

    let isEvictedViaTech = false;

    // 2. AŞAMA: Open Banking VRP (Düzenli Çekim) Cezası
    if (lease.vrpPenaltyRate) {
      const penaltyAmount = Number(lease.rent) * Number(lease.vrpPenaltyRate);
      console.log(`[EvictionEnforcement] VRP Penalty Triggered: ${penaltyAmount} ${lease.currency}`);
      
      // Kiracının açık bankacılık yetkisi ile hesabından cezalı tutarı çek
      // (Gerçek hayatta burada openbanking_mandate tablosundan tenant'a ait yetkiyi bulup çekeriz)
      try {
        await OpenBankingService.executeRecurringPayment(
          `mandate_for_tenant_${lease.tenantId}`, 
          penaltyAmount, 
          `EVICTION_PENALTY_LEASE_${lease.id}`
        );
        console.log(`[EvictionEnforcement] Penalty successfully collected. Tenant paid the price.`);
      } catch (error) {
        console.error(`[EvictionEnforcement] VRP Penalty failed. Tenant might have revoked mandate or insufficient funds.`);
        // Para çekilemezse, bir sonraki sert aşamaya (Hizmet Kesintisi) geçilir.
      }
    }

    // 3. AŞAMA: Hizmet (Utility & Smart Lock) Kesintisi
    if (lease.isUtilityManaged) {
      console.log(`[EvictionEnforcement] Revoking Utilities (Wi-Fi, Electricity management) for Lease ${lease.id}`);
      // await UtilityProviderAPI.suspendServices(lease.listingId);
      isEvictedViaTech = true;
    }

    if (lease.smartLockId) {
      console.log(`[EvictionEnforcement] Downgrading Smart Lock access for Lock ${lease.smartLockId}`);
      // await SmartLockService.revokeAccess(lease.smartLockId, lease.tenantId);
      // Sadece gündüz saatleri veya tamamen kilitleme senaryosu işletilir
      isEvictedViaTech = true;
    }

    // 4. Sonuçlandırma
    if (isEvictedViaTech) {
      await prisma.lease.update({
        where: { id: lease.id },
        data: { status: 'EVICTED_VIA_TECH' }
      });
      console.log(`[EvictionEnforcement] Tenant effectively evicted via tech restrictions. Court bypassed.`);
    }
  }
}
