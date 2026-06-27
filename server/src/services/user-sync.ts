import { prismaManager } from "../lib/prisma";

export class UserSyncService {
  /**
   * Checks if a user exists in the local database for the target region.
   * If not, it searches all other region databases for the user.
   * If found, it clones the user and their authentication accounts into the local database.
   *
   * @param email The user's email address
   * @param targetRegion The region currently being accessed
   * @returns boolean indicating whether the user is now available in the local database
   */
  async cloneUserIfNeeded(email: string, targetRegion: string): Promise<boolean> {
    const localPrisma = prismaManager.getClient(targetRegion);

    // 1. Check if user already exists locally
    const localUser = await localPrisma.user.findUnique({
      where: { email },
    });

    if (localUser) {
      return true; // Already exists, no need to clone
    }

    // 2. Search other regions
    const allRegions = prismaManager.getSupportedRegions();
    const normalizedTarget = targetRegion.trim().toUpperCase();

    for (const region of allRegions) {
      if (region === normalizedTarget) continue;

      // Ensure we have a client for this region
      const foreignPrisma = prismaManager.getClient(region);
      
      // We wrap in try-catch in case a region database is offline
      try {
        const foreignUser = await foreignPrisma.user.findUnique({
          where: { email },
          include: { accounts: true },
        });

        if (foreignUser) {
          console.log(`🌍 UserSyncService: Found user [${email}] in region [${region}]. Cloning to [${normalizedTarget}]...`);

          // 3. Clone the user into the local database
          const clonedUser = await localPrisma.user.create({
            data: {
              email: foreignUser.email,
              name: foreignUser.name,
              phone: foreignUser.phone,
              imageUrl: foreignUser.imageUrl,
              
              // originRegion: foreignUser.originRegion || region,
              // isClone: true,
              lastSyncedAt: new Date(),
              accounts: {
                create: foreignUser.accounts.map((acc) => ({
                  type: acc.type,
                  providerId: acc.providerId,
                  accountId: acc.accountId,
                  accessToken: acc.accessToken,
                  refreshToken: acc.refreshToken,
                  accessTokenExpiresAt: acc.accessTokenExpiresAt,
                })),
              },
            },
          });

          console.log(`✅ UserSyncService: Successfully cloned user [${clonedUser.id}] to [${normalizedTarget}].`);
          return true;
        }
      } catch (err) {
        console.error(`⚠️ UserSyncService: Failed to query region [${region}] for cloning:`, err);
        // Continue searching other regions
      }
    }

    // User was not found in any region
    return false;
  }
}

export const userSyncService = new UserSyncService();
