#!/usr/bin/env dart

// Script to move repositories from /lib/repositories to appropriate feature folders
// Run this script with: dart run scripts/move_repositories.dart

import 'dart:io'; 
import 'package:easy_localization/easy_localization.dart';

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
    'mobile.leftovers.authrepository_dart'.tr(): 'auth/data/repositories',
    'mobile.leftovers.userrepository_dart'.tr(): 'auth/data/repositories',
    'mobile.leftovers.useractivitylogrepository_dart'.tr(): 'auth/data/repositories',
    'mobile.leftovers.userfinancialprofilerepository_dart'.tr(): 'auth/data/repositories',
    'mobile.leftovers.userpreferencerepository_dart'.tr(): 'auth/data/repositories',
    'mobile.leftovers.sessionrepository_dart'.tr(): 'auth/data/repositories',
    'mobile.leftovers.apikeyrepository_dart'.tr(): 'auth/data/repositories',
    'mobile.leftovers.apitokenrepository_dart'.tr(): 'auth/data/repositories',
    'mobile.leftovers.permissionrepository_dart'.tr(): 'auth/data/repositories',
    'mobile.leftovers.rolerepository_dart'.tr(): 'auth/data/repositories',
    'mobile.leftovers.rolepermissionrepository_dart'.tr(): 'auth/data/repositories',

    // Agency & Agents
    'mobile.leftovers.agencyrepository_dart'.tr(): 'mobile.leftovers.agency_data_repositories'.tr(),
    'mobile.leftovers.agentrepository_dart'.tr(): 'agents/data/repositories',
    'mobile.leftovers.agentassignmentrepository_dart'.tr(): 'agents/data/repositories',
    'mobile.leftovers.agentperformancerepository_dart'.tr(): 'agents/data/repositories',
    'mobile.leftovers.agentteamrepository_dart'.tr(): 'agents/data/repositories',
    'mobile.leftovers.agentteammemberrepository_dart'.tr(): 'agents/data/repositories',

    // Properties
    'mobile.leftovers.propertyrepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.propertyamenityrepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.propertycompliancerepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.propertydisclosurerepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.propertydocumentrepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.propertyinventoryrepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.propertyofferrepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.propertyphotorepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.propertypromotionrepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.propertyvaluationrepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.propertyviewingrepository_dart'.tr(): 'properties/data/repositories',

    // Listings
    'mobile.leftovers.listingrepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.listingchannelrepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.listingstatushistoryrepository_dart'.tr(): 'properties/data/repositories',
    'mobile.leftovers.listingtagrepository_dart'.tr(): 'properties/data/repositories',

    // Bookings & Reservations
    'mobile.leftovers.bookingrepository_dart'.tr(): 'bookings/data/repositories',
    'mobile.leftovers.reservationrepository_dart'.tr(): 'bookings/data/repositories',
    'mobile.leftovers.availabilityrepository_dart'.tr(): 'bookings/data/repositories',

    // Leases
    'mobile.leftovers.leaserepository_dart'.tr(): 'leases/data/repositories',
    'mobile.leftovers.leaserenewalrepository_dart'.tr(): 'leases/data/repositories',

    // Contacts & Leads
    'mobile.leftovers.contactrepository_dart'.tr(): 'contacts/data/repositories',
    'mobile.leftovers.leadrepository_dart'.tr(): 'contacts/data/repositories',
    'mobile.leftovers.leadsourcerepository_dart'.tr(): 'contacts/data/repositories',
    'mobile.leftovers.clientrelationshiprepository_dart'.tr(): 'contacts/data/repositories',

    // Deals & Commissions
    'mobile.leftovers.dealrepository_dart'.tr(): 'deals/data/repositories',
    'mobile.leftovers.commissionrepository_dart'.tr(): 'deals/data/repositories',
    'mobile.leftovers.commissionrulerepository_dart'.tr(): 'deals/data/repositories',

    // Tasks & Appointments
    'mobile.leftovers.taskrepository_dart'.tr(): 'tasks/data/repositories',
    'mobile.leftovers.appointmentrepository_dart'.tr(): 'tasks/data/repositories',
    'mobile.leftovers.automationrulerepository_dart'.tr(): 'tasks/data/repositories',
    'mobile.leftovers.automationtaskrepository_dart'.tr(): 'tasks/data/repositories',
    'mobile.leftovers.automationexecutionrepository_dart'.tr(): 'tasks/data/repositories',

    // Documents
    'mobile.leftovers.documentrepository_dart'.tr(): 'documents/data/repositories',
    'mobile.leftovers.documenttemplaterepository_dart'.tr(): 'documents/data/repositories',
    'mobile.leftovers.attachmentrepository_dart'.tr(): 'documents/data/repositories',
    'mobile.leftovers.photorepository_dart'.tr(): 'documents/data/repositories',
    'mobile.leftovers.floorplanrepository_dart'.tr(): 'documents/data/repositories',

    // Financial
    'mobile.leftovers.financialrecordrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.paymentrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.paymentinstallmentrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.paymentnegotiationrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.payoutrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.expenserepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.earningrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.budgetrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.ledgerentryrepository_dart'.tr(): 'financials/data/repositories',

    // Escrow
    'mobile.leftovers.escrowaccountrepository_dart'.tr(): 'escrow/data/repositories',
    'mobile.leftovers.escrowdisputerepository_dart'.tr(): 'escrow/data/repositories',
    'mobile.leftovers.escrowreleaserepository_dart'.tr(): 'escrow/data/repositories',
    'mobile.leftovers.escrowstatushistoryrepository_dart'.tr(): 'escrow/data/repositories',

    // Contracts
    'mobile.leftovers.contractrepository_dart'.tr(): 'contracts/data/repositories',
    'mobile.leftovers.contractversionrepository_dart'.tr(): 'contracts/data/repositories',
    'mobile.leftovers.signaturerequestrepository_dart'.tr(): 'contracts/data/repositories',
    'mobile.leftovers.signaturesignerrepository_dart'.tr(): 'contracts/data/repositories',

    // Analytics & Reports
    'mobile.leftovers.analyticsrepository_dart'.tr(): 'mobile.leftovers.analytics_data_repositories'.tr(),
    'mobile.leftovers.reportrepository_dart'.tr(): 'mobile.leftovers.analytics_data_repositories'.tr(),
    'mobile.leftovers.reportexecutionrepository_dart'.tr(): 'mobile.leftovers.analytics_data_repositories'.tr(),
    'mobile.leftovers.dashboardconfigurationrepository_dart'.tr(): 'mobile.leftovers.analytics_data_repositories'.tr(),
    'mobile.leftovers.dashboardwidgetrepository_dart'.tr(): 'mobile.leftovers.analytics_data_repositories'.tr(),

    // AI Features
    'mobile.leftovers.aichatbotsessionrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aichathandoffrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aichatmessagerepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aifrauddetectionrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aiimageanalysisrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aiinvestmentanalysisrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aileadscorerepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aileadscoringrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aimarketanalysisrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aimodelrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aimodeldeploymentrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aipredictionrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aipredictivemaintenancerepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aipriceoptimizationrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aipropertydescriptionrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aipropertyvaluationrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.airecommendationrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aisentimentanalysisrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aitenantscreeningrepository_dart'.tr(): 'ai/data/repositories',
    'mobile.leftovers.aivaluationmodelrepository_dart'.tr(): 'ai/data/repositories',

    // Messages & Communication
    'mobile.leftovers.messagerepository_dart'.tr(): 'messages/data/repositories',
    'mobile.leftovers.channelrepository_dart'.tr(): 'messages/data/repositories',
    'mobile.leftovers.communicationlogrepository_dart'.tr(): 'messages/data/repositories',
    'mobile.leftovers.communicationtemplaterepository_dart'.tr(): 'messages/data/repositories',
    'mobile.leftovers.mentionrepository_dart'.tr(): 'messages/data/repositories',

    // Notifications
    'mobile.leftovers.notificationrepository_dart'.tr(): 'notifications/data/repositories',

    // Organizations
    'mobile.leftovers.organizationrepository_dart'.tr(): 'organizations/data/repositories',
    'mobile.leftovers.orgsubscriptionrepository_dart'.tr(): 'organizations/data/repositories',

    // Locations
    'mobile.leftovers.locationrepository_dart'.tr(): 'locations/data/repositories',
    'mobile.leftovers.neighborhoodrepository_dart'.tr(): 'locations/data/repositories',
    'mobile.leftovers.mapdatarepository_dart'.tr(): 'locations/data/repositories',
    'mobile.leftovers.maplayerrepository_dart'.tr(): 'locations/data/repositories',

    // Facilities
    'mobile.leftovers.facilityrepository_dart'.tr(): 'facilities/data/repositories',
    'mobile.leftovers.facilityblockrepository_dart'.tr(): 'facilities/data/repositories',
    'mobile.leftovers.amenityrepository_dart'.tr(): 'facilities/data/repositories',
    'mobile.leftovers.sharedamenityrepository_dart'.tr(): 'facilities/data/repositories',

    // Marketing
    'mobile.leftovers.marketingcampaignrepository_dart'.tr(): 'marketing/data/repositories',
    'mobile.leftovers.brandambassadorrepository_dart'.tr(): 'marketing/data/repositories',
    'mobile.leftovers.ambassadorcampaignrepository_dart'.tr(): 'marketing/data/repositories',
    'mobile.leftovers.ambassadorcontractrepository_dart'.tr(): 'marketing/data/repositories',

    // Video & Media
    'mobile.leftovers.videocontentrepository_dart'.tr(): 'video/data/repositories',
    'mobile.leftovers.virtualtourrepository_dart'.tr(): 'video/data/repositories',

    // Settings
    'mobile.leftovers.mobiledevicerepository_dart'.tr(): 'settings/data/repositories',

    // System & Admin
    'mobile.leftovers.auditlogrepository_dart'.tr(): 'admin/data/repositories',
    'mobile.leftovers.systemmetricsrepository_dart'.tr(): 'admin/data/repositories',
    'mobile.leftovers.healthcheckrepository_dart'.tr(): 'admin/data/repositories',
    'mobile.leftovers.routerepository_dart'.tr(): 'admin/data/repositories',

    // Favorites
    'mobile.leftovers.favoriterepository_dart'.tr(): 'favorites/data/repositories',

    // Achievements
    'mobile.leftovers.achievementrepository_dart'.tr(): 'achievements/data/repositories',

    // MLS Integration
    'mobile.leftovers.mlconfigurationrepository_dart'.tr(): 'mls/data/repositories',
    'mobile.leftovers.mlmodelrepository_dart'.tr(): 'mls/data/repositories',
    'mobile.leftovers.mlsconnectionrepository_dart'.tr(): 'mls/data/repositories',
    'mobile.leftovers.mlsdatamappingrepository_dart'.tr(): 'mls/data/repositories',
    'mobile.leftovers.mlsexternallistingrepository_dart'.tr(): 'mls/data/repositories',
    'mobile.leftovers.mlslistingenhancementrepository_dart'.tr(): 'mls/data/repositories',
    'mobile.leftovers.mlssyncjobrepository_dart'.tr(): 'mls/data/repositories',

    // Integrations
    'mobile.leftovers.apiintegrationrepository_dart'.tr(): 'integrations/data/repositories',
    'mobile.leftovers.integrationlogrepository_dart'.tr(): 'integrations/data/repositories',
    'mobile.leftovers.webhookrepository_dart'.tr(): 'integrations/data/repositories',
    'mobile.leftovers.webhookdeliveryrepository_dart'.tr(): 'integrations/data/repositories',

    // Account & Finance
    'mobile.leftovers.accountrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.depositprotectionrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.securitydepositprotectionrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.giftcardrepository_dart'.tr(): 'financials/data/repositories',
    'mobile.leftovers.loyaltyaccountrepository_dart'.tr(): 'financials/data/repositories',

    // Legal & Compliance
    'mobile.leftovers.attorneymanagementrepository_dart'.tr(): 'legal/data/repositories',
    'mobile.leftovers.compliancerecordrepository_dart'.tr(): 'legal/data/repositories',
    'mobile.leftovers.solicitormanagementrepository_dart'.tr(): 'legal/data/repositories',
    'mobile.leftovers.righttorentcheckrepository_dart'.tr(): 'legal/data/repositories',
    'mobile.leftovers.immigrationstatuscheckrepository_dart'.tr(): 'legal/data/repositories',
    'mobile.leftovers.homeinformationpackrepository_dart'.tr(): 'legal/data/repositories',

    // Events & Calendar
    'mobile.leftovers.eventrepository_dart'.tr(): 'events/data/repositories',
    'mobile.leftovers.eventattendeerepository_dart'.tr(): 'events/data/repositories',
    'mobile.leftovers.calendareventrepository_dart'.tr(): 'events/data/repositories',

    // Projects
    'mobile.leftovers.projectrepository_dart'.tr(): 'projects/data/repositories',
    'mobile.leftovers.projectalertrepository_dart'.tr(): 'projects/data/repositories',
    'mobile.leftovers.projectanalyticsrepository_dart'.tr(): 'projects/data/repositories',
    'mobile.leftovers.projectreportrepository_dart'.tr(): 'projects/data/repositories',
    'mobile.leftovers.performancealertrepository_dart'.tr(): 'projects/data/repositories',

    // Mortgages
    'mobile.leftovers.mortgagerepository_dart'.tr(): 'mortgages/data/repositories',
    'mobile.leftovers.mortgageofferrepository_dart'.tr(): 'mortgages/data/repositories',
    'mobile.leftovers.mortgagepreapprovalrepository_dart'.tr(): 'mortgages/data/repositories',

    // Guests & Reviews
    'mobile.leftovers.guestrepository_dart'.tr(): 'guests/data/repositories',
    'mobile.leftovers.guestprofilerepository_dart'.tr(): 'guests/data/repositories',
    'mobile.leftovers.guestreviewrepository_dart'.tr(): 'guests/data/repositories',

    // Tenants
    'mobile.leftovers.tenantrepository_dart'.tr(): 'tenants/data/repositories',
    'mobile.leftovers.tenantapplicationrepository_dart'.tr(): 'tenants/data/repositories',
    'mobile.leftovers.rentarrearsrepository_dart'.tr(): 'tenants/data/repositories',
    'mobile.leftovers.rentschedulerepository_dart'.tr(): 'tenants/data/repositories',

    // Vacation Rentals
    'mobile.leftovers.vacationrentalrepository_dart'.tr(): 'vacation-rentals/data/repositories',
    'mobile.leftovers.vacationrentalplatformrepository_dart'.tr(): 'vacation-rentals/data/repositories',
    'mobile.leftovers.externalrentallistingrepository_dart'.tr(): 'vacation-rentals/data/repositories',
    'mobile.leftovers.rentalsyncjobrepository_dart'.tr(): 'vacation-rentals/data/repositories',

    // Investors
    'mobile.leftovers.investorportfoliorepository_dart'.tr(): 'investors/data/repositories',
    'mobile.leftovers.investorpropertyrepository_dart'.tr(): 'investors/data/repositories',

    // Social Impact
    'mobile.leftovers.socialimpactcounterrepository_dart'.tr(): 'social-impact/data/repositories',
    'mobile.leftovers.socialimpactrecordrepository_dart'.tr(): 'social-impact/data/repositories',

    // Government & Compliance
    'mobile.leftovers.governmentintegrationrepository_dart'.tr(): 'government/data/repositories',

    // Vendors
    'mobile.leftovers.vendorprofilerepository_dart'.tr(): 'vendors/data/repositories',

    // Subscriptions
    'mobile.leftovers.subscriptionrepository_dart'.tr(): 'subscriptions/data/repositories',

    // Tax
    'mobile.leftovers.tax1099formrepository_dart'.tr(): 'tax/data/repositories',
    'mobile.leftovers.taxdepreciationrepository_dart'.tr(): 'tax/data/repositories',
    'mobile.leftovers.taxrecordrepository_dart'.tr(): 'tax/data/repositories',

    // Quotes
    'mobile.leftovers.quoterepository_dart'.tr(): 'quotes/data/repositories',

    // Maintenance
    'mobile.leftovers.maintenanceblockrepository_dart'.tr(): 'maintenance/data/repositories',
    'mobile.leftovers.maintenanceworkorderrepository_dart'.tr(): 'maintenance/data/repositories',
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
