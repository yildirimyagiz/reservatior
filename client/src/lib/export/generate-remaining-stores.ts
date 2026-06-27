// Script to generate all remaining stores to reach 156
import { writeFileSync } from "fs";
import { join } from "path";

// Store templates for remaining models
const remainingStores = [
  // Property Management (additional)
  { name: "facilities-store", entity: "Facility" },
  { name: "property-amenities-store", entity: "PropertyAmenity" },
  { name: "listing-status-history-store", entity: "ListingStatusHistory" },
  { name: "listing-tags-store", entity: "ListingTag" },
  { name: "listing-channels-store", entity: "ListingChannel" },
  { name: "mls-external-listings-store", entity: "MLSExternalListing" },
  { name: "mls-sync-jobs-store", entity: "MLSSyncJob" },
  { name: "mls-data-mappings-store", entity: "MlsDataMapping" },
  { name: "mls-listing-enhancements-store", entity: "MlsListingEnhancement" },

  // Bookings & Reservations
  { name: "booking-statuses-store", entity: "BookingStatus" },
  { name: "booking-types-store", entity: "BookingType" },
  { name: "reservations-store", entity: "Reservation" },
  { name: "guest-profiles-store", entity: "GuestProfile" },
  { name: "guest-reviews-store", entity: "GuestReview" },
  { name: "vacation-rentals-store", entity: "VacationRental" },
  { name: "vacation-rental-platforms-store", entity: "VacationRentalPlatform" },
  { name: "maintenance-block-types-store", entity: "MaintenanceBlockType" },
  { name: "maintenance-work-orders-store", entity: "MaintenanceWorkOrder" },

  // Leases & Tenants
  { name: "lease-statuses-store", entity: "LeaseStatus" },
  { name: "lease-renewals-store", entity: "LeaseRenewal" },
  { name: "rent-schedules-store", entity: "RentSchedule" },
  { name: "right-to-rent-checks-store", entity: "RightToRentCheck" },
  { name: "immigration-status-checks-store", entity: "ImmigrationStatusCheck" },
  { name: "deposit-protections-store", entity: "DepositProtection" },
  { name: "home-information-packs-store", entity: "HomeInformationPack" },

  // Financial Management
  { name: "ledger-entries-store", entity: "LedgerEntry" },
  { name: "transaction-types-store", entity: "TransactionType" },
  { name: "payment-statuses-store", entity: "PaymentStatus" },
  { name: "bill-categories-store", entity: "BillCategory" },
  { name: "payouts-store", entity: "Payout" },
  { name: "earnings-store", entity: "Earning" },
  { name: "earning-strategies-store", entity: "EarningStrategy" },
  { name: "tax-1099-forms-store", entity: "Tax1099Form" },
  { name: "tax-category-types-store", entity: "TaxCategoryType" },
  { name: "tax-periods-store", entity: "TaxPeriod" },
  { name: "exchange-rates-store", entity: "ExchangeRate" },
  { name: "currencies-store", entity: "Currency" },

  // Contracts & Legal
  { name: "contract-versions-store", entity: "ContractVersion" },
  { name: "contract-types-store", entity: "ContractType" },
  { name: "contract-statuses-store", entity: "ContractStatus" },
  { name: "signature-requests-store", entity: "SignatureRequest" },
  { name: "signature-signers-store", entity: "SignatureSigner" },
  { name: "signature-statuses-store", entity: "SignatureStatus" },
  { name: "document-templates-store", entity: "DocumentTemplate" },
  { name: "attachments-store", entity: "Attachment" },

  // Contacts & Relationships
  { name: "contact-types-store", entity: "ContactType" },
  { name: "client-relationships-store", entity: "ClientRelationship" },
  { name: "referrals-store", entity: "Referral" },
  { name: "agent-teams-store", entity: "AgentTeam" },
  { name: "agent-team-members-store", entity: "AgentTeamMember" },
  { name: "message-participant-types-store", entity: "MessageParticipantType" },
  { name: "notification-channels-store", entity: "NotificationChannel" },
  { name: "notification-statuses-store", entity: "NotificationStatus" },
  { name: "calendar-events-store", entity: "CalendarEvent" },

  // Users & Organizations
  { name: "api-keys-store", entity: "ApiKey" },
  { name: "user-financial-profiles-store", entity: "UserFinancialProfile" },
  { name: "offline-sync-queues-store", entity: "OfflineSyncQueue" },
  { name: "org-types-store", entity: "OrgType" },
  { name: "regions-store", entity: "Region" },
  { name: "permission-keys-store", entity: "PermissionKey" },
  { name: "org-subscriptions-store", entity: "OrgSubscription" },
  { name: "plans-store", entity: "Plan" },

  // Projects & Tasks
  { name: "project-types-store", entity: "ProjectType" },
  { name: "task-types-store", entity: "TaskType" },
  { name: "task-statuses-store", entity: "TaskStatus" },
  { name: "priorities-store", entity: "Priority" },
  { name: "task-assignments-store", entity: "TaskAssignment" },

  // Reports & Analytics
  { name: "report-executions-store", entity: "ReportExecution" },
  { name: "export-jobs-store", entity: "ExportJob" },
  { name: "export-files-store", entity: "ExportFile" },
  { name: "export-types-store", entity: "ExportType" },
  { name: "export-statuses-store", entity: "ExportStatus" },
  { name: "dashboard-configurations-store", entity: "DashboardConfiguration" },
  { name: "dashboard-widgets-store", entity: "DashboardWidget" },
  { name: "system-metrics-store", entity: "SystemMetrics" },
  { name: "health-checks-store", entity: "HealthCheck" },
  { name: "performance-alerts-store", entity: "PerformanceAlert" },
  { name: "activity-logs-store", entity: "ActivityLog" },

  // Integrations & Automation
  { name: "api-integrations-store", entity: "APIIntegration" },
  { name: "government-integrations-store", entity: "GovernmentIntegration" },
  { name: "webhook-deliveries-store", entity: "WebhookDelivery" },
  { name: "integration-logs-store", entity: "IntegrationLog" },
  { name: "queue-messages-store", entity: "QueueMessage" },

  // AI & Analytics (additional)
  { name: "recommendation-results-store", entity: "RecommendationResult" },

  // Investment & Portfolio (additional)
  { name: "risk-tolerances-store", entity: "RiskTolerance" },
  { name: "investment-strategies-store", entity: "InvestmentStrategy" },

  // Compliance & Security (additional)
  { name: "compliance-types-store", entity: "ComplianceType" },
  { name: "compliance-statuses-store", entity: "ComplianceStatus" },
  { name: "security-settings-store", entity: "SecuritySettings" },
  { name: "two-factor-auth-store", entity: "TwoFactorAuth" },
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
  bearing
  )
);`;
};

// Generate all remaining stores
const generateAllRemainingStores = () => {
  const storeDir = join(__dirname, "..");

  remainingStores.forEach(({ name, entity }) => {
    const content = generateStoreContent(name, entity);
    const filePath = join(storeDir, `${name}.ts`);

    try {
      writeFileSync(filePath, content, "utf8");
      console.log(`Generated: ${name}`);
    } catch (error) {
      console.error(`Error generating ${name}:`, error);
    }
  });

  console.log(`Generated ${remainingStores.length} remaining stores!`);
};

// Run if executed directly
if (require.main === module) {
  generateAllRemainingStores();
}

export default generateAllRemainingStores;
