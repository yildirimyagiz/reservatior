import React, { lazy, Suspense } from "react";
import { createBrowserRouter, RouterProvider, Outlet, Navigate } from "react-router-dom";
import { AppLayout } from "@/pages/client/layout/AppLayout";
import PublicLayout from "@/pages/client/layout/PublicLayout";
import { useAuth } from "@/lib/auth/hooks";

// ─── Shared Components ────────────────────────────────────────────────────────
const LoadingFallback = () => <div className="p-8 text-center text-slate-500 animate-pulse">Loading module...</div>;

// ─── Auth ─────────────────────────────────────────────────────────────────────
const Login = lazy(() => import("@/pages/auth/Login"));
const Signup = lazy(() => import("@/pages/auth/Signup"));
const VerifyEmail = lazy(() => import("@/pages/auth/VerifyEmail"));
const ForgotPassword = lazy(() => import("@/pages/auth/ForgotPassword"));
const AuthCallback = lazy(() => import("@/pages/auth/AuthCallback"));
const Unauthorized = lazy(() => import("@/pages/client/Unauthorized"));
const Terms = lazy(() => import("@/pages/client/Terms"));
const Privacy = lazy(() => import("@/pages/client/Privacy"));
const Pricing = lazy(() => import("@/pages/client/Pricing"));
const Features = lazy(() => import("@/pages/public/Features"));
const NotFound = lazy(() => import("@/pages/client/NotFound"));
const AddPropertyWizard = lazy(() => import("@/pages/host/AddPropertyWizard"));

import { AdminLayout } from "@/pages/admin/layout/AdminLayout";

// ─── All pages lazy-loaded ───────────────────────────────────────────────────
const Home = lazy(() => import("@/pages/client/Home"));
const Explore = lazy(() => import("@/pages/client/Explore"));
const Videos = lazy(() => import("@/pages/client/Videos"));
const LeaseCare = lazy(() => import("@/pages/client/LeaseCare"));
const Today = lazy(() => import("@/pages/client/calendar/Today"));
const Dashboard = lazy(() => import("@/pages/client/Dashboard"));
const TrustCenter = lazy(() => import("@/pages/client/TrustCenter"));
const HospitalityStandards = lazy(() => import("@/pages/client/HospitalityStandards"));
const ShortTermRentalSafety = lazy(() => import("@/pages/client/ShortTermRentalSafety"));
const TenantVerification = lazy(() => import("@/pages/client/TenantVerification"));
const Documents = lazy(() => import("@/pages/client/legal/Documents"));
const Legal = lazy(() => import("@/pages/client/legal/Legal"));
const Events = lazy(() => import("@/pages/client/Events"));
const AnalyticsDashboard = lazy(() => import("@/pages/client/reports/AnalyticsDashboard"));
const Contact = lazy(() => import("@/pages/client/Contact"));
const Profile = lazy(() => import("@/pages/client/profile/Profile"));
const Deals = lazy(() => import("@/pages/client/deals/DealsManagement"));
const Tags = lazy(() => import("@/pages/client/crm/Tags"));
const Subscriptions = lazy(() => import("@/pages/client/membership/Subscriptions"));
const ApiKeys = lazy(() => import("@/pages/client/integrations/ApiKeys"));
const MobileDevices = lazy(() => import("@/pages/client/mobile/MobileDevices"));
const AIStudio = lazy(() => import("@/pages/client/ai/AIStudio"));
const Contacts = lazy(() => import("@/pages/client/contacts/Contacts"));
const Leads = lazy(() => import("@/pages/client/crm/Leads"));
const Tasks = lazy(() => import("@/pages/client/tasks/Tasks"));
const Properties = lazy(() => import("@/pages/client/property/Properties"));
const PropertyDetail = lazy(() => import("@/pages/client/property/PropertyDetail"));
const PropertySearch = lazy(() => import("@/pages/client/property/PropertySearch"));
const PropertyManagement = lazy(() => import("@/pages/client/property/PropertyManagement"));
const PropertyEdit = lazy(() => import("@/pages/client/property/PropertyEdit"));
const PropertySearchMap = lazy(() => import("@/pages/client/property/PropertySearchMap"));
const WisePayment = lazy(() => import("@/pages/admin/payments/WisePayment"));
const GoogleCloudManager = lazy(() => import("@/pages/admin/cloud/GoogleCloudManager"));
const CompanyManagement = lazy(() => import("@/pages/admin/company/CompanyManagement"));
const CustomerInvoices = lazy(() => import("@/pages/admin/invoices/CustomerInvoices"));
const MembershipManagement = lazy(() => import("@/pages/admin/membership/MembershipManagement"));
const SettingsComponent = lazy(() => import("@/pages/admin/settings/Settings"));
const Billing = lazy(() => import("@/pages/admin/billing/Billing"));
const Analytics = lazy(() => import("@/pages/admin/analytics/Analytics"));
const EscrowDashboard = lazy(() => import("@/pages/admin/escrow/EscrowDashboard"));
const FinancialReports = lazy(() => import("@/pages/admin/reports/FinancialReports"));
const AIDashboard = lazy(() => import("@/pages/admin/ai/AIDashboard"));
const Agents = lazy(() => import("@/pages/client/agents/Agents"));
const Agencies = lazy(() => import("@/pages/client/agents/Agencies"));
const AgentTeams = lazy(() => import("@/pages/client/agents/AgentTeams"));
const AgentPerformance = lazy(() => import("@/pages/client/agents/AgentPerformance"));
const Commissions = lazy(() => import("@/pages/client/agents/Commissions"));
const Tenants = lazy(() => import("@/pages/client/tenants/Tenants"));
const Leases = lazy(() => import("@/pages/client/leases/Leases"));
const TenantApplications = lazy(() => import("@/pages/client/tenants/TenantApplications"));
const RentSchedule = lazy(() => import("@/pages/client/tenants/RentSchedule"));
const RentArrears = lazy(() => import("@/pages/client/tenants/RentArrears"));
const Increases = lazy(() => import("@/pages/client/tenants/Increases"));
const BookingCenter = lazy(() => import("@/pages/client/bookings/BookingCenter"));
const Payments = lazy(() => import("@/pages/client/financial/Payments"));
const Escrow = lazy(() => import("@/pages/client/financial/Escrow"));
const Coupons = lazy(() => import("@/pages/client/financial/Coupons"));
const Contracts = lazy(() => import("@/pages/client/contracts/Contracts"));
const Integrations = lazy(() => import("@/pages/client/integrations/Integrations"));
const ExportJobs = lazy(() => import("@/pages/admin/integrations/ExportJobs"));
const MLSIntegration = lazy(() => import("@/pages/admin/integrations/MLSIntegration"));
const Listings = lazy(() => import("@/pages/client/property/Listings"));
const Reservations = lazy(() => import("@/pages/client/property/Reservations"));
const Facilities = lazy(() => import("@/pages/client/property/Facilities"));
const PropertyDisclosures = lazy(() => import("@/pages/client/property/PropertyDisclosures"));
const Mortgages = lazy(() => import("@/pages/client/mortgages/Mortgages"));
const CommunicationLogs = lazy(() => import("@/pages/client/communication/CommunicationLogs"));
const CommunicationTemplates = lazy(() => import("@/pages/client/communication/CommunicationTemplates"));
const MaintenanceBlocks = lazy(() => import("@/pages/client/listings/MaintenanceBlocks"));
const PropertyOffers = lazy(() => import("@/pages/client/listings/PropertyOffers"));
const ListingManagement = lazy(() => import("@/pages/client/listings/ListingManagement"));
const Tax1099Forms = lazy(() => import("@/pages/client/financial/Tax1099Forms"));
const InvestorPortfolio = lazy(() => import("@/pages/client/investors/Portfolio"));
const LoyaltyRewards = lazy(() => import("@/pages/client/membership/LoyaltyRewards"));
const NeuralReview = lazy(() => import("@/pages/public/NeuralReview"));
const MembershipManagementClient = lazy(() => import("@/pages/client/membership/MembershipManagement"));
const TaxRecords = lazy(() => import("@/pages/client/financial/TaxRecords"));
const Budgets = lazy(() => import("@/pages/client/financial/Budgets"));
const CommissionRules = lazy(() => import("@/pages/client/financial/CommissionRules"));
const Discounts = lazy(() => import("@/pages/client/property/Discounts"));
const Expenses = lazy(() => import("@/pages/client/financial/Expenses"));
const Payouts = lazy(() => import("@/pages/client/financial/Payouts"));
const TaxOverview = lazy(() => import("@/pages/client/financial/TaxOverview"));
const DepositProtection = lazy(() => import("@/pages/client/legal/DepositProtection"));
const RightToRent = lazy(() => import("@/pages/client/legal/RightToRent"));
const SolicitorManagement = lazy(() => import("@/pages/client/legal/SolicitorManagement"));
const Signatures = lazy(() => import("@/pages/client/legal/Signatures"));
const DocumentTemplates = lazy(() => import("@/pages/client/legal/DocumentTemplates"));
const Compliance = lazy(() => import("@/pages/client/legal/Compliance"));
const Referrals = lazy(() => import("@/pages/client/contacts/Referrals"));
const Guests = lazy(() => import("@/pages/client/contacts/Guests"));
const Offers = lazy(() => import("@/pages/client/contacts/Offers"));
const ClientRelationships = lazy(() => import("@/pages/client/contacts/ClientRelationships"));
const Appointments = lazy(() => import("@/pages/client/tasks/Appointments"));
const TaskEvents = lazy(() => import("@/pages/client/tasks/Events"));
const TasksKanban = lazy(() => import("@/pages/client/tasks/TasksKanban"));
const Maintenance = lazy(() => import("@/pages/client/listings/Maintenance"));
const Projects = lazy(() => import("@/pages/client/projects/Projects"));
const Messages = lazy(() => import("@/pages/client/messages/Messages"));
const AIValuation = lazy(() => import("@/pages/client/ai/AIValuation"));
const AIRecommendations = lazy(() => import("@/pages/client/ai/AIRecommendations"));
const AutomationRules = lazy(() => import("@/pages/admin/ai/AutomationRules"));
const AIAutomationRules = AutomationRules;
const AISentimentAnalysis = lazy(() => import("@/pages/admin/ai/SentimentAnalysis"));
const AISentiment = AISentimentAnalysis;
const MLSConnections = lazy(() => import("@/pages/client/integrations/MLSConnections"));
const VacationRentalPlatforms = lazy(() => import("@/pages/client/integrations/VacationRentalPlatforms"));
const Webhooks = lazy(() => import("@/pages/client/integrations/Webhooks"));
const MapServices = lazy(() => import("@/pages/client/integrations/MapServices"));
const MediaManagement = lazy(() => import("@/pages/client/media/MediaManagement"));
const FacilityManagement = lazy(() => import("@/pages/client/facilities/FacilityManagement"));
const DocumentsEnhanced = lazy(() => import("@/pages/client/legal/DocumentsEnhanced"));
const DocumentWorkflow = lazy(() => import("@/pages/client/legal/DocumentWorkflow"));
const CalendarIntegration = lazy(() => import("@/pages/client/calendar/CalendarIntegration"));
const ExportsClient = lazy(() => import("@/pages/client/exports/Exports"));
const Notifications = lazy(() => import("@/pages/client/notifications/Notifications"));
const TaskManagement = lazy(() => import("@/pages/client/tasks/TaskManagement"));
const DealsManagement = lazy(() => import("@/pages/client/deals/DealsManagement"));
const FinancialPages = lazy(() => import("@/pages/client/financial/FinancialPages").then(m => ({ default: m.FinancialRecords })));
const Invoices = lazy(() => import("@/pages/client/financial/Invoices"));
const Transactions = lazy(() => import("@/pages/client/financial/Transactions"));
const ReportsClient = lazy(() => import("@/pages/client/reports/ReportsEnhanced"));
const ActivityTracking = lazy(() => import("@/pages/client/property/ReservationTracking"));
const Deposits = lazy(() => import("@/pages/client/payments/Deposits"));
const Signing = lazy(() => import("@/pages/client/contracts/Signing"));
const PropertyViewings = lazy(() => import("@/pages/admin/property/PropertyViewings"));
const PropertyPromotions = lazy(() => import("@/pages/admin/property/PropertyPromotions"));
const VacationRentalsAdmin = lazy(() => import("@/pages/admin/property/VacationRentals"));
const PropertyAnalyticsAdmin = lazy(() => import("@/pages/admin/property/PropertyAnalytics"));
const AdminPermissions = lazy(() => import("@/pages/admin/organization/Permissions"));
const AdminDepartments = lazy(() => import("@/pages/admin/organization/Departments"));
const AdminTeams = lazy(() => import("@/pages/admin/organization/Teams"));
const AdminSubscriptionMgmt = lazy(() => import("@/pages/admin/organization/SubscriptionManagement"));
const SystemManagement = lazy(() => import("@/pages/admin/system/SystemManagement"));
const AdminCommunicationTemplates = lazy(() => import("@/pages/admin/communication/CommunicationTemplates"));
const MLConfiguration = lazy(() => import("@/pages/admin/ai/MLConfiguration"));
const MLTasks = lazy(() => import("@/pages/admin/ai/MLTasks"));
const EventLog = lazy(() => import("@/pages/admin/system/EventLog"));
const NotificationTemplates = lazy(() => import("@/pages/admin/system/NotificationTemplates"));
const AutomationExecutionHistory = lazy(() => import("@/pages/admin/system/AutomationExecutionHistory"));

// ─── Admin Pages (all lazy) ────────────────────────────────────────────────
const AdminDashboard = lazy(() => import("@/pages/admin/core/Dashboard"));
const AdminProperties = lazy(() => import("@/pages/admin/property/AdminProperties"));
const PropertyInventory = lazy(() => import("@/pages/admin/inventory/PropertyInventory"));
const OwnershipVerification = lazy(() => import("@/pages/admin/property/OwnershipVerification"));
const Organizations = lazy(() => import("@/pages/admin/users/Organizations"));
const Plans = lazy(() => import("@/pages/admin/users/Plans"));
const AdminReports = lazy(() => import("@/pages/admin/reports/Reports"));
const Exports = lazy(() => import("@/pages/admin/integrations/Exports"));
const ProjectDashboard = lazy(() => import("@/pages/admin/projects/ProjectDashboard"));
const BookingsManagement = lazy(() => import("@/pages/admin/BookingsManagement"));
const AdminPayouts = lazy(() => import("@/pages/admin/financial/Payouts"));
const AdminPayments = lazy(() => import("@/pages/admin/financial/Payments"));
const AdminExpenses = lazy(() => import("@/pages/admin/financial/Expenses"));
const EscrowManagement = lazy(() => import("@/pages/admin/financial/EscrowManagement"));
const DocumentManagement = lazy(() => import("@/pages/admin/documents/DocumentManagement"));
const LocationServices = lazy(() => import("@/pages/admin/location/LocationServices"));
const SystemSettings = lazy(() => import("@/pages/admin/system/SystemSettings"));
const AdminAnalytics = lazy(() => import("@/pages/admin/analytics/AnalyticsDashboard"));
const CustomReports = lazy(() => import("@/pages/admin/reports/CustomReports"));
const LeadScoring = lazy(() => import("@/pages/admin/ai/LeadScoring"));
const AIModels = lazy(() => import("@/pages/admin/ai/AIModels"));
const ScrapingDashboard = lazy(() => import("@/pages/admin/scraping/ScrapingDashboard"));
const MarketingAutomation = lazy(() => import("@/pages/admin/marketing/MarketingAutomation"));
const ComplianceDashboard = lazy(() => import("@/pages/admin/compliance/ComplianceDashboard"));
const SecurityEvents = lazy(() => import("@/pages/admin/security/SecurityEvents"));
const SystemMetrics = lazy(() => import("@/pages/admin/system/SystemMetrics"));
const AIFraud = lazy(() => import("@/pages/admin/ai/FraudDetection"));
const AIPredictive = lazy(() => import("@/pages/admin/ai/PredictiveMaintenance"));
const AIPredictiveAnalytics = lazy(() => import("@/pages/admin/ai/PredictiveAnalytics"));
const AIChatManagement = lazy(() => import("@/pages/admin/ai/AIChatManagement"));
const AIConfiguration = lazy(() => import("@/pages/admin/ai/AIConfiguration"));
const AICustomModels = lazy(() => import("@/pages/admin/ai/Models"));
const ApiTokens = lazy(() => import("@/pages/admin/security/ApiTokens"));
const AdvancedSecurity = lazy(() => import("@/pages/admin/security/AdvancedSecurity"));
const SecurityOverview = lazy(() => import("@/pages/admin/security/SecurityOverview"));
const SecurityScreening = lazy(() => import("@/pages/admin/security/SecurityScreening"));
const Sessions = lazy(() => import("@/pages/admin/security/Sessions"));
const Attachments = lazy(() => import("@/pages/admin/system/Attachments"));
const MobileDeviceManagementAdmin = lazy(() => import("@/pages/admin/mobile/MobileDeviceManagement"));
const AIServiceAnalytics = lazy(() => import("@/pages/admin/analytics/AIServiceAnalytics"));
const CommissionDistribution = lazy(() => import("@/pages/admin/sales/CommissionDistribution"));
const GlobalTaxSettings = lazy(() => import("@/pages/admin/financial/GlobalTaxSettings"));
const AgenciesManagement = lazy(() => import("@/pages/admin/agencies/AgenciesManagement"));
const AgentsManagement = lazy(() => import("@/pages/admin/agents/AgentsManagement"));
const VendorsManagement = lazy(() => import("@/pages/admin/vendors/VendorsManagement"));
const ContactsManagement = lazy(() => import("@/pages/admin/contacts/ContactsManagement"));
const TasksManagement = lazy(() => import("@/pages/admin/tasks/TasksManagement"));
const MaintenanceManagement = lazy(() => import("@/pages/admin/maintenance/MaintenanceManagement"));

const FacilitiesManagement = lazy(() => import("@/pages/admin/facilities/FacilitiesManagement"));
const DigitalTwinDashboard = lazy(() => import("@/pages/admin/projects/DigitalTwin"));
const UserManagement = lazy(() => import("@/pages/admin/users/UserManagement"));
const RolesPage = lazy(() => import("@/pages/admin/users/Roles"));
const AuditLogs = lazy(() => import("@/pages/admin/security/AuditLogs"));
const AgencyDashboard = lazy(() => import("@/pages/client/agents/AgencyDashboard"));
const AgentProfile = lazy(() => import("@/pages/client/agents/AgentProfile"));
const ChannelManagement = lazy(() => import("@/pages/client/channels/ChannelManagement"));
const VideoVendorMarketplace = lazy(() => import("@/pages/client/VideoVendors"));
const VideoContentManagement = lazy(() => import("@/pages/client/video/VideoContentManagement"));
const HelpDesk = lazy(() => import("@/pages/client/support/PayoutHelpdesk"));
const GuestFollowUp = lazy(() => import("@/pages/client/guests/GuestFollowUp"));
const B2BHotelIntegrations = lazy(() => import("@/pages/admin/integrations/B2BHotelIntegrations"));
const FileManagement = lazy(() => import("@/pages/client/FileManagement"));
const SecuritySettings = lazy(() => import("@/pages/client/profile/SecuritySettings"));
const Favorites = lazy(() => import("@/pages/client/profile/Favorites"));
const MyListings = lazy(() => import("@/pages/client/profile/MyListings"));
const CompareList = lazy(() => import("@/pages/client/profile/CompareList"));
const Reviews = lazy(() => import("@/pages/client/profile/Reviews"));
const SupportDashboard = lazy(() => import("@/pages/client/support/SupportDashboard"));
const Checkout = lazy(() => import("@/pages/client/bookings/Checkout"));
const PaymentStatus = lazy(() => import("@/pages/client/financial/PaymentStatus"));

const AdminLayoutWrapper = () => {
  const { user } = useAuth();
  return (
    <AdminLayout 
      userRole={user?.role} 
      userName={user?.firstName} 
      userEmail={user?.email}
    >
      <Suspense fallback={<LoadingFallback />}>
        <Outlet />
      </Suspense>
    </AdminLayout>
  );
};

const ProtectedRoute = ({ children, allowedRoles }: { children: React.ReactNode, allowedRoles?: string[] }) => {
  const { user, loading } = useAuth();
  if (loading) return <LoadingFallback />;
  if (!user) return <Navigate to="/auth/login" replace />;
  if (allowedRoles && !allowedRoles.includes(user.role)) return <Navigate to="/unauthorized" replace />;
  return <>{children}</>;
};

export const router = createBrowserRouter([
  {
    element: <PublicLayout />,
    children: [
      { path: "/auth/login",             element: <Login /> },
      { path: "/auth/signup",            element: <Signup /> },
      { path: "/auth/verify-email",      element: <VerifyEmail /> },
      { path: "/auth/forgot-password",   element: <ForgotPassword /> },
      { path: "/auth/reset-password",    element: <ForgotPassword /> },
      { path: "/auth/callback",          element: <AuthCallback /> },
      { path: "/auth/register",          element: <Navigate to="/auth/signup" replace /> },
    ]
  },

  { path: "/unauthorized",           element: <Unauthorized /> },
  { path: "/login",                  element: <Navigate to="/auth/login" replace /> },
  { path: "/signup",                 element: <Navigate to="/auth/signup" replace /> },
  { path: "/register",               element: <Navigate to="/auth/signup" replace /> },
  { path: "/forgot-password",        element: <Navigate to="/auth/forgot-password" replace /> },
  { path: "/en",                     element: <Navigate to="/" replace /> },
  
  { 
    path: "/host/new-listing", 
    element: <ProtectedRoute><React.Suspense fallback={<LoadingFallback />}><AddPropertyWizard /></React.Suspense></ProtectedRoute> 
  },
  
  {
    element: <PublicLayout />,
    children: [
      { path: "/",                       element: <Home /> },
      { path: "/trust",                  element: <TrustCenter /> },
      { path: "/hospitality-standards",  element: <HospitalityStandards /> },
      { path: "/short-term-rental-safety", element: <ShortTermRentalSafety /> },
      { path: "/tenant-verification",    element: <TenantVerification /> },
      { path: "/terms",                  element: <Terms /> },
      { path: "/privacy",                element: <Privacy /> },
      { path: "/contact",                element: <Contact /> },
      { path: "/pricing",                element: <Pricing /> },
      { path: "/explore",                element: <Explore /> },
      { path: "/videos",                 element: <Videos /> },
      { path: "/leasecare",              element: <LeaseCare /> },
      { path: "/properties",             element: <PropertySearch /> },
      { path: "/properties/:id",         element: <PropertyDetail /> },
    ]
  },

  { path: "/activities",             element: <Navigate to="/activity" replace /> },
  { path: "/cookies",                element: <Navigate to="/privacy" replace /> },
  { path: "/showcase",               element: <Navigate to="/properties" replace /> },
  { path: "/stage/:id",              element: <Navigate to="/properties/:id" replace /> },

  {
    element: <ProtectedRoute><AppLayout><Outlet /></AppLayout></ProtectedRoute>,
    children: [
      { path: "/home",                   element: <Navigate to="/" replace /> },
      { path: "/dashboard",              element: <Dashboard /> },
      { path: "/checkout/:id",           element: <Checkout /> },
      { path: "/calendar",               element: <Today /> },
      { path: "/documents",              element: <Documents /> },
      { path: "/legal",                  element: <Legal /> },
      { path: "/events",                 element: <Events /> },
      { path: "/analytics",              element: <AnalyticsDashboard /> },
      { path: "/profile",                element: <Profile /> },
      { path: "/deals",                  element: <Deals /> },
      { path: "/tags",                   element: <Tags /> },
      { path: "/subscriptions",          element: <Subscriptions /> },
      { path: "/api-keys",               element: <ApiKeys /> },
      { path: "/mobile-devices",         element: <MobileDevices /> },
      { path: "/ai-studio",              element: <AIStudio /> },

      // Property Management
      { path: "/listings",               element: <Listings /> },
      { path: "/reservations",           element: <Reservations /> },
      { path: "/reservations/tracking",  element: <ActivityTracking /> },
      { path: "/bookings",               element: <BookingCenter /> },
      { path: "/facilities",             element: <Facilities /> },
      { path: "/availability",           element: <BookingCenter /> },
      { path: "/property/availability",  element: <BookingCenter /> },
      { path: "/maintenance",            element: <Maintenance /> },
      { path: "/maintenance-blocks",     element: <MaintenanceBlocks /> },
      { path: "/listings/maintenance",   element: <Maintenance /> },
      { path: "/property-offers",        element: <PropertyOffers /> },
      { path: "/listing-management",     element: <ListingManagement /> },

      // Communication
      { path: "/communication-logs",     element: <CommunicationLogs /> },
      { path: "/communication-templates", element: <CommunicationTemplates /> },

      // Agents & Agencies
      { path: "/mortgages",              element: <Mortgages /> },
      { path: "/agents",                 element: <Agents /> },
      { path: "/agencies",               element: <Agencies /> },
      { path: "/agency-dashboard",       element: <AgencyDashboard /> },
      { path: "/video-vendors",          element: <VideoVendorMarketplace /> },
      { path: "/video-content",           element: <VideoContentManagement /> },
      { path: "/video-studio",            element: <VideoContentManagement /> },

      // Financial
      { path: "/payments",               element: <Payments /> },
      { path: "/expenses",               element: <Expenses /> },
      { path: "/financial",              element: <AnalyticsDashboard /> },
      { path: "/financial/taxes",        element: <TaxRecords /> },
      { path: "/financial/tax-overview", element: <TaxOverview /> },
      { path: "/financial/expenses",     element: <Expenses /> },
      { path: "/financial/transactions", element: <Payments /> },
      { path: "/financial/reports",      element: <AnalyticsDashboard /> },
      { path: "/financial/invoices",     element: <Payments /> },
      { path: "/financial/budgets",      element: <Budgets /> },
      { path: "/financial/commission-rules", element: <CommissionRules /> },
      { path: "/extra-charges",          element: <Payments /> },
      { path: "/tax-1099",               element: <Tax1099Forms /> },
      { path: "/payouts",                element: <Payouts /> },
      { path: "/payout-and-helpdesk",    element: <HelpDesk /> },

      // Contracts & Legal
      { path: "/contracts",              element: <Contracts /> },
      { path: "/legal/compliance",       element: <Compliance /> },
      { path: "/legal/signatures",       element: <Signatures /> },
      { path: "/legal/deposit-protection", element: <DepositProtection /> },
      { path: "/legal/right-to-rent",    element: <RightToRent /> },
      { path: "/legal/solicitors",       element: <SolicitorManagement /> },
      { path: "/document-templates",     element: <DocumentTemplates /> },

      // Other Client Pages
      { path: "/agent-profile/:id",      element: <AgentProfile /> },
      { path: "/channels",               element: <ChannelManagement /> },
      { path: "/helpdesk",               element: <HelpDesk /> },
      { path: "/guests",                 element: <GuestFollowUp /> },
      { path: "/guests/follow-up",       element: <GuestFollowUp /> },
      { path: "/activity",               element: <Suspense fallback={<LoadingFallback />}><ActivityTracking /></Suspense> },
      { path: "/files",                  element: <FileManagement /> },
      { path: "/security",               element: <SecuritySettings /> },
      { path: "/security-settings",      element: <SecuritySettings /> },
      { path: "/favorites",              element: <Favorites /> },
      { path: "/my-listings",            element: <MyListings /> },
      { path: "/compare",                element: <CompareList /> },
      { path: "/reviews",                element: <Reviews /> },
      { path: "/support-dashboard",      element: <SupportDashboard /> },
      { path: "/support",                element: <SupportDashboard /> },
      { path: "/agent-teams",            element: <AgentTeams /> },
      { path: "/agent-performance",      element: <AgentPerformance /> },
      { path: "/agent-commissions",      element: <Commissions /> },
      { path: "/commissions",            element: <Commissions /> },
      { path: "/tenants",                element: <Tenants /> },
      { path: "/leases",                 element: <Leases /> },
      { path: "/tenants/applications",   element: <TenantApplications /> },
      { path: "/tenant-applications",    element: <TenantApplications /> },
      { path: "/rent-schedule",          element: <RentSchedule /> },
      { path: "/rent-arrears",           element: <RentArrears /> },
      { path: "/rent-increases",         element: <Increases /> },
      { path: "/increases",              element: <Increases /> },
      { path: "/escrow",                 element: <Escrow /> },
      { path: "/integrations",           element: <Integrations /> },
      { path: "/mls",                    element: <MLSConnections /> },
      { path: "/property-disclosures",   element: <PropertyDisclosures /> },
      { path: "/investor-portfolio",     element: <InvestorPortfolio /> },
      { path: "/investors/portfolio",    element: <InvestorPortfolio /> },
      { path: "/loyalty-rewards",        element: <LoyaltyRewards /> },
      { path: "/loyalty",                element: <LoyaltyRewards /> },
      { path: "/membership-management",  element: <MembershipManagementClient /> },
      { path: "/membership",             element: <MembershipManagementClient /> },
      { path: "/budgets",                element: <Budgets /> },
      { path: "/commission-rules",       element: <CommissionRules /> },
      { path: "/discounts",              element: <Discounts /> },
      { path: "/deposit-protection",     element: <DepositProtection /> },
      { path: "/right-to-rent",          element: <RightToRent /> },
      { path: "/solicitor-management",   element: <SolicitorManagement /> },
      { path: "/referrals",              element: <Referrals /> },
      { path: "/client-relationships",   element: <ClientRelationships /> },
      { path: "/offers",                 element: <Offers /> },
      { path: "/appointments",           element: <Appointments /> },
      { path: "/tasks-events",           element: <TaskEvents /> },
      { path: "/task-events",            element: <TaskEvents /> },
      { path: "/tasks/events",            element: <TaskEvents /> },
      { path: "/tasks-kanban",           element: <TasksKanban /> },
      { path: "/tasks/kanban",           element: <TasksKanban /> },
      { path: "/messages",               element: <Messages /> },
      { path: "/messages/:id",           element: <Messages /> },
      { path: "/ai-valuation",           element: <AIValuation /> },
      { path: "/ai/valuation",           element: <AIValuation /> },
      { path: "/ai-recommendations",     element: <AIRecommendations /> },
      { path: "/ai/recommendations",     element: <AIRecommendations /> },
      { path: "/ai/maintenance",         element: <Maintenance /> },
      { path: "/ai/sentiment",           element: <AISentimentAnalysis /> },
      { path: "/ai/lead-scoring",        element: <LeadScoring /> },
      { path: "/automation",             element: <AutomationRules /> },
      { path: "/mls-connections",        element: <MLSConnections /> },
      { path: "/vacation-rental-platforms", element: <VacationRentalPlatforms /> },
      { path: "/webhooks",               element: <Webhooks /> },
      { path: "/contacts",               element: <Contacts /> },
      { path: "/leads",                  element: <Leads /> },
      { path: "/tasks",                  element: <Tasks /> },
      { path: "/properties",             element: <Properties /> },
      { path: "/properties/new",         element: <PropertyEdit /> },
      { path: "/properties/:id/edit",    element: <PropertyEdit /> },
      { path: "/property-detail",        element: <PropertyDetail /> },
      { path: "/property-search",        element: <PropertySearch /> },
      { path: "/property-search-map",    element: <PropertySearchMap /> },
      { path: "/search",                 element: <PropertySearch /> },
      { path: "/property-management",    element: <PropertyManagement /> },
      { path: "/settings",               element: <SettingsComponent /> },
      { path: "/admin/payments/wise",      element: <WisePayment /> },
      { path: "/admin/invoices",           element: <CustomerInvoices /> },
      { path: "/admin/billing",             element: <Billing /> },
      { path: "/billing",                   element: <Billing /> },
      { path: "/help",                   element: <HelpDesk /> },
      { path: "/notifications",          element: <Notifications /> },
      { path: "/features",               element: <Features /> },
      { path: "/review/:id",             element: <NeuralReview /> },
      { path: "/signatures",             element: <Signatures /> },
      { path: "/projects",               element: <Projects /> },
      { path: "/ai/dashboard",           element: <AIStudio /> },
      { path: "/ai/models",              element: <AIValuation /> },
      { path: "/guests-crm",             element: <Guests /> },
      { path: "/audit-logs",             element: <AuditLogs /> },

      // ── Server Parity: Property Sub-routes ──────────────────────────────
      { path: "/property-media",         element: <Suspense fallback={<LoadingFallback />}><MediaManagement /></Suspense> },
      { path: "/property-photos",        element: <Suspense fallback={<LoadingFallback />}><MediaManagement /></Suspense> },
      { path: "/property-amenities",     element: <Facilities /> },
      { path: "/property-compliance",    element: <Compliance /> },
      { path: "/property-documents",     element: <Suspense fallback={<LoadingFallback />}><DocumentsEnhanced /></Suspense> },
      { path: "/property-viewings",      element: <Suspense fallback={<LoadingFallback />}><PropertyViewings /></Suspense> },
      { path: "/property-promotions",    element: <Suspense fallback={<LoadingFallback />}><PropertyPromotions /></Suspense> },
      { path: "/property-valuations",    element: <AIValuation /> },
      { path: "/property-inventory",     element: <PropertyManagement /> },
      { path: "/pricing-rules",          element: <Suspense fallback={<LoadingFallback />}><Discounts /></Suspense> },
      { path: "/listing-channels",       element: <Listings /> },

      // ── Server Parity: Financial Sub-routes ─────────────────────────────
      { path: "/financial-records",      element: <Suspense fallback={<LoadingFallback />}><ReportsClient /></Suspense> },
      { path: "/payment-installments",   element: <Payments /> },
      { path: "/ledger-entries",         element: <Suspense fallback={<LoadingFallback />}><Transactions /></Suspense> },
      { path: "/exchange-rates",         element: <Suspense fallback={<LoadingFallback />}><FinancialPages /></Suspense> },
      { path: "/tax-records",            element: <Suspense fallback={<LoadingFallback />}><TaxRecords /></Suspense> },
      { path: "/tax-1099-forms",         element: <Tax1099Forms /> },
      { path: "/invoices",               element: <Suspense fallback={<LoadingFallback />}><Invoices /></Suspense> },
      { path: "/transactions",           element: <Suspense fallback={<LoadingFallback />}><Transactions /></Suspense> },
      { path: "/deposits",               element: <Suspense fallback={<LoadingFallback />}><Deposits /></Suspense> },
      { path: "/export-files",           element: <Suspense fallback={<LoadingFallback />}><ExportsClient /></Suspense> },
      { path: "/exports",                element: <Suspense fallback={<LoadingFallback />}><ExportsClient /></Suspense> },

      // ── Server Parity: Legal & Compliance ───────────────────────────────
      { path: "/deposit-protections",    element: <DepositProtection /> },
      { path: "/right-to-rent-checks",   element: <RightToRent /> },
      { path: "/contract-versions",      element: <Contracts /> },
      { path: "/legal-compliance",       element: <Compliance /> },
      { path: "/document-workflow",      element: <Suspense fallback={<LoadingFallback />}><DocumentWorkflow /></Suspense> },
      { path: "/signing",                element: <Suspense fallback={<LoadingFallback />}><Signing /></Suspense> },

      // ── Server Parity: Integrations & Maps ──────────────────────────────
      { path: "/map-layers",             element: <MapServices /> },
      { path: "/map-services",           element: <MapServices /> },
      { path: "/vacation-rentals",       element: <VacationRentalPlatforms /> },
      { path: "/rental-sync-jobs",       element: <VacationRentalPlatforms /> },
      { path: "/api-integrations",       element: <Integrations /> },

      // ── Server Parity: CRM & Communication ──────────────────────────────
      { path: "/mortgage-offers",        element: <Mortgages /> },
      { path: "/neighborhoods",          element: <PropertySearch /> },
      { path: "/user-preferences",       element: <SettingsComponent /> },
      { path: "/included-services",      element: <Facilities /> },
      { path: "/calendar-integration",   element: <Suspense fallback={<LoadingFallback />}><CalendarIntegration /></Suspense> },

      // ── Server Parity: Tasks & Deals ────────────────────────────────────
      { path: "/task-management",        element: <Suspense fallback={<LoadingFallback />}><TaskManagement /></Suspense> },
      { path: "/deals-management",       element: <Suspense fallback={<LoadingFallback />}><DealsManagement /></Suspense> },

      // ── Server Parity: Facility Management ──────────────────────────────
      { path: "/facility-management",    element: <Suspense fallback={<LoadingFallback />}><FacilityManagement /></Suspense> },

      // ── Financial / Checkout ──────────────────────────────────────────
      { path: "/checkout",               element: <Suspense fallback={<LoadingFallback />}><Checkout /></Suspense> },
      { path: "/payment/success",        element: <Suspense fallback={<LoadingFallback />}><PaymentStatus /></Suspense> },
      { path: "/payment/cancel",         element: <Suspense fallback={<LoadingFallback />}><PaymentStatus /></Suspense> },

      // ── Server Parity: Reports ──────────────────────────────────────────
      { path: "/reports",                element: <Suspense fallback={<LoadingFallback />}><ReportsClient /></Suspense> },
    ],
  },

  {
    element: <ProtectedRoute allowedRoles={["ADMIN", "SUPER_ADMIN", "ORG_ADMIN", "OWNER", "AGENCY_ADMIN", "VENDOR_MANAGER", "ACCOUNTANT", "MAINTENANCE"]}><AdminLayoutWrapper /></ProtectedRoute>,
    children: [
      {
        path: "/admin",
        element: <Navigate to="/admin/dashboard" replace />,
      },
      {
        path: "/admin",
        children: [
          { path: "dashboard",     element: <AdminDashboard /> },
          { path: "properties",    element: <AdminProperties /> },
          { path: "inventory",     element: <PropertyInventory /> },
          { path: "ownership-verification", element: <OwnershipVerification /> },
          { path: "channels",      element: <ChannelManagement /> },
          { path: "users",         element: <UserManagement /> },
          { path: "roles",         element: <RolesPage /> },
          { path: "organizations", element: <Organizations /> },
          { path: "financial-reports", element: <FinancialReports /> },
          { path: "ai-dashboard",  element: <AIDashboard /> },
          { path: "plans",         element: <Plans /> },
          { path: "reports",       element: <AdminReports /> },
          
          // Additional Admin Pages
          { path: "exports",       element: <Exports /> },
          { path: "projects",      element: <ProjectDashboard /> },
          { path: "digital-twin",  element: <DigitalTwinDashboard /> },
          { path: "bookings",      element: <BookingsManagement /> },
          { path: "payouts",       element: <AdminPayouts /> },
          { path: "payments",      element: <AdminPayments /> },
          { path: "expenses",      element: <AdminExpenses /> },
          { path: "escrow",        element: <EscrowDashboard /> },
          { path: "b2b-integrations", element: <B2BHotelIntegrations /> },
          { path: "documents",     element: <DocumentManagement /> },
          { path: "locations",     element: <LocationServices /> },
          { path: "location",      element: <LocationServices /> },
          { path: "settings",      element: <SystemSettings /> },
          { path: "analytics",     element: <AdminAnalytics /> },
          { path: "custom-reports", element: <CustomReports /> },
          { path: "lead-scoring",  element: <LeadScoring /> },
          { path: "ai-models",     element: <AIModels /> },
          { path: "scraping",      element: <ScrapingDashboard /> },
          { path: "marketing",     element: <MarketingAutomation /> },
          { path: "compliance",    element: <ComplianceDashboard /> },
          { path: "right-to-rent", element: <ComplianceDashboard /> },
          { path: "immigration",   element: <ComplianceDashboard /> },
          { path: "solicitors",    element: <SolicitorManagement /> },
          { path: "inventory",     element: <PropertyInventory /> },
          { path: "inventory/facilities", element: <PropertyInventory /> },
          { path: "investors",     element: <InvestorPortfolio /> },
          { path: "leads",         element: <Leads /> },
          { path: "maintenance",   element: <MaintenanceManagement /> },
          { path: "communication-logs", element: <CommunicationLogs /> },
          { path: "ai-sentiment",  element: <AISentiment /> },
          { path: "ai-fraud",      element: <AIFraud /> },
          { path: "ai-predictive", element: <AIPredictive /> },
          { path: "ai-predictive-analytics", element: <AIPredictiveAnalytics /> },
          { path: "ai-automation-rules", element: <AIAutomationRules /> },
          { path: "ai-chat",       element: <AIChatManagement /> },
          { path: "ai-config",     element: <AIConfiguration /> },
          { path: "ai-configuration", element: <AIConfiguration /> },
          { path: "ai-custom-models", element: <AICustomModels /> },
          { path: "audit-logs",    element: <AuditLogs /> },
          { path: "security-events", element: <SecurityEvents /> },
          { path: "security",      element: <SecurityOverview /> },
          { path: "advanced-security", element: <AdvancedSecurity /> },
          { path: "security-overview", element: <SecurityOverview /> },
          { path: "security-screening", element: <SecurityScreening /> },
          { path: "api-tokens",    element: <ApiTokens /> },
          { path: "sessions",      element: <Sessions /> },
          { path: "system-metrics", element: <SystemMetrics /> },
          { path: "metrics",       element: <SystemMetrics /> },
          { path: "attachments",   element: <Attachments /> },
          { path: "automation-rules", element: <AutomationRules /> },
          { path: "sentiment-analysis", element: <AISentimentAnalysis /> },
          { path: "export-jobs",   element: <ExportJobs /> },
          { path: "mls-integration", element: <MLSIntegration /> },
          { path: "mls",           element: <MLSIntegration /> },
          { path: "commission-distribution", element: <CommissionDistribution /> },
          { path: "tax-settings", element: <GlobalTaxSettings /> },
          
          // Domain Specific Admin
          { path: "agencies",      element: <AgenciesManagement /> },
          { path: "agents",        element: <AgentsManagement /> },
          { path: "vendors",       element: <VendorsManagement /> },
          { path: "contacts",      element: <ContactsManagement /> },
          { path: "tasks",         element: <TasksManagement /> },
          { path: "facilities",    element: <FacilitiesManagement /> },
          { path: "tenants",       element: <Tenants /> },
          { path: "leases",        element: <Leases /> },
          { path: "guests",        element: <Guests /> },
          { path: "bookings-management", element: <BookingsManagement /> },
          
          { path: "cloud/manager", element: <GoogleCloudManager /> },
          { path: "company",       element: <CompanyManagement /> },
          { path: "membership",    element: <MembershipManagement /> },
          
          // AI & Video Features
          { path: "service-analytics", element: <AIServiceAnalytics /> },
          { path: "valuations",    element: <AIValuation /> },
          { path: "lead-conversions", element: <LeadScoring /> },
          { path: "market-insights", element: <AdminAnalytics /> },
          { path: "video-vendors", element: <ScrapingDashboard /> },
          { path: "video-partnerships", element: <MarketingAutomation /> },
          { path: "agent-videos",   element: <AIModels /> },

          // ── Server Parity: Property Admin ───────────────────────────────
          { path: "property-viewings",    element: <Suspense fallback={<LoadingFallback />}><PropertyViewings /></Suspense> },
          { path: "property-promotions",  element: <Suspense fallback={<LoadingFallback />}><PropertyPromotions /></Suspense> },
          { path: "vacation-rentals",     element: <Suspense fallback={<LoadingFallback />}><VacationRentalsAdmin /></Suspense> },
          { path: "property-analytics",   element: <Suspense fallback={<LoadingFallback />}><PropertyAnalyticsAdmin /></Suspense> },
          { path: "property-media",       element: <Suspense fallback={<LoadingFallback />}><MediaManagement /></Suspense> },
          { path: "property-inventory",   element: <PropertyInventory /> },

          // ── Server Parity: Organization Admin ───────────────────────────
          { path: "permissions",    element: <Suspense fallback={<LoadingFallback />}><AdminPermissions /></Suspense> },
          { path: "departments",    element: <Suspense fallback={<LoadingFallback />}><AdminDepartments /></Suspense> },
          { path: "teams",          element: <Suspense fallback={<LoadingFallback />}><AdminTeams /></Suspense> },
          { path: "subscription-management", element: <Suspense fallback={<LoadingFallback />}><AdminSubscriptionMgmt /></Suspense> },

          // ── Server Parity: System Admin ─────────────────────────────────
          { path: "system-management", element: <Suspense fallback={<LoadingFallback />}><SystemManagement /></Suspense> },
          { path: "event-log", element: <Suspense fallback={<LoadingFallback />}><EventLog /></Suspense> },
          { path: "notification-templates", element: <Suspense fallback={<LoadingFallback />}><NotificationTemplates /></Suspense> },
          { path: "automation-executions", element: <Suspense fallback={<LoadingFallback />}><AutomationExecutionHistory /></Suspense> },
          { path: "communication-templates", element: <Suspense fallback={<LoadingFallback />}><AdminCommunicationTemplates /></Suspense> },
          { path: "ml-configuration", element: <Suspense fallback={<LoadingFallback />}><MLConfiguration /></Suspense> },
          { path: "ml-tasks",       element: <Suspense fallback={<LoadingFallback />}><MLTasks /></Suspense> },
          { path: "mobile-devices", element: <Suspense fallback={<LoadingFallback />}><MobileDeviceManagementAdmin /></Suspense> },
          { path: "location-services", element: <LocationServices /> },
          { path: "audit",           element: <AuditLogs /> },

          // Legacy Compatibility
          { path: "old-settings",  element: <SettingsComponent /> },
          { path: "old-billing",   element: <Billing /> },
          { path: "old-analytics", element: <Analytics /> },
        ],
      },
    ],
  },
  { path: "*", element: <NotFound /> },
]);

export const AppRouter: React.FC = () => <RouterProvider router={router} />;

