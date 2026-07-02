// Script to generate the remaining stores to reach 156 total
import { writeFileSync } from "fs";
import { join } from "path";

// Final batch of remaining stores
const finalStores = [
  // Property Management (remaining)
  { name: "property-amenities-store", entity: "PropertyAmenity" },
  { name: "listing-status-history-store", entity: "ListingStatusHistory" },
  { name: "listing-tags-store", entity: "ListingTag" },
  { name: "listing-channels-store", entity: "ListingChannel" },
  { name: "mls-external-listings-store", entity: "MLSExternalListing" },
  { name: "mls-sync-jobs-store", entity: "MLSSyncJob" },
  { name: "mls-data-mappings-store", entity: "MlsDataMapping" },
  { name: "mls-listing-enhancements-store", entity: "MlsListingEnhancement" },

  // Bookings & Reservations (remaining)
  { name: "booking-statuses-store", entity: "BookingStatus" },
  { name: "booking-types-store", entity: "BookingType" },
  { name: "guest-profiles-store", entity: "GuestProfile" },
  { name: "guest-reviews-store", entity: "GuestReview" },
  { name: "vacation-rentals-store", entity: "VacationRental" },
  { name: "vacation-rental-platforms-store", entity: "VacationRentalPlatform" },
  { name: "maintenance-block-types-store", entity: "MaintenanceBlockType" },
  { name: "maintenance-work-orders-store", entity: "MaintenanceWorkOrder" },

  // Leases & Tenants (remaining)
  { name: "lease-statuses-store", entity: "LeaseStatus" },
  { name: "lease-renewals-store", entity: "LeaseRenewal" },
  { name: "rent-schedules-store", entity: "RentSchedule" },
  { name: "right-to-rent-checks-store", entity: "RightToRentCheck" },
  { name: "immigration-status-checks-store", entity: "ImmigrationStatusCheck" },
  { name: "deposit-protections-store", entity: "DepositProtection" },
  { name: "home-information-packs-store", entity: "HomeInformationPack" },

  // Financial Management (remaining)
  { name: "transaction-types-store", entity: "TransactionType" },
  { name: "payment-statuses-store", entity: "PaymentStatus" },
  { name: "bill-categories-store", entity: "BillCategory" },
  { name: "earning-strategies-store", entity: "EarningStrategy" },
  { name: "tax-1099-forms-store", entity: "Tax1099Form" },
  { name: "tax-category-types-store", entity: "TaxCategoryType" },
  { name: "tax-periods-store", entity: "TaxPeriod" },

  // Contracts & Legal (remaining)
  { name: "contract-types-store", entity: "ContractType" },
  { name: "contract-statuses-store", entity: "ContractStatus" },
  { name: "signature-statuses-store", entity: "SignatureStatus" },

  // Contacts & Relationships (remaining)
  { name: "contact-types-store", entity: "ContactType" },
  { name: "client-relationships-store", entity: "ClientRelationship" },
  { name: "referrals-store", entity: "Referral" },
  { name: "agent-teams-store", entity: "AgentTeam" },
  { name: "agent-team-members-store", entity: "AgentTeamMember" },
  { name: "message-participant-types-store", entity: "MessageParticipantType" },
  { name: "notification-channels-store", entity: "NotificationChannel" },
  { name: "notification-statuses-store", entity: "NotificationStatus" },

  // Users & Organizations (remaining)
  { name: "org-types-store", entity: "OrgType" },
  { name: "regions-store", entity: "Region" },
  { name: "permission-keys-store", entity: "PermissionKey" },
  { name: "org-subscriptions-store", entity: "OrgSubscription" },

  // Projects & Tasks (remaining)
  { name: "project-types-store", entity: "ProjectType" },
  { name: "task-types-store", entity: "TaskType" },
  { name: "task-statuses-store", entity: "TaskStatus" },
  { name: "priorities-store", entity: "Priority" },
  { name: "task-assignments-store", entity: "TaskAssignment" },

  // Reports & Analytics (remaining)
  { name: "export-files-store", entity: "ExportFile" },
  { name: "export-types-store", entity: "ExportType" },
  { name: "export-statuses-store", entity: "ExportStatus" },
  { name: "dashboard-widgets-store", entity: "DashboardWidget" },
  { name: "activity-logs-store", entity: "ActivityLog" },

  // Integrations & Automation (remaining)
  { name: "api-integrations-store", entity: "APIIntegration" },
  { name: "government-integrations-store", entity: "GovernmentIntegration" },

  // AI & Analytics (remaining)
  { name: "ai-model-deployments-store", entity: "AIModelDeployment" },
  { name: "ai-predictions-store", entity: "AIPrediction" },
  { name: "ai-valuation-models-store", entity: "AIValuationModel" },
  { name: "ai-property-valuations-store", entity: "AIPropertyValuation" },
  { name: "ai-lead-scoring-store", entity: "AILeadScoring" },
  { name: "ai-market-analysis-store", entity: "AIMarketAnalysis" },
  { name: "ai-image-analysis-store", entity: "AIImageAnalysis" },
  { name: "ai-price-optimization-store", entity: "AIPriceOptimization" },
  { name: "ai-sentiment-analysis-store", entity: "AISentimentAnalysis" },
  { name: "ai-fraud-detection-store", entity: "AIFraudDetection" },
  {
    name: "ai-predictive-maintenance-store",
    entity: "AIPredictiveMaintenance",
  },
  { name: "ai-tenant-screening-store", entity: "AITenantScreening" },
  { name: "ai-investment-analysis-store", entity: "AIInvestmentAnalysis" },

  // Investment & Portfolio (remaining)
  { name: "risk-tolerances-store", entity: "RiskTolerance" },
  { name: "investment-strategies-store", entity: "InvestmentStrategy" },

  // Compliance & Security (remaining)
  { name: "compliance-types-store", entity: "ComplianceType" },
  { name: "compliance-statuses-store", entity: "ComplianceStatus" },
  { name: "security-settings-store", entity: "SecuritySettings" },
  { name: "two-factor-auth-store", entity: "TwoFactorAuth" },

  // Additional entities from router
  { name: "vendor-profiles-store", entity: "VendorProfile" },
  { name: "agency-profiles-store", entity: "AgencyProfile" },
  { name: "agent-performance-store", entity: "AgentPerformance" },
  { name: "solicitor-management-store", entity: "SolicitorManagement" },
  { name: "rental-sync-jobs-store", entity: "RentalSyncJob" },
  { name: "external-rental-listings-store", entity: "ExternalRentalListing" },
  { name: "tax-depreciation-store", entity: "TaxDepreciation" },
  { name: "communication-templates-store", entity: "CommunicationTemplate" },
  { name: "key-management-store", entity: "KeyManagement" },
  {
    name: "security-deposit-protection-store",
    entity: "SecurityDepositProtection",
  },
  { name: "property-disclosures-store", entity: "PropertyDisclosure" },
  { name: "rent-arrears-store", entity: "RentArrears" },
  { name: "attorney-management-store", entity: "AttorneyManagement" },
  { name: "mortgage-offers-store", entity: "MortgageOffer" },
  { name: "mortgage-pre-approvals-store", entity: "MortgagePreApproval" },
  { name: "locations-store", entity: "Location" },
  { name: "map-layers-store", entity: "MapLayer" },
  { name: "routes-store", entity: "Route" },
];

// Generate store content
const generateStoreContent = (name: string, entity: string) => {
  const interfaceName = `${entity}State`;
  const itemName = entity.toLowerCase();

  return `import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ${entity} {
  id: string;
  name: string;
  description?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ${interfaceName} {
  ${itemName}s: ${entity}[];
  loading: boolean;
  error: string | null;
  selected${entity}: ${entity} | null;
  filters: {
    search: string;
    organizationId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  set${itemName}s: (${itemName}s: ${entity}[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelected${entity}: (${entity}: ${entity} | null) => void;
  setFilters: (filters: Partial<${interfaceName}["filters"]>) => void;
  setPagination: (pagination: Partial<${interfaceName}["pagination"]>) => void;
  add${entity}: (${entity}: ${entity}) => void;
  update${entity}: (id: string, ${entity}: Partial<${entity}>) => void;
  remove${entity}: (id: string) => void;
  clearFilters: () => void;
}

export const use${entity}sStore = create<${interfaceName}>()(
  devtools(
    (set) => ({
      ${itemName}s: [],
      loading: false,
      error: null,
      selected${entity}: null,
      filters: {
        search: "",
        organizationId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      set${itemName}s: (${itemName}s) => set({ ${itemName}s }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelected${entity}: (selected${entity}) => set({ selected${entity} }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({ pagination: { ...state.pagination, ...pagination } })),
      add${entity}: (${entity}) =>
        set((state) => ({ ${itemName}s: [...state.${itemName}s, ${entity}] })),
      update${entity}: (id, updated${entity}) =>
        set((state) => ({
          ${itemName}s: state.${itemName}s.map((item) =>
            item.id === id ? { ...item, ...updated${entity} } : item
          ),
        })),
      remove${entity}: (id) =>
        set((state) => ({
          ${itemName}s: state.${itemName}s.filter((item) => item.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            organizationId: "all",
          },
        }),
    }),
    { name: "${name}" }
  )
);`;
};

// Generate all final stores
const generateAllFinalStores = () => {
  const storeDir = join(__dirname, "..", "store");

  finalStores.forEach(({ name, entity }) => {
    const content = generateStoreContent(name, entity);
    const filePath = join(storeDir, `${name}.ts`);

    try {
      writeFileSync(filePath, content, "utf8");
      console.log(`Generated: ${name}`);
    } catch (error) {
      console.error(`Error generating ${name}:`, error);
    }
  });

  console.log(`Generated ${finalStores.length} final stores!`);
};

// Run if executed directly
if (require.main === module) {
  generateAllFinalStores();
}

export default generateAllFinalStores;
