//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'shared_status.dart';
import 'organization.dart';
import 'extra_charge.dart';
import 'facility.dart';
import 'included_service.dart';
import 'user.dart';
import 'agent.dart';
import 'analytics.dart';
import 'communication_log.dart';
import 'compliance_record.dart';
import 'contract.dart';
import 'expense.dart';
import 'guest.dart';
import 'hashtag.dart';
import 'language.dart';
import 'location.dart';
import 'mention.dart';
import 'notification.dart';
import 'photo.dart';
import 'post.dart';
import 'property.dart';
import 'report.dart';
import 'reservation.dart';
import 'review.dart';
import 'subscription.dart';
import 'task.dart';
import 'property_promotion.dart';

class Agency implements PrismaModel<String, Agency>, Id<String> {
  @override
  String? id;
  String? organizationId;
  String? name;
  String? description;
  String? email;
  String? phoneNumber;
  String? address;
  String? website;
  String? logoUrl;
  SharedStatus? status;
  DateTime? createdAt;
  DateTime? deletedAt;
  DateTime? updatedAt;
  String? facilityId;
  String? includedServiceId;
  String? extraChargeId;
  bool? isActive;
  String? ownerId;
  dynamic settings;
  String? theme;
  String? externalId;
  dynamic integration;
  int? totalProperties;
  int? totalAgents;
  int? establishedYear;
  String? licenseNumber;
  double? commissionRate;
  String? taxIdentificationNumber;
  String? taxJurisdiction;
  dynamic metrics;
  dynamic taxConfiguration;
  Organization? Organization;
  ExtraCharge? ExtraCharge;
  Facility? Facility;
  IncludedService? IncludedService;
  User? Owner;
  List<Agent>? Agent;
  List<Analytics>? Analytics;
  List<Organization>? AgencyRelations;
  List<Organization>? OrganizationAgencies;
  List<CommunicationLog>? CommunicationLog;
  List<ComplianceRecord>? ComplianceRecord;
  List<Contract>? Contract;
  List<Expense>? Expense;
  List<Guest>? Guest;
  List<Hashtag>? Hashtag;
  List<Language>? Language;
  List<Location>? location;
  List<Mention>? Mention;
  List<Notification>? Notification;
  List<Photo>? Photo;
  List<Post>? Post;
  List<Property>? Property;
  List<Report>? Report;
  List<Reservation>? Reservation;
  List<Review>? Review;
  List<Subscription>? Subscription;
  List<Task>? Task;
  List<User>? User;
  List<PropertyPromotion>? PropertyPromotion;
  int? $AgentCount;
  int? $AnalyticsCount;
  int? $AgencyRelationsCount;
  int? $OrganizationAgenciesCount;
  int? $CommunicationLogCount;
  int? $ComplianceRecordCount;
  int? $ContractCount;
  int? $ExpenseCount;
  int? $GuestCount;
  int? $HashtagCount;
  int? $LanguageCount;
  int? $locationCount;
  int? $MentionCount;
  int? $NotificationCount;
  int? $PhotoCount;
  int? $PostCount;
  int? $PropertyCount;
  int? $ReportCount;
  int? $ReservationCount;
  int? $ReviewCount;
  int? $SubscriptionCount;
  int? $TaskCount;
  int? $UserCount;
  int? $PropertyPromotionCount;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  Agency({
    this.id,
    this.organizationId,
    this.name,
    this.description,
    this.email,
    this.phoneNumber,
    this.address,
    this.website,
    this.logoUrl,
    this.status = SharedStatus.PENDING,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.facilityId,
    this.includedServiceId,
    this.extraChargeId,
    this.isActive = true,
    this.ownerId,
    required this.settings,
    this.theme,
    this.externalId,
    required this.integration,
    this.totalProperties,
    this.totalAgents,
    this.establishedYear,
    this.licenseNumber,
    this.commissionRate,
    this.taxIdentificationNumber,
    this.taxJurisdiction,
    required this.metrics,
    required this.taxConfiguration,
    this.Organization,
    this.ExtraCharge,
    this.Facility,
    this.IncludedService,
    this.Owner,
    this.Agent,
    this.Analytics,
    this.AgencyRelations,
    this.OrganizationAgencies,
    this.CommunicationLog,
    this.ComplianceRecord,
    this.Contract,
    this.Expense,
    this.Guest,
    this.Hashtag,
    this.Language,
    this.location,
    this.Mention,
    this.Notification,
    this.Photo,
    this.Post,
    this.Property,
    this.Report,
    this.Reservation,
    this.Review,
    this.Subscription,
    this.Task,
    this.User,
    this.PropertyPromotion,
    this.$AgentCount,
    this.$AnalyticsCount,
    this.$AgencyRelationsCount,
    this.$OrganizationAgenciesCount,
    this.$CommunicationLogCount,
    this.$ComplianceRecordCount,
    this.$ContractCount,
    this.$ExpenseCount,
    this.$GuestCount,
    this.$HashtagCount,
    this.$LanguageCount,
    this.$locationCount,
    this.$MentionCount,
    this.$NotificationCount,
    this.$PhotoCount,
    this.$PostCount,
    this.$PropertyCount,
    this.$ReportCount,
    this.$ReservationCount,
    this.$ReviewCount,
    this.$SubscriptionCount,
    this.$TaskCount,
    this.$UserCount,
    this.$PropertyPromotionCount,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<Agency, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "organizationId": (m) => m.organizationId,
    "name": (m) => m.name,
    "description": (m) => m.description,
    "email": (m) => m.email,
    "phoneNumber": (m) => m.phoneNumber,
    "address": (m) => m.address,
    "website": (m) => m.website,
    "logoUrl": (m) => m.logoUrl,
    "status": (m) => m.status,
    "createdAt": (m) => m.createdAt,
    "deletedAt": (m) => m.deletedAt,
    "updatedAt": (m) => m.updatedAt,
    "facilityId": (m) => m.facilityId,
    "includedServiceId": (m) => m.includedServiceId,
    "extraChargeId": (m) => m.extraChargeId,
    "isActive": (m) => m.isActive,
    "ownerId": (m) => m.ownerId,
    "settings": (m) => m.settings,
    "theme": (m) => m.theme,
    "externalId": (m) => m.externalId,
    "integration": (m) => m.integration,
    "totalProperties": (m) => m.totalProperties,
    "totalAgents": (m) => m.totalAgents,
    "establishedYear": (m) => m.establishedYear,
    "licenseNumber": (m) => m.licenseNumber,
    "commissionRate": (m) => m.commissionRate,
    "taxIdentificationNumber": (m) => m.taxIdentificationNumber,
    "taxJurisdiction": (m) => m.taxJurisdiction,
    "metrics": (m) => m.metrics,
    "taxConfiguration": (m) => m.taxConfiguration,
    "Organization": (m) => m.Organization,
    "ExtraCharge": (m) => m.ExtraCharge,
    "Facility": (m) => m.Facility,
    "IncludedService": (m) => m.IncludedService,
    "Owner": (m) => m.Owner,
    "Agent": (m) => m.Agent,
    "Analytics": (m) => m.Analytics,
    "AgencyRelations": (m) => m.AgencyRelations,
    "OrganizationAgencies": (m) => m.OrganizationAgencies,
    "CommunicationLog": (m) => m.CommunicationLog,
    "ComplianceRecord": (m) => m.ComplianceRecord,
    "Contract": (m) => m.Contract,
    "Expense": (m) => m.Expense,
    "Guest": (m) => m.Guest,
    "Hashtag": (m) => m.Hashtag,
    "Language": (m) => m.Language,
    "location": (m) => m.location,
    "Mention": (m) => m.Mention,
    "Notification": (m) => m.Notification,
    "Photo": (m) => m.Photo,
    "Post": (m) => m.Post,
    "Property": (m) => m.Property,
    "Report": (m) => m.Report,
    "Reservation": (m) => m.Reservation,
    "Review": (m) => m.Review,
    "Subscription": (m) => m.Subscription,
    "Task": (m) => m.Task,
    "User": (m) => m.User,
    "PropertyPromotion": (m) => m.PropertyPromotion,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(Agency) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Agency');
    }
    return propFunction as V? Function(Agency);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory Agency.fromJson(JsonMap json) => Agency(
        id: json['id'] as String?,
        organizationId: json['organizationId'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        email: json['email'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        address: json['address'] as String?,
        website: json['website'] as String?,
        logoUrl: json['logoUrl'] as String?,
        status: json['status'] != null
            ? SharedStatus.fromJson(json['status'])
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        deletedAt: json['deletedAt'] != null
            ? DateTime.parse(json['deletedAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        facilityId: json['facilityId'] as String?,
        includedServiceId: json['includedServiceId'] as String?,
        extraChargeId: json['extraChargeId'] as String?,
        isActive: json['isActive'] as bool?,
        ownerId: json['ownerId'] as String?,
        settings: json['settings'] as dynamic,
        theme: json['theme'] as String?,
        externalId: json['externalId'] as String?,
        integration: json['integration'] as dynamic,
        totalProperties: int.tryParse(json['totalProperties'].toString()),
        totalAgents: int.tryParse(json['totalAgents'].toString()),
        establishedYear: int.tryParse(json['establishedYear'].toString()),
        licenseNumber: json['licenseNumber'] as String?,
        commissionRate: json['commissionRate']?.toDouble(),
        taxIdentificationNumber: json['taxIdentificationNumber'] as String?,
        taxJurisdiction: json['taxJurisdiction'] as String?,
        metrics: json['metrics'] as dynamic,
        taxConfiguration: json['taxConfiguration'] as dynamic,
        Organization: json['Organization'] != null
            ? Organization.fromJson(json['Organization'] as JsonMap)
            : null,
        ExtraCharge: json['ExtraCharge'] != null
            ? ExtraCharge.fromJson(json['ExtraCharge'] as JsonMap)
            : null,
        Facility: json['Facility'] != null
            ? Facility.fromJson(json['Facility'] as JsonMap)
            : null,
        IncludedService: json['IncludedService'] != null
            ? IncludedService.fromJson(json['IncludedService'] as JsonMap)
            : null,
        Owner: json['Owner'] != null
            ? User.fromJson(json['Owner'] as JsonMap)
            : null,
        Agent: json['Agent'] != null
            ? createModels<Agent>(
                (json['Agent'] as List).cast<JsonMap>(), Agent.fromJson)
            : null,
        Analytics: json['Analytics'] != null
            ? createModels<Analytics>(
                (json['Analytics'] as List).cast<JsonMap>(), Analytics.fromJson)
            : null,
        AgencyRelations: json['AgencyRelations'] != null
            ? createModels<Organization>(
                (json['AgencyRelations'] as List).cast<JsonMap>(),
                Organization.fromJson)
            : null,
        OrganizationAgencies: json['OrganizationAgencies'] != null
            ? createModels<Organization>(
                (json['OrganizationAgencies'] as List).cast<JsonMap>(),
                Organization.fromJson)
            : null,
        CommunicationLog: json['CommunicationLog'] != null
            ? createModels<CommunicationLog>(
                (json['CommunicationLog'] as List).cast<JsonMap>(),
                CommunicationLog.fromJson)
            : null,
        ComplianceRecord: json['ComplianceRecord'] != null
            ? createModels<ComplianceRecord>(
                (json['ComplianceRecord'] as List).cast<JsonMap>(),
                ComplianceRecord.fromJson)
            : null,
        Contract: json['Contract'] != null
            ? createModels<Contract>(
                (json['Contract'] as List).cast<JsonMap>(), Contract.fromJson)
            : null,
        Expense: json['Expense'] != null
            ? createModels<Expense>(
                (json['Expense'] as List).cast<JsonMap>(), Expense.fromJson)
            : null,
        Guest: json['Guest'] != null
            ? createModels<Guest>(
                (json['Guest'] as List).cast<JsonMap>(), Guest.fromJson)
            : null,
        Hashtag: json['Hashtag'] != null
            ? createModels<Hashtag>(
                (json['Hashtag'] as List).cast<JsonMap>(), Hashtag.fromJson)
            : null,
        Language: json['Language'] != null
            ? createModels<Language>(
                (json['Language'] as List).cast<JsonMap>(), Language.fromJson)
            : null,
        location: json['location'] != null
            ? createModels<Location>(
                (json['location'] as List).cast<JsonMap>(), Location.fromJson)
            : null,
        Mention: json['Mention'] != null
            ? createModels<Mention>(
                (json['Mention'] as List).cast<JsonMap>(), Mention.fromJson)
            : null,
        Notification: json['Notification'] != null
            ? createModels<Notification>(
                (json['Notification'] as List).cast<JsonMap>(),
                Notification.fromJson)
            : null,
        Photo: json['Photo'] != null
            ? createModels<Photo>(
                (json['Photo'] as List).cast<JsonMap>(), Photo.fromJson)
            : null,
        Post: json['Post'] != null
            ? createModels<Post>(
                (json['Post'] as List).cast<JsonMap>(), Post.fromJson)
            : null,
        Property: json['Property'] != null
            ? createModels<Property>(
                (json['Property'] as List).cast<JsonMap>(), Property.fromJson)
            : null,
        Report: json['Report'] != null
            ? createModels<Report>(
                (json['Report'] as List).cast<JsonMap>(), Report.fromJson)
            : null,
        Reservation: json['Reservation'] != null
            ? createModels<Reservation>(
                (json['Reservation'] as List).cast<JsonMap>(),
                Reservation.fromJson)
            : null,
        Review: json['Review'] != null
            ? createModels<Review>(
                (json['Review'] as List).cast<JsonMap>(), Review.fromJson)
            : null,
        Subscription: json['Subscription'] != null
            ? createModels<Subscription>(
                (json['Subscription'] as List).cast<JsonMap>(),
                Subscription.fromJson)
            : null,
        Task: json['Task'] != null
            ? createModels<Task>(
                (json['Task'] as List).cast<JsonMap>(), Task.fromJson)
            : null,
        User: json['User'] != null
            ? createModels<User>(
                (json['User'] as List).cast<JsonMap>(), User.fromJson)
            : null,
        PropertyPromotion: json['PropertyPromotion'] != null
            ? createModels<PropertyPromotion>(
                (json['PropertyPromotion'] as List).cast<JsonMap>(),
                PropertyPromotion.fromJson)
            : null,
        $AgentCount: json['_count']?['Agent'] as int?,
        $AnalyticsCount: json['_count']?['Analytics'] as int?,
        $AgencyRelationsCount: json['_count']?['AgencyRelations'] as int?,
        $OrganizationAgenciesCount:
            json['_count']?['OrganizationAgencies'] as int?,
        $CommunicationLogCount: json['_count']?['CommunicationLog'] as int?,
        $ComplianceRecordCount: json['_count']?['ComplianceRecord'] as int?,
        $ContractCount: json['_count']?['Contract'] as int?,
        $ExpenseCount: json['_count']?['Expense'] as int?,
        $GuestCount: json['_count']?['Guest'] as int?,
        $HashtagCount: json['_count']?['Hashtag'] as int?,
        $LanguageCount: json['_count']?['Language'] as int?,
        $locationCount: json['_count']?['location'] as int?,
        $MentionCount: json['_count']?['Mention'] as int?,
        $NotificationCount: json['_count']?['Notification'] as int?,
        $PhotoCount: json['_count']?['Photo'] as int?,
        $PostCount: json['_count']?['Post'] as int?,
        $PropertyCount: json['_count']?['Property'] as int?,
        $ReportCount: json['_count']?['Report'] as int?,
        $ReservationCount: json['_count']?['Reservation'] as int?,
        $ReviewCount: json['_count']?['Review'] as int?,
        $SubscriptionCount: json['_count']?['Subscription'] as int?,
        $TaskCount: json['_count']?['Task'] as int?,
        $UserCount: json['_count']?['User'] as int?,
        $PropertyPromotionCount: json['_count']?['PropertyPromotion'] as int?,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  Agency copyWith({
    Value<String?>? id,
    Value<String?>? organizationId,
    Value<String?>? name,
    Value<String?>? description,
    Value<String?>? email,
    Value<String?>? phoneNumber,
    Value<String?>? address,
    Value<String?>? website,
    Value<String?>? logoUrl,
    Value<SharedStatus?>? status,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? deletedAt,
    Value<DateTime?>? updatedAt,
    Value<String?>? facilityId,
    Value<String?>? includedServiceId,
    Value<String?>? extraChargeId,
    Value<bool?>? isActive,
    Value<String?>? ownerId,
    Value<dynamic>? settings,
    Value<String?>? theme,
    Value<String?>? externalId,
    Value<dynamic>? integration,
    Value<int?>? totalProperties,
    Value<int?>? totalAgents,
    Value<int?>? establishedYear,
    Value<String?>? licenseNumber,
    Value<double?>? commissionRate,
    Value<String?>? taxIdentificationNumber,
    Value<String?>? taxJurisdiction,
    Value<dynamic>? metrics,
    Value<dynamic>? taxConfiguration,
    Value<Organization?>? Organization,
    Value<ExtraCharge?>? ExtraCharge,
    Value<Facility?>? Facility,
    Value<IncludedService?>? IncludedService,
    Value<User?>? Owner,
    Value<List<Agent>?>? Agent,
    Value<List<Analytics>?>? Analytics,
    Value<List<Organization>?>? AgencyRelations,
    Value<List<Organization>?>? OrganizationAgencies,
    Value<List<CommunicationLog>?>? CommunicationLog,
    Value<List<ComplianceRecord>?>? ComplianceRecord,
    Value<List<Contract>?>? Contract,
    Value<List<Expense>?>? Expense,
    Value<List<Guest>?>? Guest,
    Value<List<Hashtag>?>? Hashtag,
    Value<List<Language>?>? Language,
    Value<List<Location>?>? location,
    Value<List<Mention>?>? Mention,
    Value<List<Notification>?>? Notification,
    Value<List<Photo>?>? Photo,
    Value<List<Post>?>? Post,
    Value<List<Property>?>? Property,
    Value<List<Report>?>? Report,
    Value<List<Reservation>?>? Reservation,
    Value<List<Review>?>? Review,
    Value<List<Subscription>?>? Subscription,
    Value<List<Task>?>? Task,
    Value<List<User>?>? User,
    Value<List<PropertyPromotion>?>? PropertyPromotion,
    int? $AgentCount,
    int? $AnalyticsCount,
    int? $AgencyRelationsCount,
    int? $OrganizationAgenciesCount,
    int? $CommunicationLogCount,
    int? $ComplianceRecordCount,
    int? $ContractCount,
    int? $ExpenseCount,
    int? $GuestCount,
    int? $HashtagCount,
    int? $LanguageCount,
    int? $locationCount,
    int? $MentionCount,
    int? $NotificationCount,
    int? $PhotoCount,
    int? $PostCount,
    int? $PropertyCount,
    int? $ReportCount,
    int? $ReservationCount,
    int? $ReviewCount,
    int? $SubscriptionCount,
    int? $TaskCount,
    int? $UserCount,
    int? $PropertyPromotionCount,
  }) {
    return Agency(
        id: id != null ? id.value : this.id,
        organizationId:
            organizationId != null ? organizationId.value : this.organizationId,
        name: name != null ? name.value : this.name,
        description: description != null ? description.value : this.description,
        email: email != null ? email.value : this.email,
        phoneNumber: phoneNumber != null ? phoneNumber.value : this.phoneNumber,
        address: address != null ? address.value : this.address,
        website: website != null ? website.value : this.website,
        logoUrl: logoUrl != null ? logoUrl.value : this.logoUrl,
        status: status != null ? status.value : this.status,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        facilityId: facilityId != null ? facilityId.value : this.facilityId,
        includedServiceId: includedServiceId != null
            ? includedServiceId.value
            : this.includedServiceId,
        extraChargeId:
            extraChargeId != null ? extraChargeId.value : this.extraChargeId,
        isActive: isActive != null ? isActive.value : this.isActive,
        ownerId: ownerId != null ? ownerId.value : this.ownerId,
        settings: settings != null ? settings.value : this.settings,
        theme: theme != null ? theme.value : this.theme,
        externalId: externalId != null ? externalId.value : this.externalId,
        integration: integration != null ? integration.value : this.integration,
        totalProperties: totalProperties != null
            ? totalProperties.value
            : this.totalProperties,
        totalAgents: totalAgents != null ? totalAgents.value : this.totalAgents,
        establishedYear: establishedYear != null
            ? establishedYear.value
            : this.establishedYear,
        licenseNumber:
            licenseNumber != null ? licenseNumber.value : this.licenseNumber,
        commissionRate:
            commissionRate != null ? commissionRate.value : this.commissionRate,
        taxIdentificationNumber: taxIdentificationNumber != null
            ? taxIdentificationNumber.value
            : this.taxIdentificationNumber,
        taxJurisdiction: taxJurisdiction != null
            ? taxJurisdiction.value
            : this.taxJurisdiction,
        metrics: metrics != null ? metrics.value : this.metrics,
        taxConfiguration: taxConfiguration != null
            ? taxConfiguration.value
            : this.taxConfiguration,
        Organization:
            Organization != null ? Organization.value : this.Organization,
        ExtraCharge: ExtraCharge != null ? ExtraCharge.value : this.ExtraCharge,
        Facility: Facility != null ? Facility.value : this.Facility,
        IncludedService: IncludedService != null
            ? IncludedService.value
            : this.IncludedService,
        Owner: Owner != null ? Owner.value : this.Owner,
        Agent: Agent != null ? Agent.value : this.Agent,
        Analytics: Analytics != null ? Analytics.value : this.Analytics,
        AgencyRelations: AgencyRelations != null
            ? AgencyRelations.value
            : this.AgencyRelations,
        OrganizationAgencies: OrganizationAgencies != null
            ? OrganizationAgencies.value
            : this.OrganizationAgencies,
        CommunicationLog: CommunicationLog != null
            ? CommunicationLog.value
            : this.CommunicationLog,
        ComplianceRecord: ComplianceRecord != null
            ? ComplianceRecord.value
            : this.ComplianceRecord,
        Contract: Contract != null ? Contract.value : this.Contract,
        Expense: Expense != null ? Expense.value : this.Expense,
        Guest: Guest != null ? Guest.value : this.Guest,
        Hashtag: Hashtag != null ? Hashtag.value : this.Hashtag,
        Language: Language != null ? Language.value : this.Language,
        location: location != null ? location.value : this.location,
        Mention: Mention != null ? Mention.value : this.Mention,
        Notification:
            Notification != null ? Notification.value : this.Notification,
        Photo: Photo != null ? Photo.value : this.Photo,
        Post: Post != null ? Post.value : this.Post,
        Property: Property != null ? Property.value : this.Property,
        Report: Report != null ? Report.value : this.Report,
        Reservation: Reservation != null ? Reservation.value : this.Reservation,
        Review: Review != null ? Review.value : this.Review,
        Subscription:
            Subscription != null ? Subscription.value : this.Subscription,
        Task: Task != null ? Task.value : this.Task,
        User: User != null ? User.value : this.User,
        PropertyPromotion: PropertyPromotion != null
            ? PropertyPromotion.value
            : this.PropertyPromotion,
        $AgentCount: $AgentCount ?? this.$AgentCount,
        $AnalyticsCount: $AnalyticsCount ?? this.$AnalyticsCount,
        $AgencyRelationsCount:
            $AgencyRelationsCount ?? this.$AgencyRelationsCount,
        $OrganizationAgenciesCount:
            $OrganizationAgenciesCount ?? this.$OrganizationAgenciesCount,
        $CommunicationLogCount:
            $CommunicationLogCount ?? this.$CommunicationLogCount,
        $ComplianceRecordCount:
            $ComplianceRecordCount ?? this.$ComplianceRecordCount,
        $ContractCount: $ContractCount ?? this.$ContractCount,
        $ExpenseCount: $ExpenseCount ?? this.$ExpenseCount,
        $GuestCount: $GuestCount ?? this.$GuestCount,
        $HashtagCount: $HashtagCount ?? this.$HashtagCount,
        $LanguageCount: $LanguageCount ?? this.$LanguageCount,
        $locationCount: $locationCount ?? this.$locationCount,
        $MentionCount: $MentionCount ?? this.$MentionCount,
        $NotificationCount: $NotificationCount ?? this.$NotificationCount,
        $PhotoCount: $PhotoCount ?? this.$PhotoCount,
        $PostCount: $PostCount ?? this.$PostCount,
        $PropertyCount: $PropertyCount ?? this.$PropertyCount,
        $ReportCount: $ReportCount ?? this.$ReportCount,
        $ReservationCount: $ReservationCount ?? this.$ReservationCount,
        $ReviewCount: $ReviewCount ?? this.$ReviewCount,
        $SubscriptionCount: $SubscriptionCount ?? this.$SubscriptionCount,
        $TaskCount: $TaskCount ?? this.$TaskCount,
        $UserCount: $UserCount ?? this.$UserCount,
        $PropertyPromotionCount:
            $PropertyPromotionCount ?? this.$PropertyPromotionCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  Agency copyWithInstanceValues(Agency agency) {
    return Agency(
        id: agency.id ?? id,
        organizationId: agency.organizationId ?? organizationId,
        name: agency.name ?? name,
        description: agency.description ?? description,
        email: agency.email ?? email,
        phoneNumber: agency.phoneNumber ?? phoneNumber,
        address: agency.address ?? address,
        website: agency.website ?? website,
        logoUrl: agency.logoUrl ?? logoUrl,
        status: agency.status ?? status,
        createdAt: agency.createdAt ?? createdAt,
        deletedAt: agency.deletedAt ?? deletedAt,
        updatedAt: agency.updatedAt ?? updatedAt,
        facilityId: agency.facilityId ?? facilityId,
        includedServiceId: agency.includedServiceId ?? includedServiceId,
        extraChargeId: agency.extraChargeId ?? extraChargeId,
        isActive: agency.isActive ?? isActive,
        ownerId: agency.ownerId ?? ownerId,
        settings: agency.settings ?? settings,
        theme: agency.theme ?? theme,
        externalId: agency.externalId ?? externalId,
        integration: agency.integration ?? integration,
        totalProperties: agency.totalProperties ?? totalProperties,
        totalAgents: agency.totalAgents ?? totalAgents,
        establishedYear: agency.establishedYear ?? establishedYear,
        licenseNumber: agency.licenseNumber ?? licenseNumber,
        commissionRate: agency.commissionRate ?? commissionRate,
        taxIdentificationNumber:
            agency.taxIdentificationNumber ?? taxIdentificationNumber,
        taxJurisdiction: agency.taxJurisdiction ?? taxJurisdiction,
        metrics: agency.metrics ?? metrics,
        taxConfiguration: agency.taxConfiguration ?? taxConfiguration,
        Organization: agency.Organization ?? Organization,
        ExtraCharge: agency.ExtraCharge ?? ExtraCharge,
        Facility: agency.Facility ?? Facility,
        IncludedService: agency.IncludedService ?? IncludedService,
        Owner: agency.Owner ?? Owner,
        Agent: agency.Agent ?? Agent,
        Analytics: agency.Analytics ?? Analytics,
        AgencyRelations: agency.AgencyRelations ?? AgencyRelations,
        OrganizationAgencies:
            agency.OrganizationAgencies ?? OrganizationAgencies,
        CommunicationLog: agency.CommunicationLog ?? CommunicationLog,
        ComplianceRecord: agency.ComplianceRecord ?? ComplianceRecord,
        Contract: agency.Contract ?? Contract,
        Expense: agency.Expense ?? Expense,
        Guest: agency.Guest ?? Guest,
        Hashtag: agency.Hashtag ?? Hashtag,
        Language: agency.Language ?? Language,
        location: agency.location ?? location,
        Mention: agency.Mention ?? Mention,
        Notification: agency.Notification ?? Notification,
        Photo: agency.Photo ?? Photo,
        Post: agency.Post ?? Post,
        Property: agency.Property ?? Property,
        Report: agency.Report ?? Report,
        Reservation: agency.Reservation ?? Reservation,
        Review: agency.Review ?? Review,
        Subscription: agency.Subscription ?? Subscription,
        Task: agency.Task ?? Task,
        User: agency.User ?? User,
        PropertyPromotion: agency.PropertyPromotion ?? PropertyPromotion,
        $AgentCount: agency.$AgentCount ?? $AgentCount,
        $AnalyticsCount: agency.$AnalyticsCount ?? $AnalyticsCount,
        $AgencyRelationsCount:
            agency.$AgencyRelationsCount ?? $AgencyRelationsCount,
        $OrganizationAgenciesCount:
            agency.$OrganizationAgenciesCount ?? $OrganizationAgenciesCount,
        $CommunicationLogCount:
            agency.$CommunicationLogCount ?? $CommunicationLogCount,
        $ComplianceRecordCount:
            agency.$ComplianceRecordCount ?? $ComplianceRecordCount,
        $ContractCount: agency.$ContractCount ?? $ContractCount,
        $ExpenseCount: agency.$ExpenseCount ?? $ExpenseCount,
        $GuestCount: agency.$GuestCount ?? $GuestCount,
        $HashtagCount: agency.$HashtagCount ?? $HashtagCount,
        $LanguageCount: agency.$LanguageCount ?? $LanguageCount,
        $locationCount: agency.$locationCount ?? $locationCount,
        $MentionCount: agency.$MentionCount ?? $MentionCount,
        $NotificationCount: agency.$NotificationCount ?? $NotificationCount,
        $PhotoCount: agency.$PhotoCount ?? $PhotoCount,
        $PostCount: agency.$PostCount ?? $PostCount,
        $PropertyCount: agency.$PropertyCount ?? $PropertyCount,
        $ReportCount: agency.$ReportCount ?? $ReportCount,
        $ReservationCount: agency.$ReservationCount ?? $ReservationCount,
        $ReviewCount: agency.$ReviewCount ?? $ReviewCount,
        $SubscriptionCount: agency.$SubscriptionCount ?? $SubscriptionCount,
        $TaskCount: agency.$TaskCount ?? $TaskCount,
        $UserCount: agency.$UserCount ?? $UserCount,
        $PropertyPromotionCount:
            agency.$PropertyPromotionCount ?? $PropertyPromotionCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  Agency mergeWithInstanceValues(Agency agency) {
    return Agency(
        id: agency.$assignedFields.contains('id') ? agency.id : id,
        organizationId: agency.$assignedFields.contains('organizationId')
            ? agency.organizationId
            : organizationId,
        name: agency.$assignedFields.contains('name') ? agency.name : name,
        description: agency.$assignedFields.contains('description')
            ? agency.description
            : description,
        email: agency.$assignedFields.contains('email') ? agency.email : email,
        phoneNumber: agency.$assignedFields.contains('phoneNumber')
            ? agency.phoneNumber
            : phoneNumber,
        address: agency.$assignedFields.contains('address')
            ? agency.address
            : address,
        website: agency.$assignedFields.contains('website')
            ? agency.website
            : website,
        logoUrl: agency.$assignedFields.contains('logoUrl')
            ? agency.logoUrl
            : logoUrl,
        status:
            agency.$assignedFields.contains('status') ? agency.status : status,
        createdAt: agency.$assignedFields.contains('createdAt')
            ? agency.createdAt
            : createdAt,
        deletedAt: agency.$assignedFields.contains('deletedAt')
            ? agency.deletedAt
            : deletedAt,
        updatedAt: agency.$assignedFields.contains('updatedAt')
            ? agency.updatedAt
            : updatedAt,
        facilityId: agency.$assignedFields.contains('facilityId')
            ? agency.facilityId
            : facilityId,
        includedServiceId: agency.$assignedFields.contains('includedServiceId')
            ? agency.includedServiceId
            : includedServiceId,
        extraChargeId: agency.$assignedFields.contains('extraChargeId')
            ? agency.extraChargeId
            : extraChargeId,
        isActive: agency.$assignedFields.contains('isActive')
            ? agency.isActive
            : isActive,
        ownerId: agency.$assignedFields.contains('ownerId')
            ? agency.ownerId
            : ownerId,
        settings: agency.$assignedFields.contains('settings')
            ? agency.settings
            : settings,
        theme: agency.$assignedFields.contains('theme') ? agency.theme : theme,
        externalId: agency.$assignedFields.contains('externalId')
            ? agency.externalId
            : externalId,
        integration: agency.$assignedFields.contains('integration')
            ? agency.integration
            : integration,
        totalProperties: agency.$assignedFields.contains('totalProperties')
            ? agency.totalProperties
            : totalProperties,
        totalAgents: agency.$assignedFields.contains('totalAgents')
            ? agency.totalAgents
            : totalAgents,
        establishedYear: agency.$assignedFields.contains('establishedYear')
            ? agency.establishedYear
            : establishedYear,
        licenseNumber: agency.$assignedFields.contains('licenseNumber')
            ? agency.licenseNumber
            : licenseNumber,
        commissionRate: agency.$assignedFields.contains('commissionRate')
            ? agency.commissionRate
            : commissionRate,
        taxIdentificationNumber: agency.$assignedFields.contains('taxIdentificationNumber')
            ? agency.taxIdentificationNumber
            : taxIdentificationNumber,
        taxJurisdiction: agency.$assignedFields.contains('taxJurisdiction')
            ? agency.taxJurisdiction
            : taxJurisdiction,
        metrics: agency.$assignedFields.contains('metrics')
            ? agency.metrics
            : metrics,
        taxConfiguration: agency.$assignedFields.contains('taxConfiguration')
            ? agency.taxConfiguration
            : taxConfiguration,
        Organization: agency.$assignedFields.contains('Organization')
            ? agency.Organization
            : Organization,
        ExtraCharge: agency.$assignedFields.contains('ExtraCharge')
            ? agency.ExtraCharge
            : ExtraCharge,
        Facility: agency.$assignedFields.contains('Facility')
            ? agency.Facility
            : Facility,
        IncludedService: agency.$assignedFields.contains('IncludedService')
            ? agency.IncludedService
            : IncludedService,
        Owner: agency.$assignedFields.contains('Owner') ? agency.Owner : Owner,
        Agent: (agency.$assignedFields.contains('Agent') && agency.Agent != null)
            ? mergeModelLists(Agent, agency.Agent)
            : Agent,
        Analytics: (agency.$assignedFields.contains('Analytics') && agency.Analytics != null)
            ? mergeModelLists(Analytics, agency.Analytics)
            : Analytics,
        AgencyRelations: (agency.$assignedFields.contains('AgencyRelations') && agency.AgencyRelations != null)
            ? mergeModelLists(AgencyRelations, agency.AgencyRelations)
            : AgencyRelations,
        OrganizationAgencies: (agency.$assignedFields.contains('OrganizationAgencies') &&
                agency.OrganizationAgencies != null)
            ? mergeModelLists(OrganizationAgencies, agency.OrganizationAgencies)
            : OrganizationAgencies,
        CommunicationLog: (agency.$assignedFields.contains('CommunicationLog') && agency.CommunicationLog != null)
            ? mergeModelLists(CommunicationLog, agency.CommunicationLog)
            : CommunicationLog,
        ComplianceRecord: (agency.$assignedFields.contains('ComplianceRecord') && agency.ComplianceRecord != null) ? mergeModelLists(ComplianceRecord, agency.ComplianceRecord) : ComplianceRecord,
        Contract: (agency.$assignedFields.contains('Contract') && agency.Contract != null) ? mergeModelLists(Contract, agency.Contract) : Contract,
        Expense: (agency.$assignedFields.contains('Expense') && agency.Expense != null) ? mergeModelLists(Expense, agency.Expense) : Expense,
        Guest: (agency.$assignedFields.contains('Guest') && agency.Guest != null) ? mergeModelLists(Guest, agency.Guest) : Guest,
        Hashtag: (agency.$assignedFields.contains('Hashtag') && agency.Hashtag != null) ? mergeModelLists(Hashtag, agency.Hashtag) : Hashtag,
        Language: (agency.$assignedFields.contains('Language') && agency.Language != null) ? mergeModelLists(Language, agency.Language) : Language,
        location: (agency.$assignedFields.contains('location') && agency.location != null) ? mergeModelLists(location, agency.location) : location,
        Mention: (agency.$assignedFields.contains('Mention') && agency.Mention != null) ? mergeModelLists(Mention, agency.Mention) : Mention,
        Notification: (agency.$assignedFields.contains('Notification') && agency.Notification != null) ? mergeModelLists(Notification, agency.Notification) : Notification,
        Photo: (agency.$assignedFields.contains('Photo') && agency.Photo != null) ? mergeModelLists(Photo, agency.Photo) : Photo,
        Post: (agency.$assignedFields.contains('Post') && agency.Post != null) ? mergeModelLists(Post, agency.Post) : Post,
        Property: (agency.$assignedFields.contains('Property') && agency.Property != null) ? mergeModelLists(Property, agency.Property) : Property,
        Report: (agency.$assignedFields.contains('Report') && agency.Report != null) ? mergeModelLists(Report, agency.Report) : Report,
        Reservation: (agency.$assignedFields.contains('Reservation') && agency.Reservation != null) ? mergeModelLists(Reservation, agency.Reservation) : Reservation,
        Review: (agency.$assignedFields.contains('Review') && agency.Review != null) ? mergeModelLists(Review, agency.Review) : Review,
        Subscription: (agency.$assignedFields.contains('Subscription') && agency.Subscription != null) ? mergeModelLists(Subscription, agency.Subscription) : Subscription,
        Task: (agency.$assignedFields.contains('Task') && agency.Task != null) ? mergeModelLists(Task, agency.Task) : Task,
        User: (agency.$assignedFields.contains('User') && agency.User != null) ? mergeModelLists(User, agency.User) : User,
        PropertyPromotion: (agency.$assignedFields.contains('PropertyPromotion') && agency.PropertyPromotion != null) ? mergeModelLists(PropertyPromotion, agency.PropertyPromotion) : PropertyPromotion,
        $AgentCount: agency.$AgentCount ?? $AgentCount,
        $AnalyticsCount: agency.$AnalyticsCount ?? $AnalyticsCount,
        $AgencyRelationsCount: agency.$AgencyRelationsCount ?? $AgencyRelationsCount,
        $OrganizationAgenciesCount: agency.$OrganizationAgenciesCount ?? $OrganizationAgenciesCount,
        $CommunicationLogCount: agency.$CommunicationLogCount ?? $CommunicationLogCount,
        $ComplianceRecordCount: agency.$ComplianceRecordCount ?? $ComplianceRecordCount,
        $ContractCount: agency.$ContractCount ?? $ContractCount,
        $ExpenseCount: agency.$ExpenseCount ?? $ExpenseCount,
        $GuestCount: agency.$GuestCount ?? $GuestCount,
        $HashtagCount: agency.$HashtagCount ?? $HashtagCount,
        $LanguageCount: agency.$LanguageCount ?? $LanguageCount,
        $locationCount: agency.$locationCount ?? $locationCount,
        $MentionCount: agency.$MentionCount ?? $MentionCount,
        $NotificationCount: agency.$NotificationCount ?? $NotificationCount,
        $PhotoCount: agency.$PhotoCount ?? $PhotoCount,
        $PostCount: agency.$PostCount ?? $PostCount,
        $PropertyCount: agency.$PropertyCount ?? $PropertyCount,
        $ReportCount: agency.$ReportCount ?? $ReportCount,
        $ReservationCount: agency.$ReservationCount ?? $ReservationCount,
        $ReviewCount: agency.$ReviewCount ?? $ReviewCount,
        $SubscriptionCount: agency.$SubscriptionCount ?? $SubscriptionCount,
        $TaskCount: agency.$TaskCount ?? $TaskCount,
        $UserCount: agency.$UserCount ?? $UserCount,
        $PropertyPromotionCount: agency.$PropertyPromotionCount ?? $PropertyPromotionCount);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  Agency updateWithInstanceValues(Agency agency) {
    if (agency.$assignedFields.contains('id')) {
      id = agency.id;
    }
    if (agency.$assignedFields.contains('organizationId')) {
      organizationId = agency.organizationId;
    }
    if (agency.$assignedFields.contains('name')) {
      name = agency.name;
    }
    if (agency.$assignedFields.contains('description')) {
      description = agency.description;
    }
    if (agency.$assignedFields.contains('email')) {
      email = agency.email;
    }
    if (agency.$assignedFields.contains('phoneNumber')) {
      phoneNumber = agency.phoneNumber;
    }
    if (agency.$assignedFields.contains('address')) {
      address = agency.address;
    }
    if (agency.$assignedFields.contains('website')) {
      website = agency.website;
    }
    if (agency.$assignedFields.contains('logoUrl')) {
      logoUrl = agency.logoUrl;
    }
    if (agency.$assignedFields.contains('status')) {
      status = agency.status;
    }
    if (agency.$assignedFields.contains('createdAt')) {
      createdAt = agency.createdAt;
    }
    if (agency.$assignedFields.contains('deletedAt')) {
      deletedAt = agency.deletedAt;
    }
    if (agency.$assignedFields.contains('updatedAt')) {
      updatedAt = agency.updatedAt;
    }
    if (agency.$assignedFields.contains('facilityId')) {
      facilityId = agency.facilityId;
    }
    if (agency.$assignedFields.contains('includedServiceId')) {
      includedServiceId = agency.includedServiceId;
    }
    if (agency.$assignedFields.contains('extraChargeId')) {
      extraChargeId = agency.extraChargeId;
    }
    if (agency.$assignedFields.contains('isActive')) {
      isActive = agency.isActive;
    }
    if (agency.$assignedFields.contains('ownerId')) {
      ownerId = agency.ownerId;
    }
    if (agency.$assignedFields.contains('settings')) {
      settings = agency.settings;
    }
    if (agency.$assignedFields.contains('theme')) {
      theme = agency.theme;
    }
    if (agency.$assignedFields.contains('externalId')) {
      externalId = agency.externalId;
    }
    if (agency.$assignedFields.contains('integration')) {
      integration = agency.integration;
    }
    if (agency.$assignedFields.contains('totalProperties')) {
      totalProperties = agency.totalProperties;
    }
    if (agency.$assignedFields.contains('totalAgents')) {
      totalAgents = agency.totalAgents;
    }
    if (agency.$assignedFields.contains('establishedYear')) {
      establishedYear = agency.establishedYear;
    }
    if (agency.$assignedFields.contains('licenseNumber')) {
      licenseNumber = agency.licenseNumber;
    }
    if (agency.$assignedFields.contains('commissionRate')) {
      commissionRate = agency.commissionRate;
    }
    if (agency.$assignedFields.contains('taxIdentificationNumber')) {
      taxIdentificationNumber = agency.taxIdentificationNumber;
    }
    if (agency.$assignedFields.contains('taxJurisdiction')) {
      taxJurisdiction = agency.taxJurisdiction;
    }
    if (agency.$assignedFields.contains('metrics')) {
      metrics = agency.metrics;
    }
    if (agency.$assignedFields.contains('taxConfiguration')) {
      taxConfiguration = agency.taxConfiguration;
    }
    if (agency.$assignedFields.contains('Organization')) {
      Organization = agency.Organization;
    }
    if (agency.$assignedFields.contains('ExtraCharge')) {
      ExtraCharge = agency.ExtraCharge;
    }
    if (agency.$assignedFields.contains('Facility')) {
      Facility = agency.Facility;
    }
    if (agency.$assignedFields.contains('IncludedService')) {
      IncludedService = agency.IncludedService;
    }
    if (agency.$assignedFields.contains('Owner')) {
      Owner = agency.Owner;
    }
    if (agency.$assignedFields.contains('Agent') && agency.Agent != null) {
      Agent = mergeModelLists(Agent, agency.Agent);
    }
    if (agency.$assignedFields.contains('Analytics') &&
        agency.Analytics != null) {
      Analytics = mergeModelLists(Analytics, agency.Analytics);
    }
    if (agency.$assignedFields.contains('AgencyRelations') &&
        agency.AgencyRelations != null) {
      AgencyRelations =
          mergeModelLists(AgencyRelations, agency.AgencyRelations);
    }
    if (agency.$assignedFields.contains('OrganizationAgencies') &&
        agency.OrganizationAgencies != null) {
      OrganizationAgencies =
          mergeModelLists(OrganizationAgencies, agency.OrganizationAgencies);
    }
    if (agency.$assignedFields.contains('CommunicationLog') &&
        agency.CommunicationLog != null) {
      CommunicationLog =
          mergeModelLists(CommunicationLog, agency.CommunicationLog);
    }
    if (agency.$assignedFields.contains('ComplianceRecord') &&
        agency.ComplianceRecord != null) {
      ComplianceRecord =
          mergeModelLists(ComplianceRecord, agency.ComplianceRecord);
    }
    if (agency.$assignedFields.contains('Contract') &&
        agency.Contract != null) {
      Contract = mergeModelLists(Contract, agency.Contract);
    }
    if (agency.$assignedFields.contains('Expense') && agency.Expense != null) {
      Expense = mergeModelLists(Expense, agency.Expense);
    }
    if (agency.$assignedFields.contains('Guest') && agency.Guest != null) {
      Guest = mergeModelLists(Guest, agency.Guest);
    }
    if (agency.$assignedFields.contains('Hashtag') && agency.Hashtag != null) {
      Hashtag = mergeModelLists(Hashtag, agency.Hashtag);
    }
    if (agency.$assignedFields.contains('Language') &&
        agency.Language != null) {
      Language = mergeModelLists(Language, agency.Language);
    }
    if (agency.$assignedFields.contains('location') &&
        agency.location != null) {
      location = mergeModelLists(location, agency.location);
    }
    if (agency.$assignedFields.contains('Mention') && agency.Mention != null) {
      Mention = mergeModelLists(Mention, agency.Mention);
    }
    if (agency.$assignedFields.contains('Notification') &&
        agency.Notification != null) {
      Notification = mergeModelLists(Notification, agency.Notification);
    }
    if (agency.$assignedFields.contains('Photo') && agency.Photo != null) {
      Photo = mergeModelLists(Photo, agency.Photo);
    }
    if (agency.$assignedFields.contains('Post') && agency.Post != null) {
      Post = mergeModelLists(Post, agency.Post);
    }
    if (agency.$assignedFields.contains('Property') &&
        agency.Property != null) {
      Property = mergeModelLists(Property, agency.Property);
    }
    if (agency.$assignedFields.contains('Report') && agency.Report != null) {
      Report = mergeModelLists(Report, agency.Report);
    }
    if (agency.$assignedFields.contains('Reservation') &&
        agency.Reservation != null) {
      Reservation = mergeModelLists(Reservation, agency.Reservation);
    }
    if (agency.$assignedFields.contains('Review') && agency.Review != null) {
      Review = mergeModelLists(Review, agency.Review);
    }
    if (agency.$assignedFields.contains('Subscription') &&
        agency.Subscription != null) {
      Subscription = mergeModelLists(Subscription, agency.Subscription);
    }
    if (agency.$assignedFields.contains('Task') && agency.Task != null) {
      Task = mergeModelLists(Task, agency.Task);
    }
    if (agency.$assignedFields.contains('User') && agency.User != null) {
      User = mergeModelLists(User, agency.User);
    }
    if (agency.$assignedFields.contains('PropertyPromotion') &&
        agency.PropertyPromotion != null) {
      PropertyPromotion =
          mergeModelLists(PropertyPromotion, agency.PropertyPromotion);
    }
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
        ? {...?serializedTypes, 'Agency'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (address != null) 'address': address,
      if (website != null) 'website': website,
      if (logoUrl != null) 'logoUrl': logoUrl,
      if (status != null) 'status': status?.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
      if (facilityId != null) 'facilityId': facilityId,
      if (includedServiceId != null) 'includedServiceId': includedServiceId,
      if (extraChargeId != null) 'extraChargeId': extraChargeId,
      if (isActive != null) 'isActive': isActive,
      if (ownerId != null) 'ownerId': ownerId,
      if (settings != null) 'settings': settings,
      if (theme != null) 'theme': theme,
      if (externalId != null) 'externalId': externalId,
      if (integration != null) 'integration': integration,
      if (totalProperties != null) 'totalProperties': totalProperties,
      if (totalAgents != null) 'totalAgents': totalAgents,
      if (establishedYear != null) 'establishedYear': establishedYear,
      if (licenseNumber != null) 'licenseNumber': licenseNumber,
      if (commissionRate != null) 'commissionRate': commissionRate,
      if (taxIdentificationNumber != null)
        'taxIdentificationNumber': taxIdentificationNumber,
      if (taxJurisdiction != null) 'taxJurisdiction': taxJurisdiction,
      if (metrics != null) 'metrics': metrics,
      if (taxConfiguration != null) 'taxConfiguration': taxConfiguration,
      if (Organization != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'Organization': Organization?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (ExtraCharge != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('ExtraCharge')))
        'ExtraCharge': ExtraCharge?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (Facility != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Facility')))
        'Facility': Facility?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (IncludedService != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('IncludedService')))
        'IncludedService': IncludedService?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (Owner != null &&
          (!preventCircularSerialization || !serializedModels.contains('User')))
        'Owner': Owner?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (Agent != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Agent')))
        'Agent': Agent?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Analytics != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Analytics')))
        'Analytics': Analytics?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (AgencyRelations != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'AgencyRelations': AgencyRelations?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (OrganizationAgencies != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'OrganizationAgencies': OrganizationAgencies?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (CommunicationLog != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('CommunicationLog')))
        'CommunicationLog': CommunicationLog?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (ComplianceRecord != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('ComplianceRecord')))
        'ComplianceRecord': ComplianceRecord?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Contract != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Contract')))
        'Contract': Contract?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Expense != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Expense')))
        'Expense': Expense?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Guest != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Guest')))
        'Guest': Guest?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Hashtag != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Hashtag')))
        'Hashtag': Hashtag?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Language != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Language')))
        'Language': Language?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (location != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Location')))
        'location': location
            ?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Mention != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Mention')))
        'Mention': Mention?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Notification != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Notification')))
        'Notification': Notification?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Photo != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Photo')))
        'Photo': Photo?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Post != null &&
          (!preventCircularSerialization || !serializedModels.contains('Post')))
        'Post': Post?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Property != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Property')))
        'Property': Property?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Report != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Report')))
        'Report': Report?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Reservation != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Reservation')))
        'Reservation': Reservation?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Review != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Review')))
        'Review': Review?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Subscription != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Subscription')))
        'Subscription': Subscription?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (Task != null &&
          (!preventCircularSerialization || !serializedModels.contains('Task')))
        'Task': Task?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (User != null &&
          (!preventCircularSerialization || !serializedModels.contains('User')))
        'User': User?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (PropertyPromotion != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('PropertyPromotion')))
        'PropertyPromotion': PropertyPromotion?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if ($AgentCount != null ||
          $AnalyticsCount != null ||
          $AgencyRelationsCount != null ||
          $OrganizationAgenciesCount != null ||
          $CommunicationLogCount != null ||
          $ComplianceRecordCount != null ||
          $ContractCount != null ||
          $ExpenseCount != null ||
          $GuestCount != null ||
          $HashtagCount != null ||
          $LanguageCount != null ||
          $locationCount != null ||
          $MentionCount != null ||
          $NotificationCount != null ||
          $PhotoCount != null ||
          $PostCount != null ||
          $PropertyCount != null ||
          $ReportCount != null ||
          $ReservationCount != null ||
          $ReviewCount != null ||
          $SubscriptionCount != null ||
          $TaskCount != null ||
          $UserCount != null ||
          $PropertyPromotionCount != null)
        '_count': {
          if ($AgentCount != null) 'Agent': $AgentCount,
          if ($AnalyticsCount != null) 'Analytics': $AnalyticsCount,
          if ($AgencyRelationsCount != null)
            'AgencyRelations': $AgencyRelationsCount,
          if ($OrganizationAgenciesCount != null)
            'OrganizationAgencies': $OrganizationAgenciesCount,
          if ($CommunicationLogCount != null)
            'CommunicationLog': $CommunicationLogCount,
          if ($ComplianceRecordCount != null)
            'ComplianceRecord': $ComplianceRecordCount,
          if ($ContractCount != null) 'Contract': $ContractCount,
          if ($ExpenseCount != null) 'Expense': $ExpenseCount,
          if ($GuestCount != null) 'Guest': $GuestCount,
          if ($HashtagCount != null) 'Hashtag': $HashtagCount,
          if ($LanguageCount != null) 'Language': $LanguageCount,
          if ($locationCount != null) 'location': $locationCount,
          if ($MentionCount != null) 'Mention': $MentionCount,
          if ($NotificationCount != null) 'Notification': $NotificationCount,
          if ($PhotoCount != null) 'Photo': $PhotoCount,
          if ($PostCount != null) 'Post': $PostCount,
          if ($PropertyCount != null) 'Property': $PropertyCount,
          if ($ReportCount != null) 'Report': $ReportCount,
          if ($ReservationCount != null) 'Reservation': $ReservationCount,
          if ($ReviewCount != null) 'Review': $ReviewCount,
          if ($SubscriptionCount != null) 'Subscription': $SubscriptionCount,
          if ($TaskCount != null) 'Task': $TaskCount,
          if ($UserCount != null) 'User': $UserCount,
          if ($PropertyPromotionCount != null)
            'PropertyPromotion': $PropertyPromotionCount,
        },
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Agency && runtimeType == other.runtimeType && $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
