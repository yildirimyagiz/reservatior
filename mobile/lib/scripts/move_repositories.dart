#!/usr/bin/env dart

// Script to move repositories from /lib/repositories to appropriate feature folders
// Run this script with: dart run scripts/move_repositories.dart

import 'dart:io';

void main() async {
  print('🚀 Moving repositories to feature folders...\n');

  final repositoriesDir = Directory('lib/repositories');
  final featuresDir = Directory('lib/features');

  if (!repositoriesDir.existsSync()) {
    print('❌ Repositories directory not found!');
    return;
  }

  if (!featuresDir.existsSync()) {
    print('❌ Features directory not found!');
    return;
  }

  // Mapping of repository names to feature folders
  final repositoryToFeatureMap = {
    // Auth & User
    'AuthRepository.dart': 'auth/data/repositories',
    'UserRepository.dart': 'auth/data/repositories',
    'UseractivitylogRepository.dart': 'auth/data/repositories',
    'UserfinancialprofileRepository.dart': 'auth/data/repositories',
    'UserpreferenceRepository.dart': 'auth/data/repositories',
    'SessionRepository.dart': 'auth/data/repositories',
    'ApikeyRepository.dart': 'auth/data/repositories',
    'ApitokenRepository.dart': 'auth/data/repositories',
    'PermissionRepository.dart': 'auth/data/repositories',
    'RoleRepository.dart': 'auth/data/repositories',
    'RolepermissionRepository.dart': 'auth/data/repositories',

    // Agency & Agents
    'AgencyRepository.dart': 'Agency/data/repositories',
    'AgentRepository.dart': 'agents/data/repositories',
    'AgentassignmentRepository.dart': 'agents/data/repositories',
    'AgentperformanceRepository.dart': 'agents/data/repositories',
    'AgentteamRepository.dart': 'agents/data/repositories',
    'AgentteammemberRepository.dart': 'agents/data/repositories',

    // Properties
    'PropertyRepository.dart': 'properties/data/repositories',
    'PropertyamenityRepository.dart': 'properties/data/repositories',
    'PropertycomplianceRepository.dart': 'properties/data/repositories',
    'PropertydisclosureRepository.dart': 'properties/data/repositories',
    'PropertydocumentRepository.dart': 'properties/data/repositories',
    'PropertyinventoryRepository.dart': 'properties/data/repositories',
    'PropertyofferRepository.dart': 'properties/data/repositories',
    'PropertyphotoRepository.dart': 'properties/data/repositories',
    'PropertypromotionRepository.dart': 'properties/data/repositories',
    'PropertyvaluationRepository.dart': 'properties/data/repositories',
    'PropertyviewingRepository.dart': 'properties/data/repositories',

    // Listings
    'ListingRepository.dart': 'properties/data/repositories',
    'ListingchannelRepository.dart': 'properties/data/repositories',
    'ListingstatushistoryRepository.dart': 'properties/data/repositories',
    'ListingtagRepository.dart': 'properties/data/repositories',

    // Bookings & Reservations
    'BookingRepository.dart': 'bookings/data/repositories',
    'ReservationRepository.dart': 'bookings/data/repositories',
    'AvailabilityRepository.dart': 'bookings/data/repositories',

    // Leases
    'LeaseRepository.dart': 'leases/data/repositories',
    'LeaserenewalRepository.dart': 'leases/data/repositories',

    // Contacts & Leads
    'ContactRepository.dart': 'contacts/data/repositories',
    'LeadRepository.dart': 'contacts/data/repositories',
    'LeadsourceRepository.dart': 'contacts/data/repositories',
    'ClientrelationshipRepository.dart': 'contacts/data/repositories',

    // Deals & Commissions
    'DealRepository.dart': 'deals/data/repositories',
    'CommissionRepository.dart': 'deals/data/repositories',
    'CommissionruleRepository.dart': 'deals/data/repositories',

    // Tasks & Appointments
    'TaskRepository.dart': 'tasks/data/repositories',
    'AppointmentRepository.dart': 'tasks/data/repositories',
    'AutomationruleRepository.dart': 'tasks/data/repositories',
    'AutomationtaskRepository.dart': 'tasks/data/repositories',
    'AutomationexecutionRepository.dart': 'tasks/data/repositories',

    // Documents
    'DocumentRepository.dart': 'documents/data/repositories',
    'DocumenttemplateRepository.dart': 'documents/data/repositories',
    'AttachmentRepository.dart': 'documents/data/repositories',
    'PhotoRepository.dart': 'documents/data/repositories',
    'FloorplanRepository.dart': 'documents/data/repositories',

    // Financial
    'FinancialrecordRepository.dart': 'financials/data/repositories',
    'PaymentRepository.dart': 'financials/data/repositories',
    'PaymentinstallmentRepository.dart': 'financials/data/repositories',
    'PaymentnegotiationRepository.dart': 'financials/data/repositories',
    'PayoutRepository.dart': 'financials/data/repositories',
    'ExpenseRepository.dart': 'financials/data/repositories',
    'EarningRepository.dart': 'financials/data/repositories',
    'BudgetRepository.dart': 'financials/data/repositories',
    'LedgerentryRepository.dart': 'financials/data/repositories',

    // Escrow
    'EscrowaccountRepository.dart': 'escrow/data/repositories',
    'EscrowdisputeRepository.dart': 'escrow/data/repositories',
    'EscrowreleaseRepository.dart': 'escrow/data/repositories',
    'EscrowstatushistoryRepository.dart': 'escrow/data/repositories',

    // Contracts
    'ContractRepository.dart': 'contracts/data/repositories',
    'ContractversionRepository.dart': 'contracts/data/repositories',
    'SignaturerequestRepository.dart': 'contracts/data/repositories',
    'SignaturesignerRepository.dart': 'contracts/data/repositories',

    // Analytics & Reports
    'AnalyticsRepository.dart': 'Analytics/data/repositories',
    'ReportRepository.dart': 'Analytics/data/repositories',
    'ReportexecutionRepository.dart': 'Analytics/data/repositories',
    'DashboardconfigurationRepository.dart': 'Analytics/data/repositories',
    'DashboardwidgetRepository.dart': 'Analytics/data/repositories',

    // AI Features
    'AichatbotsessionRepository.dart': 'ai/data/repositories',
    'AichathandoffRepository.dart': 'ai/data/repositories',
    'AichatmessageRepository.dart': 'ai/data/repositories',
    'AifrauddetectionRepository.dart': 'ai/data/repositories',
    'AiimageanalysisRepository.dart': 'ai/data/repositories',
    'AiinvestmentanalysisRepository.dart': 'ai/data/repositories',
    'AileadscoreRepository.dart': 'ai/data/repositories',
    'AileadscoringRepository.dart': 'ai/data/repositories',
    'AimarketanalysisRepository.dart': 'ai/data/repositories',
    'AimodelRepository.dart': 'ai/data/repositories',
    'AimodeldeploymentRepository.dart': 'ai/data/repositories',
    'AipredictionRepository.dart': 'ai/data/repositories',
    'AipredictivemaintenanceRepository.dart': 'ai/data/repositories',
    'AipriceoptimizationRepository.dart': 'ai/data/repositories',
    'AipropertydescriptionRepository.dart': 'ai/data/repositories',
    'AipropertyvaluationRepository.dart': 'ai/data/repositories',
    'AirecommendationRepository.dart': 'ai/data/repositories',
    'AisentimentanalysisRepository.dart': 'ai/data/repositories',
    'AitenantscreeningRepository.dart': 'ai/data/repositories',
    'AivaluationmodelRepository.dart': 'ai/data/repositories',

    // Messages & Communication
    'MessageRepository.dart': 'messages/data/repositories',
    'ChannelRepository.dart': 'messages/data/repositories',
    'CommunicationlogRepository.dart': 'messages/data/repositories',
    'CommunicationtemplateRepository.dart': 'messages/data/repositories',
    'MentionRepository.dart': 'messages/data/repositories',

    // Notifications
    'NotificationRepository.dart': 'notifications/data/repositories',

    // Organizations
    'OrganizationRepository.dart': 'organizations/data/repositories',
    'OrgsubscriptionRepository.dart': 'organizations/data/repositories',

    // Locations
    'LocationRepository.dart': 'locations/data/repositories',
    'NeighborhoodRepository.dart': 'locations/data/repositories',
    'MapdataRepository.dart': 'locations/data/repositories',
    'MaplayerRepository.dart': 'locations/data/repositories',

    // Facilities
    'FacilityRepository.dart': 'facilities/data/repositories',
    'FacilityblockRepository.dart': 'facilities/data/repositories',
    'AmenityRepository.dart': 'facilities/data/repositories',
    'SharedamenityRepository.dart': 'facilities/data/repositories',

    // Marketing
    'MarketingcampaignRepository.dart': 'marketing/data/repositories',
    'BrandambassadorRepository.dart': 'marketing/data/repositories',
    'AmbassadorcampaignRepository.dart': 'marketing/data/repositories',
    'AmbassadorcontractRepository.dart': 'marketing/data/repositories',

    // Video & Media
    'VideocontentRepository.dart': 'video/data/repositories',
    'VirtualtourRepository.dart': 'video/data/repositories',

    // Settings
    'MobiledeviceRepository.dart': 'settings/data/repositories',

    // System & Admin
    'AuditlogRepository.dart': 'admin/data/repositories',
    'SystemmetricsRepository.dart': 'admin/data/repositories',
    'HealthcheckRepository.dart': 'admin/data/repositories',
    'RouteRepository.dart': 'admin/data/repositories',

    // Favorites
    'FavoriteRepository.dart': 'favorites/data/repositories',

    // Achievements
    'AchievementRepository.dart': 'achievements/data/repositories',

    // MLS Integration
    'MlconfigurationRepository.dart': 'mls/data/repositories',
    'MlmodelRepository.dart': 'mls/data/repositories',
    'MlsconnectionRepository.dart': 'mls/data/repositories',
    'MlsdatamappingRepository.dart': 'mls/data/repositories',
    'MlsexternallistingRepository.dart': 'mls/data/repositories',
    'MlslistingenhancementRepository.dart': 'mls/data/repositories',
    'MlssyncjobRepository.dart': 'mls/data/repositories',

    // Integrations
    'ApiintegrationRepository.dart': 'integrations/data/repositories',
    'IntegrationlogRepository.dart': 'integrations/data/repositories',
    'WebhookRepository.dart': 'integrations/data/repositories',
    'WebhookdeliveryRepository.dart': 'integrations/data/repositories',

    // Account & Finance
    'AccountRepository.dart': 'financials/data/repositories',
    'DepositprotectionRepository.dart': 'financials/data/repositories',
    'SecuritydepositprotectionRepository.dart': 'financials/data/repositories',
    'GiftcardRepository.dart': 'financials/data/repositories',
    'LoyaltyaccountRepository.dart': 'financials/data/repositories',

    // Legal & Compliance
    'AttorneymanagementRepository.dart': 'legal/data/repositories',
    'CompliancerecordRepository.dart': 'legal/data/repositories',
    'SolicitormanagementRepository.dart': 'legal/data/repositories',
    'RighttorentcheckRepository.dart': 'legal/data/repositories',
    'ImmigrationstatuscheckRepository.dart': 'legal/data/repositories',
    'HomeinformationpackRepository.dart': 'legal/data/repositories',

    // Events & Calendar
    'EventRepository.dart': 'events/data/repositories',
    'EventattendeeRepository.dart': 'events/data/repositories',
    'CalendareventRepository.dart': 'events/data/repositories',

    // Projects
    'ProjectRepository.dart': 'projects/data/repositories',
    'ProjectalertRepository.dart': 'projects/data/repositories',
    'ProjectanalyticsRepository.dart': 'projects/data/repositories',
    'ProjectreportRepository.dart': 'projects/data/repositories',
    'PerformanceAlertRepository.dart': 'projects/data/repositories',

    // Mortgages
    'MortgageRepository.dart': 'mortgages/data/repositories',
    'MortgageofferRepository.dart': 'mortgages/data/repositories',
    'MortgagepreapprovalRepository.dart': 'mortgages/data/repositories',

    // Guests & Reviews
    'GuestRepository.dart': 'guests/data/repositories',
    'GuestprofileRepository.dart': 'guests/data/repositories',
    'GuestreviewRepository.dart': 'guests/data/repositories',

    // Tenants
    'TenantRepository.dart': 'tenants/data/repositories',
    'TenantapplicationRepository.dart': 'tenants/data/repositories',
    'RentarrearsRepository.dart': 'tenants/data/repositories',
    'RentscheduleRepository.dart': 'tenants/data/repositories',

    // Vacation Rentals
    'VacationrentalRepository.dart': 'vacation-rentals/data/repositories',
    'VacationrentalplatformRepository.dart': 'vacation-rentals/data/repositories',
    'ExternalrentallistingRepository.dart': 'vacation-rentals/data/repositories',
    'RentalsyncjobRepository.dart': 'vacation-rentals/data/repositories',

    // Investors
    'InvestorportfolioRepository.dart': 'investors/data/repositories',
    'InvestorpropertyRepository.dart': 'investors/data/repositories',

    // Social Impact
    'SocialimpactcounterRepository.dart': 'social-impact/data/repositories',
    'SocialimpactrecordRepository.dart': 'social-impact/data/repositories',

    // Government & Compliance
    'GovernmentintegrationRepository.dart': 'government/data/repositories',

    // Vendors
    'VendorprofileRepository.dart': 'vendors/data/repositories',

    // Subscriptions
    'SubscriptionRepository.dart': 'subscriptions/data/repositories',

    // Tax
    'Tax1099formRepository.dart': 'tax/data/repositories',
    'TaxdepreciationRepository.dart': 'tax/data/repositories',
    'TaxrecordRepository.dart': 'tax/data/repositories',

    // Quotes
    'QuoteRepository.dart': 'quotes/data/repositories',

    // Maintenance
    'MaintenanceblockRepository.dart': 'maintenance/data/repositories',
    'MaintenanceworkorderRepository.dart': 'maintenance/data/repositories',
  };

  int movedCount = 0;
  int skippedCount = 0;

  final files = repositoriesDir.listSync();
  
  for (final file in files) {
    if (file is File && file.path.endsWith('.dart')) {
      final fileName = file.path.split('/').last;
      
      if (repositoryToFeatureMap.containsKey(fileName)) {
        final targetPath = repositoryToFeatureMap[fileName]!;
        final targetDir = Directory('lib/features/$targetPath');
        
        // Create target directory if it doesn't exist
        if (!targetDir.existsSync()) {
          targetDir.createSync(recursive: true);
        }
        
        final targetFile = File('${targetDir.path}/$fileName');
        
        // Copy file
        file.copySync(targetFile.path);
        print('✅ Moved: $fileName → $targetPath');
        movedCount++;
      } else {
        print('⚠️  Skipped: $fileName (no mapping found)');
        skippedCount++;
      }
    }
  }

  print('\n🎉 Repository move completed!');
  print('📊 Summary:');
  print('   ✅ Moved: $movedCount files');
  print('   ⚠️  Skipped: $skippedCount files');
  print('\n💡 Next steps:');
  print('   1. Update import statements in your files');
  print('   2. Test the application');
  print('   3. Remove old /lib/repositories directory when ready');
}
