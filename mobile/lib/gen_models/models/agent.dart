
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'shared_status.dart';
import 'agent_specialities.dart';
import 'agency.dart';
import 'location.dart';
import 'user.dart';
import 'analytics.dart';
import 'compliance_record.dart';
import 'language.dart';
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


class Agent implements PrismaModel<String, Agent> , Id<String> {
    @override
String? id;
	String? name;
	String? email;
	String? phoneNumber;
	String? bio;
	String? locationId;
	String? address;
	String? website;
	String? logoUrl;
	SharedStatus? status;
	DateTime? createdAt;
	DateTime? deletedAt;
	DateTime? updatedAt;
	String? agencyId;
	String? licenseNumber;
	double? commissionRate;
	List<String>? specialties;
	List<String>? serviceAreas;
	int? yearsOfExperience;
	List<String>? certifications;
	String? education;
	List<String>? languages;
	dynamic performanceMetrics;
	dynamic taxConfiguration;
	dynamic availability;
	dynamic socialMedia;
	List<AgentSpecialities>? specialities;
	dynamic settings;
	String? externalId;
	dynamic integration;
	String? ownerId;
	DateTime? lastActive;
	Agency? Agency;
	Location? Location;
	User? Owner;
	List<Analytics>? Analytics;
	List<ComplianceRecord>? ComplianceRecord;
	List<Language>? language;
	List<Notification>? Notification;
	List<Photo>? Photo;
	List<Post>? Post;
	List<Property>? Property;
	List<Report>? Report;
	List<Reservation>? Reservation;
	List<Review>? Review;
	List<Subscription>? Subscription;
	List<Task>? Task;
	List<PropertyPromotion>? PropertyPromotion;
	int? $specialtiesCount;
	int? $serviceAreasCount;
	int? $certificationsCount;
	int? $languagesCount;
	int? $specialitiesCount;
	int? $AnalyticsCount;
	int? $ComplianceRecordCount;
	int? $languageCount;
	int? $NotificationCount;
	int? $PhotoCount;
	int? $PostCount;
	int? $PropertyCount;
	int? $ReportCount;
	int? $ReservationCount;
	int? $ReviewCount;
	int? $SubscriptionCount;
	int? $TaskCount;
	int? $PropertyPromotionCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Agent({ this.id,
	 this.name,
	 this.email,
	 this.phoneNumber,
	 this.bio,
	 this.locationId,
	 this.address,
	 this.website,
	 this.logoUrl,
	 this.status = SharedStatus.PENDING,
	 this.createdAt,
	 this.deletedAt,
	 this.updatedAt,
	 this.agencyId,
	 this.licenseNumber,
	 this.commissionRate,
	 this.specialties,
	 this.serviceAreas,
	 this.yearsOfExperience,
	 this.certifications,
	 this.education,
	 this.languages,
	required this.performanceMetrics,
	required this.taxConfiguration,
	required this.availability,
	required this.socialMedia,
	 this.specialities,
	required this.settings,
	 this.externalId,
	required this.integration,
	 this.ownerId,
	 this.lastActive,
	 this.Agency,
	 this.Location,
	 this.Owner,
	 this.Analytics,
	 this.ComplianceRecord,
	 this.language,
	 this.Notification,
	 this.Photo,
	 this.Post,
	 this.Property,
	 this.Report,
	 this.Reservation,
	 this.Review,
	 this.Subscription,
	 this.Task,
	 this.PropertyPromotion,
	this.$specialtiesCount,
	this.$serviceAreasCount,
	this.$certificationsCount,
	this.$languagesCount,
	this.$specialitiesCount,
	this.$AnalyticsCount,
	this.$ComplianceRecordCount,
	this.$languageCount,
	this.$NotificationCount,
	this.$PhotoCount,
	this.$PostCount,
	this.$PropertyCount,
	this.$ReportCount,
	this.$ReservationCount,
	this.$ReviewCount,
	this.$SubscriptionCount,
	this.$TaskCount,
	this.$PropertyPromotionCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Agent, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"name": (m) => m.name,

	"email": (m) => m.email,

	"phoneNumber": (m) => m.phoneNumber,

	"bio": (m) => m.bio,

	"locationId": (m) => m.locationId,

	"address": (m) => m.address,

	"website": (m) => m.website,

	"logoUrl": (m) => m.logoUrl,

	"status": (m) => m.status,

	"createdAt": (m) => m.createdAt,

	"deletedAt": (m) => m.deletedAt,

	"updatedAt": (m) => m.updatedAt,

	"agencyId": (m) => m.agencyId,

	"licenseNumber": (m) => m.licenseNumber,

	"commissionRate": (m) => m.commissionRate,

	"specialties": (m) => m.specialties,

	"serviceAreas": (m) => m.serviceAreas,

	"yearsOfExperience": (m) => m.yearsOfExperience,

	"certifications": (m) => m.certifications,

	"education": (m) => m.education,

	"languages": (m) => m.languages,

	"performanceMetrics": (m) => m.performanceMetrics,

	"taxConfiguration": (m) => m.taxConfiguration,

	"availability": (m) => m.availability,

	"socialMedia": (m) => m.socialMedia,

	"specialities": (m) => m.specialities,

	"settings": (m) => m.settings,

	"externalId": (m) => m.externalId,

	"integration": (m) => m.integration,

	"ownerId": (m) => m.ownerId,

	"lastActive": (m) => m.lastActive,

	"Agency": (m) => m.Agency,

	"Location": (m) => m.Location,

	"Owner": (m) => m.Owner,

	"Analytics": (m) => m.Analytics,

	"ComplianceRecord": (m) => m.ComplianceRecord,

	"language": (m) => m.language,

	"Notification": (m) => m.Notification,

	"Photo": (m) => m.Photo,

	"Post": (m) => m.Post,

	"Property": (m) => m.Property,

	"Report": (m) => m.Report,

	"Reservation": (m) => m.Reservation,

	"Review": (m) => m.Review,

	"Subscription": (m) => m.Subscription,

	"Task": (m) => m.Task,

	"PropertyPromotion": (m) => m.PropertyPromotion,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Agent) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Agent');
    }
    return propFunction as V? Function(Agent);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Agent.fromJson(JsonMap json) =>
      Agent(
        id: json['id'] as String?,
	name: json['name'] as String?,
	email: json['email'] as String?,
	phoneNumber: json['phoneNumber'] as String?,
	bio: json['bio'] as String?,
	locationId: json['locationId'] as String?,
	address: json['address'] as String?,
	website: json['website'] as String?,
	logoUrl: json['logoUrl'] as String?,
	status: json['status'] != null ? SharedStatus.fromJson(json['status']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	agencyId: json['agencyId'] as String?,
	licenseNumber: json['licenseNumber'] as String?,
	commissionRate: json['commissionRate']?.toDouble(),
	specialties: json['specialties'] != null ? (json['specialties'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	serviceAreas: json['serviceAreas'] != null ? (json['serviceAreas'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	yearsOfExperience: int.tryParse(json['yearsOfExperience'].toString()),
	certifications: json['certifications'] != null ? (json['certifications'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	education: json['education'] as String?,
	languages: json['languages'] != null ? (json['languages'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	performanceMetrics: json['performanceMetrics'] as dynamic,
	taxConfiguration: json['taxConfiguration'] as dynamic,
	availability: json['availability'] as dynamic,
	socialMedia: json['socialMedia'] as dynamic,
	specialities: json['specialities'] != null ? (json['specialities']).map((item) => AgentSpecialities.fromJson(item)).toList() : null,
	settings: json['settings'] as dynamic,
	externalId: json['externalId'] as String?,
	integration: json['integration'] as dynamic,
	ownerId: json['ownerId'] as String?,
	lastActive: json['lastActive'] != null ? DateTime.parse(json['lastActive']) : null,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	Location: json['Location'] != null ? Location.fromJson(json['Location'] as JsonMap) : null,
	Owner: json['Owner'] != null ? User.fromJson(json['Owner'] as JsonMap) : null,
	Analytics: json['Analytics'] != null ? createModels<Analytics>((json['Analytics'] as List).cast<JsonMap>(), Analytics.fromJson) : null,
	ComplianceRecord: json['ComplianceRecord'] != null ? createModels<ComplianceRecord>((json['ComplianceRecord'] as List).cast<JsonMap>(), ComplianceRecord.fromJson) : null,
	language: json['language'] != null ? createModels<Language>((json['language'] as List).cast<JsonMap>(), Language.fromJson) : null,
	Notification: json['Notification'] != null ? createModels<Notification>((json['Notification'] as List).cast<JsonMap>(), Notification.fromJson) : null,
	Photo: json['Photo'] != null ? createModels<Photo>((json['Photo'] as List).cast<JsonMap>(), Photo.fromJson) : null,
	Post: json['Post'] != null ? createModels<Post>((json['Post'] as List).cast<JsonMap>(), Post.fromJson) : null,
	Property: json['Property'] != null ? createModels<Property>((json['Property'] as List).cast<JsonMap>(), Property.fromJson) : null,
	Report: json['Report'] != null ? createModels<Report>((json['Report'] as List).cast<JsonMap>(), Report.fromJson) : null,
	Reservation: json['Reservation'] != null ? createModels<Reservation>((json['Reservation'] as List).cast<JsonMap>(), Reservation.fromJson) : null,
	Review: json['Review'] != null ? createModels<Review>((json['Review'] as List).cast<JsonMap>(), Review.fromJson) : null,
	Subscription: json['Subscription'] != null ? createModels<Subscription>((json['Subscription'] as List).cast<JsonMap>(), Subscription.fromJson) : null,
	Task: json['Task'] != null ? createModels<Task>((json['Task'] as List).cast<JsonMap>(), Task.fromJson) : null,
	PropertyPromotion: json['PropertyPromotion'] != null ? createModels<PropertyPromotion>((json['PropertyPromotion'] as List).cast<JsonMap>(), PropertyPromotion.fromJson) : null,
	$specialtiesCount: json['_count']?['specialties'] as int?,
	$serviceAreasCount: json['_count']?['serviceAreas'] as int?,
	$certificationsCount: json['_count']?['certifications'] as int?,
	$languagesCount: json['_count']?['languages'] as int?,
	$specialitiesCount: json['_count']?['specialities'] as int?,
	$AnalyticsCount: json['_count']?['Analytics'] as int?,
	$ComplianceRecordCount: json['_count']?['ComplianceRecord'] as int?,
	$languageCount: json['_count']?['language'] as int?,
	$NotificationCount: json['_count']?['Notification'] as int?,
	$PhotoCount: json['_count']?['Photo'] as int?,
	$PostCount: json['_count']?['Post'] as int?,
	$PropertyCount: json['_count']?['Property'] as int?,
	$ReportCount: json['_count']?['Report'] as int?,
	$ReservationCount: json['_count']?['Reservation'] as int?,
	$ReviewCount: json['_count']?['Review'] as int?,
	$SubscriptionCount: json['_count']?['Subscription'] as int?,
	$TaskCount: json['_count']?['Task'] as int?,
	$PropertyPromotionCount: json['_count']?['PropertyPromotion'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Agent copyWith({
        Value<String?>? id,
		Value<String?>? name,
		Value<String?>? email,
		Value<String?>? phoneNumber,
		Value<String?>? bio,
		Value<String?>? locationId,
		Value<String?>? address,
		Value<String?>? website,
		Value<String?>? logoUrl,
		Value<SharedStatus?>? status,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? deletedAt,
		Value<DateTime?>? updatedAt,
		Value<String?>? agencyId,
		Value<String?>? licenseNumber,
		Value<double?>? commissionRate,
		Value<List<String>?>? specialties,
		Value<List<String>?>? serviceAreas,
		Value<int?>? yearsOfExperience,
		Value<List<String>?>? certifications,
		Value<String?>? education,
		Value<List<String>?>? languages,
		Value<dynamic>? performanceMetrics,
		Value<dynamic>? taxConfiguration,
		Value<dynamic>? availability,
		Value<dynamic>? socialMedia,
		Value<List<AgentSpecialities>?>? specialities,
		Value<dynamic>? settings,
		Value<String?>? externalId,
		Value<dynamic>? integration,
		Value<String?>? ownerId,
		Value<DateTime?>? lastActive,
		Value<Agency?>? Agency,
		Value<Location?>? Location,
		Value<User?>? Owner,
		Value<List<Analytics>?>? Analytics,
		Value<List<ComplianceRecord>?>? ComplianceRecord,
		Value<List<Language>?>? language,
		Value<List<Notification>?>? Notification,
		Value<List<Photo>?>? Photo,
		Value<List<Post>?>? Post,
		Value<List<Property>?>? Property,
		Value<List<Report>?>? Report,
		Value<List<Reservation>?>? Reservation,
		Value<List<Review>?>? Review,
		Value<List<Subscription>?>? Subscription,
		Value<List<Task>?>? Task,
		Value<List<PropertyPromotion>?>? PropertyPromotion,
		int? $specialtiesCount,
		int? $serviceAreasCount,
		int? $certificationsCount,
		int? $languagesCount,
		int? $specialitiesCount,
		int? $AnalyticsCount,
		int? $ComplianceRecordCount,
		int? $languageCount,
		int? $NotificationCount,
		int? $PhotoCount,
		int? $PostCount,
		int? $PropertyCount,
		int? $ReportCount,
		int? $ReservationCount,
		int? $ReviewCount,
		int? $SubscriptionCount,
		int? $TaskCount,
		int? $PropertyPromotionCount,
        }) {
        return Agent(
            id: id != null ? id.value : this.id,
		name: name != null ? name.value : this.name,
		email: email != null ? email.value : this.email,
		phoneNumber: phoneNumber != null ? phoneNumber.value : this.phoneNumber,
		bio: bio != null ? bio.value : this.bio,
		locationId: locationId != null ? locationId.value : this.locationId,
		address: address != null ? address.value : this.address,
		website: website != null ? website.value : this.website,
		logoUrl: logoUrl != null ? logoUrl.value : this.logoUrl,
		status: status != null ? status.value : this.status,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		licenseNumber: licenseNumber != null ? licenseNumber.value : this.licenseNumber,
		commissionRate: commissionRate != null ? commissionRate.value : this.commissionRate,
		specialties: specialties != null ? specialties.value : this.specialties,
		serviceAreas: serviceAreas != null ? serviceAreas.value : this.serviceAreas,
		yearsOfExperience: yearsOfExperience != null ? yearsOfExperience.value : this.yearsOfExperience,
		certifications: certifications != null ? certifications.value : this.certifications,
		education: education != null ? education.value : this.education,
		languages: languages != null ? languages.value : this.languages,
		performanceMetrics: performanceMetrics != null ? performanceMetrics.value : this.performanceMetrics,
		taxConfiguration: taxConfiguration != null ? taxConfiguration.value : this.taxConfiguration,
		availability: availability != null ? availability.value : this.availability,
		socialMedia: socialMedia != null ? socialMedia.value : this.socialMedia,
		specialities: specialities != null ? specialities.value : this.specialities,
		settings: settings != null ? settings.value : this.settings,
		externalId: externalId != null ? externalId.value : this.externalId,
		integration: integration != null ? integration.value : this.integration,
		ownerId: ownerId != null ? ownerId.value : this.ownerId,
		lastActive: lastActive != null ? lastActive.value : this.lastActive,
		Agency: Agency != null ? Agency.value : this.Agency,
		Location: Location != null ? Location.value : this.Location,
		Owner: Owner != null ? Owner.value : this.Owner,
		Analytics: Analytics != null ? Analytics.value : this.Analytics,
		ComplianceRecord: ComplianceRecord != null ? ComplianceRecord.value : this.ComplianceRecord,
		language: language != null ? language.value : this.language,
		Notification: Notification != null ? Notification.value : this.Notification,
		Photo: Photo != null ? Photo.value : this.Photo,
		Post: Post != null ? Post.value : this.Post,
		Property: Property != null ? Property.value : this.Property,
		Report: Report != null ? Report.value : this.Report,
		Reservation: Reservation != null ? Reservation.value : this.Reservation,
		Review: Review != null ? Review.value : this.Review,
		Subscription: Subscription != null ? Subscription.value : this.Subscription,
		Task: Task != null ? Task.value : this.Task,
		PropertyPromotion: PropertyPromotion != null ? PropertyPromotion.value : this.PropertyPromotion,
		$specialtiesCount: $specialtiesCount ?? this.$specialtiesCount,
		$serviceAreasCount: $serviceAreasCount ?? this.$serviceAreasCount,
		$certificationsCount: $certificationsCount ?? this.$certificationsCount,
		$languagesCount: $languagesCount ?? this.$languagesCount,
		$specialitiesCount: $specialitiesCount ?? this.$specialitiesCount,
		$AnalyticsCount: $AnalyticsCount ?? this.$AnalyticsCount,
		$ComplianceRecordCount: $ComplianceRecordCount ?? this.$ComplianceRecordCount,
		$languageCount: $languageCount ?? this.$languageCount,
		$NotificationCount: $NotificationCount ?? this.$NotificationCount,
		$PhotoCount: $PhotoCount ?? this.$PhotoCount,
		$PostCount: $PostCount ?? this.$PostCount,
		$PropertyCount: $PropertyCount ?? this.$PropertyCount,
		$ReportCount: $ReportCount ?? this.$ReportCount,
		$ReservationCount: $ReservationCount ?? this.$ReservationCount,
		$ReviewCount: $ReviewCount ?? this.$ReviewCount,
		$SubscriptionCount: $SubscriptionCount ?? this.$SubscriptionCount,
		$TaskCount: $TaskCount ?? this.$TaskCount,
		$PropertyPromotionCount: $PropertyPromotionCount ?? this.$PropertyPromotionCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Agent copyWithInstanceValues(Agent agent) {
        return Agent(
            id: agent.id ?? id,
		name: agent.name ?? name,
		email: agent.email ?? email,
		phoneNumber: agent.phoneNumber ?? phoneNumber,
		bio: agent.bio ?? bio,
		locationId: agent.locationId ?? locationId,
		address: agent.address ?? address,
		website: agent.website ?? website,
		logoUrl: agent.logoUrl ?? logoUrl,
		status: agent.status ?? status,
		createdAt: agent.createdAt ?? createdAt,
		deletedAt: agent.deletedAt ?? deletedAt,
		updatedAt: agent.updatedAt ?? updatedAt,
		agencyId: agent.agencyId ?? agencyId,
		licenseNumber: agent.licenseNumber ?? licenseNumber,
		commissionRate: agent.commissionRate ?? commissionRate,
		specialties: agent.specialties ?? specialties,
		serviceAreas: agent.serviceAreas ?? serviceAreas,
		yearsOfExperience: agent.yearsOfExperience ?? yearsOfExperience,
		certifications: agent.certifications ?? certifications,
		education: agent.education ?? education,
		languages: agent.languages ?? languages,
		performanceMetrics: agent.performanceMetrics ?? performanceMetrics,
		taxConfiguration: agent.taxConfiguration ?? taxConfiguration,
		availability: agent.availability ?? availability,
		socialMedia: agent.socialMedia ?? socialMedia,
		specialities: agent.specialities ?? specialities,
		settings: agent.settings ?? settings,
		externalId: agent.externalId ?? externalId,
		integration: agent.integration ?? integration,
		ownerId: agent.ownerId ?? ownerId,
		lastActive: agent.lastActive ?? lastActive,
		Agency: agent.Agency ?? Agency,
		Location: agent.Location ?? Location,
		Owner: agent.Owner ?? Owner,
		Analytics: agent.Analytics ?? Analytics,
		ComplianceRecord: agent.ComplianceRecord ?? ComplianceRecord,
		language: agent.language ?? language,
		Notification: agent.Notification ?? Notification,
		Photo: agent.Photo ?? Photo,
		Post: agent.Post ?? Post,
		Property: agent.Property ?? Property,
		Report: agent.Report ?? Report,
		Reservation: agent.Reservation ?? Reservation,
		Review: agent.Review ?? Review,
		Subscription: agent.Subscription ?? Subscription,
		Task: agent.Task ?? Task,
		PropertyPromotion: agent.PropertyPromotion ?? PropertyPromotion,
		$specialtiesCount: agent.$specialtiesCount ?? $specialtiesCount,
		$serviceAreasCount: agent.$serviceAreasCount ?? $serviceAreasCount,
		$certificationsCount: agent.$certificationsCount ?? $certificationsCount,
		$languagesCount: agent.$languagesCount ?? $languagesCount,
		$specialitiesCount: agent.$specialitiesCount ?? $specialitiesCount,
		$AnalyticsCount: agent.$AnalyticsCount ?? $AnalyticsCount,
		$ComplianceRecordCount: agent.$ComplianceRecordCount ?? $ComplianceRecordCount,
		$languageCount: agent.$languageCount ?? $languageCount,
		$NotificationCount: agent.$NotificationCount ?? $NotificationCount,
		$PhotoCount: agent.$PhotoCount ?? $PhotoCount,
		$PostCount: agent.$PostCount ?? $PostCount,
		$PropertyCount: agent.$PropertyCount ?? $PropertyCount,
		$ReportCount: agent.$ReportCount ?? $ReportCount,
		$ReservationCount: agent.$ReservationCount ?? $ReservationCount,
		$ReviewCount: agent.$ReviewCount ?? $ReviewCount,
		$SubscriptionCount: agent.$SubscriptionCount ?? $SubscriptionCount,
		$TaskCount: agent.$TaskCount ?? $TaskCount,
		$PropertyPromotionCount: agent.$PropertyPromotionCount ?? $PropertyPromotionCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Agent mergeWithInstanceValues(Agent agent) {
        return Agent(
            id: agent.$assignedFields.contains('id') ? agent.id : id,
		name: agent.$assignedFields.contains('name') ? agent.name : name,
		email: agent.$assignedFields.contains('email') ? agent.email : email,
		phoneNumber: agent.$assignedFields.contains('phoneNumber') ? agent.phoneNumber : phoneNumber,
		bio: agent.$assignedFields.contains('bio') ? agent.bio : bio,
		locationId: agent.$assignedFields.contains('locationId') ? agent.locationId : locationId,
		address: agent.$assignedFields.contains('address') ? agent.address : address,
		website: agent.$assignedFields.contains('website') ? agent.website : website,
		logoUrl: agent.$assignedFields.contains('logoUrl') ? agent.logoUrl : logoUrl,
		status: agent.$assignedFields.contains('status') ? agent.status : status,
		createdAt: agent.$assignedFields.contains('createdAt') ? agent.createdAt : createdAt,
		deletedAt: agent.$assignedFields.contains('deletedAt') ? agent.deletedAt : deletedAt,
		updatedAt: agent.$assignedFields.contains('updatedAt') ? agent.updatedAt : updatedAt,
		agencyId: agent.$assignedFields.contains('agencyId') ? agent.agencyId : agencyId,
		licenseNumber: agent.$assignedFields.contains('licenseNumber') ? agent.licenseNumber : licenseNumber,
		commissionRate: agent.$assignedFields.contains('commissionRate') ? agent.commissionRate : commissionRate,
		specialties: agent.$assignedFields.contains('specialties') ? agent.specialties : specialties,
		serviceAreas: agent.$assignedFields.contains('serviceAreas') ? agent.serviceAreas : serviceAreas,
		yearsOfExperience: agent.$assignedFields.contains('yearsOfExperience') ? agent.yearsOfExperience : yearsOfExperience,
		certifications: agent.$assignedFields.contains('certifications') ? agent.certifications : certifications,
		education: agent.$assignedFields.contains('education') ? agent.education : education,
		languages: agent.$assignedFields.contains('languages') ? agent.languages : languages,
		performanceMetrics: agent.$assignedFields.contains('performanceMetrics') ? agent.performanceMetrics : performanceMetrics,
		taxConfiguration: agent.$assignedFields.contains('taxConfiguration') ? agent.taxConfiguration : taxConfiguration,
		availability: agent.$assignedFields.contains('availability') ? agent.availability : availability,
		socialMedia: agent.$assignedFields.contains('socialMedia') ? agent.socialMedia : socialMedia,
		specialities: agent.$assignedFields.contains('specialities') ? agent.specialities : specialities,
		settings: agent.$assignedFields.contains('settings') ? agent.settings : settings,
		externalId: agent.$assignedFields.contains('externalId') ? agent.externalId : externalId,
		integration: agent.$assignedFields.contains('integration') ? agent.integration : integration,
		ownerId: agent.$assignedFields.contains('ownerId') ? agent.ownerId : ownerId,
		lastActive: agent.$assignedFields.contains('lastActive') ? agent.lastActive : lastActive,
		Agency: agent.$assignedFields.contains('Agency') ? agent.Agency : Agency,
		Location: agent.$assignedFields.contains('Location') ? agent.Location : Location,
		Owner: agent.$assignedFields.contains('Owner') ? agent.Owner : Owner,
		Analytics: (agent.$assignedFields.contains('Analytics') && agent.Analytics != null) ? mergeModelLists(Analytics, agent.Analytics) : Analytics,
		ComplianceRecord: (agent.$assignedFields.contains('ComplianceRecord') && agent.ComplianceRecord != null) ? mergeModelLists(ComplianceRecord, agent.ComplianceRecord) : ComplianceRecord,
		language: (agent.$assignedFields.contains('language') && agent.language != null) ? mergeModelLists(language, agent.language) : language,
		Notification: (agent.$assignedFields.contains('Notification') && agent.Notification != null) ? mergeModelLists(Notification, agent.Notification) : Notification,
		Photo: (agent.$assignedFields.contains('Photo') && agent.Photo != null) ? mergeModelLists(Photo, agent.Photo) : Photo,
		Post: (agent.$assignedFields.contains('Post') && agent.Post != null) ? mergeModelLists(Post, agent.Post) : Post,
		Property: (agent.$assignedFields.contains('Property') && agent.Property != null) ? mergeModelLists(Property, agent.Property) : Property,
		Report: (agent.$assignedFields.contains('Report') && agent.Report != null) ? mergeModelLists(Report, agent.Report) : Report,
		Reservation: (agent.$assignedFields.contains('Reservation') && agent.Reservation != null) ? mergeModelLists(Reservation, agent.Reservation) : Reservation,
		Review: (agent.$assignedFields.contains('Review') && agent.Review != null) ? mergeModelLists(Review, agent.Review) : Review,
		Subscription: (agent.$assignedFields.contains('Subscription') && agent.Subscription != null) ? mergeModelLists(Subscription, agent.Subscription) : Subscription,
		Task: (agent.$assignedFields.contains('Task') && agent.Task != null) ? mergeModelLists(Task, agent.Task) : Task,
		PropertyPromotion: (agent.$assignedFields.contains('PropertyPromotion') && agent.PropertyPromotion != null) ? mergeModelLists(PropertyPromotion, agent.PropertyPromotion) : PropertyPromotion,
		$specialtiesCount: agent.$specialtiesCount ?? $specialtiesCount,
		$serviceAreasCount: agent.$serviceAreasCount ?? $serviceAreasCount,
		$certificationsCount: agent.$certificationsCount ?? $certificationsCount,
		$languagesCount: agent.$languagesCount ?? $languagesCount,
		$specialitiesCount: agent.$specialitiesCount ?? $specialitiesCount,
		$AnalyticsCount: agent.$AnalyticsCount ?? $AnalyticsCount,
		$ComplianceRecordCount: agent.$ComplianceRecordCount ?? $ComplianceRecordCount,
		$languageCount: agent.$languageCount ?? $languageCount,
		$NotificationCount: agent.$NotificationCount ?? $NotificationCount,
		$PhotoCount: agent.$PhotoCount ?? $PhotoCount,
		$PostCount: agent.$PostCount ?? $PostCount,
		$PropertyCount: agent.$PropertyCount ?? $PropertyCount,
		$ReportCount: agent.$ReportCount ?? $ReportCount,
		$ReservationCount: agent.$ReservationCount ?? $ReservationCount,
		$ReviewCount: agent.$ReviewCount ?? $ReviewCount,
		$SubscriptionCount: agent.$SubscriptionCount ?? $SubscriptionCount,
		$TaskCount: agent.$TaskCount ?? $TaskCount,
		$PropertyPromotionCount: agent.$PropertyPromotionCount ?? $PropertyPromotionCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Agent updateWithInstanceValues(Agent agent) {
        if (agent.$assignedFields.contains('id')) { id = agent.id; }
		if (agent.$assignedFields.contains('name')) { name = agent.name; }
		if (agent.$assignedFields.contains('email')) { email = agent.email; }
		if (agent.$assignedFields.contains('phoneNumber')) { phoneNumber = agent.phoneNumber; }
		if (agent.$assignedFields.contains('bio')) { bio = agent.bio; }
		if (agent.$assignedFields.contains('locationId')) { locationId = agent.locationId; }
		if (agent.$assignedFields.contains('address')) { address = agent.address; }
		if (agent.$assignedFields.contains('website')) { website = agent.website; }
		if (agent.$assignedFields.contains('logoUrl')) { logoUrl = agent.logoUrl; }
		if (agent.$assignedFields.contains('status')) { status = agent.status; }
		if (agent.$assignedFields.contains('createdAt')) { createdAt = agent.createdAt; }
		if (agent.$assignedFields.contains('deletedAt')) { deletedAt = agent.deletedAt; }
		if (agent.$assignedFields.contains('updatedAt')) { updatedAt = agent.updatedAt; }
		if (agent.$assignedFields.contains('agencyId')) { agencyId = agent.agencyId; }
		if (agent.$assignedFields.contains('licenseNumber')) { licenseNumber = agent.licenseNumber; }
		if (agent.$assignedFields.contains('commissionRate')) { commissionRate = agent.commissionRate; }
		if (agent.$assignedFields.contains('specialties')) { specialties = agent.specialties; }
		if (agent.$assignedFields.contains('serviceAreas')) { serviceAreas = agent.serviceAreas; }
		if (agent.$assignedFields.contains('yearsOfExperience')) { yearsOfExperience = agent.yearsOfExperience; }
		if (agent.$assignedFields.contains('certifications')) { certifications = agent.certifications; }
		if (agent.$assignedFields.contains('education')) { education = agent.education; }
		if (agent.$assignedFields.contains('languages')) { languages = agent.languages; }
		if (agent.$assignedFields.contains('performanceMetrics')) { performanceMetrics = agent.performanceMetrics; }
		if (agent.$assignedFields.contains('taxConfiguration')) { taxConfiguration = agent.taxConfiguration; }
		if (agent.$assignedFields.contains('availability')) { availability = agent.availability; }
		if (agent.$assignedFields.contains('socialMedia')) { socialMedia = agent.socialMedia; }
		if (agent.$assignedFields.contains('specialities')) { specialities = agent.specialities; }
		if (agent.$assignedFields.contains('settings')) { settings = agent.settings; }
		if (agent.$assignedFields.contains('externalId')) { externalId = agent.externalId; }
		if (agent.$assignedFields.contains('integration')) { integration = agent.integration; }
		if (agent.$assignedFields.contains('ownerId')) { ownerId = agent.ownerId; }
		if (agent.$assignedFields.contains('lastActive')) { lastActive = agent.lastActive; }
		if (agent.$assignedFields.contains('Agency')) { Agency = agent.Agency; }
		if (agent.$assignedFields.contains('Location')) { Location = agent.Location; }
		if (agent.$assignedFields.contains('Owner')) { Owner = agent.Owner; }
		if (agent.$assignedFields.contains('Analytics') && agent.Analytics != null) { Analytics = mergeModelLists(Analytics, agent.Analytics); }
		if (agent.$assignedFields.contains('ComplianceRecord') && agent.ComplianceRecord != null) { ComplianceRecord = mergeModelLists(ComplianceRecord, agent.ComplianceRecord); }
		if (agent.$assignedFields.contains('language') && agent.language != null) { language = mergeModelLists(language, agent.language); }
		if (agent.$assignedFields.contains('Notification') && agent.Notification != null) { Notification = mergeModelLists(Notification, agent.Notification); }
		if (agent.$assignedFields.contains('Photo') && agent.Photo != null) { Photo = mergeModelLists(Photo, agent.Photo); }
		if (agent.$assignedFields.contains('Post') && agent.Post != null) { Post = mergeModelLists(Post, agent.Post); }
		if (agent.$assignedFields.contains('Property') && agent.Property != null) { Property = mergeModelLists(Property, agent.Property); }
		if (agent.$assignedFields.contains('Report') && agent.Report != null) { Report = mergeModelLists(Report, agent.Report); }
		if (agent.$assignedFields.contains('Reservation') && agent.Reservation != null) { Reservation = mergeModelLists(Reservation, agent.Reservation); }
		if (agent.$assignedFields.contains('Review') && agent.Review != null) { Review = mergeModelLists(Review, agent.Review); }
		if (agent.$assignedFields.contains('Subscription') && agent.Subscription != null) { Subscription = mergeModelLists(Subscription, agent.Subscription); }
		if (agent.$assignedFields.contains('Task') && agent.Task != null) { Task = mergeModelLists(Task, agent.Task); }
		if (agent.$assignedFields.contains('PropertyPromotion') && agent.PropertyPromotion != null) { PropertyPromotion = mergeModelLists(PropertyPromotion, agent.PropertyPromotion); }
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
          ? {...?serializedTypes, 'Agent'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(name != null) 'name': name,
	if(email != null) 'email': email,
	if(phoneNumber != null) 'phoneNumber': phoneNumber,
	if(bio != null) 'bio': bio,
	if(locationId != null) 'locationId': locationId,
	if(address != null) 'address': address,
	if(website != null) 'website': website,
	if(logoUrl != null) 'logoUrl': logoUrl,
	if(status != null) 'status': status?.toJson(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(agencyId != null) 'agencyId': agencyId,
	if(licenseNumber != null) 'licenseNumber': licenseNumber,
	if(commissionRate != null) 'commissionRate': commissionRate,
	if(specialties != null) 'specialties': specialties,
	if(serviceAreas != null) 'serviceAreas': serviceAreas,
	if(yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
	if(certifications != null) 'certifications': certifications,
	if(education != null) 'education': education,
	if(languages != null) 'languages': languages,
	if(performanceMetrics != null) 'performanceMetrics': performanceMetrics,
	if(taxConfiguration != null) 'taxConfiguration': taxConfiguration,
	if(availability != null) 'availability': availability,
	if(socialMedia != null) 'socialMedia': socialMedia,
	if(specialities != null) 'specialities': specialities?.map((item) => item.toJson()).toList(),
	if(settings != null) 'settings': settings,
	if(externalId != null) 'externalId': externalId,
	if(integration != null) 'integration': integration,
	if(ownerId != null) 'ownerId': ownerId,
	if(lastActive != null) 'lastActive': lastActive?.toIso8601String(),
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Location != null && (!preventCircularSerialization || !serializedModels.contains('Location'))) 'Location': Location?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Owner != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'Owner': Owner?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Analytics != null && (!preventCircularSerialization || !serializedModels.contains('Analytics'))) 'Analytics': Analytics?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(ComplianceRecord != null && (!preventCircularSerialization || !serializedModels.contains('ComplianceRecord'))) 'ComplianceRecord': ComplianceRecord?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(language != null && (!preventCircularSerialization || !serializedModels.contains('Language'))) 'language': language?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Notification != null && (!preventCircularSerialization || !serializedModels.contains('Notification'))) 'Notification': Notification?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Photo != null && (!preventCircularSerialization || !serializedModels.contains('Photo'))) 'Photo': Photo?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Post != null && (!preventCircularSerialization || !serializedModels.contains('Post'))) 'Post': Post?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Report != null && (!preventCircularSerialization || !serializedModels.contains('Report'))) 'Report': Report?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'Reservation': Reservation?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Review != null && (!preventCircularSerialization || !serializedModels.contains('Review'))) 'Review': Review?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Subscription != null && (!preventCircularSerialization || !serializedModels.contains('Subscription'))) 'Subscription': Subscription?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Task != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'Task': Task?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(PropertyPromotion != null && (!preventCircularSerialization || !serializedModels.contains('PropertyPromotion'))) 'PropertyPromotion': PropertyPromotion?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($specialtiesCount != null || $serviceAreasCount != null || $certificationsCount != null || $languagesCount != null || $specialitiesCount != null || $AnalyticsCount != null || $ComplianceRecordCount != null || $languageCount != null || $NotificationCount != null || $PhotoCount != null || $PostCount != null || $PropertyCount != null || $ReportCount != null || $ReservationCount != null || $ReviewCount != null || $SubscriptionCount != null || $TaskCount != null || $PropertyPromotionCount != null) '_count': { 
		if ($specialtiesCount != null) 'specialties': $specialtiesCount, 
		if ($serviceAreasCount != null) 'serviceAreas': $serviceAreasCount, 
		if ($certificationsCount != null) 'certifications': $certificationsCount, 
		if ($languagesCount != null) 'languages': $languagesCount, 
		if ($specialitiesCount != null) 'specialities': $specialitiesCount, 
		if ($AnalyticsCount != null) 'Analytics': $AnalyticsCount, 
		if ($ComplianceRecordCount != null) 'ComplianceRecord': $ComplianceRecordCount, 
		if ($languageCount != null) 'language': $languageCount, 
		if ($NotificationCount != null) 'Notification': $NotificationCount, 
		if ($PhotoCount != null) 'Photo': $PhotoCount, 
		if ($PostCount != null) 'Post': $PostCount, 
		if ($PropertyCount != null) 'Property': $PropertyCount, 
		if ($ReportCount != null) 'Report': $ReportCount, 
		if ($ReservationCount != null) 'Reservation': $ReservationCount, 
		if ($ReviewCount != null) 'Review': $ReviewCount, 
		if ($SubscriptionCount != null) 'Subscription': $SubscriptionCount, 
		if ($TaskCount != null) 'Task': $TaskCount, 
		if ($PropertyPromotionCount != null) 'PropertyPromotion': $PropertyPromotionCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Agent &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    