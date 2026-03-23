
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'task_type.dart';
import 'task_status.dart';
import 'priority.dart';
import 'attachment.dart';
import 'contact.dart';
import 'user.dart';
import 'booking.dart';
import 'contract.dart';
import 'lease.dart';
import 'listing.dart';
import 'organization.dart';
import 'project.dart';
import 'property.dart';
import 'reservation.dart';
import 'agent.dart';
import 'extra_charge.dart';
import 'agency.dart';
import 'included_service.dart';
import 'analytics.dart';
import 'mention.dart';


class Task implements PrismaModel<String, Task> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	String? leaseId;
	String? bookingId;
	String? contractId;
	String? reservationId;
	String? projectId;
	TaskType? type;
	TaskStatus? status;
	Priority? priority;
	String? title;
	String? description;
	DateTime? dueAt;
	int? slaHours;
	String? assignedToUserId;
	String? assignedToContactId;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Attachment>? attachments;
	Contact? assignedContact;
	User? assignedUser;
	Booking? booking;
	Contract? contract;
	Lease? lease;
	Listing? listing;
	Organization? org;
	Project? project;
	Property? property;
	Reservation? reservation;
	List<Agent>? agents;
	List<ExtraCharge>? extraCharges;
	List<Agency>? agencies;
	List<IncludedService>? includedServices;
	List<Analytics>? analytics;
	List<Mention>? mentions;
	int? $attachmentsCount;
	int? $agentsCount;
	int? $extraChargesCount;
	int? $agenciesCount;
	int? $includedServicesCount;
	int? $analyticsCount;
	int? $mentionsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Task({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.leaseId,
	 this.bookingId,
	 this.contractId,
	 this.reservationId,
	 this.projectId,
	 this.type,
	 this.status = TaskStatus.OPEN,
	 this.priority = Priority.MEDIUM,
	 this.title,
	 this.description,
	 this.dueAt,
	 this.slaHours,
	 this.assignedToUserId,
	 this.assignedToContactId,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.attachments,
	 this.assignedContact,
	 this.assignedUser,
	 this.booking,
	 this.contract,
	 this.lease,
	 this.listing,
	 this.org,
	 this.project,
	 this.property,
	 this.reservation,
	 this.agents,
	 this.extraCharges,
	 this.agencies,
	 this.includedServices,
	 this.analytics,
	 this.mentions,
	this.$attachmentsCount,
	this.$agentsCount,
	this.$extraChargesCount,
	this.$agenciesCount,
	this.$includedServicesCount,
	this.$analyticsCount,
	this.$mentionsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Task, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"leaseId": (m) => m.leaseId,

	"bookingId": (m) => m.bookingId,

	"contractId": (m) => m.contractId,

	"reservationId": (m) => m.reservationId,

	"projectId": (m) => m.projectId,

	"type": (m) => m.type,

	"status": (m) => m.status,

	"priority": (m) => m.priority,

	"title": (m) => m.title,

	"description": (m) => m.description,

	"dueAt": (m) => m.dueAt,

	"slaHours": (m) => m.slaHours,

	"assignedToUserId": (m) => m.assignedToUserId,

	"assignedToContactId": (m) => m.assignedToContactId,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"attachments": (m) => m.attachments,

	"assignedContact": (m) => m.assignedContact,

	"assignedUser": (m) => m.assignedUser,

	"booking": (m) => m.booking,

	"contract": (m) => m.contract,

	"lease": (m) => m.lease,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"project": (m) => m.project,

	"property": (m) => m.property,

	"reservation": (m) => m.reservation,

	"agents": (m) => m.agents,

	"extraCharges": (m) => m.extraCharges,

	"agencies": (m) => m.agencies,

	"includedServices": (m) => m.includedServices,

	"analytics": (m) => m.analytics,

	"mentions": (m) => m.mentions,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Task) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Task');
    }
    return propFunction as V? Function(Task);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Task.fromJson(JsonMap json) =>
      Task(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	leaseId: json['leaseId'] as String?,
	bookingId: json['bookingId'] as String?,
	contractId: json['contractId'] as String?,
	reservationId: json['reservationId'] as String?,
	projectId: json['projectId'] as String?,
	type: json['type'] != null ? TaskType.fromJson(json['type']) : null,
	status: json['status'] != null ? TaskStatus.fromJson(json['status']) : null,
	priority: json['priority'] != null ? Priority.fromJson(json['priority']) : null,
	title: json['title'] as String?,
	description: json['description'] as String?,
	dueAt: json['dueAt'] != null ? DateTime.parse(json['dueAt']) : null,
	slaHours: int.tryParse(json['slaHours'].toString()),
	assignedToUserId: json['assignedToUserId'] as String?,
	assignedToContactId: json['assignedToContactId'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	attachments: json['attachments'] != null ? createModels<Attachment>((json['attachments'] as List).cast<JsonMap>(), Attachment.fromJson) : null,
	assignedContact: json['assignedContact'] != null ? Contact.fromJson(json['assignedContact'] as JsonMap) : null,
	assignedUser: json['assignedUser'] != null ? User.fromJson(json['assignedUser'] as JsonMap) : null,
	booking: json['booking'] != null ? Booking.fromJson(json['booking'] as JsonMap) : null,
	contract: json['contract'] != null ? Contract.fromJson(json['contract'] as JsonMap) : null,
	lease: json['lease'] != null ? Lease.fromJson(json['lease'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	project: json['project'] != null ? Project.fromJson(json['project'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation'] as JsonMap) : null,
	agents: json['agents'] != null ? createModels<Agent>((json['agents'] as List).cast<JsonMap>(), Agent.fromJson) : null,
	extraCharges: json['extraCharges'] != null ? createModels<ExtraCharge>((json['extraCharges'] as List).cast<JsonMap>(), ExtraCharge.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	includedServices: json['includedServices'] != null ? createModels<IncludedService>((json['includedServices'] as List).cast<JsonMap>(), IncludedService.fromJson) : null,
	analytics: json['analytics'] != null ? createModels<Analytics>((json['analytics'] as List).cast<JsonMap>(), Analytics.fromJson) : null,
	mentions: json['mentions'] != null ? createModels<Mention>((json['mentions'] as List).cast<JsonMap>(), Mention.fromJson) : null,
	$attachmentsCount: json['_count']?['attachments'] as int?,
	$agentsCount: json['_count']?['agents'] as int?,
	$extraChargesCount: json['_count']?['extraCharges'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$includedServicesCount: json['_count']?['includedServices'] as int?,
	$analyticsCount: json['_count']?['analytics'] as int?,
	$mentionsCount: json['_count']?['mentions'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Task copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<String?>? leaseId,
		Value<String?>? bookingId,
		Value<String?>? contractId,
		Value<String?>? reservationId,
		Value<String?>? projectId,
		Value<TaskType?>? type,
		Value<TaskStatus?>? status,
		Value<Priority?>? priority,
		Value<String?>? title,
		Value<String?>? description,
		Value<DateTime?>? dueAt,
		Value<int?>? slaHours,
		Value<String?>? assignedToUserId,
		Value<String?>? assignedToContactId,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Attachment>?>? attachments,
		Value<Contact?>? assignedContact,
		Value<User?>? assignedUser,
		Value<Booking?>? booking,
		Value<Contract?>? contract,
		Value<Lease?>? lease,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Project?>? project,
		Value<Property?>? property,
		Value<Reservation?>? reservation,
		Value<List<Agent>?>? agents,
		Value<List<ExtraCharge>?>? extraCharges,
		Value<List<Agency>?>? agencies,
		Value<List<IncludedService>?>? includedServices,
		Value<List<Analytics>?>? analytics,
		Value<List<Mention>?>? mentions,
		int? $attachmentsCount,
		int? $agentsCount,
		int? $extraChargesCount,
		int? $agenciesCount,
		int? $includedServicesCount,
		int? $analyticsCount,
		int? $mentionsCount,
        }) {
        return Task(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		bookingId: bookingId != null ? bookingId.value : this.bookingId,
		contractId: contractId != null ? contractId.value : this.contractId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		projectId: projectId != null ? projectId.value : this.projectId,
		type: type != null ? type.value : this.type,
		status: status != null ? status.value : this.status,
		priority: priority != null ? priority.value : this.priority,
		title: title != null ? title.value : this.title,
		description: description != null ? description.value : this.description,
		dueAt: dueAt != null ? dueAt.value : this.dueAt,
		slaHours: slaHours != null ? slaHours.value : this.slaHours,
		assignedToUserId: assignedToUserId != null ? assignedToUserId.value : this.assignedToUserId,
		assignedToContactId: assignedToContactId != null ? assignedToContactId.value : this.assignedToContactId,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		attachments: attachments != null ? attachments.value : this.attachments,
		assignedContact: assignedContact != null ? assignedContact.value : this.assignedContact,
		assignedUser: assignedUser != null ? assignedUser.value : this.assignedUser,
		booking: booking != null ? booking.value : this.booking,
		contract: contract != null ? contract.value : this.contract,
		lease: lease != null ? lease.value : this.lease,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		project: project != null ? project.value : this.project,
		property: property != null ? property.value : this.property,
		reservation: reservation != null ? reservation.value : this.reservation,
		agents: agents != null ? agents.value : this.agents,
		extraCharges: extraCharges != null ? extraCharges.value : this.extraCharges,
		agencies: agencies != null ? agencies.value : this.agencies,
		includedServices: includedServices != null ? includedServices.value : this.includedServices,
		analytics: analytics != null ? analytics.value : this.analytics,
		mentions: mentions != null ? mentions.value : this.mentions,
		$attachmentsCount: $attachmentsCount ?? this.$attachmentsCount,
		$agentsCount: $agentsCount ?? this.$agentsCount,
		$extraChargesCount: $extraChargesCount ?? this.$extraChargesCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$includedServicesCount: $includedServicesCount ?? this.$includedServicesCount,
		$analyticsCount: $analyticsCount ?? this.$analyticsCount,
		$mentionsCount: $mentionsCount ?? this.$mentionsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Task copyWithInstanceValues(Task task) {
        return Task(
            id: task.id ?? id,
		orgId: task.orgId ?? orgId,
		propertyId: task.propertyId ?? propertyId,
		listingId: task.listingId ?? listingId,
		leaseId: task.leaseId ?? leaseId,
		bookingId: task.bookingId ?? bookingId,
		contractId: task.contractId ?? contractId,
		reservationId: task.reservationId ?? reservationId,
		projectId: task.projectId ?? projectId,
		type: task.type ?? type,
		status: task.status ?? status,
		priority: task.priority ?? priority,
		title: task.title ?? title,
		description: task.description ?? description,
		dueAt: task.dueAt ?? dueAt,
		slaHours: task.slaHours ?? slaHours,
		assignedToUserId: task.assignedToUserId ?? assignedToUserId,
		assignedToContactId: task.assignedToContactId ?? assignedToContactId,
		createdBy: task.createdBy ?? createdBy,
		createdAt: task.createdAt ?? createdAt,
		updatedAt: task.updatedAt ?? updatedAt,
		deletedAt: task.deletedAt ?? deletedAt,
		attachments: task.attachments ?? attachments,
		assignedContact: task.assignedContact ?? assignedContact,
		assignedUser: task.assignedUser ?? assignedUser,
		booking: task.booking ?? booking,
		contract: task.contract ?? contract,
		lease: task.lease ?? lease,
		listing: task.listing ?? listing,
		org: task.org ?? org,
		project: task.project ?? project,
		property: task.property ?? property,
		reservation: task.reservation ?? reservation,
		agents: task.agents ?? agents,
		extraCharges: task.extraCharges ?? extraCharges,
		agencies: task.agencies ?? agencies,
		includedServices: task.includedServices ?? includedServices,
		analytics: task.analytics ?? analytics,
		mentions: task.mentions ?? mentions,
		$attachmentsCount: task.$attachmentsCount ?? $attachmentsCount,
		$agentsCount: task.$agentsCount ?? $agentsCount,
		$extraChargesCount: task.$extraChargesCount ?? $extraChargesCount,
		$agenciesCount: task.$agenciesCount ?? $agenciesCount,
		$includedServicesCount: task.$includedServicesCount ?? $includedServicesCount,
		$analyticsCount: task.$analyticsCount ?? $analyticsCount,
		$mentionsCount: task.$mentionsCount ?? $mentionsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Task mergeWithInstanceValues(Task task) {
        return Task(
            id: task.$assignedFields.contains('id') ? task.id : id,
		orgId: task.$assignedFields.contains('orgId') ? task.orgId : orgId,
		propertyId: task.$assignedFields.contains('propertyId') ? task.propertyId : propertyId,
		listingId: task.$assignedFields.contains('listingId') ? task.listingId : listingId,
		leaseId: task.$assignedFields.contains('leaseId') ? task.leaseId : leaseId,
		bookingId: task.$assignedFields.contains('bookingId') ? task.bookingId : bookingId,
		contractId: task.$assignedFields.contains('contractId') ? task.contractId : contractId,
		reservationId: task.$assignedFields.contains('reservationId') ? task.reservationId : reservationId,
		projectId: task.$assignedFields.contains('projectId') ? task.projectId : projectId,
		type: task.$assignedFields.contains('type') ? task.type : type,
		status: task.$assignedFields.contains('status') ? task.status : status,
		priority: task.$assignedFields.contains('priority') ? task.priority : priority,
		title: task.$assignedFields.contains('title') ? task.title : title,
		description: task.$assignedFields.contains('description') ? task.description : description,
		dueAt: task.$assignedFields.contains('dueAt') ? task.dueAt : dueAt,
		slaHours: task.$assignedFields.contains('slaHours') ? task.slaHours : slaHours,
		assignedToUserId: task.$assignedFields.contains('assignedToUserId') ? task.assignedToUserId : assignedToUserId,
		assignedToContactId: task.$assignedFields.contains('assignedToContactId') ? task.assignedToContactId : assignedToContactId,
		createdBy: task.$assignedFields.contains('createdBy') ? task.createdBy : createdBy,
		createdAt: task.$assignedFields.contains('createdAt') ? task.createdAt : createdAt,
		updatedAt: task.$assignedFields.contains('updatedAt') ? task.updatedAt : updatedAt,
		deletedAt: task.$assignedFields.contains('deletedAt') ? task.deletedAt : deletedAt,
		attachments: (task.$assignedFields.contains('attachments') && task.attachments != null) ? mergeModelLists(attachments, task.attachments) : attachments,
		assignedContact: task.$assignedFields.contains('assignedContact') ? task.assignedContact : assignedContact,
		assignedUser: task.$assignedFields.contains('assignedUser') ? task.assignedUser : assignedUser,
		booking: task.$assignedFields.contains('booking') ? task.booking : booking,
		contract: task.$assignedFields.contains('contract') ? task.contract : contract,
		lease: task.$assignedFields.contains('lease') ? task.lease : lease,
		listing: task.$assignedFields.contains('listing') ? task.listing : listing,
		org: task.$assignedFields.contains('org') ? task.org : org,
		project: task.$assignedFields.contains('project') ? task.project : project,
		property: task.$assignedFields.contains('property') ? task.property : property,
		reservation: task.$assignedFields.contains('reservation') ? task.reservation : reservation,
		agents: (task.$assignedFields.contains('agents') && task.agents != null) ? mergeModelLists(agents, task.agents) : agents,
		extraCharges: (task.$assignedFields.contains('extraCharges') && task.extraCharges != null) ? mergeModelLists(extraCharges, task.extraCharges) : extraCharges,
		agencies: (task.$assignedFields.contains('agencies') && task.agencies != null) ? mergeModelLists(agencies, task.agencies) : agencies,
		includedServices: (task.$assignedFields.contains('includedServices') && task.includedServices != null) ? mergeModelLists(includedServices, task.includedServices) : includedServices,
		analytics: (task.$assignedFields.contains('analytics') && task.analytics != null) ? mergeModelLists(analytics, task.analytics) : analytics,
		mentions: (task.$assignedFields.contains('mentions') && task.mentions != null) ? mergeModelLists(mentions, task.mentions) : mentions,
		$attachmentsCount: task.$attachmentsCount ?? $attachmentsCount,
		$agentsCount: task.$agentsCount ?? $agentsCount,
		$extraChargesCount: task.$extraChargesCount ?? $extraChargesCount,
		$agenciesCount: task.$agenciesCount ?? $agenciesCount,
		$includedServicesCount: task.$includedServicesCount ?? $includedServicesCount,
		$analyticsCount: task.$analyticsCount ?? $analyticsCount,
		$mentionsCount: task.$mentionsCount ?? $mentionsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Task updateWithInstanceValues(Task task) {
        if (task.$assignedFields.contains('id')) { id = task.id; }
		if (task.$assignedFields.contains('orgId')) { orgId = task.orgId; }
		if (task.$assignedFields.contains('propertyId')) { propertyId = task.propertyId; }
		if (task.$assignedFields.contains('listingId')) { listingId = task.listingId; }
		if (task.$assignedFields.contains('leaseId')) { leaseId = task.leaseId; }
		if (task.$assignedFields.contains('bookingId')) { bookingId = task.bookingId; }
		if (task.$assignedFields.contains('contractId')) { contractId = task.contractId; }
		if (task.$assignedFields.contains('reservationId')) { reservationId = task.reservationId; }
		if (task.$assignedFields.contains('projectId')) { projectId = task.projectId; }
		if (task.$assignedFields.contains('type')) { type = task.type; }
		if (task.$assignedFields.contains('status')) { status = task.status; }
		if (task.$assignedFields.contains('priority')) { priority = task.priority; }
		if (task.$assignedFields.contains('title')) { title = task.title; }
		if (task.$assignedFields.contains('description')) { description = task.description; }
		if (task.$assignedFields.contains('dueAt')) { dueAt = task.dueAt; }
		if (task.$assignedFields.contains('slaHours')) { slaHours = task.slaHours; }
		if (task.$assignedFields.contains('assignedToUserId')) { assignedToUserId = task.assignedToUserId; }
		if (task.$assignedFields.contains('assignedToContactId')) { assignedToContactId = task.assignedToContactId; }
		if (task.$assignedFields.contains('createdBy')) { createdBy = task.createdBy; }
		if (task.$assignedFields.contains('createdAt')) { createdAt = task.createdAt; }
		if (task.$assignedFields.contains('updatedAt')) { updatedAt = task.updatedAt; }
		if (task.$assignedFields.contains('deletedAt')) { deletedAt = task.deletedAt; }
		if (task.$assignedFields.contains('attachments') && task.attachments != null) { attachments = mergeModelLists(attachments, task.attachments); }
		if (task.$assignedFields.contains('assignedContact')) { assignedContact = task.assignedContact; }
		if (task.$assignedFields.contains('assignedUser')) { assignedUser = task.assignedUser; }
		if (task.$assignedFields.contains('booking')) { booking = task.booking; }
		if (task.$assignedFields.contains('contract')) { contract = task.contract; }
		if (task.$assignedFields.contains('lease')) { lease = task.lease; }
		if (task.$assignedFields.contains('listing')) { listing = task.listing; }
		if (task.$assignedFields.contains('org')) { org = task.org; }
		if (task.$assignedFields.contains('project')) { project = task.project; }
		if (task.$assignedFields.contains('property')) { property = task.property; }
		if (task.$assignedFields.contains('reservation')) { reservation = task.reservation; }
		if (task.$assignedFields.contains('agents') && task.agents != null) { agents = mergeModelLists(agents, task.agents); }
		if (task.$assignedFields.contains('extraCharges') && task.extraCharges != null) { extraCharges = mergeModelLists(extraCharges, task.extraCharges); }
		if (task.$assignedFields.contains('agencies') && task.agencies != null) { agencies = mergeModelLists(agencies, task.agencies); }
		if (task.$assignedFields.contains('includedServices') && task.includedServices != null) { includedServices = mergeModelLists(includedServices, task.includedServices); }
		if (task.$assignedFields.contains('analytics') && task.analytics != null) { analytics = mergeModelLists(analytics, task.analytics); }
		if (task.$assignedFields.contains('mentions') && task.mentions != null) { mentions = mergeModelLists(mentions, task.mentions); }
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
          ? {...?serializedTypes, 'Task'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(leaseId != null) 'leaseId': leaseId,
	if(bookingId != null) 'bookingId': bookingId,
	if(contractId != null) 'contractId': contractId,
	if(reservationId != null) 'reservationId': reservationId,
	if(projectId != null) 'projectId': projectId,
	if(type != null) 'type': type?.toJson(),
	if(status != null) 'status': status?.toJson(),
	if(priority != null) 'priority': priority?.toJson(),
	if(title != null) 'title': title,
	if(description != null) 'description': description,
	if(dueAt != null) 'dueAt': dueAt?.toIso8601String(),
	if(slaHours != null) 'slaHours': slaHours,
	if(assignedToUserId != null) 'assignedToUserId': assignedToUserId,
	if(assignedToContactId != null) 'assignedToContactId': assignedToContactId,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(attachments != null && (!preventCircularSerialization || !serializedModels.contains('Attachment'))) 'attachments': attachments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(assignedContact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'assignedContact': assignedContact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(assignedUser != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'assignedUser': assignedUser?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(booking != null && (!preventCircularSerialization || !serializedModels.contains('Booking'))) 'booking': booking?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(contract != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'contract': contract?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'lease': lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(project != null && (!preventCircularSerialization || !serializedModels.contains('Project'))) 'project': project?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'reservation': reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(agents != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'agents': agents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(extraCharges != null && (!preventCircularSerialization || !serializedModels.contains('ExtraCharge'))) 'extraCharges': extraCharges?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(includedServices != null && (!preventCircularSerialization || !serializedModels.contains('IncludedService'))) 'includedServices': includedServices?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(analytics != null && (!preventCircularSerialization || !serializedModels.contains('Analytics'))) 'analytics': analytics?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mentions != null && (!preventCircularSerialization || !serializedModels.contains('Mention'))) 'mentions': mentions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($attachmentsCount != null || $agentsCount != null || $extraChargesCount != null || $agenciesCount != null || $includedServicesCount != null || $analyticsCount != null || $mentionsCount != null) '_count': { 
		if ($attachmentsCount != null) 'attachments': $attachmentsCount, 
		if ($agentsCount != null) 'agents': $agentsCount, 
		if ($extraChargesCount != null) 'extraCharges': $extraChargesCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($includedServicesCount != null) 'includedServices': $includedServicesCount, 
		if ($analyticsCount != null) 'analytics': $analyticsCount, 
		if ($mentionsCount != null) 'mentions': $mentionsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Task &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    