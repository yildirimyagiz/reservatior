
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'listing_type.dart';
import 'listing_status.dart';
import 'earning_strategy.dart';
import 'ai_price_optimization.dart';
import 'agent_assignment.dart';
import 'appointment.dart';
import 'booking.dart';
import 'contract.dart';
import 'deal.dart';
import 'document.dart';
import 'financial_record.dart';
import 'lead.dart';
import 'lease.dart';
import 'lease_renewal.dart';
import 'location.dart';
import 'organization.dart';
import 'property.dart';
import 'listing_channel.dart';
import 'listing_status_history.dart';
import 'listing_tag.dart';
import 'maintenance_block.dart';
import 'mls_listing_enhancement.dart';
import 'property_offer.dart';
import 'property_viewing.dart';
import 'quote.dart';
import 'reservation.dart';
import 'task.dart';
import 'tenant_application.dart';
import 'vacation_rental.dart';
import 'video_content.dart';
import 'pricing_rule.dart';
import 'ai_chat_message.dart';


class Listing implements PrismaModel<String, Listing> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	ListingType? type;
	ListingStatus? status;
	DateTime? willBeAvailableAt;
	EarningStrategy? strategy;
	String? title;
	String? description;
	double? price;
	String? priceCurrency;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? locationId;
	List<AIPriceOptimization>? aiPriceOptimizations;
	List<AgentAssignment>? agentAssignments;
	List<Appointment>? appointments;
	List<Booking>? bookings;
	List<Contract>? contracts;
	List<Deal>? deals;
	List<Document>? documents;
	List<FinancialRecord>? financialRecords;
	List<Lead>? leads;
	List<Lease>? leases;
	List<LeaseRenewal>? leaseRenewals;
	Location? location;
	Organization? org;
	Property? property;
	List<ListingChannel>? channels;
	List<ListingStatusHistory>? statusHistory;
	List<ListingTag>? tags;
	List<MaintenanceBlock>? maintenanceBlocks;
	MlsListingEnhancement? mlsListingEnhancement;
	List<PropertyOffer>? propertyOffers;
	List<PropertyViewing>? viewings;
	List<Quote>? quotes;
	List<Reservation>? reservations;
	List<Task>? tasks;
	List<TenantApplication>? tenantApplications;
	VacationRental? vacationRental;
	List<VideoContent>? videoContents;
	List<PricingRule>? PricingRule;
	List<AIChatMessage>? aiChatMessages;
	int? $aiPriceOptimizationsCount;
	int? $agentAssignmentsCount;
	int? $appointmentsCount;
	int? $bookingsCount;
	int? $contractsCount;
	int? $dealsCount;
	int? $documentsCount;
	int? $financialRecordsCount;
	int? $leadsCount;
	int? $leasesCount;
	int? $leaseRenewalsCount;
	int? $channelsCount;
	int? $statusHistoryCount;
	int? $tagsCount;
	int? $maintenanceBlocksCount;
	int? $propertyOffersCount;
	int? $viewingsCount;
	int? $quotesCount;
	int? $reservationsCount;
	int? $tasksCount;
	int? $tenantApplicationsCount;
	int? $videoContentsCount;
	int? $PricingRuleCount;
	int? $aiChatMessagesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Listing({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.type,
	 this.status,
	 this.willBeAvailableAt,
	 this.strategy = EarningStrategy.LONG_TERM_STABLE,
	 this.title,
	 this.description,
	 this.price,
	 this.priceCurrency,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.locationId,
	 this.aiPriceOptimizations,
	 this.agentAssignments,
	 this.appointments,
	 this.bookings,
	 this.contracts,
	 this.deals,
	 this.documents,
	 this.financialRecords,
	 this.leads,
	 this.leases,
	 this.leaseRenewals,
	 this.location,
	 this.org,
	 this.property,
	 this.channels,
	 this.statusHistory,
	 this.tags,
	 this.maintenanceBlocks,
	 this.mlsListingEnhancement,
	 this.propertyOffers,
	 this.viewings,
	 this.quotes,
	 this.reservations,
	 this.tasks,
	 this.tenantApplications,
	 this.vacationRental,
	 this.videoContents,
	 this.PricingRule,
	 this.aiChatMessages,
	this.$aiPriceOptimizationsCount,
	this.$agentAssignmentsCount,
	this.$appointmentsCount,
	this.$bookingsCount,
	this.$contractsCount,
	this.$dealsCount,
	this.$documentsCount,
	this.$financialRecordsCount,
	this.$leadsCount,
	this.$leasesCount,
	this.$leaseRenewalsCount,
	this.$channelsCount,
	this.$statusHistoryCount,
	this.$tagsCount,
	this.$maintenanceBlocksCount,
	this.$propertyOffersCount,
	this.$viewingsCount,
	this.$quotesCount,
	this.$reservationsCount,
	this.$tasksCount,
	this.$tenantApplicationsCount,
	this.$videoContentsCount,
	this.$PricingRuleCount,
	this.$aiChatMessagesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Listing, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"type": (m) => m.type,

	"status": (m) => m.status,

	"willBeAvailableAt": (m) => m.willBeAvailableAt,

	"strategy": (m) => m.strategy,

	"title": (m) => m.title,

	"description": (m) => m.description,

	"price": (m) => m.price,

	"priceCurrency": (m) => m.priceCurrency,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"locationId": (m) => m.locationId,

	"aiPriceOptimizations": (m) => m.aiPriceOptimizations,

	"agentAssignments": (m) => m.agentAssignments,

	"appointments": (m) => m.appointments,

	"bookings": (m) => m.bookings,

	"contracts": (m) => m.contracts,

	"deals": (m) => m.deals,

	"documents": (m) => m.documents,

	"financialRecords": (m) => m.financialRecords,

	"leads": (m) => m.leads,

	"leases": (m) => m.leases,

	"leaseRenewals": (m) => m.leaseRenewals,

	"location": (m) => m.location,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"channels": (m) => m.channels,

	"statusHistory": (m) => m.statusHistory,

	"tags": (m) => m.tags,

	"maintenanceBlocks": (m) => m.maintenanceBlocks,

	"mlsListingEnhancement": (m) => m.mlsListingEnhancement,

	"propertyOffers": (m) => m.propertyOffers,

	"viewings": (m) => m.viewings,

	"quotes": (m) => m.quotes,

	"reservations": (m) => m.reservations,

	"tasks": (m) => m.tasks,

	"tenantApplications": (m) => m.tenantApplications,

	"vacationRental": (m) => m.vacationRental,

	"videoContents": (m) => m.videoContents,

	"PricingRule": (m) => m.PricingRule,

	"aiChatMessages": (m) => m.aiChatMessages,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Listing) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Listing');
    }
    return propFunction as V? Function(Listing);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Listing.fromJson(JsonMap json) =>
      Listing(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	type: json['type'] != null ? ListingType.fromJson(json['type']) : null,
	status: json['status'] != null ? ListingStatus.fromJson(json['status']) : null,
	willBeAvailableAt: json['willBeAvailableAt'] != null ? DateTime.parse(json['willBeAvailableAt']) : null,
	strategy: json['strategy'] != null ? EarningStrategy.fromJson(json['strategy']) : null,
	title: json['title'] as String?,
	description: json['description'] as String?,
	price: json['price'] as double?,
	priceCurrency: json['priceCurrency'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	locationId: json['locationId'] as String?,
	aiPriceOptimizations: json['aiPriceOptimizations'] != null ? createModels<AIPriceOptimization>((json['aiPriceOptimizations'] as List).cast<JsonMap>(), AIPriceOptimization.fromJson) : null,
	agentAssignments: json['agentAssignments'] != null ? createModels<AgentAssignment>((json['agentAssignments'] as List).cast<JsonMap>(), AgentAssignment.fromJson) : null,
	appointments: json['appointments'] != null ? createModels<Appointment>((json['appointments'] as List).cast<JsonMap>(), Appointment.fromJson) : null,
	bookings: json['bookings'] != null ? createModels<Booking>((json['bookings'] as List).cast<JsonMap>(), Booking.fromJson) : null,
	contracts: json['contracts'] != null ? createModels<Contract>((json['contracts'] as List).cast<JsonMap>(), Contract.fromJson) : null,
	deals: json['deals'] != null ? createModels<Deal>((json['deals'] as List).cast<JsonMap>(), Deal.fromJson) : null,
	documents: json['documents'] != null ? createModels<Document>((json['documents'] as List).cast<JsonMap>(), Document.fromJson) : null,
	financialRecords: json['financialRecords'] != null ? createModels<FinancialRecord>((json['financialRecords'] as List).cast<JsonMap>(), FinancialRecord.fromJson) : null,
	leads: json['leads'] != null ? createModels<Lead>((json['leads'] as List).cast<JsonMap>(), Lead.fromJson) : null,
	leases: json['leases'] != null ? createModels<Lease>((json['leases'] as List).cast<JsonMap>(), Lease.fromJson) : null,
	leaseRenewals: json['leaseRenewals'] != null ? createModels<LeaseRenewal>((json['leaseRenewals'] as List).cast<JsonMap>(), LeaseRenewal.fromJson) : null,
	location: json['location'] != null ? Location.fromJson(json['location'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	channels: json['channels'] != null ? createModels<ListingChannel>((json['channels'] as List).cast<JsonMap>(), ListingChannel.fromJson) : null,
	statusHistory: json['statusHistory'] != null ? createModels<ListingStatusHistory>((json['statusHistory'] as List).cast<JsonMap>(), ListingStatusHistory.fromJson) : null,
	tags: json['tags'] != null ? createModels<ListingTag>((json['tags'] as List).cast<JsonMap>(), ListingTag.fromJson) : null,
	maintenanceBlocks: json['maintenanceBlocks'] != null ? createModels<MaintenanceBlock>((json['maintenanceBlocks'] as List).cast<JsonMap>(), MaintenanceBlock.fromJson) : null,
	mlsListingEnhancement: json['mlsListingEnhancement'] != null ? MlsListingEnhancement.fromJson(json['mlsListingEnhancement'] as JsonMap) : null,
	propertyOffers: json['propertyOffers'] != null ? createModels<PropertyOffer>((json['propertyOffers'] as List).cast<JsonMap>(), PropertyOffer.fromJson) : null,
	viewings: json['viewings'] != null ? createModels<PropertyViewing>((json['viewings'] as List).cast<JsonMap>(), PropertyViewing.fromJson) : null,
	quotes: json['quotes'] != null ? createModels<Quote>((json['quotes'] as List).cast<JsonMap>(), Quote.fromJson) : null,
	reservations: json['reservations'] != null ? createModels<Reservation>((json['reservations'] as List).cast<JsonMap>(), Reservation.fromJson) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	tenantApplications: json['tenantApplications'] != null ? createModels<TenantApplication>((json['tenantApplications'] as List).cast<JsonMap>(), TenantApplication.fromJson) : null,
	vacationRental: json['vacationRental'] != null ? VacationRental.fromJson(json['vacationRental'] as JsonMap) : null,
	videoContents: json['videoContents'] != null ? createModels<VideoContent>((json['videoContents'] as List).cast<JsonMap>(), VideoContent.fromJson) : null,
	PricingRule: json['PricingRule'] != null ? createModels<PricingRule>((json['PricingRule'] as List).cast<JsonMap>(), PricingRule.fromJson) : null,
	aiChatMessages: json['aiChatMessages'] != null ? createModels<AIChatMessage>((json['aiChatMessages'] as List).cast<JsonMap>(), AIChatMessage.fromJson) : null,
	$aiPriceOptimizationsCount: json['_count']?['aiPriceOptimizations'] as int?,
	$agentAssignmentsCount: json['_count']?['agentAssignments'] as int?,
	$appointmentsCount: json['_count']?['appointments'] as int?,
	$bookingsCount: json['_count']?['bookings'] as int?,
	$contractsCount: json['_count']?['contracts'] as int?,
	$dealsCount: json['_count']?['deals'] as int?,
	$documentsCount: json['_count']?['documents'] as int?,
	$financialRecordsCount: json['_count']?['financialRecords'] as int?,
	$leadsCount: json['_count']?['leads'] as int?,
	$leasesCount: json['_count']?['leases'] as int?,
	$leaseRenewalsCount: json['_count']?['leaseRenewals'] as int?,
	$channelsCount: json['_count']?['channels'] as int?,
	$statusHistoryCount: json['_count']?['statusHistory'] as int?,
	$tagsCount: json['_count']?['tags'] as int?,
	$maintenanceBlocksCount: json['_count']?['maintenanceBlocks'] as int?,
	$propertyOffersCount: json['_count']?['propertyOffers'] as int?,
	$viewingsCount: json['_count']?['viewings'] as int?,
	$quotesCount: json['_count']?['quotes'] as int?,
	$reservationsCount: json['_count']?['reservations'] as int?,
	$tasksCount: json['_count']?['tasks'] as int?,
	$tenantApplicationsCount: json['_count']?['tenantApplications'] as int?,
	$videoContentsCount: json['_count']?['videoContents'] as int?,
	$PricingRuleCount: json['_count']?['PricingRule'] as int?,
	$aiChatMessagesCount: json['_count']?['aiChatMessages'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Listing copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<ListingType?>? type,
		Value<ListingStatus?>? status,
		Value<DateTime?>? willBeAvailableAt,
		Value<EarningStrategy?>? strategy,
		Value<String?>? title,
		Value<String?>? description,
		Value<double?>? price,
		Value<String?>? priceCurrency,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? locationId,
		Value<List<AIPriceOptimization>?>? aiPriceOptimizations,
		Value<List<AgentAssignment>?>? agentAssignments,
		Value<List<Appointment>?>? appointments,
		Value<List<Booking>?>? bookings,
		Value<List<Contract>?>? contracts,
		Value<List<Deal>?>? deals,
		Value<List<Document>?>? documents,
		Value<List<FinancialRecord>?>? financialRecords,
		Value<List<Lead>?>? leads,
		Value<List<Lease>?>? leases,
		Value<List<LeaseRenewal>?>? leaseRenewals,
		Value<Location?>? location,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<List<ListingChannel>?>? channels,
		Value<List<ListingStatusHistory>?>? statusHistory,
		Value<List<ListingTag>?>? tags,
		Value<List<MaintenanceBlock>?>? maintenanceBlocks,
		Value<MlsListingEnhancement?>? mlsListingEnhancement,
		Value<List<PropertyOffer>?>? propertyOffers,
		Value<List<PropertyViewing>?>? viewings,
		Value<List<Quote>?>? quotes,
		Value<List<Reservation>?>? reservations,
		Value<List<Task>?>? tasks,
		Value<List<TenantApplication>?>? tenantApplications,
		Value<VacationRental?>? vacationRental,
		Value<List<VideoContent>?>? videoContents,
		Value<List<PricingRule>?>? PricingRule,
		Value<List<AIChatMessage>?>? aiChatMessages,
		int? $aiPriceOptimizationsCount,
		int? $agentAssignmentsCount,
		int? $appointmentsCount,
		int? $bookingsCount,
		int? $contractsCount,
		int? $dealsCount,
		int? $documentsCount,
		int? $financialRecordsCount,
		int? $leadsCount,
		int? $leasesCount,
		int? $leaseRenewalsCount,
		int? $channelsCount,
		int? $statusHistoryCount,
		int? $tagsCount,
		int? $maintenanceBlocksCount,
		int? $propertyOffersCount,
		int? $viewingsCount,
		int? $quotesCount,
		int? $reservationsCount,
		int? $tasksCount,
		int? $tenantApplicationsCount,
		int? $videoContentsCount,
		int? $PricingRuleCount,
		int? $aiChatMessagesCount,
        }) {
        return Listing(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		type: type != null ? type.value : this.type,
		status: status != null ? status.value : this.status,
		willBeAvailableAt: willBeAvailableAt != null ? willBeAvailableAt.value : this.willBeAvailableAt,
		strategy: strategy != null ? strategy.value : this.strategy,
		title: title != null ? title.value : this.title,
		description: description != null ? description.value : this.description,
		price: price != null ? price.value : this.price,
		priceCurrency: priceCurrency != null ? priceCurrency.value : this.priceCurrency,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		locationId: locationId != null ? locationId.value : this.locationId,
		aiPriceOptimizations: aiPriceOptimizations != null ? aiPriceOptimizations.value : this.aiPriceOptimizations,
		agentAssignments: agentAssignments != null ? agentAssignments.value : this.agentAssignments,
		appointments: appointments != null ? appointments.value : this.appointments,
		bookings: bookings != null ? bookings.value : this.bookings,
		contracts: contracts != null ? contracts.value : this.contracts,
		deals: deals != null ? deals.value : this.deals,
		documents: documents != null ? documents.value : this.documents,
		financialRecords: financialRecords != null ? financialRecords.value : this.financialRecords,
		leads: leads != null ? leads.value : this.leads,
		leases: leases != null ? leases.value : this.leases,
		leaseRenewals: leaseRenewals != null ? leaseRenewals.value : this.leaseRenewals,
		location: location != null ? location.value : this.location,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		channels: channels != null ? channels.value : this.channels,
		statusHistory: statusHistory != null ? statusHistory.value : this.statusHistory,
		tags: tags != null ? tags.value : this.tags,
		maintenanceBlocks: maintenanceBlocks != null ? maintenanceBlocks.value : this.maintenanceBlocks,
		mlsListingEnhancement: mlsListingEnhancement != null ? mlsListingEnhancement.value : this.mlsListingEnhancement,
		propertyOffers: propertyOffers != null ? propertyOffers.value : this.propertyOffers,
		viewings: viewings != null ? viewings.value : this.viewings,
		quotes: quotes != null ? quotes.value : this.quotes,
		reservations: reservations != null ? reservations.value : this.reservations,
		tasks: tasks != null ? tasks.value : this.tasks,
		tenantApplications: tenantApplications != null ? tenantApplications.value : this.tenantApplications,
		vacationRental: vacationRental != null ? vacationRental.value : this.vacationRental,
		videoContents: videoContents != null ? videoContents.value : this.videoContents,
		PricingRule: PricingRule != null ? PricingRule.value : this.PricingRule,
		aiChatMessages: aiChatMessages != null ? aiChatMessages.value : this.aiChatMessages,
		$aiPriceOptimizationsCount: $aiPriceOptimizationsCount ?? this.$aiPriceOptimizationsCount,
		$agentAssignmentsCount: $agentAssignmentsCount ?? this.$agentAssignmentsCount,
		$appointmentsCount: $appointmentsCount ?? this.$appointmentsCount,
		$bookingsCount: $bookingsCount ?? this.$bookingsCount,
		$contractsCount: $contractsCount ?? this.$contractsCount,
		$dealsCount: $dealsCount ?? this.$dealsCount,
		$documentsCount: $documentsCount ?? this.$documentsCount,
		$financialRecordsCount: $financialRecordsCount ?? this.$financialRecordsCount,
		$leadsCount: $leadsCount ?? this.$leadsCount,
		$leasesCount: $leasesCount ?? this.$leasesCount,
		$leaseRenewalsCount: $leaseRenewalsCount ?? this.$leaseRenewalsCount,
		$channelsCount: $channelsCount ?? this.$channelsCount,
		$statusHistoryCount: $statusHistoryCount ?? this.$statusHistoryCount,
		$tagsCount: $tagsCount ?? this.$tagsCount,
		$maintenanceBlocksCount: $maintenanceBlocksCount ?? this.$maintenanceBlocksCount,
		$propertyOffersCount: $propertyOffersCount ?? this.$propertyOffersCount,
		$viewingsCount: $viewingsCount ?? this.$viewingsCount,
		$quotesCount: $quotesCount ?? this.$quotesCount,
		$reservationsCount: $reservationsCount ?? this.$reservationsCount,
		$tasksCount: $tasksCount ?? this.$tasksCount,
		$tenantApplicationsCount: $tenantApplicationsCount ?? this.$tenantApplicationsCount,
		$videoContentsCount: $videoContentsCount ?? this.$videoContentsCount,
		$PricingRuleCount: $PricingRuleCount ?? this.$PricingRuleCount,
		$aiChatMessagesCount: $aiChatMessagesCount ?? this.$aiChatMessagesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Listing copyWithInstanceValues(Listing listing) {
        return Listing(
            id: listing.id ?? id,
		orgId: listing.orgId ?? orgId,
		propertyId: listing.propertyId ?? propertyId,
		type: listing.type ?? type,
		status: listing.status ?? status,
		willBeAvailableAt: listing.willBeAvailableAt ?? willBeAvailableAt,
		strategy: listing.strategy ?? strategy,
		title: listing.title ?? title,
		description: listing.description ?? description,
		price: listing.price ?? price,
		priceCurrency: listing.priceCurrency ?? priceCurrency,
		createdBy: listing.createdBy ?? createdBy,
		createdAt: listing.createdAt ?? createdAt,
		updatedAt: listing.updatedAt ?? updatedAt,
		deletedAt: listing.deletedAt ?? deletedAt,
		locationId: listing.locationId ?? locationId,
		aiPriceOptimizations: listing.aiPriceOptimizations ?? aiPriceOptimizations,
		agentAssignments: listing.agentAssignments ?? agentAssignments,
		appointments: listing.appointments ?? appointments,
		bookings: listing.bookings ?? bookings,
		contracts: listing.contracts ?? contracts,
		deals: listing.deals ?? deals,
		documents: listing.documents ?? documents,
		financialRecords: listing.financialRecords ?? financialRecords,
		leads: listing.leads ?? leads,
		leases: listing.leases ?? leases,
		leaseRenewals: listing.leaseRenewals ?? leaseRenewals,
		location: listing.location ?? location,
		org: listing.org ?? org,
		property: listing.property ?? property,
		channels: listing.channels ?? channels,
		statusHistory: listing.statusHistory ?? statusHistory,
		tags: listing.tags ?? tags,
		maintenanceBlocks: listing.maintenanceBlocks ?? maintenanceBlocks,
		mlsListingEnhancement: listing.mlsListingEnhancement ?? mlsListingEnhancement,
		propertyOffers: listing.propertyOffers ?? propertyOffers,
		viewings: listing.viewings ?? viewings,
		quotes: listing.quotes ?? quotes,
		reservations: listing.reservations ?? reservations,
		tasks: listing.tasks ?? tasks,
		tenantApplications: listing.tenantApplications ?? tenantApplications,
		vacationRental: listing.vacationRental ?? vacationRental,
		videoContents: listing.videoContents ?? videoContents,
		PricingRule: listing.PricingRule ?? PricingRule,
		aiChatMessages: listing.aiChatMessages ?? aiChatMessages,
		$aiPriceOptimizationsCount: listing.$aiPriceOptimizationsCount ?? $aiPriceOptimizationsCount,
		$agentAssignmentsCount: listing.$agentAssignmentsCount ?? $agentAssignmentsCount,
		$appointmentsCount: listing.$appointmentsCount ?? $appointmentsCount,
		$bookingsCount: listing.$bookingsCount ?? $bookingsCount,
		$contractsCount: listing.$contractsCount ?? $contractsCount,
		$dealsCount: listing.$dealsCount ?? $dealsCount,
		$documentsCount: listing.$documentsCount ?? $documentsCount,
		$financialRecordsCount: listing.$financialRecordsCount ?? $financialRecordsCount,
		$leadsCount: listing.$leadsCount ?? $leadsCount,
		$leasesCount: listing.$leasesCount ?? $leasesCount,
		$leaseRenewalsCount: listing.$leaseRenewalsCount ?? $leaseRenewalsCount,
		$channelsCount: listing.$channelsCount ?? $channelsCount,
		$statusHistoryCount: listing.$statusHistoryCount ?? $statusHistoryCount,
		$tagsCount: listing.$tagsCount ?? $tagsCount,
		$maintenanceBlocksCount: listing.$maintenanceBlocksCount ?? $maintenanceBlocksCount,
		$propertyOffersCount: listing.$propertyOffersCount ?? $propertyOffersCount,
		$viewingsCount: listing.$viewingsCount ?? $viewingsCount,
		$quotesCount: listing.$quotesCount ?? $quotesCount,
		$reservationsCount: listing.$reservationsCount ?? $reservationsCount,
		$tasksCount: listing.$tasksCount ?? $tasksCount,
		$tenantApplicationsCount: listing.$tenantApplicationsCount ?? $tenantApplicationsCount,
		$videoContentsCount: listing.$videoContentsCount ?? $videoContentsCount,
		$PricingRuleCount: listing.$PricingRuleCount ?? $PricingRuleCount,
		$aiChatMessagesCount: listing.$aiChatMessagesCount ?? $aiChatMessagesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Listing mergeWithInstanceValues(Listing listing) {
        return Listing(
            id: listing.$assignedFields.contains('id') ? listing.id : id,
		orgId: listing.$assignedFields.contains('orgId') ? listing.orgId : orgId,
		propertyId: listing.$assignedFields.contains('propertyId') ? listing.propertyId : propertyId,
		type: listing.$assignedFields.contains('type') ? listing.type : type,
		status: listing.$assignedFields.contains('status') ? listing.status : status,
		willBeAvailableAt: listing.$assignedFields.contains('willBeAvailableAt') ? listing.willBeAvailableAt : willBeAvailableAt,
		strategy: listing.$assignedFields.contains('strategy') ? listing.strategy : strategy,
		title: listing.$assignedFields.contains('title') ? listing.title : title,
		description: listing.$assignedFields.contains('description') ? listing.description : description,
		price: listing.$assignedFields.contains('price') ? listing.price : price,
		priceCurrency: listing.$assignedFields.contains('priceCurrency') ? listing.priceCurrency : priceCurrency,
		createdBy: listing.$assignedFields.contains('createdBy') ? listing.createdBy : createdBy,
		createdAt: listing.$assignedFields.contains('createdAt') ? listing.createdAt : createdAt,
		updatedAt: listing.$assignedFields.contains('updatedAt') ? listing.updatedAt : updatedAt,
		deletedAt: listing.$assignedFields.contains('deletedAt') ? listing.deletedAt : deletedAt,
		locationId: listing.$assignedFields.contains('locationId') ? listing.locationId : locationId,
		aiPriceOptimizations: (listing.$assignedFields.contains('aiPriceOptimizations') && listing.aiPriceOptimizations != null) ? mergeModelLists(aiPriceOptimizations, listing.aiPriceOptimizations) : aiPriceOptimizations,
		agentAssignments: (listing.$assignedFields.contains('agentAssignments') && listing.agentAssignments != null) ? mergeModelLists(agentAssignments, listing.agentAssignments) : agentAssignments,
		appointments: (listing.$assignedFields.contains('appointments') && listing.appointments != null) ? mergeModelLists(appointments, listing.appointments) : appointments,
		bookings: (listing.$assignedFields.contains('bookings') && listing.bookings != null) ? mergeModelLists(bookings, listing.bookings) : bookings,
		contracts: (listing.$assignedFields.contains('contracts') && listing.contracts != null) ? mergeModelLists(contracts, listing.contracts) : contracts,
		deals: (listing.$assignedFields.contains('deals') && listing.deals != null) ? mergeModelLists(deals, listing.deals) : deals,
		documents: (listing.$assignedFields.contains('documents') && listing.documents != null) ? mergeModelLists(documents, listing.documents) : documents,
		financialRecords: (listing.$assignedFields.contains('financialRecords') && listing.financialRecords != null) ? mergeModelLists(financialRecords, listing.financialRecords) : financialRecords,
		leads: (listing.$assignedFields.contains('leads') && listing.leads != null) ? mergeModelLists(leads, listing.leads) : leads,
		leases: (listing.$assignedFields.contains('leases') && listing.leases != null) ? mergeModelLists(leases, listing.leases) : leases,
		leaseRenewals: (listing.$assignedFields.contains('leaseRenewals') && listing.leaseRenewals != null) ? mergeModelLists(leaseRenewals, listing.leaseRenewals) : leaseRenewals,
		location: listing.$assignedFields.contains('location') ? listing.location : location,
		org: listing.$assignedFields.contains('org') ? listing.org : org,
		property: listing.$assignedFields.contains('property') ? listing.property : property,
		channels: (listing.$assignedFields.contains('channels') && listing.channels != null) ? mergeModelLists(channels, listing.channels) : channels,
		statusHistory: (listing.$assignedFields.contains('statusHistory') && listing.statusHistory != null) ? mergeModelLists(statusHistory, listing.statusHistory) : statusHistory,
		tags: (listing.$assignedFields.contains('tags') && listing.tags != null) ? mergeModelLists(tags, listing.tags) : tags,
		maintenanceBlocks: (listing.$assignedFields.contains('maintenanceBlocks') && listing.maintenanceBlocks != null) ? mergeModelLists(maintenanceBlocks, listing.maintenanceBlocks) : maintenanceBlocks,
		mlsListingEnhancement: listing.$assignedFields.contains('mlsListingEnhancement') ? listing.mlsListingEnhancement : mlsListingEnhancement,
		propertyOffers: (listing.$assignedFields.contains('propertyOffers') && listing.propertyOffers != null) ? mergeModelLists(propertyOffers, listing.propertyOffers) : propertyOffers,
		viewings: (listing.$assignedFields.contains('viewings') && listing.viewings != null) ? mergeModelLists(viewings, listing.viewings) : viewings,
		quotes: (listing.$assignedFields.contains('quotes') && listing.quotes != null) ? mergeModelLists(quotes, listing.quotes) : quotes,
		reservations: (listing.$assignedFields.contains('reservations') && listing.reservations != null) ? mergeModelLists(reservations, listing.reservations) : reservations,
		tasks: (listing.$assignedFields.contains('tasks') && listing.tasks != null) ? mergeModelLists(tasks, listing.tasks) : tasks,
		tenantApplications: (listing.$assignedFields.contains('tenantApplications') && listing.tenantApplications != null) ? mergeModelLists(tenantApplications, listing.tenantApplications) : tenantApplications,
		vacationRental: listing.$assignedFields.contains('vacationRental') ? listing.vacationRental : vacationRental,
		videoContents: (listing.$assignedFields.contains('videoContents') && listing.videoContents != null) ? mergeModelLists(videoContents, listing.videoContents) : videoContents,
		PricingRule: (listing.$assignedFields.contains('PricingRule') && listing.PricingRule != null) ? mergeModelLists(PricingRule, listing.PricingRule) : PricingRule,
		aiChatMessages: (listing.$assignedFields.contains('aiChatMessages') && listing.aiChatMessages != null) ? mergeModelLists(aiChatMessages, listing.aiChatMessages) : aiChatMessages,
		$aiPriceOptimizationsCount: listing.$aiPriceOptimizationsCount ?? $aiPriceOptimizationsCount,
		$agentAssignmentsCount: listing.$agentAssignmentsCount ?? $agentAssignmentsCount,
		$appointmentsCount: listing.$appointmentsCount ?? $appointmentsCount,
		$bookingsCount: listing.$bookingsCount ?? $bookingsCount,
		$contractsCount: listing.$contractsCount ?? $contractsCount,
		$dealsCount: listing.$dealsCount ?? $dealsCount,
		$documentsCount: listing.$documentsCount ?? $documentsCount,
		$financialRecordsCount: listing.$financialRecordsCount ?? $financialRecordsCount,
		$leadsCount: listing.$leadsCount ?? $leadsCount,
		$leasesCount: listing.$leasesCount ?? $leasesCount,
		$leaseRenewalsCount: listing.$leaseRenewalsCount ?? $leaseRenewalsCount,
		$channelsCount: listing.$channelsCount ?? $channelsCount,
		$statusHistoryCount: listing.$statusHistoryCount ?? $statusHistoryCount,
		$tagsCount: listing.$tagsCount ?? $tagsCount,
		$maintenanceBlocksCount: listing.$maintenanceBlocksCount ?? $maintenanceBlocksCount,
		$propertyOffersCount: listing.$propertyOffersCount ?? $propertyOffersCount,
		$viewingsCount: listing.$viewingsCount ?? $viewingsCount,
		$quotesCount: listing.$quotesCount ?? $quotesCount,
		$reservationsCount: listing.$reservationsCount ?? $reservationsCount,
		$tasksCount: listing.$tasksCount ?? $tasksCount,
		$tenantApplicationsCount: listing.$tenantApplicationsCount ?? $tenantApplicationsCount,
		$videoContentsCount: listing.$videoContentsCount ?? $videoContentsCount,
		$PricingRuleCount: listing.$PricingRuleCount ?? $PricingRuleCount,
		$aiChatMessagesCount: listing.$aiChatMessagesCount ?? $aiChatMessagesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Listing updateWithInstanceValues(Listing listing) {
        if (listing.$assignedFields.contains('id')) { id = listing.id; }
		if (listing.$assignedFields.contains('orgId')) { orgId = listing.orgId; }
		if (listing.$assignedFields.contains('propertyId')) { propertyId = listing.propertyId; }
		if (listing.$assignedFields.contains('type')) { type = listing.type; }
		if (listing.$assignedFields.contains('status')) { status = listing.status; }
		if (listing.$assignedFields.contains('willBeAvailableAt')) { willBeAvailableAt = listing.willBeAvailableAt; }
		if (listing.$assignedFields.contains('strategy')) { strategy = listing.strategy; }
		if (listing.$assignedFields.contains('title')) { title = listing.title; }
		if (listing.$assignedFields.contains('description')) { description = listing.description; }
		if (listing.$assignedFields.contains('price')) { price = listing.price; }
		if (listing.$assignedFields.contains('priceCurrency')) { priceCurrency = listing.priceCurrency; }
		if (listing.$assignedFields.contains('createdBy')) { createdBy = listing.createdBy; }
		if (listing.$assignedFields.contains('createdAt')) { createdAt = listing.createdAt; }
		if (listing.$assignedFields.contains('updatedAt')) { updatedAt = listing.updatedAt; }
		if (listing.$assignedFields.contains('deletedAt')) { deletedAt = listing.deletedAt; }
		if (listing.$assignedFields.contains('locationId')) { locationId = listing.locationId; }
		if (listing.$assignedFields.contains('aiPriceOptimizations') && listing.aiPriceOptimizations != null) { aiPriceOptimizations = mergeModelLists(aiPriceOptimizations, listing.aiPriceOptimizations); }
		if (listing.$assignedFields.contains('agentAssignments') && listing.agentAssignments != null) { agentAssignments = mergeModelLists(agentAssignments, listing.agentAssignments); }
		if (listing.$assignedFields.contains('appointments') && listing.appointments != null) { appointments = mergeModelLists(appointments, listing.appointments); }
		if (listing.$assignedFields.contains('bookings') && listing.bookings != null) { bookings = mergeModelLists(bookings, listing.bookings); }
		if (listing.$assignedFields.contains('contracts') && listing.contracts != null) { contracts = mergeModelLists(contracts, listing.contracts); }
		if (listing.$assignedFields.contains('deals') && listing.deals != null) { deals = mergeModelLists(deals, listing.deals); }
		if (listing.$assignedFields.contains('documents') && listing.documents != null) { documents = mergeModelLists(documents, listing.documents); }
		if (listing.$assignedFields.contains('financialRecords') && listing.financialRecords != null) { financialRecords = mergeModelLists(financialRecords, listing.financialRecords); }
		if (listing.$assignedFields.contains('leads') && listing.leads != null) { leads = mergeModelLists(leads, listing.leads); }
		if (listing.$assignedFields.contains('leases') && listing.leases != null) { leases = mergeModelLists(leases, listing.leases); }
		if (listing.$assignedFields.contains('leaseRenewals') && listing.leaseRenewals != null) { leaseRenewals = mergeModelLists(leaseRenewals, listing.leaseRenewals); }
		if (listing.$assignedFields.contains('location')) { location = listing.location; }
		if (listing.$assignedFields.contains('org')) { org = listing.org; }
		if (listing.$assignedFields.contains('property')) { property = listing.property; }
		if (listing.$assignedFields.contains('channels') && listing.channels != null) { channels = mergeModelLists(channels, listing.channels); }
		if (listing.$assignedFields.contains('statusHistory') && listing.statusHistory != null) { statusHistory = mergeModelLists(statusHistory, listing.statusHistory); }
		if (listing.$assignedFields.contains('tags') && listing.tags != null) { tags = mergeModelLists(tags, listing.tags); }
		if (listing.$assignedFields.contains('maintenanceBlocks') && listing.maintenanceBlocks != null) { maintenanceBlocks = mergeModelLists(maintenanceBlocks, listing.maintenanceBlocks); }
		if (listing.$assignedFields.contains('mlsListingEnhancement')) { mlsListingEnhancement = listing.mlsListingEnhancement; }
		if (listing.$assignedFields.contains('propertyOffers') && listing.propertyOffers != null) { propertyOffers = mergeModelLists(propertyOffers, listing.propertyOffers); }
		if (listing.$assignedFields.contains('viewings') && listing.viewings != null) { viewings = mergeModelLists(viewings, listing.viewings); }
		if (listing.$assignedFields.contains('quotes') && listing.quotes != null) { quotes = mergeModelLists(quotes, listing.quotes); }
		if (listing.$assignedFields.contains('reservations') && listing.reservations != null) { reservations = mergeModelLists(reservations, listing.reservations); }
		if (listing.$assignedFields.contains('tasks') && listing.tasks != null) { tasks = mergeModelLists(tasks, listing.tasks); }
		if (listing.$assignedFields.contains('tenantApplications') && listing.tenantApplications != null) { tenantApplications = mergeModelLists(tenantApplications, listing.tenantApplications); }
		if (listing.$assignedFields.contains('vacationRental')) { vacationRental = listing.vacationRental; }
		if (listing.$assignedFields.contains('videoContents') && listing.videoContents != null) { videoContents = mergeModelLists(videoContents, listing.videoContents); }
		if (listing.$assignedFields.contains('PricingRule') && listing.PricingRule != null) { PricingRule = mergeModelLists(PricingRule, listing.PricingRule); }
		if (listing.$assignedFields.contains('aiChatMessages') && listing.aiChatMessages != null) { aiChatMessages = mergeModelLists(aiChatMessages, listing.aiChatMessages); }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'Listing'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(type != null) 'type': type?.toJson(),
	if(status != null) 'status': status?.toJson(),
	if(willBeAvailableAt != null) 'willBeAvailableAt': willBeAvailableAt?.toIso8601String(),
	if(strategy != null) 'strategy': strategy?.toJson(),
	if(title != null) 'title': title,
	if(description != null) 'description': description,
	if(price != null) 'price': price,
	if(priceCurrency != null) 'priceCurrency': priceCurrency,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(locationId != null) 'locationId': locationId,
	if(aiPriceOptimizations != null && (!preventCircularSerialization || !serializedModels.contains('AIPriceOptimization'))) 'aiPriceOptimizations': aiPriceOptimizations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agentAssignments != null && (!preventCircularSerialization || !serializedModels.contains('AgentAssignment'))) 'agentAssignments': agentAssignments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(appointments != null && (!preventCircularSerialization || !serializedModels.contains('Appointment'))) 'appointments': appointments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(bookings != null && (!preventCircularSerialization || !serializedModels.contains('Booking'))) 'bookings': bookings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(contracts != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'contracts': contracts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(deals != null && (!preventCircularSerialization || !serializedModels.contains('Deal'))) 'deals': deals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(documents != null && (!preventCircularSerialization || !serializedModels.contains('Document'))) 'documents': documents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(financialRecords != null && (!preventCircularSerialization || !serializedModels.contains('FinancialRecord'))) 'financialRecords': financialRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leads != null && (!preventCircularSerialization || !serializedModels.contains('Lead'))) 'leads': leads?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leases != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'leases': leases?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leaseRenewals != null && (!preventCircularSerialization || !serializedModels.contains('LeaseRenewal'))) 'leaseRenewals': leaseRenewals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(location != null && (!preventCircularSerialization || !serializedModels.contains('Location'))) 'location': location?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(channels != null && (!preventCircularSerialization || !serializedModels.contains('ListingChannel'))) 'channels': channels?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(statusHistory != null && (!preventCircularSerialization || !serializedModels.contains('ListingStatusHistory'))) 'statusHistory': statusHistory?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tags != null && (!preventCircularSerialization || !serializedModels.contains('ListingTag'))) 'tags': tags?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(maintenanceBlocks != null && (!preventCircularSerialization || !serializedModels.contains('MaintenanceBlock'))) 'maintenanceBlocks': maintenanceBlocks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mlsListingEnhancement != null && (!preventCircularSerialization || !serializedModels.contains('MlsListingEnhancement'))) 'mlsListingEnhancement': mlsListingEnhancement?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(propertyOffers != null && (!preventCircularSerialization || !serializedModels.contains('PropertyOffer'))) 'propertyOffers': propertyOffers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(viewings != null && (!preventCircularSerialization || !serializedModels.contains('PropertyViewing'))) 'viewings': viewings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(quotes != null && (!preventCircularSerialization || !serializedModels.contains('Quote'))) 'quotes': quotes?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(reservations != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'reservations': reservations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tenantApplications != null && (!preventCircularSerialization || !serializedModels.contains('TenantApplication'))) 'tenantApplications': tenantApplications?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(vacationRental != null && (!preventCircularSerialization || !serializedModels.contains('VacationRental'))) 'vacationRental': vacationRental?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(videoContents != null && (!preventCircularSerialization || !serializedModels.contains('VideoContent'))) 'videoContents': videoContents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(PricingRule != null && (!preventCircularSerialization || !serializedModels.contains('PricingRule'))) 'PricingRule': PricingRule?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiChatMessages != null && (!preventCircularSerialization || !serializedModels.contains('AIChatMessage'))) 'aiChatMessages': aiChatMessages?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($aiPriceOptimizationsCount != null || $agentAssignmentsCount != null || $appointmentsCount != null || $bookingsCount != null || $contractsCount != null || $dealsCount != null || $documentsCount != null || $financialRecordsCount != null || $leadsCount != null || $leasesCount != null || $leaseRenewalsCount != null || $channelsCount != null || $statusHistoryCount != null || $tagsCount != null || $maintenanceBlocksCount != null || $propertyOffersCount != null || $viewingsCount != null || $quotesCount != null || $reservationsCount != null || $tasksCount != null || $tenantApplicationsCount != null || $videoContentsCount != null || $PricingRuleCount != null || $aiChatMessagesCount != null) '_count': { 
		if ($aiPriceOptimizationsCount != null) 'aiPriceOptimizations': $aiPriceOptimizationsCount, 
		if ($agentAssignmentsCount != null) 'agentAssignments': $agentAssignmentsCount, 
		if ($appointmentsCount != null) 'appointments': $appointmentsCount, 
		if ($bookingsCount != null) 'bookings': $bookingsCount, 
		if ($contractsCount != null) 'contracts': $contractsCount, 
		if ($dealsCount != null) 'deals': $dealsCount, 
		if ($documentsCount != null) 'documents': $documentsCount, 
		if ($financialRecordsCount != null) 'financialRecords': $financialRecordsCount, 
		if ($leadsCount != null) 'leads': $leadsCount, 
		if ($leasesCount != null) 'leases': $leasesCount, 
		if ($leaseRenewalsCount != null) 'leaseRenewals': $leaseRenewalsCount, 
		if ($channelsCount != null) 'channels': $channelsCount, 
		if ($statusHistoryCount != null) 'statusHistory': $statusHistoryCount, 
		if ($tagsCount != null) 'tags': $tagsCount, 
		if ($maintenanceBlocksCount != null) 'maintenanceBlocks': $maintenanceBlocksCount, 
		if ($propertyOffersCount != null) 'propertyOffers': $propertyOffersCount, 
		if ($viewingsCount != null) 'viewings': $viewingsCount, 
		if ($quotesCount != null) 'quotes': $quotesCount, 
		if ($reservationsCount != null) 'reservations': $reservationsCount, 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		if ($tenantApplicationsCount != null) 'tenantApplications': $tenantApplicationsCount, 
		if ($videoContentsCount != null) 'videoContents': $videoContentsCount, 
		if ($PricingRuleCount != null) 'PricingRule': $PricingRuleCount, 
		if ($aiChatMessagesCount != null) 'aiChatMessages': $aiChatMessagesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Listing &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    