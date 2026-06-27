import 'package:reservatior/shared/enums/earning_strategy.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/enums/listing_status.dart';
import 'package:reservatior/shared/enums/listing_type.dart';
import 'package:reservatior/shared/enums/org_type.dart';
import 'package:reservatior/shared/enums/region.dart';
import 'package:reservatior/shared/enums/property_type.dart';
import 'package:reservatior/shared/enums/property_category.dart';
import 'agent_assignment.dart';
import 'ai_video_generation.dart';
import 'category.dart';
import 'ai_chat_message.dart';
import 'ai_price_optimization.dart';
import 'appointment.dart';
import 'booking.dart';
import 'contract.dart';
import 'deal.dart';
import 'document.dart';
import 'financial_record.dart';
import 'lead.dart';
import 'lease.dart';
import 'lease_renewal.dart';
import 'listing_channel.dart';
import 'listing_status_history.dart';
import 'listing_tag.dart';
import 'location.dart';
import 'maintenance_block.dart';
import 'mls_listing_enhancement.dart';
import 'organization.dart';
import 'pricing_rule.dart';
import 'property.dart';
import 'property_offer.dart';
import 'property_viewing.dart';
import 'quote.dart';
import 'reservation.dart';
import 'task.dart';
import 'tenant_application.dart';
import 'vacation_rental.dart';
import 'video_content.dart';

class Listing {
  final String id;
  final String orgId;
  final String propertyId;
  final String? categoryId;
  final Category? category;
  final List<AiVideoGeneration> aiVideos;
  final ListingType type;
  final ListingStatus status;
  final DateTime? willBeAvailableAt;
  final EarningStrategy strategy;
  final String? title;
  final String? description;
  final double? price;
  final String? priceCurrency;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? locationId;
  final List<AiPriceOptimization> aiPriceOptimizations;
  final List<AgentAssignment> agentAssignments;
  final List<Appointment> appointments;
  final List<Booking> bookings;
  final List<Contract> contracts;
  final List<Deal> deals;
  final List<Document> documents;
  final List<FinancialRecord> financialRecords;
  final List<Lead> leads;
  final List<Lease> leases;
  final List<LeaseRenewal> leaseRenewals;
  final Location? location;
  final Organization org;
  final Property property;
  final List<ListingChannel> channels;
  final List<ListingStatusHistory> statusHistory;
  final List<ListingTag> tags;
  final List<MaintenanceBlock> maintenanceBlocks;
  final MlsListingEnhancement? mlsListingEnhancement;
  final List<PropertyOffer> propertyOffers;
  final List<PropertyViewing> viewings;
  final List<Quote> quotes;
  final List<Reservation> reservations;
  final List<Task> tasks;
  final List<TenantApplication> tenantApplications;
  final VacationRental? vacationRental;
  final List<VideoContent> videoContents;
  final List<PricingRule> pricingRule;
  final List<AiChatMessage> aiChatMessages;

  const Listing({
    required this.id,
    required this.orgId,
    required this.propertyId,
    this.categoryId,
    this.category,
    this.aiVideos = const [],
    required this.type,
    required this.status,
    this.willBeAvailableAt,
    required this.strategy,
    this.title,
    this.description,
    this.price,
    this.priceCurrency,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.locationId,
    this.aiPriceOptimizations = const [],
    this.agentAssignments = const [],
    this.appointments = const [],
    this.bookings = const [],
    this.contracts = const [],
    this.deals = const [],
    this.documents = const [],
    this.financialRecords = const [],
    this.leads = const [],
    this.leases = const [],
    this.leaseRenewals = const [],
    this.location,
    required this.org,
    required this.property,
    this.channels = const [],
    this.statusHistory = const [],
    this.tags = const [],
    this.maintenanceBlocks = const [],
    this.mlsListingEnhancement,
    this.propertyOffers = const [],
    this.viewings = const [],
    this.quotes = const [],
    this.reservations = const [],
    this.tasks = const [],
    this.tenantApplications = const [],
    this.vacationRental,
    this.videoContents = const [],
    this.pricingRule = const [],
    this.aiChatMessages = const [],
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      categoryId: json['categoryId'] as String?,
      category: json['category'] != null ? Category.fromJson(json['category'] as Map<String, dynamic>) : null,
      aiVideos: (json['aiVideos'] as List<dynamic>?)?.map((e) => AiVideoGeneration.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      type: (() {
        final valUpper = json['type']?.toString().toUpperCase() ?? '';
        return ListingType.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => ListingType.SALE,
        );
      })(),
      status: (() {
        final valUpper = json['status']?.toString().toUpperCase() ?? '';
        return ListingStatus.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => ListingStatus.AVAILABLE,
        );
      })(),
      willBeAvailableAt: json['willBeAvailableAt'] != null ? DateTime.parse(json['willBeAvailableAt'] as String) : null,
      strategy: (() {
        final valUpper = json['strategy']?.toString().toUpperCase() ?? '';
        return EarningStrategy.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => EarningStrategy.LONG_TERM_STABLE,
        );
      })(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
      priceCurrency: json['priceCurrency'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      locationId: json['locationId'] as String?,
      aiPriceOptimizations: (json['aiPriceOptimizations'] as List<dynamic>?)?.map((e) => AiPriceOptimization.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agentAssignments: (json['agentAssignments'] as List<dynamic>?)?.map((e) => AgentAssignment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      appointments: (json['appointments'] as List<dynamic>?)?.map((e) => Appointment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      bookings: (json['bookings'] as List<dynamic>?)?.map((e) => Booking.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      contracts: (json['contracts'] as List<dynamic>?)?.map((e) => Contract.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      deals: (json['deals'] as List<dynamic>?)?.map((e) => Deal.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      documents: (json['documents'] as List<dynamic>?)?.map((e) => Document.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      financialRecords: (json['financialRecords'] as List<dynamic>?)?.map((e) => FinancialRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leads: (json['leads'] as List<dynamic>?)?.map((e) => Lead.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leases: (json['leases'] as List<dynamic>?)?.map((e) => Lease.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leaseRenewals: (json['leaseRenewals'] as List<dynamic>?)?.map((e) => LeaseRenewal.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      location: json['location'] != null ? Location.fromJson(json['location'] as Map<String, dynamic>) : null,
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : 
        Organization(
          id: json['orgId'], 
          name: 'mobile.leftovers.unknown_org'.tr(), 
          type: OrgType.AGENCY,
          region: Region.USA_NORTHEAST,
          defaultCurrency: 'USD',
          defaultLocale: 'en',
          taxReportingEnabled: false,
          complianceTracking: false,
          createdAt: DateTime.now(), 
          updatedAt: DateTime.now()
        ),
      property: json['property'] != null 
          ? Property.fromJson(json['property'] as Map<String, dynamic>)
          : Property(
              id: json['propertyId'] ?? '',
              orgId: json['orgId'] ?? '',
              type: PropertyType.APARTMENT,
              name: 'mobile.leftovers.unknown_property'.tr(),
              region: Region.USA_NORTHEAST,
              currency: 'USD',
              addressLine1: '',
              city: '',
              country: '',
              propertyCategory: PropertyCategory.RESIDENTIAL,
              listingType: ListingType.SALE,
              listingStatus: ListingStatus.AVAILABLE,
              leadPaintCompliance: false,
              accessibilityCompliance: false,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
      channels: (json['channels'] as List<dynamic>?)?.map((e) => ListingChannel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      statusHistory: (json['statusHistory'] as List<dynamic>?)?.map((e) => ListingStatusHistory.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => ListingTag.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      maintenanceBlocks: (json['maintenanceBlocks'] as List<dynamic>?)?.map((e) => MaintenanceBlock.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mlsListingEnhancement: json['mlsListingEnhancement'] != null ? MlsListingEnhancement.fromJson(json['mlsListingEnhancement'] as Map<String, dynamic>) : null,
      propertyOffers: (json['propertyOffers'] as List<dynamic>?)?.map((e) => PropertyOffer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      viewings: (json['viewings'] as List<dynamic>?)?.map((e) => PropertyViewing.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      quotes: (json['quotes'] as List<dynamic>?)?.map((e) => Quote.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reservations: (json['reservations'] as List<dynamic>?)?.map((e) => Reservation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tenantApplications: (json['tenantApplications'] as List<dynamic>?)?.map((e) => TenantApplication.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      vacationRental: json['vacationRental'] != null ? VacationRental.fromJson(json['vacationRental'] as Map<String, dynamic>) : null,
      videoContents: (json['videoContents'] as List<dynamic>?)?.map((e) => VideoContent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      pricingRule: (json['PricingRule'] as List<dynamic>?)?.map((e) => PricingRule.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiChatMessages: (json['aiChatMessages'] as List<dynamic>?)?.map((e) => AiChatMessage.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'categoryId': categoryId,
      'category': category?.toJson(),
      'aiVideos': aiVideos.map((e) => e.toJson()).toList(),
      'type': type.name,
      'status': status.name,
      'willBeAvailableAt': willBeAvailableAt?.toIso8601String(),
      'strategy': strategy.name,
      'title': title,
      'description': description,
      'price': price,
      'priceCurrency': priceCurrency,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'locationId': locationId,
      'aiPriceOptimizations': aiPriceOptimizations.map((e) => e.toJson()).toList(),
      'agentAssignments': agentAssignments.map((e) => e.toJson()).toList(),
      'appointments': appointments.map((e) => e.toJson()).toList(),
      'bookings': bookings.map((e) => e.toJson()).toList(),
      'contracts': contracts.map((e) => e.toJson()).toList(),
      'deals': deals.map((e) => e.toJson()).toList(),
      'documents': documents.map((e) => e.toJson()).toList(),
      'financialRecords': financialRecords.map((e) => e.toJson()).toList(),
      'leads': leads.map((e) => e.toJson()).toList(),
      'leases': leases.map((e) => e.toJson()).toList(),
      'leaseRenewals': leaseRenewals.map((e) => e.toJson()).toList(),
      'location': location?.toJson(),
      'org': org.toJson(),
      'property': property.toJson(),
      'channels': channels.map((e) => e.toJson()).toList(),
      'statusHistory': statusHistory.map((e) => e.toJson()).toList(),
      'tags': tags.map((e) => e.toJson()).toList(),
      'maintenanceBlocks': maintenanceBlocks.map((e) => e.toJson()).toList(),
      'mlsListingEnhancement': mlsListingEnhancement?.toJson(),
      'propertyOffers': propertyOffers.map((e) => e.toJson()).toList(),
      'viewings': viewings.map((e) => e.toJson()).toList(),
      'quotes': quotes.map((e) => e.toJson()).toList(),
      'reservations': reservations.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'tenantApplications': tenantApplications.map((e) => e.toJson()).toList(),
      'vacationRental': vacationRental?.toJson(),
      'videoContents': videoContents.map((e) => e.toJson()).toList(),
      'PricingRule': pricingRule.map((e) => e.toJson()).toList(),
      'aiChatMessages': aiChatMessages.map((e) => e.toJson()).toList(),
    };
  }

  Listing copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? categoryId,
    Category? category,
    List<AiVideoGeneration>? aiVideos,
    ListingType? type,
    ListingStatus? status,
    DateTime? willBeAvailableAt,
    EarningStrategy? strategy,
    String? title,
    String? description,
    double? price,
    String? priceCurrency,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? locationId,
    List<AiPriceOptimization>? aiPriceOptimizations,
    List<AgentAssignment>? agentAssignments,
    List<Appointment>? appointments,
    List<Booking>? bookings,
    List<Contract>? contracts,
    List<Deal>? deals,
    List<Document>? documents,
    List<FinancialRecord>? financialRecords,
    List<Lead>? leads,
    List<Lease>? leases,
    List<LeaseRenewal>? leaseRenewals,
    Location? location,
    Organization? org,
    Property? property,
    List<ListingChannel>? channels,
    List<ListingStatusHistory>? statusHistory,
    List<ListingTag>? tags,
    List<MaintenanceBlock>? maintenanceBlocks,
    MlsListingEnhancement? mlsListingEnhancement,
    List<PropertyOffer>? propertyOffers,
    List<PropertyViewing>? viewings,
    List<Quote>? quotes,
    List<Reservation>? reservations,
    List<Task>? tasks,
    List<TenantApplication>? tenantApplications,
    VacationRental? vacationRental,
    List<VideoContent>? videoContents,
    List<PricingRule>? pricingRule,
    List<AiChatMessage>? aiChatMessages,
  }) {
    return Listing(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      aiVideos: aiVideos ?? this.aiVideos,
      type: type ?? this.type,
      status: status ?? this.status,
      willBeAvailableAt: willBeAvailableAt ?? this.willBeAvailableAt,
      strategy: strategy ?? this.strategy,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      priceCurrency: priceCurrency ?? this.priceCurrency,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      locationId: locationId ?? this.locationId,
      aiPriceOptimizations: aiPriceOptimizations ?? this.aiPriceOptimizations,
      agentAssignments: agentAssignments ?? this.agentAssignments,
      appointments: appointments ?? this.appointments,
      bookings: bookings ?? this.bookings,
      contracts: contracts ?? this.contracts,
      deals: deals ?? this.deals,
      documents: documents ?? this.documents,
      financialRecords: financialRecords ?? this.financialRecords,
      leads: leads ?? this.leads,
      leases: leases ?? this.leases,
      leaseRenewals: leaseRenewals ?? this.leaseRenewals,
      location: location ?? this.location,
      org: org ?? this.org,
      property: property ?? this.property,
      channels: channels ?? this.channels,
      statusHistory: statusHistory ?? this.statusHistory,
      tags: tags ?? this.tags,
      maintenanceBlocks: maintenanceBlocks ?? this.maintenanceBlocks,
      mlsListingEnhancement: mlsListingEnhancement ?? this.mlsListingEnhancement,
      propertyOffers: propertyOffers ?? this.propertyOffers,
      viewings: viewings ?? this.viewings,
      quotes: quotes ?? this.quotes,
      reservations: reservations ?? this.reservations,
      tasks: tasks ?? this.tasks,
      tenantApplications: tenantApplications ?? this.tenantApplications,
      vacationRental: vacationRental ?? this.vacationRental,
      videoContents: videoContents ?? this.videoContents,
      pricingRule: pricingRule ?? this.pricingRule,
      aiChatMessages: aiChatMessages ?? this.aiChatMessages,
    );
  }
}
