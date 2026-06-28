/**
 * Full Seed — tüm 213 model için 10'ar kayıt (Post)
 * + her bağımlı modelden en az 1 örnek
 *
 * Çalıştırma:
 *   npx prisma db seed
 *
 * package.json:
 *   "prisma": { "seed": "ts-node --compiler-options {\"module\":\"CommonJS\"} prisma/seed.ts" }
 */

import { PrismaClient } from "@prisma/client";
import {
  OrgType,
  Region,
  PropertyType,
  PropertyCategory,
  ListingType,
  ListingStatus,
  EarningStrategy,
  BookingStatus,
  PaymentStatus,
  LeaseStatus,
  TransactionType,
  ContractType,
  ContractStatus,
  SignatureStatus,
  TaskType,
  TaskStatus,
  Priority,
  NotificationStatus,
  NotificationChannel,
  MessageParticipantType,
  ContactType,
  LedgerEventType,
  MemberRoleKey,
  PermissionKey,
  ExportType,
  ExportStatus,
  SyncStatus,
  MLSProviderKey,
  TaxPeriod,
  TaxCategoryType,
  RiskTolerance,
  MaintenanceBlockType,
  WorkOrderStatus,
  RenewalStatus,
  AssetType,
  DepreciationMethod,
  RelationshipStatus,
  ApplicationStatus,
  LoyaltyTier,
  ReferralStatus,
  EarningType,
  GoalType,
  MembershipType,
  RewardType,
  SubscriptionStatus,
  WidgetType,
  ModelType,
  LeadStatus,
  SourceType,
  DealStatusUSA,
  DocumentTypeUSA,
  PayoutStatusUSA,
  CommissionTypeUS,
  PaymentMethodUS,
  ComplianceType,
  LocationAccuracy,
  GeocodingStatus,
  MapProvider,
  MarkerType,
  MarkerIcon,
  RentalPlatform,
  SyncDirection,
  RentalStatus,
  ListingChannelType,
  HashtagType,
  SharedStatus,
  ReviewEntityType,
  CampaignType,
  CampaignStatus,
  NotificationType,
  OfferStatus,
  OfferType,
  OwnershipCategory,
  OwnershipType,
  PaymentMethod,
  PhotoType,
  AnalyticsType,
  ChannelType,
  ChannelCategory,
  CommissionRuleType,
  CommunicationType,
  ComplianceStatus,
  ExpenseStatus,
  ExpenseType,
  DiscountType,
  FacilityStatus,
  FacilityType,
  Gender,
  MortgageStatus,
  IncreaseStatus,
  MentionType,
  PermissionLevel,
  AmenityCategory,
  AmenityAccessType,
  SharedAmenityType,
  TicketStatus,
  EventType,
  EscrowStatus,
  EscrowTriggerEvent,
  EscrowReleaseStatus,
  EscrowDisputeType,
  EscrowDisputeStatus,
  EscrowDisputeParty,
  AIChatRole,
  AIChatModuleType,
  PaymentNegotiationStatus,
  VideoLoraStyle,
  VideoPipeline,
  VideoLoraStrategy,
  VideoTargetPlatform,
  VideoContentStatus,
  VideoCampaignType,
  AmbassadorCategory,
  AmbassadorStatus,
  SocialImpactType,
  NegotiationParty,
  NegotiationOfferStatus,
  AccountType,
  BookingSource,
  RecurringFrequency,
  PropertyStatus,
  ReportStatus,
  ReportType,
  ReservationStatus,
  ReviewType,
  SubscriptionTier,
  TaskPriority,
  TaxStatus,
  TaxType,
  UnitStatus,
  UnitType,
  ValuationType,
  ValuationStatus,
  ConfidenceLevel,
  VerificationMethod,
  OwnershipVerificationStatus,
  OwnershipDocumentType,
  SecurityScreeningStatus,
  SecurityRiskLevel,
  VendorTier,
  VideoQuality,
  VendorStatus,
  ProjectStatus,
  InspectionStatus,
  InspectionType,
  PropertyPromotionType,
  PropertyPromotionStatus,
} from "@prisma/client";

const prisma = new PrismaClient();

// ─── Yardımcı: ID üretici ─────────────────────────────────────────────────────
const SI = process.env.SEED_INDEX || "1";
const id = (prefix: string, n: number | string = 1) => {
  if (prefix === "org") return "us_seattle_org";
  return `seed-${prefix}-${String(n).padStart(3, "0")}-${SI}`;
};

async function main() {
  console.log("🌱 Tam seed başlatılıyor — 213 model...\n");

  // ═══════════════════════════════════════════════════════════════
  // 0. ADMIN USER (admin@propos.com)
  // ═══════════════════════════════════════════════════════════════
  const adminPasswordHash = await Bun.password.hash("Admin123!", { algorithm: "bcrypt", cost: 10 });
  const adminEmail = "admin@propos.com";
  
  const existingAdmin = await prisma.user.findUnique({ where: { email: adminEmail } });
  let adminUser;
  
  if (!existingAdmin) {
    adminUser = await prisma.user.create({
      data: {
        email: adminEmail,
        name: "System Administrator",
      },
    });

    await prisma.account.create({
      data: {
        userId: adminUser.id,
        type: "CREDENTIALS" as any,
        providerId: "credentials",
        accountId: adminEmail,
        accessToken: adminPasswordHash,
      },
    });
    console.log("✅ Admin user created: admin@propos.com / Admin123!");
  } else {
    adminUser = existingAdmin;
    console.log("ℹ️ Admin user already exists");
  }


  // ═══════════════════════════════════════════════════════════════
  // 1. ORGANIZATION
  // ═══════════════════════════════════════════════════════════════
  const org = await prisma.organization.upsert({
    where: { id: id("org") },
    update: {},
    create: {
      id: id("org"),
      name: `Seed Real Estate Corp ${SI}`,
      type: OrgType.AGENCY,
      region: Region.USA_NORTHEAST,
      defaultCurrency: "USD",
      defaultLocale: "en-US",
      legalName: `Seed RE Corp LLC-${SI}`,
      taxId: `12-3456789-${SI}`,
      address: "123 Main St, New York, NY 10001",
      contactEmail: `info@seedre.com-${SI}`,
      managementFeeType: "PERCENTAGE_RENT" as any,
      managementFeeRate: 8.0,
      managementFeeScope: "FULL_SERVICE" as any,
      taxReportingEnabled: true,
      complianceTracking: true,
    },
  });
  console.log("✅ Organization:", org.id);

  // ═══════════════════════════════════════════════════════════════
  // 2. USERS (3)
  // ═══════════════════════════════════════════════════════════════
  const users = await Promise.all([
    prisma.user.upsert({
      where: { email: `alice@seedre.com-${SI}` },
      update: {},
      create: {
        id: id("user", 1),
        email: `alice@seedre.com-${SI}`,
        name: `Alice Johnson ${SI}`,
        phone: "+1-555-0101",
        locale: "en-US",
        timezone: "America/New_York",
      },
    }),
    prisma.user.upsert({
      where: { email: `bob@seedre.com-${SI}` },
      update: {},
      create: {
        id: id("user", 2),
        email: `bob@seedre.com-${SI}`,
        name: `Bob Builder ${SI}`,
        phone: "+1-555-0102",
        locale: "en-GB",
        timezone: "Europe/London",
      },
    }),
    prisma.user.upsert({
      where: { email: `carol@seedre.com-${SI}` },
      update: {},
      create: {
        id: id("user", 3),
        email: `carol@seedre.com-${SI}`,
        name: `Carol Davis ${SI}`,
        phone: "+1-555-0103",
        locale: "tr-TR",
        timezone: "Europe/Istanbul",
      },
    }),
  ]);
  console.log("✅ Users: 3");
  const u1 = users[0];
  const u2 = users[1];
  const u3 = users[2];
  
  
  
  
  
  
  // ═══════════════════════════════════════════════════════════════
  // 3. SESSION
  // ═══════════════════════════════════════════════════════════════
  await prisma.session.upsert({
    where: { tokenHash: `seed-token-hash-001-${SI}` },
    update: {},
    create: {
      
      id: id("session"),
      userId: u1.id,
      tokenHash: `seed-token-hash-001-${SI}`,
      expiresAt: new Date(Date.now() + 30 * 24 * 3600 * 1000),
      ip: "127.0.0.1",
      userAgent: "seed/1.0",
    },
  });
  console.log("✅ Session");

  // ═══════════════════════════════════════════════════════════════
  // 4. ACCOUNT
  // ═══════════════════════════════════════════════════════════════
  await prisma.account.upsert({
    where: { providerId_accountId: { providerId: `google-${SI}`, accountId: `google-uid-001-${SI}` } },
    
    update: {},
    
    create: {
      
      id: id("account"),
      userId: u1.id,
      type: AccountType.GOOGLE,
      providerId: `google-${SI}`,
      accountId: `google-uid-001-${SI}`,
      
    },
  });
  console.log("✅ Account");

  // ═══════════════════════════════════════════════════════════════
  // 5. ROLES & PERMISSIONS MATRIX
  // ═══════════════════════════════════════════════════════════════
  console.log("🔐 Seeding Roles & Permissions...");

  // All available permissions
  const allPermissions = Object.values(PermissionKey);
  
  // Seed all permissions first
  const permissionMap = new Map<string, string>();
  for (const permKey of allPermissions) {
    const perm = await prisma.permission.upsert({
      where: { key: permKey },
      update: {},
      create: {
        id: id(`perm-${permKey.toLowerCase()}`),
        key: permKey,
        name: permKey.replace(/_/g, ' ').toLowerCase(),
        description: `Permission for ${permKey}`,
      },
    });
    permissionMap.set(permKey, perm.id);
  }

  // Define role-permission mapping
  const roleMatrix: Record<MemberRoleKey, PermissionKey[]> = {
    [MemberRoleKey.ORG_ADMIN]: allPermissions,
    [MemberRoleKey.OWNER]: allPermissions,
    [MemberRoleKey.AGENCY_ADMIN]: [
      PermissionKey.PROPERTIES_VIEW_ALL,
      PermissionKey.PROPERTIES_MANAGE_ALL,
      PermissionKey.LISTINGS_VIEW_ALL,
      PermissionKey.LISTINGS_MANAGE_ALL,
      PermissionKey.BOOKINGS_VIEW_ALL,
      PermissionKey.BOOKINGS_MANAGE_ALL,
      PermissionKey.RESERVATIONS_MANAGE_ALL,
      PermissionKey.TASKS_VIEW_ALL,
      PermissionKey.TASKS_MANAGE_ALL,
      PermissionKey.MESSAGES_READ_ALL,
      PermissionKey.REPORTS_VIEW,
      PermissionKey.USERS_MANAGE,
      PermissionKey.DOCUMENTS_MANAGE,
      PermissionKey.REVIEWS_MANAGE,
      PermissionKey.SETTINGS_MANAGE,
      PermissionKey.AUDIT_LOGS_VIEW,
    ],
    [MemberRoleKey.AGENT]: [
      PermissionKey.PROPERTIES_MANAGE_OWN,
      PermissionKey.LISTINGS_MANAGE_OWN,
      PermissionKey.BOOKINGS_VIEW_OWN,
      PermissionKey.BOOKINGS_MANAGE_OWN,
      PermissionKey.RESERVATIONS_MANAGE_OWN,
      PermissionKey.TASKS_VIEW_OWN,
      PermissionKey.TASKS_MANAGE_OWN,
      PermissionKey.MESSAGES_USE_OWN,
    ],
    [MemberRoleKey.VENDOR_MANAGER]: [
      PermissionKey.VENDORS_MANAGE,
      PermissionKey.TASKS_VIEW_ALL,
      PermissionKey.TASKS_MANAGE_ALL,
      PermissionKey.FINANCE_MANAGE,
      PermissionKey.REPORTS_VIEW,
    ],
    [MemberRoleKey.ACCOUNTANT]: [
      PermissionKey.FINANCE_MANAGE,
      PermissionKey.TAX_MANAGE,
      PermissionKey.REPORTS_VIEW,
      PermissionKey.EXPORTS_MANAGE,
    ],
    [MemberRoleKey.MAINTENANCE]: [
      PermissionKey.TASKS_VIEW_OWN,
      PermissionKey.TASKS_MANAGE_OWN,
    ],
    [MemberRoleKey.TENANT_GUEST]: [
      PermissionKey.BOOKINGS_VIEW_OWN,
      PermissionKey.RESERVATIONS_MANAGE_OWN,
      PermissionKey.MESSAGES_USE_OWN,
    ],
    [MemberRoleKey.READ_ONLY]: [
      PermissionKey.PROPERTIES_VIEW_ALL,
      PermissionKey.LISTINGS_VIEW_ALL,
      PermissionKey.REPORTS_VIEW,
    ],
  };

  // Seed roles and link permissions
  for (const [roleKey, perms] of Object.entries(roleMatrix) as [MemberRoleKey, PermissionKey[]][]) {
    const role = await prisma.role.upsert({
      where: { orgId_key: { orgId: org.id, key: roleKey } },
      update: {},
      create: {
        id: id(`role-${roleKey.toLowerCase()}`),
        orgId: org.id,
        key: roleKey,
        name: roleKey.charAt(0) + roleKey.slice(1).toLowerCase().replace(/_/g, ' '),
      },
    });

    // Link permissions to role
    for (const permKey of perms) {
      const permId = permissionMap.get(permKey);
      if (permId) {
        await prisma.rolePermission.upsert({
          where: { roleId_permissionId: { roleId: role.id, permissionId: permId } },
          update: {},
          create: {
            id: id(`rp-${roleKey.toLowerCase()}-${permKey.toLowerCase()}`),
            roleId: role.id,
            permissionId: permId,
          },
        });
      }
    }
  }

  console.log("✅ Roles & Permissions Matrix Seeded");

  // ═══════════════════════════════════════════════════════════════
  // 6. API TOKEN + API KEY
  // ═══════════════════════════════════════════════════════════════
  await prisma.apiToken.upsert({
    where: { tokenHash: `seed-api-token-hash-001-${SI}` },
    update: {},
    create: {
      
      id: id("apitoken"),
      userId: u1.id,
      name: `Seed Token ${SI}`,
      tokenHash: `seed-api-token-hash-001-${SI}`,
      scopes: ["read", "write"],
    },
  });

  await prisma.apiKey.upsert({
    where: { keyHash: `seed-api-key-hash-001-${SI}` },
    update: {},
    create: {
      
      id: id("apikey"),
      userId: u1.id,
      
      name: `Seed API Key ${SI}`,
      keyHash: `seed-api-key-hash-001-${SI}`,
      scopes: ["*"],
    },
  });
  console.log("✅ ApiToken + ApiKey");

  // ═══════════════════════════════════════════════════════════════
  // 7. USER PREFERENCE + USER FINANCIAL PROFILE + USER ACTIVITY LOG
  // ═══════════════════════════════════════════════════════════════
  await prisma.userPreference.upsert({
    where: { userId: u1.id },
    update: {},
    create: {
      
      id: id("userpref"),
      userId: u1.id,
      
      theme: "dark",
      language: "en-US",
      timezone: "America/New_York",
      emailNotifications: true,
      pushNotifications: true,
    },
  });

  await prisma.userFinancialProfile.upsert({
    where: { userId: u2.id },
    update: {},
    create: {
      
      id: id("userfinancial"),
      userId: u2.id,
      region: Region.USA_NORTHEAST,
      currency: "USD",
      monthlyIncome: 10000,
      monthlyObligations: 3000,
      riskTolerance: RiskTolerance.MEDIUM,
    },
  });
  await prisma.userActivityLog.create({
    data: {
      userId: u1.id,
      action: "LOGIN",
      entityType: "User",
      entityId: u1.id,
      ipAddress: "127.0.0.1",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ UserPreference + UserFinancialProfile + UserActivityLog");

  // ═══════════════════════════════════════════════════════════════
  
  // ═══════════════════════════════════════════════════════════════
  // 8. AGENCY
  // ═══════════════════════════════════════════════════════════════
  const agency = await prisma.agency.upsert({
    where: { externalId: `seed-agency-ext-001-${SI}` },
    update: {},
    create: { 
      organizationId: org.id, 
      ownerId: u1.id, 
      id: id("agency"),
      name: `Prestige Realty Agency ${SI}`,
      description: "Leading real estate agency",
      email: `contact@prestige.com-${SI}`,
      phoneNumber: "+1-212-555-0100",
      address: "45 Park Ave, NY",
      website: "https://prestige.com",
      status: SharedStatus.ACTIVE,
      externalId: `seed-agency-ext-001-${SI}`,
      totalProperties: 0,
    },
  });
  console.log("✅ Agency:", agency.id);

  // ═══════════════════════════════════════════════════════════════
  // 9. LOCATION (for Agent & Property)
  // ═══════════════════════════════════════════════════════════════
  const location1 = await prisma.location.create({
    data: {
      orgId: org.id,
      id: id("loc", 1),
      
      addressLine1: "100 Broadway",
      city: "New York",
      state: "NY",
      zip: "10005",
      country: "US",
      latitude: 40.7128,
      longitude: -74.006,
      accuracy: LocationAccuracy.EXACT,
      geocodingStatus: GeocodingStatus.VERIFIED,
      isVerified: true,
    },
  }).catch(() => prisma.location.findFirst({ where: { id: id("loc", 1) } }) as any);

  const location2 = await prisma.location.create({
    data: {
      orgId: org.id,
      id: id("loc", 2),
      
      addressLine1: "200 Fifth Ave",
      city: "New York",
      state: "NY",
      zip: "10010",
      country: "US",
      latitude: 40.7411,
      longitude: -73.9897,
      accuracy: LocationAccuracy.EXACT,
      geocodingStatus: GeocodingStatus.VERIFIED,
      isVerified: true,
    },
  }).catch(() => prisma.location.findFirst({ where: { id: id("loc", 2) } }) as any);
  console.log("✅ Locations");

  // ═══════════════════════════════════════════════════════════════
  // 10. AGENT
  // ═══════════════════════════════════════════════════════════════
  const agent = await prisma.agent.upsert({
    where: { email: `john.agent@prestige.com-${SI}` },
    update: {},
    create: { 
      ownerId: u1.id, 
      id: id("agent"),
      name: `John Carter ${SI}`,
      email: `john.agent@prestige.com-${SI}`,
      phoneNumber: "+1-917-555-0200",
      bio: "10+ years luxury real estate",
      status: SharedStatus.ACTIVE,
      agencyId: agency.id,
      licenseNumber: `AGT-2015-001-${SI}`,
      licenseType: "broker",
      licenseStatus: "active",
      licenseVerified: true,
      commissionRate: 1.5,
      specialties: ["LUXURY", "RESIDENTIAL"],
      serviceAreas: ["Manhattan", "Brooklyn"],
      yearsOfExperience: 10,
      experienceLevel: "expert",
      languages: ["en", "tr"],
      tierLevel: "gold",
    },
  });
  console.log("✅ Agent:", agent.id);

  // ═══════════════════════════════════════════════════════════════
  // 11. HASHTAGS (3)
  // ═══════════════════════════════════════════════════════════════
  const [tag1, tag2, tag3] = await Promise.all([
    prisma.hashtag.upsert({
      where: { name: `realestate ${SI}` },
      update: {},
      create: {
        id: id("tag", 1),
        name: `realestate ${SI}`,
        type: HashtagType.GENERAL,
        description: "Real estate posts",
        usageCount: 1,
        relatedTags: ["property", "home"],
        createdById: u1.id,
        agencyId: agency.id,
        updatedAt: new Date(),
      },
    }),
    prisma.hashtag.upsert({
      where: { name: `luxury ${SI}` },
      update: {},
      create: {
        id: id("tag", 2),
        name: `luxury ${SI}`,
        type: HashtagType.PROPERTY,
        description: "Luxury properties",
        usageCount: 1,
        relatedTags: ["penthouse", "villa"],
        createdById: u2.id,
        agencyId: agency.id,
        updatedAt: new Date(),
      },
    }),
    prisma.hashtag.upsert({
      where: { name: `investment ${SI}` },
      update: {},
      create: {
        id: id("tag", 3),
        name: `investment ${SI}`,
        type: HashtagType.AGENT,
        description: "Investment properties",
        usageCount: 1,
        relatedTags: ["roi", "yield"],
        createdById: u1.id,
        agencyId: agency.id,
        updatedAt: new Date(),
      },
    }),
  ]);
  console.log("✅ Hashtags: 3");

  // ═══════════════════════════════════════════════════════════════
  // 12. NEIGHBORHOOD
  // ═══════════════════════════════════════════════════════════════
  const neighborhood = await prisma.neighborhood.create({
    data: {
      orgId: org.id,
      id: id("neigh"),
      
      name: `Upper East Side ${SI}`,
      city: "New York",
      state: "NY",
      zip: "10021",
      lat: 40.7648,
      lng: -73.9656,
    },
  }).catch(() => prisma.neighborhood.findFirst({ where: { id: id("neigh") } }) as any);
  console.log("✅ Neighborhood");

  // ═══════════════════════════════════════════════════════════════
  // 13. PROPERTY
  // ═══════════════════════════════════════════════════════════════
  const property = await prisma.property.create({
    data: {
      id: id("prop"), 
      orgId: org.id,
      
      type: PropertyType.APARTMENT,
      name: `The Grand Tower - Unit 5A ${SI}`,
      region: Region.USA_NORTHEAST,
      currency: "USD",
      addressLine1: "350 Fifth Avenue",
      city: "New York",
      state: "NY",
      zip: "10118",
      country: "US",
      lat: 40.7484,
      lng: -73.9967,
      bedrooms: 3,
      bathrooms: 2,
      areaSqm: 120,
      yearBuilt: 2010,
      neighborhoodId: neighborhood?.id,
      propertyCategory: PropertyCategory.RESIDENTIAL,
      listingType: ListingType.SALE,
      listingStatus: ListingStatus.AVAILABLE,
      listingPrice: 1500000,
      propertyTaxRate: 1.2,
    },
  }).catch(() => prisma.property.findFirst({ where: { id: id("prop") } }) as any);
  console.log("✅ Property:", property?.id);

  // ═══════════════════════════════════════════════════════════════
  // 13a. CATEGORIES (NEW)
  // ═══════════════════════════════════════════════════════════════
  const catRes = await (prisma as any).category.upsert({
    where: { id: id("cat-res") },
    update: {},
    create: {
      id: id("cat-res"),
      slug: "residential",
      icon: "🏠",
      translations: {
        create: [
          { languageCode: "en", name: "Residential", description: "Homes and apartments" },
          { languageCode: "tr", name: "Konut", description: "Evler ve daireler" },
          { languageCode: "ar", name: "سكني", description: "منازل وشقق" },
        ]
      }
    }
  });

  const catVilla = await (prisma as any).category.upsert({
    where: { id: id("cat-villa") },
    update: {},
    create: {
      id: id("cat-villa"),
      parentId: catRes.id,
      slug: "villa",
      icon: "🏰",
      translations: {
        create: [
          { languageCode: "en", name: "Villa", description: "Luxury detached houses" },
          { languageCode: "tr", name: "Villa", description: "Lüks müstakil evler" },
        ]
      }
    }
  });
  console.log("✅ Categories: Residential & Villa");

  // ═══════════════════════════════════════════════════════════════
  // 14. LISTING
  // ═══════════════════════════════════════════════════════════════
  const listing = await (prisma.listing as any).create({
    data: {
      id: id("listing"), orgId: org.id,
      
      propertyId: property!.id,
      type: ListingType.SALE,
      status: ListingStatus.AVAILABLE,
      strategy: EarningStrategy.LONG_TERM_STABLE,
      title: `Luxury 3BR in Midtown Manhattan ${SI}`,
      description: "Stunning views, premium finishes",
      price: 1500000,
      priceCurrency: "USD",
      categoryId: catVilla.id,
    } as any,
  }).catch(() => prisma.listing.findFirst({ where: { id: id("listing") } }) as any);
  console.log("✅ Listing:", listing?.id);

  // ═══════════════════════════════════════════════════════════════
  // 14b. SEED 10 VIDEO PROPERTIES FOR REELS & HOME SCREEN
  // ═══════════════════════════════════════════════════════════════
  console.log("🌱 Seeding 10 Video Properties for Reels...");
  
  const videoPropertiesData = [
    { name: "The Glass Pavilion, Beverly Hills", city: "Los Angeles", state: "CA", price: 18500000, beds: 6, baths: 8, sqm: 1100, videoUrl: "https://videos.pexels.com/video-files/3773486/3773486-uhd_1440_2560_30fps.mp4", photo: "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800" },
    { name: "Ultra-Luxury Penthouse, Tribeca", city: "New York", state: "NY", price: 22000000, beds: 4, baths: 5, sqm: 450, videoUrl: "https://videos.pexels.com/video-files/3571264/3571264-uhd_1440_2560_30fps.mp4", photo: "https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=800" },
    { name: "Oceanfront Mansion, Miami Beach", city: "Miami", state: "FL", price: 35000000, beds: 8, baths: 10, sqm: 1400, videoUrl: "https://videos.pexels.com/video-files/4063585/4063585-uhd_1440_2560_24fps.mp4", photo: "https://images.unsplash.com/photo-1516450137517-162bdfffcc47?w=800" },
    { name: "Bel Air Mega Mansion", city: "Los Angeles", state: "CA", price: 45000000, beds: 9, baths: 12, sqm: 2200, videoUrl: "https://videos.pexels.com/video-files/4625518/4625518-uhd_1440_2560_24fps.mp4", photo: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800" },
    { name: "Mountain Estate, Aspen", city: "Aspen", state: "CO", price: 28500000, beds: 7, baths: 8, sqm: 1300, videoUrl: "https://videos.pexels.com/video-files/4328713/4328713-uhd_1440_2560_25fps.mp4", photo: "https://images.unsplash.com/photo-1518204646700-112674e2d216?w=800" },
    { name: "Billionaire's Row Estate, Malibu", city: "Malibu", state: "CA", price: 65000000, beds: 8, baths: 11, sqm: 1800, videoUrl: "https://videos.pexels.com/video-files/1093662/1093662-uhd_1440_2560_30fps.mp4", photo: "https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?w=800" },
    { name: "Central Park Tower Penthouse", city: "New York", state: "NY", price: 55000000, beds: 5, baths: 6, sqm: 650, videoUrl: "https://videos.pexels.com/video-files/6532053/6532053-hd_1080_1920_25fps.mp4", photo: "https://images.unsplash.com/photo-1600607688126-17b2b07e5b6c?w=800" },
    { name: "Desert Modern, Scottsdale", city: "Scottsdale", state: "AZ", price: 12500000, beds: 5, baths: 6, sqm: 900, videoUrl: "https://videos.pexels.com/video-files/5752729/5752729-uhd_1440_2560_25fps.mp4", photo: "https://images.unsplash.com/photo-1600585153490-76fb20a32601?w=800" },
    { name: "Historic Brownstone, Brooklyn", city: "New York", state: "NY", price: 8500000, beds: 4, baths: 5, sqm: 400, videoUrl: "https://videos.pexels.com/video-files/4169702/4169702-uhd_1440_2560_25fps.mp4", photo: "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800" },
    { name: "Silicon Valley Tech Estate", city: "Palo Alto", state: "CA", price: 32000000, beds: 6, baths: 7, sqm: 1200, videoUrl: "https://videos.pexels.com/video-files/4625518/4625518-uhd_1440_2560_24fps.mp4", photo: "https://images.unsplash.com/photo-1600607687644-b717bdf75810?w=800" }
  ];

  for (let i = 0; i < videoPropertiesData.length; i++) {
    const pData = videoPropertiesData[i];
    
    const prop = await prisma.property.upsert({
      where: { id: id(`vid-prop-${i}`) },
      update: {},
      create: {
        id: id(`vid-prop-${i}`),
        orgId: org.id,
        type: PropertyType.PENTHOUSE,
        name: pData.name,
        region: Region.USA_NORTHEAST,
        currency: "USD",
        addressLine1: `123 Luxury Ave ${i}`,
        city: pData.city,
        state: pData.state,
        country: "XX",
        bedrooms: pData.beds,
        bathrooms: pData.baths,
        areaSqm: pData.sqm,
        propertyCategory: PropertyCategory.RESIDENTIAL,
        listingType: ListingType.SALE,
        listingStatus: ListingStatus.AVAILABLE,
        listingPrice: pData.price,
      }
    });

    const lst = await (prisma.listing as any).upsert({
      where: { id: id(`vid-list-${i}`) },
      update: {},
      create: {
        id: id(`vid-list-${i}`),
        orgId: org.id,
        propertyId: prop.id,
        type: ListingType.SALE,
        status: ListingStatus.AVAILABLE,
        strategy: EarningStrategy.LONG_TERM_STABLE,
        title: pData.name,
        description: `Experience ultimate luxury at ${pData.name} in ${pData.city}.`,
        price: pData.price,
        priceCurrency: "USD",
        categoryId: catVilla.id,
      } as any
    });

    await prisma.photo.upsert({
      where: { url: pData.photo },
      update: {},
      create: {
        id: id(`vid-photo-${i}`),
        propertyId: prop.id,
        url: pData.photo,
        type: PhotoType.GALLERY,
      }
    });
    
    await prisma.videoContent.upsert({
      where: { id: id(`vid-content-${i}`) },
      update: {},
      create: {
        id: id(`vid-content-${i}`),
        orgId: org.id,
        propertyId: prop.id,
        listingId: lst.id,
        title: `${pData.name} Virtual Tour`,
        url: pData.videoUrl,
        primaryLoraStyle: VideoLoraStyle.REALISTIC,
        platform: VideoTargetPlatform.INSTAGRAM_REELS,
        pipeline: VideoPipeline.KREA_REALTIME,
        prompt: `Stunning video tour of ${pData.name}`,
        strategy: VideoLoraStrategy.PERMANENT_MERGE,
        status: VideoContentStatus.PUBLISHED,
      }
    });
  }
  console.log("✅ Seeded 10 Video Properties, Listings, photos and Video Contents");


  // ═══════════════════════════════════════════════════════════════
  // 15. LISTING STATUS HISTORY
  // ═══════════════════════════════════════════════════════════════
  await prisma.listingStatusHistory.upsert({ where: { id: id("lsthist") }, update: {}, create: {
      orgId: org.id,
      id: id("lsthist"),
      listingId: listing!.id,
      status: ListingStatus.AVAILABLE,
      fromDate: new Date(),
      reason: "Initial listing",
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 16. TAG + LISTING TAG
  // ═══════════════════════════════════════════════════════════════
  const listingTag = await prisma.tag.upsert({
    where: { orgId_name: { name: `Featured ${SI}`, orgId: org.id } },
    
    update: {},
    
    create: {
      
      id: id("ltag"),
      orgId: org.id,
      name: `Featured ${SI}`,
      color: "#FFD700",
    },
  });

  await prisma.listingTag.upsert({ where: { id: id("listi") }, update: {}, create: {
      orgId: org.id,
      id: id("listingtag"),
      listingId: listing!.id,
      tagId: listingTag.id,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Tag + ListingTag");

  // ═══════════════════════════════════════════════════════════════
  // 17. CONTACT (tenant + agent contact)
  // ═══════════════════════════════════════════════════════════════
  const contact1 = await prisma.contact.create({
    data: {
      orgId: org.id,
      id: id("contact", 1),
      
      type: ContactType.TENANT,
      fullName: "David Miller",
      email: `david.miller@example.com-${SI}`,
      phone: "+1-555-0301",
    },
  }).catch(() => prisma.contact.findFirst({ where: { id: id("contact", 1) } }) as any);

  const contact2 = await prisma.contact.create({
    data: {
      orgId: org.id,
      id: id("contact", 2),
      
      type: ContactType.OTHER,
      fullName: "Sarah Thompson",
      email: `sarah.thompson@example.com-${SI}`,
      phone: "+1-555-0302",
    },
  }).catch(() => prisma.contact.findFirst({ where: { id: id("contact", 2) } }) as any);
  console.log("✅ Contacts: 2");

  // ═══════════════════════════════════════════════════════════════
  // 18. TENANT
  // ═══════════════════════════════════════════════════════════════
  const tenant = await prisma.tenant.upsert({
    where: { email: `tenant.david@example.com-${SI}` },
    update: {},
    create: { 
      
      id: id("tenant"),
      userId: u3.id,
      firstName: "David",
      lastName: "Miller",
      email: `tenant.david@example.com-${SI}`,
      phoneNumber: "+1-555-0401",
      leaseStartDate: new Date("2024-01-01"),
      leaseEndDate: new Date("2025-01-01"),
      paymentStatus: PaymentStatus.PAID,
      propertyId: property!.id,
      createdAt: new Date(),
      updatedAt: new Date(),
    },
  });
  console.log("✅ Tenant");

  // ═══════════════════════════════════════════════════════════════
  // 19. LEASE
  const lease = await prisma.lease.upsert({
    where: { id: id("lease") },
    update: {},
    create: { 
      orgId: org.id, 
       
       
      

      id: id("lease"),
      listingId: listing!.id,
      tenantId: tenant.id,
      status: LeaseStatus.ACTIVE,
      startDate: new Date("2024-01-01"),
      endDate: new Date("2025-01-01"),
      rent: 5000,
      currency: "USD",
      deposit: 10000,
      rentDueDay: 1,
    },
  });
  console.log("✅ Lease");

  // ═══════════════════════════════════════════════════════════════
  // 20. RENT SCHEDULE
  // ═══════════════════════════════════════════════════════════════
  await prisma.rentSchedule.create({
    data: {
      orgId: org.id,
      id: id("rentsch"),
      leaseId: lease!.id,
      dueDate: new Date("2024-02-01"),
      amount: 5000,
      currency: "USD",
      status: PaymentStatus.PAID,
      paidAt: new Date("2024-01-31"),
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 21. FINANCIAL RECORD
  // ═══════════════════════════════════════════════════════════════
  await prisma.financialRecord.upsert({ where: { id: id("finan") }, update: {}, create: {
      orgId: org.id,
      id: id("finrec"),
      propertyId: property!.id,
      listingId: listing!.id,
      leaseId: lease!.id,
      type: "RENT",
      recordType: TransactionType.INCOME,
      amount: 5000,
      currency: "USD",
      occurredAt: new Date("2024-01-01"),
      paymentStatus: PaymentStatus.PAID,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ RentSchedule + FinancialRecord");

  // ═══════════════════════════════════════════════════════════════
  // 22. BOOKING
  // ═══════════════════════════════════════════════════════════════
  const booking = await prisma.booking.create({
    data: {
      orgId: org.id,
      id: id("booking"),
      listingId: listing!.id,
      propertyId: property!.id,
      contactId: contact1!.id,
      status: BookingStatus.CONFIRMED,
      startDate: new Date("2024-03-01"),
      endDate: new Date("2024-03-07"),
      adults: 2,
      children: 0,
      priceTotal: 3500,
      currency: "USD",
      paymentStatus: PaymentStatus.PAID,
    },
  }).catch(() => prisma.booking.findFirst({ where: { id: id("booking") } }) as any);
  console.log("✅ Booking");

  // ═══════════════════════════════════════════════════════════════
  // 23. RESERVATION
  // ═══════════════════════════════════════════════════════════════
  const reservation = await prisma.reservation.create({
    data: {
      orgId: org.id,
      id: id("resv"),
      listingId: listing!.id,
      propertyId: property!.id,
      contactId: contact1!.id,
      checkInDate: new Date("2024-04-01"),
      checkOutDate: new Date("2024-04-07"),
      guestCount: 2,
      nightlyRate: 500,
      cleaningFee: 150,
      totalAmount: 3150,
      currency: "USD",
      status: ReservationStatus.CONFIRMED,
      paymentStatus: PaymentStatus.PAID,
    },
  }).catch(() => prisma.reservation.findFirst({ where: { id: id("resv") } }) as any);
  console.log("✅ Reservation");

  // ═══════════════════════════════════════════════════════════════
  // 24. MAINTENANCE BLOCK
  // ═══════════════════════════════════════════════════════════════
  await prisma.maintenanceBlock.upsert({ where: { id: id("mblock") }, update: {}, create: {
      orgId: org.id,
      id: id("mblock"),
      listingId: listing!.id,
      propertyId: property!.id,
      type: MaintenanceBlockType.MAINTENANCE,
      startDate: new Date("2024-05-01"),
      endDate: new Date("2024-05-03"),
      reason: "Annual HVAC service",
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 25. CONTRACT + CONTRACT VERSION + SIGNATURE REQUEST + SIGNER
  // ═══════════════════════════════════════════════════════════════
  const contract = await prisma.contract.create({
    data: {
      orgId: org.id,
      id: id("contract"),
      propertyId: property!.id,
      leaseId: lease!.id,
      type: ContractType.RENTAL_LEASE,
      status: ContractStatus.ACTIVE,
      title: `Residential Lease Agreement ${SI}`,
      effectiveFrom: new Date("2024-01-01"),
      effectiveTo: new Date("2025-01-01"),
    },
  }).catch(() => prisma.contract.findFirst({ where: { id: id("contract") } }) as any);

  const contractVersion = await prisma.contractVersion.upsert({ where: { id: id("contr") }, update: {}, create: {
      orgId: org.id,
      id: id("cv"),
      
      contractId: contract!.id,
      version: 1,
      documentUrl: "https://cdn.example.com/contracts/lease-v1.pdf",
      checksum: `sha256-abc123-${SI}`,
    },
  }).catch((e) => { console.error(e); });

  const sigRequest = await prisma.signatureRequest.create({
    data: {
      orgId: org.id,
      id: id("sigreq"),
      
      contractId: contract!.id,
      provider: "DocuSign",
      status: SignatureStatus.PENDING,
      signUrl: "https://docusign.example.com/sign/123",
    },
  }).catch(() => prisma.signatureRequest.findFirst({ where: { id: id("sigreq") } }) as any);

  await prisma.signatureSigner.upsert({ where: { id: id("signa") }, update: {}, create: {
      orgId: org.id,
      id: id("sigsigner"),
      
      signatureRequestId: sigRequest!.id,
      participantType: MessageParticipantType.CONTACT,
      contactId: contact1!.id,
      fullName: contact1!.fullName,
      email: contact1!.email ?? `signer@example.com-${SI}`,
      status: SignatureStatus.PENDING,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Contract + ContractVersion + SignatureRequest + SignatureSigner");

  // ═══════════════════════════════════════════════════════════════
  // 26. DOCUMENT
  // ═══════════════════════════════════════════════════════════════
  const document = await prisma.document.create({
    data: {
      orgId: org.id,
      id: id("doc"),
      
      propertyId: property!.id,
      contractId: contract!.id,
      userId: u1.id,
      documentType: DocumentTypeUSA.LEASE_AGREEMENT,
      title: `Residential Lease Agreement 2024 ${SI}`,
      fileUrl: "https://cdn.example.com/docs/lease-2024.pdf",
      fileName: `lease-2024.pdf-${SI}`,
      fileSize: 204800,
      mimeType: "application/pdf",
      checksum: `sha256-lease-001-${SI}`,
      version: 1,
      isRequired: true,
      isSigned: false,
      signatureRequired: true,
      tags: ["lease", "residential"],
    },
  }).catch(() => prisma.document.findFirst({ where: { id: id("doc") } }) as any);
  console.log("✅ Document");

  // ═══════════════════════════════════════════════════════════════
  // 27. ANALYSIS JOB + DOCUMENT ANALYSIS
  // ═══════════════════════════════════════════════════════════════
  const analysisJob = await prisma.analysisJob.create({
    data: {
      orgId: org.id,
      id: id("ajob"),
      documentId: document!.id,
      
      status: "QUEUED",
      type: "DOCUMENT_ANALYSIS",
      priority: "normal",
    },
  }).catch(() => prisma.analysisJob.findFirst({ where: { id: id("ajob") } }) as any);

  await prisma.documentAnalysis.upsert({ where: { id: id("docanalysis") }, update: {}, create: {
      id: id("docanalysis"),
      documentId: document!.id,
      jobId: analysisJob?.id,
      
      confidence: 0.95,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ AnalysisJob + DocumentAnalysis");

  // ═══════════════════════════════════════════════════════════════
  // 28. TASK
  // ═══════════════════════════════════════════════════════════════
  const task = await prisma.task.create({
    data: {
      orgId: org.id,
      id: id("task"),
      
      propertyId: property!.id,

      leaseId: lease!.id,
      type: TaskType.INSPECTION,
      status: TaskStatus.OPEN,
      priority: Priority.MEDIUM,
      title: `Annual Property Inspection ${SI}`,
      description: "Routine annual inspection of the property",
      dueAt: new Date(Date.now() + 7 * 24 * 3600 * 1000),
      assignedToUserId: u2.id,
    },
  }).catch(() => prisma.task.findFirst({ where: { id: id("task") } }) as any);
  console.log("✅ Task");

  // ═══════════════════════════════════════════════════════════════
  // 29. MAINTENANCE WORK ORDER
  // ═══════════════════════════════════════════════════════════════
  await prisma.maintenanceWorkOrder.upsert({ where: { id: id("workorder") }, update: {}, create: {
      id: id("workorder"),
      propertyId: property!.id,
      reportedBy: u1.id,
      title: `HVAC Filter Replacement ${SI}`,
      description: "Replace all HVAC filters",
      priority: Priority.MEDIUM,
      category: "HVAC",
      status: WorkOrderStatus.OPEN,
      reportedAt: new Date(),
      dueDate: new Date(Date.now() + 3 * 24 * 3600 * 1000),
      
      userId: u1.id,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ MaintenanceWorkOrder");

  // ═══════════════════════════════════════════════════════════════
  // 30. NOTIFICATION
  // ═══════════════════════════════════════════════════════════════
  await prisma.notification.upsert({ where: { id: id("notif") }, update: {}, create: {
      orgId: org.id,
      id: id("notif"),
      
      userId: u1.id,
      title: `Lease Expiring Soon ${SI}`,
      body: "The lease for The Grand Tower expires in 30 days",
      status: NotificationStatus.QUEUED,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Notification");

  // ═══════════════════════════════════════════════════════════════
  // 31. MESSAGE
  // ═══════════════════════════════════════════════════════════════
  await prisma.message.upsert({ where: { id: id("messa") }, update: {}, create: {
      orgId: org.id,
      id: id("message"),
      
      threadId: "thread-001",
      senderType: MessageParticipantType.USER,
      senderUserId: u1.id,
      body: "Hello David, your lease renewal is due next month.",
      subject: "Lease Renewal Reminder",
      isThreadStarter: true,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Message");

  // ═══════════════════════════════════════════════════════════════
  // 32. LEDGER ENTRY
  // ═══════════════════════════════════════════════════════════════
  await prisma.ledgerEntry.upsert({ where: { id: id("ledge") }, update: {}, create: {
      orgId: org.id,
      id: id("ledger"),
      
      propertyId: property!.id,
      type: LedgerEventType.INCOME,
      amount: 5000,
      currency: "USD",
      occurredAt: new Date("2024-01-01"),
      note: "Monthly rent payment",
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 33. EXCHANGE RATE
  // ═══════════════════════════════════════════════════════════════
  await prisma.exchangeRate.upsert({
    where: {
      orgId_baseCurrency_quoteCurrency_asOfDate: { orgId: org.id,

        baseCurrency: "USD",
        quoteCurrency: "EUR",
        asOfDate: new Date("2024-01-01"),
      },
    },
    
    update: {},
    
    create: {
      orgId: org.id,
      
      id: id("exrate"),
      
      baseCurrency: "USD",
      quoteCurrency: "EUR",
      rate: 0.92,
      asOfDate: new Date("2024-01-01"),
      source: "ECB",
    },
  });
  console.log("✅ LedgerEntry + ExchangeRate");

  // ═══════════════════════════════════════════════════════════════
  // 34. EXPORT JOB + EXPORT FILE
  // ═══════════════════════════════════════════════════════════════
  const exportJob = await prisma.exportJob.create({
    data: {
      orgId: org.id,
      id: id("exportjob"),
      
      type: ExportType.LEDGER_CSV,
      status: ExportStatus.DONE,
      finishedAt: new Date(),
    },
  }).catch(() => prisma.exportJob.findFirst({ where: { id: id("exportjob") } }) as any);

  await prisma.exportFile.upsert({ where: { id: id("expor") }, update: {}, create: {
      orgId: org.id,
      id: id("exportfile"),
      
      exportJobId: exportJob!.id,
      fileName: `ledger-2024.csv-${SI}`,
      storageKey: `exports/ledger-2024.csv-${SI}`,
      mimeType: "text/csv",
      sizeBytes: 102400,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ ExportJob + ExportFile");

  // ═══════════════════════════════════════════════════════════════
  // 35. GOVERNMENT INTEGRATION
  // ═══════════════════════════════════════════════════════════════
  await prisma.governmentIntegration.create({
    data: {
      orgId: org.id,
      id: id("govint"),
      
      userId: u1.id,
      region: Region.USA_NORTHEAST,
      name: `NYC DOF API ${SI}`,
      isEnabled: true,
      status: "SUCCESS",
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 36. LEAD SOURCE + LEAD
  // ═══════════════════════════════════════════════════════════════
  const leadSource = await prisma.leadSource.upsert({
    where: { orgId_name: { name: `Website ${SI}`, orgId: org.id } },
    
    update: {},
    
    create: {
      orgId: org.id,
      id: id("leadsrc"),
      name: `Website ${SI}`,
      type: SourceType.WEBSITE,
    },
  });

  const lead = await prisma.lead.create({
    data: {
      orgId: org.id,
      id: id("lead"),
      
      sourceId: leadSource.id,
      firstName: "Michael",
      lastName: "Brown",
      email: `michael.brown@prospect.com-${SI}`,
      phone: "+1-555-0501",
      budget: 2000000,
      status: LeadStatus.QUALIFIED,
      assignedToUserId: u1.id,
    },
  }).catch(() => prisma.lead.findFirst({ where: { id: id("lead") } }) as any);
  console.log("✅ LeadSource + Lead");

  // ═══════════════════════════════════════════════════════════════
  // 37. MARKETING CAMPAIGN
  // ═══════════════════════════════════════════════════════════════
  const campaign = await prisma.marketingCampaign.create({
    data: {
      orgId: org.id,
      id: id("campaign"),
      
      name: `Spring Listings 2024 ${SI}`,
      type: CampaignType.EMAIL,
      status: CampaignStatus.ACTIVE,
      scheduledAt: new Date("2024-03-01"),
      targetType: "ALL_CONTACTS",
      sentCount: 100,
    },
  }).catch(() => prisma.marketingCampaign.findFirst({ where: { id: id("campaign") } }) as any);
  console.log("✅ MarketingCampaign");

  // ═══════════════════════════════════════════════════════════════
  // 38. DEAL
  // ═══════════════════════════════════════════════════════════════
  const deal = await prisma.deal.create({
    data: {
      orgId: org.id,
      id: id("deal"),
      
      propertyId: property!.id,

      clientId: contact1!.id,
      agentId: contact2!.id,
      dealStatus: DealStatusUSA.UNDER_CONTRACT,
      dealType: "RESIDENTIAL",
      offerPrice: 1450000,
      listPrice: 1500000,
      commissionRate: 3.0,
      commissionAmount: 43500,
      closingDate: new Date("2024-06-01"),
    },
  }).catch(() => prisma.deal.findFirst({ where: { id: id("deal") } }) as any);
  console.log("✅ Deal");

  // ═══════════════════════════════════════════════════════════════
  // 39. PAYOUT
  // ═══════════════════════════════════════════════════════════════
  await prisma.payout.upsert({ where: { id: id("payou") }, update: {}, create: {
      orgId: org.id,
      id: id("payout"),
      
      
      recipientId: contact2!.id,
      payoutStatus: PayoutStatusUSA.PENDING,
      payoutType: CommissionTypeUS.BUYER_AGENT_COMMISSION,
      amount: 43500,
      grossAmount: 43500,
      netAmount: 40000,
      taxWithheld: 3500,
      fees: 0,
      paymentMethod: PaymentMethodUS.WIRE_TRANSFER,
      scheduledDate: new Date("2024-06-15"),
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Payout");

  // ═══════════════════════════════════════════════════════════════
  // 40. APPOINTMENT + CALENDAR EVENT
  // ═══════════════════════════════════════════════════════════════
  await prisma.appointment.upsert({ where: { id: id("appoi") }, update: {}, create: {
      orgId: org.id,
      id: id("appt"),
      
      propertyId: property!.id,

      contactId: contact1!.id,
      title: `Property Viewing ${SI}`,
      appointmentType: "VIEWING",
      startDate: new Date("2024-04-15T10:00:00Z"),
      endDate: new Date("2024-04-15T11:00:00Z"),
      status: "SCHEDULED",
      assignedToUserId: u1.id,
    },
  }).catch((e) => { console.error(e); });

  await prisma.calendarEvent.upsert({ where: { id: id("calen") }, update: {}, create: {
      orgId: org.id,
      id: id("calevent"),
      
      userId: u1.id,
      title: `Property Showing - Grand Tower 5A ${SI}`,
      description: "Client showing",
      startDate: new Date("2024-04-15T10:00:00Z"),
      endDate: new Date("2024-04-15T11:00:00Z"),
      timezone: "America/New_York",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Appointment + CalendarEvent");

  // ═══════════════════════════════════════════════════════════════
  // 41. REPORT + REPORT EXECUTION
  // ═══════════════════════════════════════════════════════════════
  const report = await prisma.report.create({
    data: {
      orgId: org.id,
      id: id("report"),
      
      userId: u1.id,
      name: `Monthly Financial Report ${SI}`,
      reportType: "FINANCIAL",
      config: { period: "2024-01", currency: "USD" },
      
    },
  }).catch(() => prisma.report.findFirst({ where: { id: id("report") } }) as any);

  await prisma.reportExecution.upsert({ where: { id: id("repor") }, update: {}, create: {
      orgId: org.id,
      id: id("repexec"),
      
      reportId: report!.id,
      executedAt: new Date(),
      executedBy: u1.id,
      status: "COMPLETED",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Report + ReportExecution");

  // ═══════════════════════════════════════════════════════════════
  // 42. BUDGET
  // ═══════════════════════════════════════════════════════════════
  await prisma.budget.upsert({ where: { id: id("budge") }, update: {}, create: {
      orgId: org.id,
      id: id("budget"),
      
      userId: u1.id,
      name: `Q1 2024 Operations Budget ${SI}`,
      budgetType: "OPERATIONAL",
      period: "QUARTERLY",
      startDate: new Date("2024-01-01"),
      endDate: new Date("2024-03-31"),
      totalAmount: 50000,
      currency: "USD",
      
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 43. QUOTE
  // ═══════════════════════════════════════════════════════════════
  await prisma.quote.upsert({
    where: { quoteNumber: `Q-2024-001-${SI}` },
    update: {},
    create: {
      orgId: org.id,
      id: id("quote"),
      contactId: contact1!.id,
      quoteNumber: `Q-2024-001-${SI}`,
      title: `Renovation Quote ${SI}`,
      propertyId: property!.id,
      items: [{ description: "Paint entire apartment", qty: 1, price: 5000 }] as any,
      subtotal: 5000,
      taxAmount: 400,
      totalAmount: 5400,
      currency: "USD",
      status: "DRAFT",
    },
  });
  console.log("✅ Budget + Quote");

  // ═══════════════════════════════════════════════════════════════
  // 44. PROJECT + PROJECT ALERT + PROJECT ANALYTICS + PROJECT REPORT
  // ═══════════════════════════════════════════════════════════════
  const project = await prisma.project.create({
    data: {
      orgId: org.id,
      id: id("project"),
      
      name: `Grand Tower Renovation ${SI}`,
      projectType: "RESIDENTIAL",
      propertyId: property!.id,
      status: "PLANNING",
      startDate: new Date("2024-06-01"),
      estimatedEndDate: new Date("2024-09-01"),
      budget: 100000,
      currency: "USD",
      managerId: u1.id,
    },
  }).catch(() => prisma.project.findFirst({ where: { id: id("project") } }) as any);

  await prisma.projectAlert.upsert({ where: { id: id("palert") }, update: {}, create: {
      id: id("palert"),
      projectId: project!.id,
      alertType: "WARNING",
      title: `Budget Threshold Reached ${SI}`,
      message: "Budget is 80% consumed",
      severity: "MEDIUM",
    },
  }).catch((e) => { console.error(e); });

  await prisma.projectAnalytics.upsert({ where: { id: id("panalytics") }, update: {}, create: {
      id: id("panalytics"),
      projectId: project!.id,
      analysisType: "business_analyst",
      analysisData: { score: 8.5, recommendations: ["Optimize timeline"] },
      insights: ["On track for completion"],
      recommendations: ["Add 2 more workers"],
      score: 8.5,
    },
  }).catch((e) => { console.error(e); });

  await prisma.projectReport.upsert({ where: { id: id("preport") }, update: {}, create: {
      id: id("preport"),
      projectId: project!.id,
      reportType: "WEEKLY",
      title: `Week 1 Progress ${SI}`,
      content: "Foundation work completed. On schedule.",
      data: { progress: 25 },
      generatedBy: u1.id,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Project + ProjectAlert + ProjectAnalytics + ProjectReport");

  // ═══════════════════════════════════════════════════════════════
  // 45. FACILITY + FACILITY BLOCK + SHARED AMENITY
  // ═══════════════════════════════════════════════════════════════
  const facility = await prisma.facility.create({
    data: {
      orgId: org.id,
      id: id("facility"),
      
      propertyId: property!.id,
      name: `Grand Tower Amenity Center ${SI}`,
      feeAmount: 200,
      feeCurrency: "USD",
    },
  }).catch(() => prisma.facility.findFirst({ where: { id: id("facility") } }) as any);

  await prisma.facilityBlock.upsert({ where: { id: id("facblock") }, update: {}, create: {
      id: id("facblock"),
      facilityId: facility!.id,
      name: `Tower A ${SI}`,
      floors: 20,
      unitsPerFloor: 4,
      totalUnits: 80,
      yearBuilt: 2010,
    },
  }).catch((e) => { console.error(e); });

  await prisma.sharedAmenity.upsert({ where: { id: id("samenity") }, update: {}, create: {
      id: id("samenity"),
      facilityId: facility!.id,
      name: `Rooftop Pool ${SI}`,
      type: SharedAmenityType.OUTDOOR_POOL,
      description: "Olympic-size rooftop pool",
      capacity: 50,
      isAvailable: true,
      operatingHours: "06:00-22:00",
      accessType: AmenityAccessType.FREE,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Facility + FacilityBlock + SharedAmenity");

  // ═══════════════════════════════════════════════════════════════
  // 46. AMENITY + PROPERTY AMENITY
  // ═══════════════════════════════════════════════════════════════
  const amenity = await prisma.amenity.create({
    data: {
      orgId: org.id,
      id: id("amenity"),
      
      name: `Swimming Pool ${SI}`,
      category: AmenityCategory.FITNESS,
      icon: "pool",
    },
  }).catch(() => prisma.amenity.findFirst({ where: { id: id("amenity") } }) as any);

  await prisma.propertyAmenity.upsert({ where: { id: id("propamenity") }, update: {}, create: {
      orgId: org.id,
      id: id("propamenity"),
      propertyId: property!.id,
      amenityId: amenity!.id,
      
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Amenity + PropertyAmenity");

  // ═══════════════════════════════════════════════════════════════
  // 47. PROPERTY PHOTO + PHOTO
  // ═══════════════════════════════════════════════════════════════
  await prisma.propertyPhoto.upsert({ where: { id: id("prope") }, update: {}, create: {
      orgId: org.id,
      id: id("propphoto"),
      propertyId: property!.id,
      url: "https://cdn.example.com/properties/grand-tower-main.jpg",
      caption: "Grand Tower lobby",
      isPrimary: true,
      sortOrder: 1,
      
    },
  }).catch((e) => { console.error(e); });

  await prisma.photo.upsert({
    where: { url: "https://cdn.example.com/photos/agent-001.jpg" },
    update: {},
    create: {
      
      id: id("photo"),
      url: "https://cdn.example.com/photos/agent-001.jpg",
      type: PhotoType.PROFILE,
      caption: "Agent John Carter",
      featured: true,
      agentId: agent.id,
      agencyId: agency.id,
      userId: u1.id,
      propertyId: property!.id,
    },
  });
  console.log("✅ PropertyPhoto + Photo");

  // ═══════════════════════════════════════════════════════════════
  // 48. FLOOR PLAN + VIRTUAL TOUR + KEY MANAGEMENT
  // ═══════════════════════════════════════════════════════════════
  await prisma.floorPlan.create({
    data: {
      orgId: org.id,
      id: id("floorplan"),
      
      propertyId: property!.id,
      name: `Main Floor ${SI}`,
      floorLevel: 5,
      imageUrl: "https://cdn.example.com/floorplans/grand-tower-5.jpg",
      imageWidth: 1200,
      imageHeight: 900,
      
    },
  }).catch((e) => { console.error(e); });

  await prisma.virtualTour.create({
    data: {
      orgId: org.id,
      id: id("vtour"),
      
      propertyId: property!.id,
      name: `360 Virtual Tour ${SI}`,
      tourType: "MATTERPORT",
      videoUrl: "https://matterport.com/tour/grand-tower-5a",
      thumbnailUrl: "https://cdn.example.com/tours/thumb.jpg",
      
    },
  }).catch((e) => { console.error(e); });

  await prisma.keyManagement.create({
    data: {
      orgId: org.id,
      id: id("keys"),
      
      propertyId: property!.id,
      keyType: "APARTMENT",
      keyNumber: "5A-001",
      keyLocation: "Manager's office",
      keyStatus: "AVAILABLE",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ FloorPlan + VirtualTour + KeyManagement");

  // ═══════════════════════════════════════════════════════════════
  // 49. PROPERTY INVENTORY
  // ═══════════════════════════════════════════════════════════════
  await prisma.propertyInventory.create({
    data: {
      orgId: org.id,
      id: id("inventory"),
      
      propertyId: property!.id,
      leaseId: lease!.id,
      inventoryType: "MOVE_IN",
      inventoryDate: new Date("2024-01-01"),
      conductedBy: u1.id,
      presentAtCheck: ["David Miller", "Alice Johnson"],
      overallCondition: "EXCELLENT",
      cleaningRequired: false,
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 50. PROPERTY COMPLIANCE
  // ═══════════════════════════════════════════════════════════════
  await prisma.propertyCompliance.create({
    data: {
      orgId: org.id,
      id: id("compliance"),
      
      propertyId: property!.id,
      type: "FIRE_SAFETY",
      status: "PASSED",
      data: { inspectionDate: new Date() },
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 51. PROPERTY DOCUMENT
  // ═══════════════════════════════════════════════════════════════
  await prisma.propertyDocument.create({
    data: {
      orgId: org.id,
      id: id("propdoc"),
      
      propertyId: property!.id,
      title: `Property Title Deed ${SI}`,
      fileName: `title-deed.pdf-${SI}`,
      mimeType: "application/pdf",
      sizeBytes: 512000,
      storageKey: `docs/title-deed.pdf-${SI}`,
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 52. PROPERTY DISCLOSURE
  // ═══════════════════════════════════════════════════════════════
  await prisma.propertyDisclosure.upsert({
    where: { propertyId: property!.id },
    update: {},
    create: {
      orgId: org.id,
      id: id("propdisclosure"),
      propertyId: property!.id,
      packStatus: "COMPLETE",
    },
  });
  console.log("✅ PropertyInventory + Compliance + Document + Disclosure");

  // ═══════════════════════════════════════════════════════════════
  // 53. PROPERTY VIEWING
  // ═══════════════════════════════════════════════════════════════
  await prisma.propertyViewing.create({
    data: {
      orgId: org.id,
      id: id("viewing"),
      
      propertyId: property!.id,

      viewingType: "IN_PERSON",
      scheduledDate: new Date("2024-04-20T14:00:00Z"),
      duration: 60,
      attendeeName: "Michael Brown",
      attendeeEmail: `michael.brown@prospect.com-${SI}`,
      attendeePhone: "+1-555-0501",
      attendeeType: "BUYER",
      status: "CONFIRMED",
      assignedAgentId: u1.id,
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 54. PROPERTY OFFER + DEAL ATTORNEY
  // ═══════════════════════════════════════════════════════════════
  await prisma.propertyOffer.create({
    data: {
      orgId: org.id,
      id: id("propoffer"),
      
      propertyId: property!.id,

      contactId: contact1!.id,
      offerPrice: 1420000,
      currency: "USD",
      closingDate: new Date(Date.now() + 30 * 24 * 3600 * 1000),
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 55. ATTORNEY MANAGEMENT
  // ═══════════════════════════════════════════════════════════════
  await prisma.attorneyManagement.upsert({
    where: { dealId: deal!.id },
    update: {},
    create: {
      orgId: org.id,
      id: id("attorney"),
      dealId: deal!.id,
      contactId: contact2!.id,
      solicitorFirm: "Smith & Partners LLP",
      solicitorName: "James Wilson",
      solicitorEmail: `james@smithpartners.com-${SI}`,
      solicitorPhone: "+1-212-555-0800",
      appointmentType: "BUYER",
      status: "ASSIGNED",
    },
  });
  console.log("✅ PropertyViewing + PropertyOffer + AttorneyManagement");

  // ═══════════════════════════════════════════════════════════════
  // 56. MORTGAGE + MORTGAGE OFFER + MORTGAGE PRE-APPROVAL
  // ═══════════════════════════════════════════════════════════════
  await prisma.mortgage.create({
    data: {
      id: id("mortgage"),
      propertyId: property!.id,
      lender: "First National Bank",
      principal: 800000,
      interestRate: 6.5,
      startDate: new Date("2020-01-01"),
      endDate: new Date("2050-01-01"),
      status: MortgageStatus.ACTIVE,
    },
  }).catch((e) => { console.error(e); });

  await prisma.mortgageOffer.create({
    data: {
      orgId: org.id,
      id: id("mortgageoffer"),
      propertyId: property!.id,
      contactId: contact1!.id,
      lender: "Chase Bank",
      offerAmount: 900000,
      interestRate: 6.25,
      termYears: 30,
      monthlyPayment: 5544,
      lenderName: "Chase Bank",
      mortgageType: "FIXED_RATE",
      mortgageTerm: 30,
      arrangementFee: 1500,
      valuationFee: 500,
      loanAmount: 900000,
      depositAmount: 200000,
      loanToValue: 81.8,
      totalPayable: 2000000,
      offerDate: new Date(),
      currency: "USD",
      status: "offered",
      offeredAt: new Date(),
    },
  }).catch((e) => { console.error(e); });

  await prisma.mortgagePreApproval.create({
    data: {
      orgId: org.id,
      id: id("mortgagepre"),
      
      
      contactId: contact1!.id,
      lenderName: "Wells Fargo",
      mortgageType: "FIXED",
      mortgageTerm: 30,
      interestRate: 6.5,
      arrangementFee: 1500,
      valuationFee: 500,
      loanAmount: 900000,
      depositAmount: 550000,
      loanToValue: 62,
      monthlyPayment: 5694,
      totalPayable: 2049840,
      offerDate: new Date(),
      offerStatus: "OFFERED",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Mortgage + MortgageOffer + MortgagePreApproval");

  // ═══════════════════════════════════════════════════════════════
  // 57. LEASE RENEWAL + DEPOSIT PROTECTION + RIGHT TO RENT
  // ═══════════════════════════════════════════════════════════════
  await prisma.leaseRenewal.create({
    data: {
      id: id("renewal"),
      leaseId: lease!.id,
      status: RenewalStatus.OFFERED,
      proposedRent: 5250,
      renewalDate: new Date("2025-01-01"),
      responseDeadline: new Date("2024-11-01"),
      
    },
  }).catch((e) => { console.error(e); });

  await prisma.depositProtection.create({
    data: {
      orgId: org.id,
      id: id("deprotect"),
      leaseId: lease!.id,
      amount: 10000,
      currency: "USD",
      provider: "DPS",
      scheme: "DPS",
      reference: `DPS-2024-001-${SI}`,
      status: "PROTECTED",
      protectedAt: new Date("2024-01-02"),
      schemeProvider: "DPS",
      schemeReference: `seed-depref-001-${SI}`,
      depositAmount: 10000,
      tenantDetails: { name: "John Doe", email: "john@example.com" },
    },
  }).catch((e) => { console.error(e); });

  await prisma.rightToRentCheck.create({
    data: {
      orgId: org.id,
      id: id("rentcheck"),
      leaseId: lease!.id,
      contactId: contact1!.id,
      checkType: "PASSPORT",
      reference: `US123456789-${SI}`,
      status: "PASSED",
      checkedAt: new Date("2024-01-01"),
      expiresAt: new Date("2025-01-01"),
      tenantId: tenant!.id,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ LeaseRenewal + DepositProtection + RightToRentCheck");

  // ═══════════════════════════════════════════════════════════════
  // 58. SECURITY DEPOSIT PROTECTION + RENT ARREARS + IMMIGRATION CHECK
  // ═══════════════════════════════════════════════════════════════
  await prisma.securityDepositProtection.upsert({
    where: { leaseId: lease!.id },
    update: {},
    create: {
      orgId: org.id,
      id: id("secdep"),
      
      leaseId: lease!.id,
      schemeProvider: "TDS",
      schemeReference: `TDS-2024-001-${SI}`,
      depositAmount: 10000,
      currency: "USD",
      protectionStatus: "PROTECTED",
      protectedDate: new Date("2024-01-02"),
      tenantDetails: { name: `David Miller ${SI}`, email: `david@example.com-${SI}` },
      landlordDetails: { name: `Seed RE Corp ${SI}`, email: `info@seedre.com-${SI}` },
    },
  });

  await prisma.rentArrears.create({
    data: {
      orgId: org.id,
      id: id("rentarrears"),
      
      leaseId: lease!.id,
      tenantId: contact1!.id,
      periodStart: new Date("2024-01-01"),
      periodEnd: new Date("2024-01-31"),
      rentDue: 5000,
      rentPaid: 5000,
      arrearsAmount: 0,
      status: "CURRENT",
    },
  }).catch((e) => { console.error(e); });

  await prisma.immigrationStatusCheck.upsert({
    where: { leaseId: lease!.id },
    update: {},
    create: {
      orgId: org.id,
      id: id("immcheck"),
      leaseId: lease!.id,
      tenantId: contact1!.id,
      checkStatus: "PASSED",
      immigrationStatus: "CITIZEN",
      documentType: "PASSPORT",
      documentNumber: "US987654321",
      documentVerified: true,
    },
  });
  console.log("✅ SecurityDepositProtection + RentArrears + ImmigrationCheck");

  // ═══════════════════════════════════════════════════════════════
  // 59. HOME INFORMATION PACK + SOLICITOR
  // ═══════════════════════════════════════════════════════════════
  await prisma.homeInformationPack.upsert({
    where: { propertyId: property!.id },
    update: {},
    create: {
      orgId: org.id,
      id: id("hip"),
      
      propertyId: property!.id,
      title: `Home Information Pack ${SI}`,
      description: "Complete property documentation",
      fileUrl: "https://cdn.example.com/hip/property-info.pdf",
      fileName: `property-info.pdf-${SI}`,
      fileSize: 2048000,
      mimeType: "application/pdf",
      checksum: `abc123-${SI}`,
      
    },
  });

  await prisma.solicitorManagement.create({
    data: {
      orgId: org.id,
      id: id("solicitor"),
      contactId: contact2!.id,
      solicitorType: "BUYER_SOLICITOR",
      status: "INSTRUCTED",
      engagedAt: new Date(),
      fee: 2000,
      currency: "USD",
      solicitorFirm: "Apex Legal Partners",
      solicitorName: "Sarah Jenkins",
      solicitorEmail: "sarah@apexlegal.com",
      appointmentType: "INITIAL_CONSULTATION",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ HomeInformationPack + SolicitorManagement");

  // ═══════════════════════════════════════════════════════════════
  // 60. AGENT TEAM + TEAM MEMBER + AGENT PERFORMANCE
  // ═══════════════════════════════════════════════════════════════
  const agentTeam = await prisma.agentTeam.create({
    data: {
      orgId: org.id,
      id: id("agteam"),
      
      name: `Manhattan Elite Team ${SI}`,
      leaderId: u1.id,
    },
  }).catch(() => prisma.agentTeam.findFirst({ where: { id: id("agteam") } }) as any);

  await prisma.agentTeamMember.upsert({
    where: { teamId_userId: { teamId: agentTeam!.id, userId: u2.id } },
    
    update: {},
    
    create: {
      
      id: id("agteammember"),
      teamId: agentTeam!.id,
      userId: u2.id,
      role: "MEMBER",
    },
  });

  await prisma.agentPerformance.upsert({
    where: { userId_period_startDate: { userId: u1.id, period: "2024-Q1", startDate: new Date("2024-01-01") } },
    
    update: {},
    
    create: {
      
      id: id("agperf"),
      userId: u1.id,
      period: "2024-Q1",
      startDate: new Date("2024-01-01"),
      endDate: new Date("2024-03-31"),
      leadsGenerated: 25,
      showingsCompleted: 15,
      offersSubmitted: 8,
      dealsClosed: 3,
      commissionEarned: 120000,
    },
  });
  console.log("✅ AgentTeam + AgentTeamMember + AgentPerformance");

  // ═══════════════════════════════════════════════════════════════
  // 61. CLIENT RELATIONSHIP
  // ═══════════════════════════════════════════════════════════════
  await prisma.clientRelationship.upsert({
    where: { agentId_clientId: { agentId: u1.id, clientId: contact1!.id } },
    
    update: {},
    
    create: {
      
      id: id("clientrel"),
      agentId: u1.id,
      clientId: contact1!.id,
      status: RelationshipStatus.CLIENT,
      firstContact: new Date("2023-06-01"),
      lastContact: new Date("2024-01-15"),
      preferredChannel: NotificationChannel.EMAIL,
    },
  });
  console.log("✅ ClientRelationship");

  // ═══════════════════════════════════════════════════════════════
  // 62. TENANT APPLICATION
  // ═══════════════════════════════════════════════════════════════
  await prisma.tenantApplication.create({
    data: {
      id: id("tenantapp"),
      propertyId: property!.id,
      applicantId: contact1!.id,
      status: ApplicationStatus.APPROVED,
      submittedAt: new Date("2023-12-15"),
      reviewedAt: new Date("2023-12-20"),
      reviewedBy: u1.id,
      applicationData: { income: 150000, employer: "Tech Corp", creditScore: 780 },
      creditScore: 780,
      incomeVerified: true,
      backgroundCheck: true,
      organizationId: org.id,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ TenantApplication");

  // ═══════════════════════════════════════════════════════════════
  // 63. GUEST PROFILE + GUEST REVIEW
  // ═══════════════════════════════════════════════════════════════
  await prisma.guestProfile.upsert({
    where: { contactId: contact1!.id },
    update: {},
    create: {
      
      id: id("guestprofile"),
      contactId: contact1!.id,
      preferredCheckInTime: "15:00",
      preferredAmenities: ["pool", "gym"],
      loyaltyPoints: 500,
      lifetimeSpent: 7000,
      bookingCount: 5,
    },
  });

  await prisma.guestReview.create({
    data: {
      id: id("guestreview"),
      bookingId: booking?.id || id("booking"),
      guestId: contact1!.id,
      propertyId: property!.id,
      rating: 5,
      cleanliness: 5,
      communication: 5,
      checkIn: 5,
      accuracy: 5,
      location: 5,
      value: 4,
      comment: "Wonderful apartment, highly recommend!",
      isPublic: true,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ GuestProfile + GuestReview");

  // ═══════════════════════════════════════════════════════════════
  // 64. REVIEW
  // ═══════════════════════════════════════════════════════════════
  await prisma.review.create({
    data: {
      orgId: org.id,
      id: id("review"),
      
      reviewerId: u1.id,
      targetId: agent.id,
      targetType: "AGENT",
      rating: 5,
      title: `Excellent Agent ${SI}`,
      comment: "John is a fantastic agent. Highly professional.",
      isVerified: true,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Review");

  // ═══════════════════════════════════════════════════════════════
  // 65. TAX RECORD + TAX DEPRECIATION + TAX 1099 FORM
  // ═══════════════════════════════════════════════════════════════
  const taxRecord = await prisma.taxRecord.create({
    data: {
      orgId: org.id,
      id: id("taxrec"),
      
      recordType: "PROFILE",
      
    },
  }).catch(() => prisma.taxRecord.findFirst({ where: { id: id("taxrec") } }) as any);

  await prisma.taxDepreciation.create({
    data: {
      id: id("taxdep"),
      propertyId: property!.id,
      assetType: AssetType.BUILDING,
      costBasis: 1200000,
      depreciationMethod: DepreciationMethod.STRAIGHT_LINE,
      usefulLife: 39,
      salvageValue: 0,
      startDate: new Date("2020-01-01"),
      organizationId: org.id,
    },
  }).catch((e) => { console.error(e); });

  await prisma.tax1099Form.upsert({
    where: { recipientId_taxYear_formType: { recipientId: contact2!.id, taxYear: 2023, formType: "FORM_1099" as any } },
    
    update: {},
    
    create: {
      orgId: org.id,
      id: id("tax1099"),
      
      recipientId: contact2!.id,
      taxYear: 2023,
      formType: "FORM_1099" as any,
      amount: 43500,
      description: "Real estate commission",
      issuedAt: new Date("2024-01-31"),
    },
  });
  console.log("✅ TaxRecord + TaxDepreciation + Tax1099Form");

  // ═══════════════════════════════════════════════════════════════
  // 66. ATTACHMENT
  // ═══════════════════════════════════════════════════════════════
  await prisma.attachment.create({
    data: {
      orgId: org.id,
      id: id("attachment"),
      
      propertyId: property!.id,
      entityType: "Task",
      entityId: task!.id,
      taskId: task!.id,
      fileName: `inspection-report.pdf-${SI}`,
      mimeType: "application/pdf",
      sizeBytes: 204800,
      storageKey: `attachments/inspection-001.pdf-${SI}`,
      url: "https://cdn.example.com/attachments/inspection-001.pdf",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Attachment");

  // ═══════════════════════════════════════════════════════════════
  // 67. MLS CONNECTION + MLS SYNC JOB + MLS EXTERNAL LISTING
  // ═══════════════════════════════════════════════════════════════
  const mlsConn = await prisma.mLSConnection.create({ data: { orgId: org.id, id: id("mlsconn"), provider: "RIGHTMOVE", name: `Rightmove Connection ${SI}`, isEnabled: true, status: "SUCCESS" } }).catch(() => prisma.mLSConnection.findFirst({ where: { id: id("mlsconn") } }) as any);
  const mlsSyncJob = await prisma.mLSSyncJob.create({
    data: {
      orgId: org.id,
      id: id("mlssync"),
      connectionId: mlsConn?.id || id("mlsconn"),
      status: "SUCCESS",
      finishedAt: new Date(),
    },
  }).catch(() => prisma.mLSSyncJob.findFirst({ where: { id: id("mlssync") } }) as any);

  await prisma.mLSExternalListing.create({
    data: {
      orgId: org.id,
      connectionId: mlsConn!.id,
      id: id("mlslisting"),
      status: "SUCCESS",
      externalId: `RM-123456-${SI}`,
      raw: { address: "350 Fifth Avenue", price: 1500000, bedrooms: 3 },
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ MLSConnection + MLSSyncJob + MLSExternalListing");

  // ═══════════════════════════════════════════════════════════════
  // 68. MAP LAYER + ROUTE
  // ═══════════════════════════════════════════════════════════════
  await prisma.mapLayer.create({
    data: {
      orgId: org.id,
      id: id("maplayer"),
      
      name: `Property Heatmap ${SI}`,
      type: "HEATMAP",
      provider: MapProvider.GOOGLE_MAPS,
      isVisible: true,
      opacity: 0.7,
    },
  }).catch((e) => { console.error(e); });

  await prisma.route.create({
    data: {
      orgId: org.id,
      id: id("route"),
      
      name: `Airport to Property ${SI}`,
      type: "DRIVING",
      startLocationId: location1!.id,
      endLocationId: location2!.id,
      distance: 12.5,
      duration: 1800,
      provider: MapProvider.GOOGLE_MAPS,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ MapLayer + Route");

  // ═══════════════════════════════════════════════════════════════
  // 69. API INTEGRATION
  // ═══════════════════════════════════════════════════════════════
  await prisma.apiIntegration.create({
    data: {
      orgId: org.id,
      id: id("apiint"),
      
      platform: RentalPlatform.AIRBNB,
      name: `Airbnb Integration ${SI}`,
      
      lastSyncAt: new Date(),
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 70. VACATION RENTAL + VACATION RENTAL PLATFORM
  // ═══════════════════════════════════════════════════════════════
  await prisma.vacationRental.upsert({
    where: { propertyId: property!.id },
    update: {},
    create: {
      orgId: org.id,
      id: id("vacrent"),
      propertyId: property!.id,
      baseNightlyRate: 150.00,
      currency: "USD",
      maxGuests: 4,
      minStayNights: 2,
      isActive: true,
      checkInTime: "15:00",
      checkOutTime: "11:00",
    },
  });

  await prisma.vacationRentalPlatform.create({
    data: {
      rentalId: id("vacrent"),
      platform: RentalPlatform.AIRBNB,
      externalId: `airbnb-listing-123-${SI}`,

      status: RentalStatus.ACTIVE,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ VacationRental + VacationRentalPlatform");

  // ═══════════════════════════════════════════════════════════════
  // 71. RENTAL SYNC JOB + EXTERNAL RENTAL LISTING
  // ═══════════════════════════════════════════════════════════════
  await prisma.rentalSyncJob.create({
    data: {
      orgId: org.id, 
      id: id("rentalsync"),
      
      platform: RentalPlatform.AIRBNB,
      integrationId: id("apiint"),
      jobType: "FULL_SYNC",
      direction: SyncDirection.IMPORT,
      status: "SUCCESS",

      finishedAt: new Date(),
    },
  }).catch((e) => { console.error(e); });

  await prisma.externalRentalListing.create({
    data: {
      orgId: org.id,
      id: id("extlisting"),
      
      platform: RentalPlatform.AIRBNB,
      integrationId: id("apiint"),
      externalId: `airbnb-123456-${SI}`,
      title: `Grand Tower Suite ${SI}`,
      description: "Luxury Manhattan apartment",
      rawData: { airbnb_id: "123456", stars: 4.9 },
      status: RentalStatus.ACTIVE,
      lastSyncedAt: new Date(),
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ RentalSyncJob + ExternalRentalListing");

  // ═══════════════════════════════════════════════════════════════
  // 72. MLS DATA MAPPING + MLS LISTING ENHANCEMENT
  // ═══════════════════════════════════════════════════════════════
  await prisma.mlsDataMapping.create({
    data: {
      orgId: org.id,

      mlsProvider: "RIGHTMOVE",
      standardField: "PRICE",
      dataType: "DECIMAL",
      id: id("mlsmap"),
      fieldName: "ListPrice",
      isRequired: true,
    },
  }).catch((e) => { console.error(e); });

  await prisma.mlsListingEnhancement.upsert({
    where: { listingId: listing!.id },
    update: {},
    create: {
      orgId: org.id,
      id: id("mlsenh"),
      listingId: listing!.id,
      mlsStatus: "ENHANCED",
      mlsHistory: { description: "Enhanced via AI", amenities: ["pool", "gym"] },
      },
  });
  console.log("✅ MlsDataMapping + MlsListingEnhancement");

  // ═══════════════════════════════════════════════════════════════
  // 73. LISTING CHANNEL
  // ═══════════════════════════════════════════════════════════════
  await prisma.listingChannel.create({
    data: {
      id: id("lstchannel"),
      orgId: org.id,
      listingId: listing!.id,
      channel: ListingChannelType.DIRECT,
      status: "SUCCESS",
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 74. INVESTOR PORTFOLIO + INVESTOR PROPERTY
  // ═══════════════════════════════════════════════════════════════
  const investorPortfolio = await prisma.investorPortfolio.upsert({
    where: { userId: u2.id },
    update: {},
    create: {
      id: id("portfolio"),
      organizationId: org.id,
      userId: u2.id,
      name: `Bob's Real Estate Portfolio ${SI}`,
      riskTolerance: "MEDIUM" as any,
      },
  });

  await prisma.investorProperty.create({
    data: {
      id: id("invprop"),
      portfolioId: investorPortfolio.id,
      propertyId: property!.id,
      acquiredCost: 1500000,
      acquiredAt: new Date("2020-01-15"),
      
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ InvestorPortfolio + InvestorProperty");

  // ═══════════════════════════════════════════════════════════════
  // 75. PROPERTY VALUATION (predict price engine)
  // ═══════════════════════════════════════════════════════════════
  const valuation = await prisma.propertyValuation.create({
    data: {
      orgId: org.id, 
      id: id("valuation"),
      propertyId: property!.id,
      
      
      status: "COMPLETED",
      value: 1500000,
      confidence: 0.92,
      valuationDate: new Date(),
    },
  }).catch(() => prisma.propertyValuation.findFirst({ where: { id: id("valuation") } }) as any);
  console.log("✅ PropertyValuation");

  // ═══════════════════════════════════════════════════════════════
  // 76. VALUATION REQUEST + VALUATION REPORT
  // ═══════════════════════════════════════════════════════════════
  const valuationRequest = await prisma.valuationRequest.create({
    data: {
      orgId: org.id, 
      id: id("valreq"),
      propertyId: property!.id,
      valuationId: (valuation?.id || id("valuation")),
      userId: u1.id,
      status: "completed",
      requestType: "SALE",
    },
  }).catch(() => prisma.valuationRequest.findFirst({ where: { id: id("valreq") } }) as any);

  await prisma.valuationReport.create({
    data: {
      orgId: org.id,
      id: id("valreport"),
      valuationId: (valuation?.id || id("valuation")),
      
      userId: u1.id,
      reportType: "basic",
      format: "pdf",
      summary: "Property valued at $1.5M based on comparable sales",
      isPublic: false,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ ValuationRequest + ValuationReport");

  // ═══════════════════════════════════════════════════════════════
  // 77. LEAD CONVERSION
  // ═══════════════════════════════════════════════════════════════
  await prisma.leadConversion.create({
    data: {
      orgId: org.id,
      id: id("leadconv"),
      valuationId: (valuation?.id || id("valuation")),
      
      userId: u1.id,
      agentId: agent.id,
      propertyId: property!.id,
      conversionType: "viewing",
      status: "qualified",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ LeadConversion");

  // ═══════════════════════════════════════════════════════════════
  // 78. MARKET INSIGHT + USER VALUATION PREFERENCE
  // ═══════════════════════════════════════════════════════════════
  await prisma.marketInsight.create({
    data: {
      id: id("mktinsight"),
      region: "Manhattan",
      propertyType: "RESIDENTIAL",
      insightType: "price_trend",
      title: `Manhattan Prices Rising 8% YoY ${SI}`,
      description: "Manhattan residential real estate has seen 8% appreciation.",
      confidence: 0.88,
      impact: "positive",
      relevanceScore: 0.9,
      

    },
  }).catch((e) => { console.error(e); });

  await prisma.userValuationPreference.upsert({
    where: { userId_orgId: { userId: u1.id, orgId: org.id } },
    
    update: {},
    
    create: {
      orgId: org.id,
      id: id("valuepref"),
      userId: u1.id,
      
      preferredType: ValuationType.BASIC,
      notifications: true,
      autoRefresh: false,
      preferredRegions: ["Manhattan", "Brooklyn"],
      propertyTypes: ["RESIDENTIAL", "COMMERCIAL"],
      reportFormat: "pdf",
      language: "en",
    },
  });
  console.log("✅ MarketInsight + UserValuationPreference");

  // ═══════════════════════════════════════════════════════════════
  // 79. AI MODELS FAMILY
  // ═══════════════════════════════════════════════════════════════
  const aiModel = await prisma.aIModel.create({
    data: {
      id: id("aimodel"),
      
      modelName: `PricePredictor v2-${SI}`,
      modelVersion: "2.0.1",
      modelType: "PRICE_PREDICTION",
      provider: "anthropic",
      
      accuracy: 0.94,
    },
  }).catch(() => prisma.aIModel.findFirst({ where: { id: id("aimodel") } }) as any);

  await prisma.aIModelDeployment.create({
    data: {
      id: id("aimdeploy"),
      
      modelId: aiModel!.id,
      deploymentId: `deploy-001-${SI}`,
      environment: "production",
      status: "DEPLOYED",
      deployedAt: new Date(),
    },
  }).catch((e) => { console.error(e); });

  await prisma.aIPrediction.create({
    data: {
      orgId: org.id,
      id: id("aipred"),
      
      modelId: aiModel!.id,
      modelType: "PRICE_PREDICTION",
      result: { predictedPrice: 1520000, range: [1450000, 1590000] },
      confidence: 0.92,
      status: "COMPLETED",
      success: true,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ AIModel + AIModelDeployment + AIPrediction");

  const aivm = await prisma.aIValuationModel.create({
    data: {
      orgId: org.id,
      id: id("aivalmod"),
      modelName: `GRADIENT_BOOSTING-${SI}`,
      modelVersion: "v1.0",
      accuracy: 0.91,
      lastTrainedAt: new Date(),
      features: ["bedrooms", "location"],
      hyperparameters: { depth: 6, lr: 0.1 },
      trainingMetrics: { mse: 0.05, mae: 0.02 },
    },
  }).catch(() => prisma.aIValuationModel.findFirst({ where: { id: id("aivalmod") } }) as any);

  await prisma.aIPropertyValuation.create({
    data: {
      id: id("aipropval"),
      predictedValue: 1525000,
      inputFeatures: {},
      propertyId: property!.id,
      modelId: aivm?.id || id("aivalmod"),
      confidenceScore: 0.9,
      valuationDate: new Date(),
    },
  }).catch((e) => { console.error(e); });
  const ailsm = await prisma.aILeadScoring.create({ data: { orgId: org.id, id: id("aileadscoremod"), modelVersion: "2.1", lastTrainedAt: new Date(), scoringLogic: {}, modelName: `LOGISTIC_REGRESSION-${SI}`, features: ["budget", "timeline"], accuracy: 0.85 } }).catch(() => prisma.aILeadScoring.findFirst({ where: { id: id("aileadscoremod") } }) as any);
  await prisma.aILeadScore.create({ data: { orgId: org.id, id: id("aileadsc"), scoredAt: new Date(), confidence: 0.95, featuresUsed: {}, leadId: lead!.id, modelId: ailsm!.id, score: 0.78, scoreBreakdown: { budget: 0.9, engagement: 0.7 } } }).catch((e) => { console.error(e); });
  await prisma.aIMarketAnalysis.create({ data: { id: id("aimarket"), analysisType: "PRICE_TREND", insights: ["Rising demand"], dataPoints: { avgPrice: 1500000 }, location: "NYC", analysisPeriod: "2024", predictions: {}, generatedAt: new Date(), confidence: 0.88 } }).catch((e) => { console.error(e); });
  await prisma.aIPropertyDescription.create({ data: { orgId: org.id, id: id("aipropdesc"), tone: "FRESH", propertyId: property!.id, generatedAt: new Date(), generatedDescription: "A breathtaking 3BR apartment in the heart of Manhattan.", targetAudience: "Investors", keyFeatures: ["View", "Space"], seoKeywords: ["Manhattan", "3BR"], qualityScore: 0.92 } }).catch((e) => { console.error(e); });
  await prisma.aIImageAnalysis.create({ data: { orgId: org.id, id: id("aiimage"), propertyId: property!.id, analyzedAt: new Date(), analysisType: "QUALITY", styleTags: ["luxury", "bright", "modern"], qualityScore: 0.92, confidence: 0.95 } }).catch((e) => { console.error(e); });
  await prisma.aIPriceOptimization.create({ data: { orgId: org.id, id: id("aiprice"), listingId: listing!.id, currentPrice: 1500000, recommendedPrice: 1525000, priceRange: {}, factors: {}, comparableData: {}, marketTrends: {}, confidence: 0.85, generatedAt: new Date() } }).catch((e) => { console.error(e); });
  await prisma.aISentimentAnalysis.create({ data: { orgId: org.id, id: id("aisentiment"), contentType: "PROPERTY", contentId: property!.id, contentText: "Test", sentiment: "POSITIVE", sentimentScore: 0.85, analyzedAt: new Date(), confidence: 0.95 } }).catch((e) => { console.error(e); });
  await prisma.aIFraudDetection.create({ data: { orgId: org.id, id: id("aifraud"), entityType: "RESERVATION", entityId: reservation!.id, riskScore: 0.05, riskCategory: "LOW", riskFactors: {}, detectedAt: new Date() } }).catch((e) => { console.error(e); });
  await prisma.aIRecommendation.create({ data: { orgId: org.id, id: id("airec"), userType: "USER", userId: u1.id, recommendedProperties: {}, recommendationType: "SIMILAR_LISTING", userPreferences: {}, reasoning: { text: "Matching budget" }, generatedAt: new Date() } }).catch((e) => { console.error(e); });
  await prisma.aIChatbotSession.create({ data: { orgId: org.id, id: id("aichat"), sessionId: "sess-seed-001", conversationHistory: [], startedAt: new Date(), lastActivityAt: new Date(), status: "SUCCESS" } }).catch((e) => { console.error(e); });
  await prisma.aIPredictiveMaintenance.create({ data: { orgId: org.id, id: id("aimaint"), propertyId: property!.id, componentType: "HVAC", failureProbability: 0.1, riskLevel: "LOW", contributingFactors: {}, generatedAt: new Date(), predictedFailureDate: new Date("2025-06-01") } }).catch((e) => { console.error(e); });
  await prisma.aITenantScreening.create({ data: { orgId: org.id, id: id("aitenant"), applicationId: id("app"), overallScore: 0.88, riskAssessment: "LOW", creditScore: 780, riskFactors: {}, recommendations: {}, screenedAt: new Date() } }).catch((e) => { console.error(e); });
  await prisma.aIInvestmentAnalysis.create({ data: { id: id("aiinvest"), propertyId: property!.id, analysisType: "BUY", timeHorizon: "5Y", projectedReturns: {}, cashFlowProjection: {}, riskMetrics: {}, keyAssumptions: {}, sensitivityAnalysis: {}, confidence: 0.85, generatedAt: new Date() } }).catch((e) => { console.error(e); });
  console.log("✅ All AI models (15)");

  // ═══════════════════════════════════════════════════════════════
  // 81. QUEUE MESSAGE + QUEUE CONFIGURATION
  // ═══════════════════════════════════════════════════════════════
  await prisma.queueMessage.create({
    data: {
      id: id("qmsg"),
      messageId: "msg-seed-001",
      queueName: "notifications", messageType: "NOTIFICATION",
      payload: { type: "LEASE_EXPIRY", userId: u1.id },
      status: "QUEUED",
    },
  }).catch((e) => { console.error(e); });

  await prisma.queueConfiguration.create({
    data: {
      id: id("qconfig"),
      
      queueName: "notifications", messageType: "NOTIFICATION",
      exchangeName: "events",
      routingKey: "notification.*",
      handlerClass: "NotificationHandler",
      retryPolicy: { maxRetries: 3 },
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ QueueMessage + QueueConfiguration");

  // ═══════════════════════════════════════════════════════════════
  // 82. INTEGRATION LOG
  // ═══════════════════════════════════════════════════════════════
  await prisma.integrationLog.create({
    data: {
      id: id("intlog"),
      orgId: org.id,
      integrationType: "Airbnb",
      operation: "SYNC",
      requestData: { endpoint: "/listings/sync" },
      responseData: { synced: 1 },
      processingTimeMs: 1250,
      success: true,
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 83. AUTOMATION RULE + AUTOMATION EXECUTION
  // ═══════════════════════════════════════════════════════════════
  const autoRule = await prisma.automationRule.create({
    data: {
      orgId: org.id, 
      id: id("autorule"),
      ruleName: "Lease Expiry Notification", 
      ruleType: "LEASE", 
      triggerType: "LEASE_EXPIRY",
      triggerConfig: { daysBeforeExpiry: 30 },
      conditions: { daysBeforeExpiry: 30 },
      actions: [{ type: "SEND_NOTIFICATION", template: "lease-expiry" }],
    },
  }).catch(() => prisma.automationRule.findFirst({ where: { id: id("autorule") } }) as any);

  await prisma.automationExecution.create({
    data: {
      orgId: org.id, 
      id: id("autoexec"),
      
      ruleId: (autoRule?.id || id("autorule")),
      status: "COMPLETED",
      executionData: {},
      executedAt: new Date(),


    },
  }).catch((e) => { console.error(e); });
  console.log("✅ AutomationRule + AutomationExecution");

  // ═══════════════════════════════════════════════════════════════
  // 84. MOBILE DEVICE + OFFLINE SYNC QUEUE
  // ═══════════════════════════════════════════════════════════════
  await prisma.mobileDevice.create({
    data: {
      orgId: org.id,
      id: id("mobdev"),
      deviceId: `DEV-123-${SI}`,
      appVersion: `1.0-${SI}`,
      userId: u1.id,
      
      deviceType: "MOBILE",
      osVersion: "15.0",
      deviceToken: `device-token-seed-001-${SI}`,
      
    },
  }).catch((e) => { console.error(e); });

  await prisma.offlineSyncQueue.create({
    data: {
      orgId: org.id, 
      id: id("offlinq"),
      userId: u1.id,
      
      entityType: "Task",
      entityId: task!.id,
      operation: "UPDATE",
      data: { status: "IN_PROGRESS" },
      deviceId: `DEV-123-${SI}`,

    },
  }).catch((e) => { console.error(e); });
  console.log("✅ MobileDevice + OfflineSyncQueue");

  // ═══════════════════════════════════════════════════════════════
  // 85. DASHBOARD WIDGET + DASHBOARD CONFIGURATION
  // ═══════════════════════════════════════════════════════════════
  await prisma.dashboardWidget.create({
    data: {
      orgId: org.id, 
      id: id("widget"),
      userId: u1.id,
      
      widgetType: WidgetType.OCCUPANCY_RATE,
      title: `Occupancy Rate ${SI}`,
      config: { timeRange: "30d", propertyId: property!.id },
      position: { x: 0, y: 0, w: 4, h: 3 },
    },
  }).catch((e) => { console.error(e); });

  await prisma.dashboardConfiguration.create({
    data: {
      orgId: org.id,
      id: id("dashconfig"),
      widgets: {},
      userId: u1.id,
      
      dashboardName: "Main Dashboard",
      layout: [{ widgetId: id("widget"), position: { x: 0, y: 0 } }],
      isDefault: true,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ DashboardWidget + DashboardConfiguration");

  // ═══════════════════════════════════════════════════════════════
  // 86. PREDICTIVE MODEL
  // ═══════════════════════════════════════════════════════════════
  await prisma.predictiveModel.create({
    data: {
      orgId: org.id,
      id: id("predmodel"),
      
      modelType: ModelType.RENT_PRICE_PREDICTION,
      trainingData: { samples: 10000, features: ["bedrooms", "location", "size"] },
      parameters: { learningRate: 0.01, epochs: 100 },
      accuracy: 0.93,
      lastTrained: new Date(),
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ PredictiveModel");

  // ═══════════════════════════════════════════════════════════════
  // 87. LOYALTY ACCOUNT + REFERRAL + ACHIEVEMENT + EARNING
  // ═══════════════════════════════════════════════════════════════
  await prisma.loyaltyAccount.create({
    data: {
      orgId: org.id,
      id: id("loyalty"),
      
      userId: u1.id,
      name: `Alice's Loyalty Account ${SI}`,
      currentPoints: 2500,
      currentTier: LoyaltyTier.SILVER,
      totalEarned: 2500,
      
    },
  }).catch((e) => { console.error(e); });

  await prisma.referral.upsert({
    where: { code: `SEED-REF-001-${SI}` },
    update: {},
    create: {

      id: id("referral"),
      userId: u1.id,
      code: `SEED-REF-001-${SI}`,
      commissionRate: 0.05,
      bonusPoints: 500,
      totalReferrals: 3,
      successfulReferrals: 2,
      totalEarnings: 6000,
    },
  });

  await prisma.achievement.create({
    data: {

      id: id("achieve"),
      userId: u1.id,
      goalType: GoalType.DEALS_CLOSED,
      goalValue: 5,
      currentValue: 3,
      isCompleted: false,
      pointsReward: 1000,
      organizationId: org.id,
    },
  }).catch((e) => { console.error(e); });

  await prisma.earning.create({
    data: {
      orgId: org.id,
      id: id("earning"),
      
      userId: u1.id,
      name: `Commission Earning Rule ${SI}`,
      type: EarningType.COMMISSION,
      percentage: 2.5,
      appliesToAgents: true,
      
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ LoyaltyAccount + Referral + Achievement + Earning");

  // ═══════════════════════════════════════════════════════════════
  // 88. SUBSCRIPTION + GIFT CARD
  // ═══════════════════════════════════════════════════════════════
  const subscription = await prisma.subscription.create({
    data: {
      orgId: org.id,
      id: id("subscription"),
      
      name: `Enterprise Plan ${SI}`,
      type: MembershipType.ENTERPRISE,
      price: 499,
      currency: "USD",
      billingCycle: "MONTHLY",
      maxProperties: 100,
      maxListings: 500,
      featuredListings: 10,
      prioritySupport: true,
      apiAccess: true,
      
    },
  }).catch(() => prisma.subscription.findFirst({ where: { id: id("subscription") } }) as any);

  await prisma.giftCard.upsert({
    where: { code: `SEED-GC-001-${SI}` },
    update: {},
    create: {
      orgId: org.id,
      id: id("giftcard"),
      
      code: `SEED-GC-001-${SI}`,
      amount: 500,
      balance: 500,
      currency: "USD",
      
      expiresAt: new Date("2025-12-31"),
    },
  });
  console.log("✅ Subscription + GiftCard");

  // ═══════════════════════════════════════════════════════════════
  // 89. ORG SUBSCRIPTION + PLAN
  // ═══════════════════════════════════════════════════════════════
  const plan = await prisma.plan.create({
    data: {
       
      id: id("plan"),
      key: "enterprise",
      name: `Enterprise ${SI}`,
      priceMonthlyCents: 49900,
      limits: { maxProperties: 100 },
      
    },
  }).catch(() => prisma.plan.findFirst({ where: { id: id("plan") } }) as any);

  await prisma.orgSubscription.create({
    data: {
      orgId: org.id,
      id: id("orgsubsc"),
      planId: (plan?.id || id("plan")),
      status: SubscriptionStatus.ACTIVE,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Plan + OrgSubscription");

  // ═══════════════════════════════════════════════════════════════
  // 90. COMMISSION + COMMISSION RULE
  // ═══════════════════════════════════════════════════════════════
  const commission = await (prisma.commission as any).create({
    data: {
      
      id: id("commission"),
      orgId: org.id,
      amountBase: 43500,
      commissionAmount: 1305,
      currency: "USD",
      platformFee: 130,
      partnerFee: 65,
      taxAmount: 260,
    } as any,
  }).catch(() => prisma.commission.findFirst({ where: { id: id("commission") } }) as any);

  const refSource = await prisma.referenceSource.create({
    data: {
      id: id("refsrc"),
      name: `Airbnb ${SI}`,
      logo: "https://cdn.example.com/logos/airbnb.svg",
      
      commission: 3.0,
      source: BookingSource.Airbnb,
    },
  }).catch(() => prisma.referenceSource.findFirst({ where: { id: id("refsrc") } }) as any);

  await prisma.commissionRule.upsert({
    where: { providerId_ruleType: { providerId: refSource!.id, ruleType: CommissionRuleType.SEASONAL } },
    
    update: {},
    
    create: {
      
      id: id("commrule"),
      providerId: refSource!.id,
      ruleType: CommissionRuleType.SEASONAL,
      commission: 15.0,
      startDate: new Date("2024-06-01"),
      endDate: new Date("2024-09-30"),
    },
  });
  console.log("✅ Commission + ReferenceSource + CommissionRule");

  // ═══════════════════════════════════════════════════════════════
  // 91. WEBHOOK + WEBHOOK DELIVERY
  // ═══════════════════════════════════════════════════════════════
  const webhook = await prisma.webhook.create({
    data: {
      
      orgId: org.id,
      
      id: id("webhook"),
      
      name: `Slack Notifications ${SI}`,
      url: "https://hooks.slack.com/seed-webhook",
      secret: "wh-secret-seed-001",
      events: ["booking.confirmed", "lease.expired", "task.completed"],
      
    },
  }).catch(() => prisma.webhook.findFirst({ where: { id: id("webhook") } }) as any);

  await prisma.webhookDelivery.create({
    data: {
      orgId: org.id,
      id: id("whdel"),
      
      webhookId: webhook!.id,
      eventType: "booking.confirmed",
      payload: { bookingId: booking!.id, status: "CONFIRMED" },
      statusCode: 200,
      deliveredAt: new Date(),
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Webhook + WebhookDelivery");

  // ═══════════════════════════════════════════════════════════════
  // 92. AUDIT LOG
  // ═══════════════════════════════════════════════════════════════
  await prisma.auditLog.create({
    data: {
      orgId: org.id,
      id: id("auditlog"),
      
      userId: u1.id,
      action: "UPDATE",
      entityType: "Lease",
      entityId: lease!.id,
      oldValues: { status: "DRAFT" },
      newValues: { status: "COMPLETED" },
      ipAddress: "127.0.0.1",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ AuditLog");

  // ═══════════════════════════════════════════════════════════════
  // 93. COMMUNICATION TEMPLATE
  // ═══════════════════════════════════════════════════════════════
  await prisma.communicationTemplate.create({
    data: {
      orgId: org.id,
      id: id("commtemplate"),
      
      name: `Lease Renewal Notice ${SI}`,
      type: "EMAIL",
      templateType: "TRANSACTIONAL",
      subject: "Your Lease is Expiring Soon",
      htmlContent: "<h1>Lease Renewal</h1><p>Your lease expires in {{days}} days.</p>",
      textContent: "Your lease expires in {{days}} days.",
      channels: ["EMAIL", "IN_APP"],
      
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 94. DOCUMENT TEMPLATE
  // ═══════════════════════════════════════════════════════════════
  await prisma.documentTemplate.create({
    data: {
      orgId: org.id,
      id: id("doctemplate"),
      
      name: `Standard Residential Lease ${SI}`,
      type: "LEASE",
      category: "RESIDENTIAL",
      templateContent: "THIS LEASE AGREEMENT is made on {{date}} between {{landlord}} and {{tenant}}...",
      variables: { date: "string", landlord: "string", tenant: "string" },
      
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ CommunicationTemplate + DocumentTemplate");

  // ═══════════════════════════════════════════════════════════════
  // 95. NEIGHBORHOOD + EVENT + EVENT ATTENDEE
  // ═══════════════════════════════════════════════════════════════
  const event = await prisma.event.create({
    data: {
      orgId: org.id,
      id: id("event"),
      
      propertyId: property!.id,
      name: `Grand Tower Open House ${SI}`,
      eventType: EventType.OPEN_HOUSE,
      startDate: new Date("2024-05-15T10:00:00Z"),
      endDate: new Date("2024-05-15T13:00:00Z"),
      
      isPublic: true,
      maxAttendees: 50,
    },
  }).catch(() => prisma.event.findFirst({ where: { id: id("event") } }) as any);

  await prisma.eventAttendee.create({
    data: {
      orgId: org.id,
      id: id("evattendee"),
      eventId: (event?.id || id("event")),
      userId: u1.id,
      contactId: contact1!.id,
      rsvpStatus: "CONFIRMED", 
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ Event + EventAttendee");

  // ═══════════════════════════════════════════════════════════════
  // 96. SYSTEM METRICS + HEALTH CHECK + PERFORMANCE ALERT
  // ═══════════════════════════════════════════════════════════════
  await prisma.systemMetrics.create({
    data: {
      id: id("sysmetrics"),
      metricType: "API_RESPONSE_TIME",
      metricName: "Average API Response Time",
      value: 125.5,
      unit: "ms",
      timestamp: new Date(),
      dimensions: { endpoint: "/api/properties", method: "GET" },
    },
  }).catch((e) => { console.error(e); });

  await prisma.healthCheck.create({
    data: {
      id: id("healthcheck"),
      serviceName: "Database",
      componentName: "PostgreSQL",
      status: "HEALTHY",
      responseTime: 12,
      details: { host: "db.example.com", port: 5432 },
    },
  }).catch((e) => { console.error(e); });

  await prisma.performanceAlert.create({
    data: {
      id: id("perfalert"),
      alertType: "RESPONSE_TIME",
      severity: "LOW",
      metricName: "Slow API Response",
      threshold: 200,
      actualValue: 215,
      description: "API response time exceeded 200ms threshold",
      status: "ACTIVE",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ SystemMetrics + HealthCheck + PerformanceAlert");

  // ═══════════════════════════════════════════════════════════════
  // 97. ESCROW ACCOUNT + ESCROW RELEASE + ESCROW DISPUTE + STATUS HISTORY
  // ═══════════════════════════════════════════════════════════════
  const escrow = await prisma.escrowAccount.create({
    data: {
      orgId: org.id,
      id: id("escrow"),
      reservationId: (reservation?.id || id("resv")),
      totalAmount: 5000,
      depositAmount: 1000,
      currency: "USD",
      status: EscrowStatus.HOLDING,
    },
  }).catch(() => prisma.escrowAccount.findFirst({ where: { id: id("escrow") } }) as any);

  const escrowRelease = await prisma.escrowRelease.create({
    data: {
      orgId: org.id,
      id: id("escrowrel"),
      triggerEvent: "CHECK_OUT_COMPLETED" as any,
      releasePercent: 1.0,
      escrowId: (escrow?.id || id("escrow")),
      amount: 2835,
      currency: "USD",
      status: "PENDING" as any,
    },
  }).catch((e) => { console.error(e); });

  await prisma.escrowDispute.create({
    data: {
      orgId: org.id,
      id: id("escrowdisp"),
      reservationId: (reservation?.id || id("resv")),
      escrowAccountId: (escrow?.id || id("escrow")),
      openedBy: "GUEST" as any,
      disputeType: "SECURITY_DEPOSIT" as any,
      description: "Damage claim dispute",
      status: "OPEN" as any,
    },
  }).catch((e) => { console.error(e); });

  await prisma.escrowStatusHistory.create({
    data: {
      orgId: org.id,
      id: id("escrowstat"),
      escrowId: (escrow?.id || id("escrow")),
      fromStatus: "RESERVED" as any,
      toStatus: "HELD" as any,
      changedBy: u1.id,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ EscrowAccount + EscrowRelease + EscrowDispute + StatusHistory");

  // ═══════════════════════════════════════════════════════════════
  // 98. AI CHAT MESSAGES + AI CHAT HANDOFF
  // ═══════════════════════════════════════════════════════════════
  const aiChatMsg = await prisma.aIChatMessage.create({
    data: {
      orgId: org.id,
      id: id("aichatmsg"),
      moduleType: "GENERAL",
      sessionId: "sess-seed-001",
      role: "USER",
      content: "Hello", 
    }
    }).catch(() => prisma.aIChatMessage.findFirst({ where: { id: id("aichatmsg") } }) as any);

  await prisma.aIChatHandoff.create({
    data: {
      orgId: org.id,
      id: id("aichathandoff"),
      sessionId: "sess-seed-001",
      handoffTo: u1.id,
      handoffReason: "Complex payment negotiation", 
    }
    }).catch((e) => { console.error(e); });
  console.log("✅ AIChatMessage + AIChatHandoff");

  // ═══════════════════════════════════════════════════════════════
  // 99. PAYMENT NEGOTIATION + NEGOTIATION OFFER + PAYMENT INSTALLMENT
  // ═══════════════════════════════════════════════════════════════
  const negotiation = await prisma.paymentNegotiation.create({
    data: {
      orgId: org.id,
      id: id("negot"),
      reservationId: (reservation?.id || id("resv")),
      tenantContactId: contact1!.id,
    }
    }).catch(() => prisma.paymentNegotiation.findFirst({ where: { id: id("negot") } }) as any);

  await prisma.negotiationOffer.create({
    data: {
      orgId: org.id,
      id: id("negotoffer"),
      negotiationId: (negotiation?.id || id("negot")),
      offeredBy: NegotiationParty.TENANT,
      installmentCount: 3,
      firstPaymentPct: 0.5,
      totalAmount: 1450000, 
    }
    }).catch((e) => { console.error(e); });

  await prisma.paymentInstallment.create({
    data: {
      orgId: org.id,
      id: id("payinst"),
      negotiationId: (negotiation?.id || id("negot")),
      installmentNo: 1,
      amount: 50000,
      currency: "USD",
      dueDate: new Date(),
    }
    }).catch((e) => { console.error(e); });
  console.log("✅ PaymentNegotiation + NegotiationOffer + PaymentInstallment");

  // ═══════════════════════════════════════════════════════════════
  // 100. VIDEO VENDOR + VIDEO VENDOR PARTNERSHIP + AGENT VIDEO + EARNINGS
  // ═══════════════════════════════════════════════════════════════
  const videoVendor = await prisma.videoVendor.upsert({
    where: { email: `vendor@reelview.com-${SI}` },
    update: {},
    create: { 
      
    orgId: org.id,
      
      id: id("vendor"),
      
      name: `ReelView Productions ${SI}`,
      email: `vendor@reelview.com-${SI}`,
      phoneNumber: "+1-212-555-0900",
      tier: VendorTier.PROFESSIONAL,
      status: VendorStatus.ACTIVE,
      commissionRate: 15.0,
      basePrice: 800,
      qualityLevel: VideoQuality.HIGH,
      serviceAreas: ["Manhattan", "Brooklyn"],
      totalVideos: 0,
    },
  });

  const vendorPartnership = await prisma.videoVendorPartnership.upsert({
    where: { vendorId_agentId: { vendorId: videoVendor.id, agentId: agent.id } },
    
    update: {},
    
    create: {
      
      orgId: org.id,
      
      id: id("vpartner"),
      vendorId: videoVendor.id,
      agentId: agent.id,
      
      status: "active",
      tier: VendorTier.PROFESSIONAL,
      commissionRate: 12.0,
    },
  });

  const agentVideo = await prisma.agentVideo.create({
    data: {
      orgId: org.id,
      id: id("agvideo"),
      agentId: agent.id,
      vendorId: videoVendor.id,
      partnershipId: vendorPartnership.id,
      propertyId: property!.id,
      
      title: `Grand Tower 5A – Property Tour ${SI}`,
      description: "Full walkthrough of luxury 3BR apartment",
      videoUrl: "https://cdn.example.com/videos/grand-tower-5a.mp4",
      thumbnailUrl: "https://cdn.example.com/videos/thumb-5a.jpg",
      duration: 180,
      quality: VideoQuality.STANDARD,
      status: "completed",
      qualityScore: 4.8,
    },
  }).catch(() => prisma.agentVideo.findFirst({ where: { id: id("agvideo") } }) as any);

  await prisma.agentEarning.create({
    data: {

      id: id("agearning"),
      agentId: agent.id,
      sourceType: "video_commission",
      sourceId: agentVideo!.id,
      amount: 120,
      commissionRate: 15.0,
      description: "Commission from property video",
      status: "approved",
    },
  }).catch((e) => { console.error(e); });

  await prisma.vendorEarning.create({
    data: {

      id: id("vendearning"),
      vendorId: videoVendor.id,
      videoId: agentVideo!.id,
      
      amount: 680,
      status: "approved",
    },
  }).catch((e) => { console.error(e); });

  await prisma.partnershipEarning.create({
    data: {
      id: id("partearning"),
      partnershipId: vendorPartnership.id,
      agentId: u1.id,
      vendorId: videoVendor.id,
      amount: 800,
      agentShare: 120,
      vendorShare: 680,
      description: "Video partnership earning",
      status: "approved",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ VideoVendor + Partnership + AgentVideo + Earnings (3)");

  // ═══════════════════════════════════════════════════════════════
  // 101. VIDEO QUALITY REVIEW + VENDOR QUALITY REVIEW
  // ═══════════════════════════════════════════════════════════════
  await prisma.videoQualityReview.create({
    data: {
      id: id("vqreview"),
      videoId: id("agvideo"),

      vendorId: videoVendor.id,

      qualityScore: 5,
      approved: true,
    },
  }).catch((e) => { console.error(e); });

  await prisma.vendorQualityReview.create({
    data: {
      id: id("vendqreview"),
      vendorId: videoVendor.id,


      overallScore: 4.7,

      qualityScore: 4,
      reliabilityScore: 5,
      comments: "Very professional and reliable vendor",

    },
  }).catch((e) => { console.error(e); });

  await prisma.videoEarning.create({
    data: {
      orgId: org.id,
      id: id("videoearning"),
      videoId: id("agvideo"),
      vendorId: videoVendor.id,
      
      agentId: agent.id,
      propertyId: property!.id,
      earningType: "view",
      amount: 10,
      currency: "USD",
      period: "monthly",
      periodStart: new Date("2024-04-01"),
      periodEnd: new Date("2024-04-30"),
      status: "confirmed",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ VideoQualityReview + VendorQualityReview + VideoEarning");

  // ═══════════════════════════════════════════════════════════════
  // 102. VIDEO CONTENT + BRAND AMBASSADOR + AMBASSADOR CONTRACT + CAMPAIGN
  // ═══════════════════════════════════════════════════════════════
  const ambassador = await prisma.brandAmbassador.create({
    data: {
      orgId: org.id,
      id: id("ambassador"),
      
      fullName: "Jake Newman",
      category: AmbassadorCategory.REAL_ESTATE_INFLUENCER,
      platform: ["INSTAGRAM", "YOUTUBE"],
      followerCount: 250000,
      engagementRate: 3.5,
      status: AmbassadorStatus.ACTIVE,
      ndaSigned: true,
      ndaSignedAt: new Date("2024-01-15"),
      equityPercent: 0.5,
      upfrontFee: 5000,
    },
  }).catch(() => prisma.brandAmbassador.findFirst({ where: { id: id("ambassador") } }) as any);

  const ambassadorCampaign = await prisma.ambassadorCampaign.create({
    data: {
      orgId: org.id,
      id: id("ambcampaign"),
      
      ambassadorId: ambassador!.id,
      name: `Spring Manhattan Showcase ${SI}`,
      description: "Luxury apartment showcase for Spring 2024",
      startDate: new Date("2024-03-01"),
      endDate: new Date("2024-05-31"),
      budget: 25000,
      currency: "USD",
      status: CampaignStatus.ACTIVE,
      targetReach: 500000,
      platforms: ["INSTAGRAM", "YOUTUBE"],
    },
  }).catch(() => prisma.ambassadorCampaign.findFirst({ where: { id: id("ambcampaign") } }) as any);

  await prisma.ambassadorContract.upsert({
    where: { ambassadorId_version: { ambassadorId: ambassador!.id, version: 1 } },
    
    update: {},
    
    create: {
      orgId: org.id,
      
      id: id("ambcontract"),
      ambassadorId: ambassador!.id,
      version: 1,
      equityPercent: 0.5,
      upfrontFee: 5000,
      currency: "USD",
      startDate: new Date("2024-01-15"),
      endDate: new Date("2025-01-15"),
      signedAt: new Date("2024-01-15"),
      status: ContractStatus.ACTIVE,
    },
  });

  await prisma.videoContent.create({
    data: {
      orgId: org.id,
      id: id("videocontent"),
      
      propertyId: property!.id,

      ambassadorId: ambassador!.id,
      ambassadorCampaignId: ambassadorCampaign!.id,
      title: `Grand Tower – Luxury Living in Manhattan ${SI}`,
      primaryLoraStyle: VideoLoraStyle.REALISTIC,
      pipeline: VideoPipeline.KREA_REALTIME,
      strategy: VideoLoraStrategy.PERMANENT_MERGE,
      prompt: "Luxury Manhattan apartment with stunning city views, golden hour lighting",
      platform: VideoTargetPlatform.INSTAGRAM_REELS,
      status: VideoContentStatus.READY,
      campaignType: VideoCampaignType.PROPERTY_SHOWCASE,
      durationSeconds: 30,
      url: "https://cdn.example.com/videos/grand-tower-reel.mp4",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ BrandAmbassador + AmbassadorContract + AmbassadorCampaign + VideoContent");

  // ═══════════════════════════════════════════════════════════════
  // 103. SOCIAL IMPACT COUNTER + RECORD
  // ═══════════════════════════════════════════════════════════════
  const socialCounter = await prisma.socialImpactCounter.upsert({
    where: { orgId_impactType: { orgId: org.id, impactType: SocialImpactType.TREE_PLANTED } },
    
    update: {},
    
    create: {
      
      orgId: org.id,
      
      id: id("socialctr"),
      
      impactType: SocialImpactType.TREE_PLANTED,
      partnerName: "Arbor Day Foundation",
      isPublic: true,
      displayGoal: 1000,
    },
  });

  await prisma.socialImpactRecord.create({
    data: {
      orgId: org.id,
      id: id("socialrec"),
      
      counterId: socialCounter.id,
      impactType: SocialImpactType.TREE_PLANTED,
      quantity: 1,
      amount: 5,
      currency: "USD",
      description: "1 tree planted for Grand Tower booking",
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ SocialImpactCounter + SocialImpactRecord");

  // ═══════════════════════════════════════════════════════════════
  // 104. PROPERTY OWNERSHIP VERIFICATION + DOCUMENT + TRANSFER
  // ═══════════════════════════════════════════════════════════════
  const ownership = await prisma.propertyOwnershipVerification.create({
    data: {
      orgId: org.id,
      id: id("ownership"),
      propertyId: property!.id,
      
      currentOwnerId: u1.id,
      verificationStatus: OwnershipVerificationStatus.VERIFIED,
      verificationMethod: VerificationMethod.DOCUMENT_UPLOAD,
      verifiedAt: new Date(),
      verifiedBy: u1.id,
      aiConfidenceScore: 0.97,
      legalDescription: "350 Fifth Avenue, Unit 5A, Manhattan, NY 10118",
      parcelNumber: "12345-678",
    },
  }).catch(() => prisma.propertyOwnershipVerification.findFirst({ where: { id: id("ownership") } }) as any);

  await prisma.ownershipVerificationDocument.create({
    data: {
      id: id("owndoc"),
      verificationId: ownership!.id,
      documentType: OwnershipDocumentType.TITLE_DEED,
      fileName: `title-deed.pdf-${SI}`,
      filePath: "/uploads/title-deed.pdf",
      fileSize: 512000,
      mimeType: "application/pdf",
      checksum: `sha256-title-deed-001-${SI}`,
      uploadMethod: "direct",
      validationStatus: "valid",
      accessLevel: "private",
    },
  }).catch((e) => { console.error(e); });

  await prisma.propertyOwnershipTransfer.create({
    data: {
      orgId: org.id,
      id: id("ownxfer"),
      propertyId: property!.id,
      
      fromOwnerId: u2.id,
      toOwnerId: u1.id,
      transferType: "sale",
      transferStatus: "completed",
      transferDate: new Date("2020-01-15"),
      considerationAmount: 1200000,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ PropertyOwnershipVerification + Document + Transfer");

  // ═══════════════════════════════════════════════════════════════
  // 105. BOOKING SECURITY SCREENING
  // ═══════════════════════════════════════════════════════════════
  await prisma.bookingSecurityScreening.create({
    data: {
      orgId: org.id,
      id: id("screening"),
      bookingId: booking!.id,
      reservationId: reservation!.id,
      contactId: contact1!.id,
      propertyId: property!.id,
      screeningStatus: SecurityScreeningStatus.CLEARED,
      riskLevel: SecurityRiskLevel.LOW,
      riskScore: 0.05,
      confidenceScore: 0.97,
      identityVerification: {},
      manualReviewRequired: false,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ BookingSecurityScreening");

  // ═══════════════════════════════════════════════════════════════
  // 106. MISC MODELS
  // ═══════════════════════════════════════════════════════════════

  // VendorProfile
  await prisma.vendorProfile.create({
    data: {
      orgId: org.id,
      id: id("vendprofile"),
      
      legalName: `ReelView Productions LLC-${SI}`,
      serviceAreas: "Manhattan, Brooklyn, Queens",
      defaultCommissionBps: 1500,
    },
  }).catch((e) => { console.error(e); });

  // AgentAssignment
  await prisma.agentAssignment.create({
    data: {
      orgId: org.id,
      id: id("agassign"),
      
      listingId: listing!.id,
      agentUserId: u1.id,
      commissionBps: 300,
    },
  }).catch((e) => { console.error(e); });

  // RecommendationResult
  await prisma.recommendationResult.create({
    data: {
      id: id("recomresult"),
      profileId: id("userfinancial"),
      orgId: org.id,
      score: 95,
      explanation: "Highly recommended based on your financial goals.",
    },
  }).catch((e) => { console.error(e); });

  // Mention
  await prisma.mention.upsert({
    where: {
      mentionedById_mentionedToId_type_taskId_propertyId: {
        mentionedById: u1.id,
        mentionedToId: u2.id,
        type: MentionType.TASK,
        taskId: task!.id,
        propertyId: property!.id,
      },
    },
    
    update: {},
    
    create: {
      id: id("mention"),
      mentionedById: u1.id,
      mentionedToId: u2.id,
      type: MentionType.TASK,
      taskId: task!.id,
      propertyId: property!.id,
      content: "@bob Please handle the inspection task",
      agencyId: agency.id,
      updatedAt: new Date(),
    },
  });

  // Ticket + CommunicationLog + Channel
  const channel = await prisma.channel.create({
    data: {
      id: id("channel"),
      name: `Support Channel ${SI}`,
      type: ChannelType.PRIVATE,
      category: ChannelCategory.TENANT,
    },
  }).catch(() => prisma.channel.findFirst({ where: { id: id("channel") } }) as any);

  const ticket = await prisma.ticket.create({
    data: {
      id: id("ticket"),
      subject: "Maintenance Request – Leaky Faucet",
      description: "The kitchen faucet in unit 5A is leaking.",
      status: TicketStatus.OPEN,
      userId: u1.id,
    },
  }).catch(() => prisma.ticket.findFirst({ where: { id: id("ticket") } }) as any);

  await prisma.communicationLog.create({
    data: {
      id: id("commlog"),
      senderId: u1.id,
      receiverId: u2.id,
      type: CommunicationType.PROBLEM,
      content: "Leaky faucet reported in unit 5A",
      entityType: "Ticket",
      entityId: ticket!.id,
      userId: u1.id,
      agencyId: agency.id,
      channelId: channel!.id,
      ticketId: ticket!.id,
      updatedAt: new Date(),
    },
  }).catch((e) => { console.error(e); });

  // Favorite
  await prisma.favorite.upsert({
    where: { userId_propertyId: { userId: u2.id, propertyId: property!.id } },
    
    update: {},
    
    create: { 

      
      
      id: id("favorite"),
      userId: u2.id,
      propertyId: property!.id,
    },
  });

  // Availability
  await prisma.availability.upsert({
    where: { propertyId_date: { propertyId: property!.id, date: new Date("2024-06-01") } },
    
    update: {},
    
    create: {

      id: id("avail"),
      propertyId: property!.id,
      date: new Date("2024-06-01"),
      isBlocked: false,
      isBooked: false,
      basePrice: 500,
      currentPrice: 500,
    },
  });

  // Discount
  await prisma.discount.upsert({
    where: { code: `SEED10-${SI}` },
    update: {},
    create: {
      id: id("discount"),
      name: `10% Early Bird Discount ${SI}`,
      description: "10% off for early bookings",
      code: `SEED10-${SI}`,
      value: 10,
      type: DiscountType.PERCENTAGE,
      
      propertyId: property!.id,
      updatedAt: new Date(),
    },
  });

  // Currency
  await prisma.currency.upsert({
    where: { code: `USD-${SI}` },
    update: {},
    create: {
      id: id("currency"),
      code: `USD-${SI}`,
      name: `US Dollar ${SI}`,
      symbol: "$",
      exchangeRate: 1.0,
      
      updatedAt: new Date(),
    },
  });

  // Expense
  await prisma.expense.create({
    data: {
      id: id("expense"),
      propertyId: property!.id,
      agencyId: agency.id,
      type: ExpenseType.MAINTENANCE,
      amount: 1500,
      currencyId: id("currency"),
      dueDate: new Date("2024-03-15"),
      status: ExpenseStatus.PAID,
      paidDate: new Date("2024-03-14"),
    },
  }).catch((e) => { console.error(e); });

  // ExtraCharge (requires a reservation)
  await prisma.extraCharge.create({
    data: {
      id: id("extracharge"),
      reservationId: reservation!.id,
      name: `Cleaning Fee ${SI}`,
      description: "Deep cleaning service",
      amount: 150,
      chargeType: "cleaning",
      isPaid: true,
    },
  }).catch((e) => { console.error(e); });

  // Increase
  const increase = await prisma.increase.create({
    data: {
      id: id("increase"),
      propertyId: property!.id,
      tenantId: tenant.id,
      proposedBy: u1.id,
      oldRent: 5000,
      newRent: 5250,
      effectiveDate: new Date("2025-01-01"),
      status: IncreaseStatus.PENDING,
      updatedAt: new Date(),
    },
  }).catch(() => prisma.increase.findFirst({ where: { id: id("increase") } }) as any);

  // Offer (requires Increase)
  await prisma.offer.create({
    data: {
      id: id("offer"),
      offerType: OfferType.STANDARD,
      status: OfferStatus.PENDING,
      basePrice: 5250,
      finalPrice: 5250,
      startDate: new Date("2025-01-01"),
      endDate: new Date("2026-01-01"),
      propertyId: property!.id,
      increaseId: increase!.id,
    },
  }).catch((e) => { console.error(e); });

  // Language
  await prisma.language.upsert({
    where: { code: `en-${SI}` },
    update: {},
    create: {
      id: id("lang"),
      code: `en-${SI}`,
      name: `English ${SI}`,
      nativeName: "English",
      agencyId: agency.id,
      userId: u1.id,
      updatedAt: new Date(),
    },
  });

  // Guest
  await prisma.guest.create({
    data: {
      id: id("guest"),
      name: `Emily Chen ${SI}`,
      phone: "+1-555-0601",
      nationality: "US",
      passportNumber: "US-PASS-001",
      gender: Gender.FEMALE,
      birthDate: new Date("1990-05-15"),
      address: "789 Park Ave",
      city: "New York",
      country: "US",
      zipCode: "10021",
      email: `emily.chen@example.com-${SI}`,
      agencyId: agency.id,
    },
  }).catch((e) => { console.error(e); });

  // Mortgage
  await prisma.mortgage.create({
    data: {
      id: id("mortgage2"),
      propertyId: property!.id,
      lender: "Capital One",
      principal: 600000,
      interestRate: 6.75,
      startDate: new Date("2021-01-01"),
      status: MortgageStatus.ACTIVE,
      updatedAt: new Date(),
    },
  }).catch((e) => { console.error(e); });

  // Analytics
  await prisma.analytics.create({
    data: {
      id: id("analytics"),
      entityId: property!.id,
      entityType: "Property",
      type: AnalyticsType.LISTING_VIEW,
      data: { views: 150, uniqueViews: 120 },
      propertyId: property!.id,
      userId: u1.id,
      agencyId: agency.id,
    },
  }).catch((e) => { console.error(e); });

  // ComplianceRecord
  await prisma.complianceRecord.create({
    data: {
      id: id("comprec"),
      entityId: property!.id,
      entityType: "Property",
      type: ComplianceType.FIRE_SAFETY,
      status: ComplianceStatus.APPROVED,
      isVerified: true,
      propertyId: property!.id,
      agencyId: agency.id,
      updatedAt: new Date(),
    },
  }).catch((e) => { console.error(e); });

  // MLConfiguration
  await prisma.mLConfiguration.upsert({
    where: { id: "singleton" },
    update: {},
    create: {
      id: "singleton",
      enableAutoTagging: true,
      qualityThreshold: 0.75,
      enableMLFeatures: true,
      maxTagsPerImage: 5,
    },
  });

  // MLModel
  await prisma.mLModel.create({
    data: {
      id: id("mlmodel"),
      modelName: `PropertyScorer-${SI}`,
      modelType: "investment_score",
      version: "1.0.0",
      accuracy: 0.91,
      trainingData: { samples: 50000, features: 45 },
      
    },
  }).catch((e) => { console.error(e); });

  // MapData
  await prisma.mapData.create({
    data: {
      id: id("mapdata"),
      coordinates: { latitude: 40.7484, longitude: -73.9967 },
      address: "350 Fifth Avenue, New York, NY 10118",
      placeId: "ChIJaXQRs6lZwokRY6EFpJnhNNE",
      amenities: [{ type: "subway", name: `34th Street Station ${SI}`, distance: 0.3 }],
      geocodingData: { accuracy: "ROOFTOP", status: "OK" },
    },
  }).catch((e) => { console.error(e); });

  // AutomationTask
  await prisma.automationTask.create({
    data: {
      id: id("autotask"),
      taskType: "monitoring",
      status: "completed",
      schedule: "0 9 * * *",
      lastRun: new Date(),
      configuration: { target: "properties", action: "check_compliance" },
      result: { checked: 1, issues: 0 },
    },
  }).catch((e) => { console.error(e); });

  // ScrapingJob
  await prisma.scrapingJob.create({
    data: {
      id: id("scrapjob"),
      jobType: "sahibinden",
      status: "completed",
      startTime: new Date(),
      endTime: new Date(),
      projectsScraped: 10,
      errors: [],
      configuration: { maxPages: 5, filters: { city: "Istanbul" } },
    },
  }).catch((e) => { console.error(e); });

  // Verification
  await prisma.verification.create({
    data: {
      id: id("verification"),
      identifier: `alice@seedre.com-${SI}`,
      value: "verified",
      expiresAt: new Date(Date.now() + 24 * 3600 * 1000),
    },
  }).catch((e) => { console.error(e); });

  // Job
  await prisma.job.create({
    data: {
      id: id("job"),
      
      type: "SEND_EMAIL",
      payload: { template: "lease-expiry", userId: u1.id },
      status: ExportStatus.DONE,
      attempts: 1,
    },
  }).catch((e) => { console.error(e); });

  // TaxRecord analytics link
  if (taxRecord) {
    await prisma.analytics.create({
      data: {
        id: id("analytics2"),
        entityId: taxRecord.id,
        entityType: "TaxRecord",
        type: AnalyticsType.TAX_PAYMENT,
        data: { amount: 5000, period: "2024-01" },
        taxRecordId: taxRecord.id,
      },
    }).catch((e) => { console.error(e); });
  }

  console.log("✅ Misc models: VendorProfile, AgentAssignment, RecommendationResult, Mention,");
  console.log("   Channel, Ticket, CommunicationLog, Favorite, Availability, Discount,");
  console.log("   Currency, Expense, ExtraCharge, Increase, Offer, Language, Guest,");
  console.log("   Analytics, ComplianceRecord, MLConfiguration, MLModel, MapData,");
  console.log("   AutomationTask, ScrapingJob, Verification, Job");

  // ═══════════════════════════════════════════════════════════════
  // 107. INCLUDED SERVICE
  // ═══════════════════════════════════════════════════════════════
  await prisma.includedService.create({
    data: {
      id: id("inclsvc"),
      propertyId: property!.id,
      name: `Internet Service ${SI}`,
      description: "1 Gbps fiber internet included",
      value: 99,
      isRecurring: true,
      frequency: "monthly",
      facilityId: facility!.id,
    },
  }).catch((e) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 108. PAYMENT
  // ═══════════════════════════════════════════════════════════════
  await prisma.payment.create({
    data: {
      id: id("payment"),
      tenantId: tenant.id,
      leaseId: lease!.id,
      amount: 5000,
      type: "Rent",
      currencyId: id("currency"),
      paymentDate: new Date("2024-01-31"),
      dueDate: new Date("2024-02-01"),
      status: PaymentStatus.PAID,
      paymentMethod: "BANK_TRANSFER",
      reference: `PAY-2024-001-${SI}`,
      propertyId: property!.id,
      reservationId: reservation!.id,
      subscriptionId: subscription!.id,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ IncludedService + Payment");

  // ═══════════════════════════════════════════════════════════════
  // FINAL: 10 POSTS
  // ═══════════════════════════════════════════════════════════════
  const posts = [
    { title: `Beşiktaş'ta Satılık 3+1 Daire ${SI}`, content: "Beşiktaş merkezde, deniz manzaralı, 140 m² brüt alanlı, yeni binalarda satılık daire. Isıtma merkezi, otoparklı, güvenlikli site içinde.", slug: "besiktas-satilik-3-1-daire", user: u1, tag: tag1 },
    { title: `Sarıyer'de Lüks Villa – Boğaz Manzaralı ${SI}`, content: "Sarıyer'de 500 m² özel bahçeli, 6+2 lüks villa. Boğaz'a sıfır konumda, özel havuzlu, akıllı ev sistemleriyle donatılmış.", slug: "sariyer-luks-villa", user: u2, tag: tag2 },
    { title: `Levent Ofis Katı – Kiralık ${SI}`, content: "Levent finans bölgesinde, A sınıfı ofis binasında 350 m² açık plan ofis katı kiralanacaktır. 7/24 güvenlik dahil.", slug: "levent-ofis-kiralik", user: u3, tag: tag3 },
    { title: `Kadıköy'de Satılık 2+1 Daire ${SI}`, content: "Kadıköy Moda'da, 85 m², çift cepheli, güneş alan 2+1 satılık daire. Kombi ısıtmalı, balkonlu, bakımlı binada.", slug: "kadikoy-satilik-2-1", user: u1, tag: tag1 },
    { title: `Ataşehir'de Yatırımlık Dükkan ${SI}`, content: "Ataşehir Finans Merkezi yakınında, 120 m² cadde üzeri dükkan satışa çıkarıldı. Yüksek yaya trafiği, zemin kat.", slug: "atasehir-yatirimlik-dukkan", user: u2, tag: tag3 },
    { title: `Bakırköy'de Denize Yakın Kiralık Daire ${SI}`, content: "Bakırköy sahil şeridine 5 dakika yürüme mesafesinde, 110 m² 3+1 kiralık daire. Eşyalı seçeneği mevcut.", slug: "bakirkoy-kiralik-daire", user: u3, tag: tag1 },
    { title: `Maslak'ta Satılık Ticari Arsa ${SI}`, content: "Maslak-Ayazağa bölgesinde, 1.200 m² ticari imarlı arsa satışa sunulmuştur. Metro hattına yakın.", slug: "maslak-ticari-arsa", user: u1, tag: tag3 },
    { title: `Üsküdar'da Tarihi Konak ${SI}`, content: "Üsküdar'da 19. yüzyıla ait ahşap konak, restorasyon amacıyla satışa çıkarıldı. 320 m² kullanım alanı.", slug: "uskudar-tarihi-konak", user: u2, tag: tag2 },
    { title: `Şişli'de Satılık 1+1 Stüdyo ${SI}`, content: "Şişli Bomonti'de modern bina içinde, 55 m² satılık stüdyo daire. Yerden ısıtmalı, amerikan mutfaklı.", slug: "sisli-studyo-daire", user: u3, tag: tag1 },
    { title: `Florya'da Müstakil Bahçeli Ev ${SI}`, content: "Florya sahil bölgesinde, 250 m² müstakil bahçeli ev. 4+1, tripleks yapı, geniş garaj. Denize 300 metre.", slug: "florya-mustakil-ev", user: u1, tag: tag2 },
  ];

  let postCount = 0;
  for (const p of posts) {
    await prisma.post.upsert({
      where: { id: id("post", postCount + 1) },
      update: {},
      create: {
        id: id("post", postCount + 1),
        title: p.title,
        content: p.content,
        slug: p.slug,
        userId: p.user.id,
        agencyId: agency.id,
        agentId: agent.id,
        hashtagId: p.tag.id,
      },
    });
    postCount++;
  }
  console.log(`\n✅ Posts: ${postCount}/10\n`);

  // ═══════════════════════════════════════════════════════════════
  // ÖZET
  // ═══════════════════════════════════════════════════════════════
  // ═══════════════════════════════════════════════════════════════
  // 109. PRICING RULE
  // ═══════════════════════════════════════════════════════════════
  await prisma.pricingRule.create({
    data: {
      id: id("pricrule"),
      listingId: listing!.id,
      name: `Weekend Premium ${SI}`,
      description: "20% surcharge on weekends",
      ruleType: "dynamic",
      basePrice: 500,
      strategy: "DYNAMIC",
      startDate: new Date("2024-01-01"),
      endDate: new Date("2024-12-31"),
      minNights: 2,
      maxNights: 14,
      conditions: { days: ["Saturday", "Sunday"] },
      actions: { type: "PERCENTAGE", value: 20 },
      priority: 1,
      isActive: true,
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ PricingRule");

  // ═══════════════════════════════════════════════════════════════
  // 110. PROPERTY PROMOTION
  // ═══════════════════════════════════════════════════════════════
  await prisma.propertyPromotion.create({
    data: {
      id: id("propromo"),
      propertyId: property!.id,
      agencyId: agency.id,
      agentId: agent.id,
      userId: u1.id,
      promotionType: PropertyPromotionType.FEATURED,
      status: PropertyPromotionStatus.ACTIVE,
      startDate: new Date("2024-03-01"),
      endDate: new Date("2024-06-01"),
      price: 299,
      currency: "USD",
      isAutoRenew: false,
      features: ["homepage_banner", "priority_search", "social_boost"],
    },
  }).catch((e) => { console.error(e); });
  console.log("✅ PropertyPromotion");

  // ═══════════════════════════════════════════════════════════════
  // 111. AI SERVICE TASKS (NEW)
  // ═══════════════════════════════════════════════════════════════
  await (prisma as any).aiServiceTask.create({
    data: {
      id: id("aitask"),
      orgId: org.id,
      propertyId: property!.id,
      listingId: listing!.id,
      taskType: "REELS_VIDEO_GEN",
      status: "COMPLETED",
      inputData: { style: "LUXURY" },
      outputData: { videoUrl: "https://example.com/ai-video.mp4" },
      progress: 100,
    }
  }).catch((e: any) => { console.error(e); });
  console.log("✅ AiServiceTask");

  // ═══════════════════════════════════════════════════════════════
  // 112. AI SERVICE ARTIFACTS
  // ═══════════════════════════════════════════════════════════════
  await (prisma as any).aiVideoGeneration.create({
    data: {
      id: id("aivideo"),
      propertyId: property!.id,
      videoUrl: "https://example.com/viral-reels.mp4",
      status: "COMPLETED"
    }
  }).catch((e: any) => { console.error(e); });

  await (prisma as any).aiBrochureGeneration.create({
    data: {
      id: id("aibrochure"),
      propertyId: property!.id,
      listingId: listing!.id,
      pdfUrl: "https://example.com/property-brochure.pdf",
      status: "COMPLETED"
    }
  }).catch((e: any) => { console.error(e); });

  await (prisma as any).aiExtractedData.create({
    data: {
      id: id("aiextract"),
      entityType: "Document",
      entityId: id("doc"),
      extractedJson: { owner: "Emily Chen", title: "Property Deed" }
    }
  }).catch((e: any) => { console.error(e); });

  await (prisma as any).videoCaption.create({
    data: {
      id: id("caption"),
      videoId: id("aivideo"),
      language: "en",
      captionText: "Enjoy this beautiful view!"
    }
  }).catch((e: any) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 113. GLOBAL COMPLIANCE & REVENUE
  // ═══════════════════════════════════════════════════════════════
  await (prisma as any).legalCompliance.create({
    data: {
      id: id("legalcomp"),
      orgId: org.id,
      countryCode: "TR",
      complianceType: "GDPR",
      status: "COMPLIANT"
    }
  }).catch((e: any) => { console.error(e); });

  await (prisma as any).globalTaxRegulation.create({
    data: {
      id: id("taxreg"),
      orgId: org.id,
      propertyId: property!.id,
      taxAuthority: "IRS",
      taxType: "VAT",
      taxRate: 0.05
    }
  }).catch((e: any) => { console.error(e); });

  await (prisma as any).platformRevenueRecord.create({
    data: {
      id: id("revrec"),
      orgId: org.id,
      amount: 1500,
      currency: "USD",
      sourceType: "PLATFORM_FEE"
    }
  }).catch((e: any) => { console.error(e); });

  // ═══════════════════════════════════════════════════════════════
  // 114. SMART ACCESS & STAY DETAILS
  // ═══════════════════════════════════════════════════════════════
  const lock = await (prisma as any).smartLock.create({
    data: {
      id: id("lock"),
      propertyId: property!.id,
      lockName: "Front Door",
      lockType: "AUGUST_SMART",
      status: "ONLINE"
    }
  }).catch(() => null);

  if (lock) {
    await (prisma as any).accessCode.create({
      data: {
        id: id("code"),
        lockId: (lock as any).id,
        code: "1234",
        status: "ACTIVE"
      }
    }).catch((e: any) => { console.error(e); });
  }

  await (prisma as any).stayOccupant.create({
    data: {
      id: id("occupant"),
      reservationId: reservation!.id,
      name: "John Doe",
      relationToGuest: "FRIEND"
    }
  }).catch((e: any) => { console.error(e); });

  await (prisma as any).policeReport.create({
    data: {
      id: id("police"),
      orgId: org.id,
      propertyId: property!.id,
      reservationId: reservation!.id,
      reportType: "KBS",
      status: "SUBMITTED"
    }
  }).catch((e: any) => { console.error("PoliceReport Error:", e.message); });

  console.log("✅ AI Artifacts + Global Compliance + Smart Access");

  if (lock) {
    await (prisma as any).accessLog.create({
      data: {
        id: id("aclog"),
        lockId: (lock as any).id,
        codeId: id("code"),
        action: "UNLOCK",
        status: "SUCCESS"
      }
    }).catch((e: any) => { console.error(e); });
  }

  const guest = await prisma.guest.findFirst();

  await (prisma as any).identityDocument.upsert({
    where: { id: id("iddoc") },
    update: {},
    create: {
      id: id("iddoc"),
      guestId: guest?.id,
      documentType: "PASSPORT",
      imageUrl: "https://example.com/passport.jpg",
      isVerified: true
    }
  }).catch((e: any) => { console.error("IdentityDocument Error:", e.message); });

  await (prisma as any).marketRateComparison.upsert({
    where: { id: id("marketcomp") },
    update: {},
    create: {
      id: id("marketcomp"),
      orgId: org.id,
      propertyId: property.id,
      sourceName: "AIRBNB",
      competitorPrice: 550,
      ourPrice: 480,
      priceDifference: 70,
      competitorCurrency: "USD",
      status: "ACTIVE"
    }
  }).catch((e: any) => { console.error("MarketRateComp Error:", e.message); });

  await (prisma as any).featureAddOn.upsert({
    where: { orgId_type: { orgId: org.id, type: "VIDEO_BOOST_CREDITS" as any } },
    update: {},
    create: {
      id: id("faddon"),
      orgId: org.id,
      type: "VIDEO_BOOST_CREDITS" as any,
      priceAmount: 50,
      status: "ACTIVE" as any
    }
  }).catch((e: any) => { console.error("FeatureAddOn Error:", e.message); });

  console.log("✅ Final Blocks: AccessLog, IdentityDoc, MarketComp, FeatureAddOn");

  console.log("═".repeat(60));
  console.log("🎉 SEED TAMAMLANDI");
  console.log("═".repeat(60));
  console.log("Oluşturulan başlıca kayıtlar:");
  console.log("  Organization, 3 User, Session, Account");
  console.log("  Role, Permission, RolePermission");
  console.log("  ApiToken, ApiKey, UserPreference, UserFinancialProfile");
  console.log("  Agency, 2 Location, Agent, 3 Hashtag, Neighborhood");
  console.log("  Property, Listing, ListingStatusHistory, Tag, ListingTag");
  console.log("  2 Contact, Tenant, Lease, RentSchedule, FinancialRecord");
  console.log("  Booking, Reservation, MaintenanceBlock");
  console.log("  Contract, ContractVersion, SignatureRequest, SignatureSigner");
  console.log("  Document, AnalysisJob, DocumentAnalysis");
  console.log("  Task, MaintenanceWorkOrder, Notification, Message");
  console.log("  LedgerEntry, ExchangeRate, ExportJob, ExportFile");
  console.log("  GovernmentIntegration, LeadSource, Lead, MarketingCampaign");
  console.log("  Deal, Payout, Appointment, CalendarEvent");
  console.log("  Report, ReportExecution, Budget, Quote");
  console.log("  Project, ProjectAlert, ProjectAnalytics, ProjectReport");
  console.log("  Facility, FacilityBlock, SharedAmenity, Amenity, PropertyAmenity");
  console.log("  PropertyPhoto, Photo, FloorPlan, VirtualTour, KeyManagement");
  console.log("  PropertyInventory, PropertyCompliance, PropertyDocument");
  console.log("  PropertyDisclosure, PropertyViewing, PropertyOffer");
  console.log("  AttorneyManagement, Mortgage, MortgageOffer, MortgagePreApproval");
  console.log("  LeaseRenewal, DepositProtection, RightToRentCheck");
  console.log("  SecurityDepositProtection, RentArrears, ImmigrationStatusCheck");
  console.log("  HomeInformationPack, SolicitorManagement");
  console.log("  AgentTeam, AgentTeamMember, AgentPerformance, ClientRelationship");
  console.log("  TenantApplication, GuestProfile, GuestReview, Review");
  console.log("  TaxRecord, TaxDepreciation, Tax1099Form, Attachment");
  console.log("  MLSConnection, MLSSyncJob, MLSExternalListing");
  console.log("  MlsDataMapping, MlsListingEnhancement, ListingChannel");
  console.log("  MapLayer, Route, ApiIntegration");
  console.log("  VacationRental, VacationRentalPlatform, RentalSyncJob, ExternalRentalListing");
  console.log("  InvestorPortfolio, InvestorProperty");
  console.log("  PropertyValuation, ValuationRequest, ValuationReport, LeadConversion");
  console.log("  MarketInsight, UserValuationPreference");
  console.log("  AIModel(+deploy+predict), 15 AI sub-models");
  console.log("  QueueMessage, QueueConfiguration, IntegrationLog");
  console.log("  AutomationRule, AutomationExecution");
  console.log("  MobileDevice, OfflineSyncQueue");
  console.log("  DashboardWidget, DashboardConfiguration, PredictiveModel");
  console.log("  LoyaltyAccount, Referral, Achievement, Earning");
  console.log("  Subscription, GiftCard, Plan, OrgSubscription");
  console.log("  Commission, ReferenceSource, CommissionRule");
  console.log("  Webhook, WebhookDelivery, AuditLog");
  console.log("  CommunicationTemplate, DocumentTemplate");
  console.log("  Event, EventAttendee");
  console.log("  SystemMetrics, HealthCheck, PerformanceAlert");
  console.log("  EscrowAccount, EscrowRelease, EscrowDispute, EscrowStatusHistory");
  console.log("  AIChatMessage, AIChatHandoff");
  console.log("  PaymentNegotiation, NegotiationOffer, PaymentInstallment");
  console.log("  VideoVendor, VideoVendorPartnership, AgentVideo");
  console.log("  AgentEarning, VendorEarning, PartnershipEarning");
  console.log("  VideoQualityReview, VendorQualityReview, VideoEarning");
  console.log("  BrandAmbassador, AmbassadorContract, AmbassadorCampaign, VideoContent");
  console.log("  SocialImpactCounter, SocialImpactRecord");
  console.log("  PropertyOwnershipVerification, OwnershipVerificationDocument, PropertyOwnershipTransfer");
  console.log("  BookingSecurityScreening");
  console.log("  LegalCompliance, GlobalTaxRegulation, PlatformRevenueRecord");
  console.log("  AiServiceTask, AiVideoGeneration, AiBrochureGeneration, VideoCaption");
  console.log("  SmartLock, AccessCode, AccessLog, StayOccupant, PoliceReport, IdentityDocument");
  console.log("  MarketRateComparison, FeatureAddOn, AiExtractedData");
  console.log("  VendorProfile, AgentAssignment, RecommendationResult, Mention");
  console.log("  Channel, Ticket, CommunicationLog, Favorite, Availability");
  console.log("  Discount, Currency, Expense, ExtraCharge, Increase, Offer");
  console.log("  Language, Guest, Analytics, ComplianceRecord");
  console.log("  MLConfiguration, MLModel, MapData, AutomationTask, ScrapingJob");
  console.log("  Verification, Job, IncludedService, Payment");
  console.log("  10 Posts");
  console.log("  PricingRule, PropertyPromotion");
  console.log("═".repeat(60));
}

main()
  .catch((e) => {
    console.error("❌ Seed hatası:", e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });