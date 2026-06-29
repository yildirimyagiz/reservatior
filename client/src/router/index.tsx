import DynamicAdminPage from "@/pages/admin/dynamic/DynamicAdminPage";
import React, { lazy, Suspense } from "react";
import { createBrowserRouter, RouterProvider, Outlet, Navigate } from "react-router-dom";
import { AppLayout } from "@/pages/client/layout/AppLayout";
import PublicLayout from "@/pages/client/layout/PublicLayout";
import { useAuth } from "@/lib/auth/hooks";

// ─── Shared Components ────────────────────────────────────────────────────────
const LoadingFallback = () => <div className="p-8 text-center text-slate-500 animate-pulse">Loading module...</div>;

// ─── Auth ─────────────────────────────────────────────────────────────────────
import Login from "@/pages/auth/Login";
import Signup from "@/pages/auth/Signup";
import VerifyEmail from "@/pages/auth/VerifyEmail";
import ForgotPassword from "@/pages/auth/ForgotPassword";
import AuthCallback from "@/pages/auth/AuthCallback";
import { AdminLayout } from "@/pages/admin/layout/AdminLayout";
import Unauthorized from "@/pages/client/Unauthorized";
import Terms from "@/pages/client/Terms";
import Privacy from "@/pages/client/Privacy";
import Pricing from "@/pages/client/Pricing";
import Features from "@/pages/public/Features";
import NotFound from "@/pages/client/NotFound";

const AddPropertyWizard = lazy(() => import("@/pages/host/AddPropertyWizard"));

import Home from "@/pages/client/Home";
import HomeChat from "@/pages/client/HomeChat";
import ROICalculator from "@/pages/marketing/ROICalculator";
import Explore from "@/pages/client/Explore";
import Videos from "@/pages/client/Videos";
import LeaseCare from "@/pages/client/LeaseCare";
import Today from "@/pages/client/calendar/Today";
import Dashboard from "@/pages/client/Dashboard";
import TrustCenter from "@/pages/client/TrustCenter";
import HospitalityStandards from "@/pages/client/HospitalityStandards";
import ShortTermRentalSafety from "@/pages/client/ShortTermRentalSafety";
import TenantVerification from "@/pages/client/TenantVerification";
import Documents from "@/pages/client/legal/Documents";
import Legal from "@/pages/client/legal/Legal";
import Events from "@/pages/client/Events";
import AnalyticsDashboard from "@/pages/client/reports/AnalyticsDashboard";
import Contact from "@/pages/client/Contact";
import Profile from "@/pages/client/profile/Profile";
import Deals from "@/pages/client/deals/DealsManagement";
import Tags from "@/pages/client/crm/Tags";
import Subscriptions from "@/pages/client/membership/Subscriptions";
import ApiKeys from "@/pages/client/integrations/ApiKeys";
import MobileDevices from "@/pages/client/mobile/MobileDevices";
import AIStudio from "@/pages/client/ai/AIStudio";
const AISearchResults = lazy(() => import("@/pages/client/ai/AISearchResults"));
import Contacts from "@/pages/client/contacts/Contacts";
import Leads from "@/pages/client/crm/Leads";
import Tasks from "@/pages/client/tasks/Tasks";
import Properties from "@/pages/client/property/Properties";
import PropertyDetail from "@/pages/client/property/PropertyDetail";

import PropertySearch from "@/pages/client/property/PropertySearch";
import PropertyManagement from "@/pages/client/property/PropertyManagement";
import PropertyEdit from "@/pages/client/property/PropertyEdit";
import PropertySearchMap from "@/pages/client/property/PropertySearchMap";
import WisePayment from "@/pages/admin/payments/WisePayment";
import GoogleCloudManager from "@/pages/admin/cloud/GoogleCloudManager";
import CompanyManagement from "@/pages/admin/company/CompanyManagement";
import CustomerInvoices from "@/pages/admin/invoices/CustomerInvoices";
import MembershipManagement from "@/pages/admin/membership/MembershipManagement";

// ─── Admin pages ─────────────────────────────────────────────────────────────
import SettingsComponent from "@/pages/admin/settings/Settings";
import Billing from "@/pages/admin/billing/Billing";
import Analytics from "@/pages/admin/analytics/Analytics";
import EscrowDashboard from "@/pages/admin/escrow/EscrowDashboard";
import FinancialReports from "@/pages/admin/reports/FinancialReports";
import AIDashboard from "@/pages/admin/ai/AIDashboard";

// ─── Batch 1: Agents & Agencies ───────────────────────────────────────────────
import Agents from "@/pages/client/agents/Agents";
import Agencies from "@/pages/client/agents/Agencies";
import AgentTeams from "@/pages/client/agents/AgentTeams";
import AgentPerformance from "@/pages/client/agents/AgentPerformance";
import Commissions from "@/pages/client/agents/Commissions";

// ─── Batch 1: Tenants ─────────────────────────────────────────────────────────
import Tenants from "@/pages/client/tenants/Tenants";
import Leases from "@/pages/client/leases/Leases";
import TenantApplications from "@/pages/client/tenants/TenantApplications";
import RentSchedule from "@/pages/client/tenants/RentSchedule";
import RentArrears from "@/pages/client/tenants/RentArrears";
import Increases from "@/pages/client/tenants/Increases";

// --- Batch 1: Bookings / Financial / Contracts / Integrations -----------------
import BookingCenter from "@/pages/client/bookings/BookingCenter";
import Payments from "@/pages/client/financial/Payments";
import Escrow from "@/pages/client/financial/Escrow";
import Coupons from "@/pages/client/financial/Coupons";
import Contracts from "@/pages/client/contracts/Contracts";
import Integrations from "@/pages/client/integrations/Integrations";
import ExportJobs from "@/pages/admin/integrations/ExportJobs";
import MLSIntegration from "@/pages/admin/integrations/MLSIntegration";

// ─── Batch 2: Property ────────────────────────────────────────────────────────
import Listings from "@/pages/client/property/Listings";
import Reservations from "@/pages/client/property/Reservations";
import Facilities from "@/pages/client/property/Facilities";
// Removed static Availability import to use lazy version from bookings/Availability
// import PropertyAssets from "@/pages/client/property/PropertyAssets";
import PropertyDisclosures from "@/pages/client/property/PropertyDisclosures";

// ─── New Feature Pages ────────────────────────────────────────────────────────
import Mortgages from "@/pages/client/mortgages/Mortgages";
import CommunicationLogs from "@/pages/client/communication/CommunicationLogs";
import CommunicationTemplates from "@/pages/client/communication/CommunicationTemplates";
import MaintenanceBlocks from "@/pages/client/listings/MaintenanceBlocks";
import PropertyOffers from "@/pages/client/listings/PropertyOffers";
import ListingManagement from "@/pages/client/listings/ListingManagement";
import Tax1099Forms from "@/pages/client/financial/Tax1099Forms";

// ─── Phase 4: Investors & Loyalty ───────────────────────────────────────────
import InvestorPortfolio from "@/pages/client/investors/Portfolio";
import LoyaltyRewards from "@/pages/client/membership/LoyaltyRewards";
const NeuralReview = lazy(() => import("@/pages/public/NeuralReview"));
import MembershipManagementClient from "@/pages/client/membership/MembershipManagement";

// ─── Financial Lazy ─────────────────────────────────────────────────────────
const TaxRecords = lazy(() => import("@/pages/client/financial/TaxRecords"));
const Budgets = lazy(() => import("@/pages/client/financial/Budgets"));
const CommissionRules = lazy(() => import("@/pages/client/financial/CommissionRules"));
const Discounts = lazy(() => import("@/pages/client/property/Discounts"));
const Expenses = lazy(() => import("@/pages/client/financial/Expenses"));
const Payouts = lazy(() => import("@/pages/client/financial/Payouts"));
const TaxOverview = lazy(() => import("@/pages/client/financial/TaxOverview"));

// ─── CRM & Legal ─────────────────────────────────────────────────────────────
import DepositProtection from "@/pages/client/legal/DepositProtection";
import RightToRent from "@/pages/client/legal/RightToRent";
import SolicitorManagement from "@/pages/client/legal/SolicitorManagement";
import Signatures from "@/pages/client/legal/Signatures";
import DocumentTemplates from "@/pages/client/legal/DocumentTemplates";
import Compliance from "@/pages/client/legal/Compliance";

// ─── Contacts & CRM ──────────────────────────────────────────────────────────
import Referrals from "@/pages/client/contacts/Referrals";
import Guests from "@/pages/client/contacts/Guests";
import Offers from "@/pages/client/contacts/Offers";
import ClientRelationships from "@/pages/client/contacts/ClientRelationships";

// ─── Tasks & Projects ────────────────────────────────────────────────────────
import Appointments from "@/pages/client/tasks/Appointments";
import TaskEvents from "@/pages/client/tasks/Events";
import TasksKanban from "@/pages/client/tasks/TasksKanban";
import Maintenance from "@/pages/client/listings/Maintenance";
import Projects from "@/pages/client/projects/Projects";

// ─── Messaging ───────────────────────────────────────────────────────────────
import Messages from "@/pages/client/messages/Messages";

// ─── AI & Automation ─────────────────────────────────────────────────────────
import AIValuation from "@/pages/client/ai/AIValuation";
import AIRecommendations from "@/pages/client/ai/AIRecommendations";
import AutomationRules from "@/pages/admin/ai/AutomationRules";
import AISentimentAnalysis from "@/pages/admin/ai/SentimentAnalysis";

// ─── Integrations ────────────────────────────────────────────────────────────
import MLSConnections from "@/pages/client/integrations/MLSConnections";
import VacationRentalPlatforms from "@/pages/client/integrations/VacationRentalPlatforms";
import Webhooks from "@/pages/client/integrations/Webhooks";
import MapServices from "@/pages/client/integrations/MapServices";

// ─── Additional lazy pages for server parity ─────────────────────────────────
const MediaManagement = lazy(() => import("@/pages/client/media/MediaManagement"));
const FacilityManagement = lazy(() => import("@/pages/client/facilities/FacilityManagement"));
const DocumentsEnhanced = lazy(() => import("@/pages/client/legal/DocumentsEnhanced"));
const DocumentWorkflow = lazy(() => import("@/pages/client/legal/DocumentWorkflow"));
const CalendarIntegration = lazy(() => import("@/pages/client/calendar/CalendarIntegration"));
const ExportsClient = lazy(() => import("@/pages/client/exports/Exports"));
const Notifications = lazy(() => import("@/pages/client/notifications/Notifications"));
const TaskManagement = lazy(() => import("@/pages/client/tasks/TaskManagement"));
const DealsManagement = lazy(() => import("@/pages/client/deals/DealsManagement"));
const MarketplaceBrain = lazy(() => import("@/pages/client/marketplace/MarketplaceBrain"));
import InmanConnect from "@/pages/marketing/InmanConnect";


// ─── Server Parity Financial / Client ──────────────────────────────────────────
const FinancialPages = lazy(() => import("@/pages/client/financial/FinancialPages").then(m => ({ default: m.FinancialRecords })));
const Invoices = lazy(() => import("@/pages/client/financial/Invoices"));
const Transactions = lazy(() => import("@/pages/client/financial/Transactions"));
const ReportsClient = lazy(() => import("@/pages/client/reports/ReportsEnhanced"));
const ActivityTracking = lazy(() => import("@/pages/client/property/ReservationTracking"));
// Availability replaced by BookingCenter
const Deposits = lazy(() => import("@/pages/client/payments/Deposits"));
const Signing = lazy(() => import("@/pages/client/contracts/Signing"));


// ─── Admin lazy pages for server parity ──────────────────────────────────────
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

// ─── Admin Core ──────────────────────────────────────────────────────────────
import { 
  Organizations, SecurityEvents, SystemMetrics, Plans, 
  Reports as AdminReports, Exports, ProjectDashboard,
  BookingsManagement, Payouts as AdminPayouts, 
  Payments as AdminPayments, Expenses as AdminExpenses,
  EscrowManagement,
  DocumentManagement, LocationServices,
  SystemSettings, AnalyticsDashboard as AdminAnalytics,
  AdminProperties,
  CustomReports, LeadScoring, AIModels, ScrapingDashboard,
  MarketingAutomation, ComplianceDashboard, PropertyInventory,
  SentimentAnalysis as AISentiment, FraudDetection as AIFraud,
  PredictiveMaintenance as AIPredictive, PredictiveAnalytics as AIPredictiveAnalytics,
  AutomationRules as AIAutomationRules, AIChatManagement, AIConfiguration,
  AICustomModels,
  ApiTokens,
  AdvancedSecurity,
  SecurityOverview,
  SecurityScreening,
  Sessions,
  Attachments,
  MobileDeviceManagement as MobileDeviceManagementAdmin,
  Dashboard as AdminDashboard,
  OwnershipVerification,
  AIServiceAnalytics,
  CommissionDistribution,
  GlobalTaxSettings,
  AgenciesManagement,
  AgentsManagement,
  VendorsManagement,
  ContactsManagement,
  TasksManagement,
  MaintenanceManagement
} from "@/pages/admin";

import FacilitiesManagement from "@/pages/admin/facilities/FacilitiesManagement";
import { PartnerAgreements } from "@/pages/admin/agencies/PartnerAgreements";

import DigitalTwinDashboard from "@/pages/admin/projects/DigitalTwin";

import UserManagement from "@/pages/admin/users/UserManagement";
import RolesPage from "@/pages/admin/users/Roles";
import AuditLogs from "@/pages/admin/security/AuditLogs";

import AgencyDashboard from "@/pages/client/agents/AgencyDashboard";
import AgentProfile from "@/pages/client/agents/AgentProfile";
import ChannelManagement from "@/pages/client/channels/ChannelManagement";
import VideoVendorMarketplace from "@/pages/client/VideoVendors";
import VideoContentManagement from "@/pages/client/video/VideoContentManagement";
import HelpDesk from "@/pages/client/support/PayoutHelpdesk";
import GuestFollowUp from "@/pages/client/guests/GuestFollowUp";
import B2BHotelIntegrations from "@/pages/admin/integrations/B2BHotelIntegrations";
// Removed static ActivityTracking import to use lazy version from property/ReservationTracking
import FileManagement from "@/pages/client/FileManagement";
import SecuritySettings from "@/pages/client/profile/SecuritySettings";
import Favorites from "@/pages/client/profile/Favorites";
import MyListings from "@/pages/client/profile/MyListings";
import CompareList from "@/pages/client/profile/CompareList";
import Reviews from "@/pages/client/profile/Reviews";
import SupportDashboard from "@/pages/client/support/SupportDashboard";
import Checkout from "@/pages/client/bookings/Checkout";
import PaymentStatus from "@/pages/client/financial/PaymentStatus";

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

import { AgentLayout } from "@/pages/agent_os/layout/AgentLayout";
import AgentDashboard from "@/pages/agent_os/Dashboard";
import { FinanceLayout } from "@/pages/finance_os/layout/FinanceLayout";
import FinanceDashboard from "@/pages/finance_os/Dashboard";

const AgentLayoutWrapper = () => {
  return (
    <AgentLayout>
      <Suspense fallback={<LoadingFallback />}>
        <Outlet />
      </Suspense>
    </AgentLayout>
  );
};

const FinanceLayoutWrapper = () => {
  return (
    <FinanceLayout>
      <Suspense fallback={<LoadingFallback />}>
        <Outlet />
      </Suspense>
    </FinanceLayout>
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
      { path: "/ai-search",              element: <HomeChat /> },
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
      { path: "/icny27",                 element: <InmanConnect /> },
      { path: "/inman",                  element: <InmanConnect /> },
      { path: "/roi",                    element: <ROICalculator /> },
      { path: "/ai-results",              element: <React.Suspense fallback={<LoadingFallback />}><AISearchResults /></React.Suspense> },
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
      { path: "/marketplace-brain",      element: <Suspense fallback={<LoadingFallback />}><MarketplaceBrain /></Suspense> },
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
    element: <ProtectedRoute><AgentLayoutWrapper /></ProtectedRoute>,
    children: [
      { path: "/agent-os/dashboard", element: <AgentDashboard /> },
      { path: "/agent-os/leads", element: <AgentDashboard /> },
      { path: "/agent-os/performance", element: <AgentDashboard /> },
      { path: "/agent-os/clients", element: <AgentDashboard /> },
      { path: "/agent-os", element: <Navigate to="/agent-os/dashboard" replace /> }
    ]
  },

  {
    element: <ProtectedRoute><FinanceLayoutWrapper /></ProtectedRoute>,
    children: [
      { path: "/finance-os/dashboard", element: <FinanceDashboard /> },
      { path: "/finance-os/ledger", element: <FinanceDashboard /> },
      { path: "/finance-os/escrow", element: <FinanceDashboard /> },
      { path: "/finance-os/revenue", element: <FinanceDashboard /> },
      { path: "/finance-os", element: <Navigate to="/finance-os/dashboard" replace /> }
    ]
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
          { path: "dynamic/:model", element: <DynamicAdminPage /> },
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
          { path: "agencies/contracts", element: <PartnerAgreements /> },
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

