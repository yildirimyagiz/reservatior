
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contract_type.dart';
import 'contract_status.dart';
import 'booking.dart';
import 'lease.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'contract_version.dart';
import 'document.dart';
import 'signature_request.dart';
import 'task.dart';
import 'agency.dart';
import 'tenant.dart';
import 'increase.dart';


class Contract implements PrismaModel<String, Contract> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	String? leaseId;
	String? bookingId;
	ContractType? type;
	ContractStatus? status;
	String? title;
	DateTime? effectiveFrom;
	DateTime? effectiveTo;
	DateTime? nextRenewalAt;
	int? renewalNoticeDays;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Booking? booking;
	Lease? lease;
	Listing? listing;
	Organization? org;
	Property? property;
	List<ContractVersion>? versions;
	List<Document>? generalDocuments;
	List<SignatureRequest>? signatureRequests;
	List<Task>? tasks;
	List<Agency>? agencies;
	List<Tenant>? tenants;
	List<Increase>? increases;
	int? $versionsCount;
	int? $generalDocumentsCount;
	int? $signatureRequestsCount;
	int? $tasksCount;
	int? $agenciesCount;
	int? $tenantsCount;
	int? $increasesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Contract({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.leaseId,
	 this.bookingId,
	 this.type,
	 this.status = ContractStatus.DRAFT,
	 this.title,
	 this.effectiveFrom,
	 this.effectiveTo,
	 this.nextRenewalAt,
	 this.renewalNoticeDays,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.booking,
	 this.lease,
	 this.listing,
	 this.org,
	 this.property,
	 this.versions,
	 this.generalDocuments,
	 this.signatureRequests,
	 this.tasks,
	 this.agencies,
	 this.tenants,
	 this.increases,
	this.$versionsCount,
	this.$generalDocumentsCount,
	this.$signatureRequestsCount,
	this.$tasksCount,
	this.$agenciesCount,
	this.$tenantsCount,
	this.$increasesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Contract, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"leaseId": (m) => m.leaseId,

	"bookingId": (m) => m.bookingId,

	"type": (m) => m.type,

	"status": (m) => m.status,

	"title": (m) => m.title,

	"effectiveFrom": (m) => m.effectiveFrom,

	"effectiveTo": (m) => m.effectiveTo,

	"nextRenewalAt": (m) => m.nextRenewalAt,

	"renewalNoticeDays": (m) => m.renewalNoticeDays,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"booking": (m) => m.booking,

	"lease": (m) => m.lease,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"versions": (m) => m.versions,

	"generalDocuments": (m) => m.generalDocuments,

	"signatureRequests": (m) => m.signatureRequests,

	"tasks": (m) => m.tasks,

	"agencies": (m) => m.agencies,

	"tenants": (m) => m.tenants,

	"increases": (m) => m.increases,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Contract) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Contract');
    }
    return propFunction as V? Function(Contract);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Contract.fromJson(JsonMap json) =>
      Contract(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	leaseId: json['leaseId'] as String?,
	bookingId: json['bookingId'] as String?,
	type: json['type'] != null ? ContractType.fromJson(json['type']) : null,
	status: json['status'] != null ? ContractStatus.fromJson(json['status']) : null,
	title: json['title'] as String?,
	effectiveFrom: json['effectiveFrom'] != null ? DateTime.parse(json['effectiveFrom']) : null,
	effectiveTo: json['effectiveTo'] != null ? DateTime.parse(json['effectiveTo']) : null,
	nextRenewalAt: json['nextRenewalAt'] != null ? DateTime.parse(json['nextRenewalAt']) : null,
	renewalNoticeDays: int.tryParse(json['renewalNoticeDays'].toString()),
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	booking: json['booking'] != null ? Booking.fromJson(json['booking'] as JsonMap) : null,
	lease: json['lease'] != null ? Lease.fromJson(json['lease'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	versions: json['versions'] != null ? createModels<ContractVersion>((json['versions'] as List).cast<JsonMap>(), ContractVersion.fromJson) : null,
	generalDocuments: json['generalDocuments'] != null ? createModels<Document>((json['generalDocuments'] as List).cast<JsonMap>(), Document.fromJson) : null,
	signatureRequests: json['signatureRequests'] != null ? createModels<SignatureRequest>((json['signatureRequests'] as List).cast<JsonMap>(), SignatureRequest.fromJson) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	tenants: json['tenants'] != null ? createModels<Tenant>((json['tenants'] as List).cast<JsonMap>(), Tenant.fromJson) : null,
	increases: json['increases'] != null ? createModels<Increase>((json['increases'] as List).cast<JsonMap>(), Increase.fromJson) : null,
	$versionsCount: json['_count']?['versions'] as int?,
	$generalDocumentsCount: json['_count']?['generalDocuments'] as int?,
	$signatureRequestsCount: json['_count']?['signatureRequests'] as int?,
	$tasksCount: json['_count']?['tasks'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$tenantsCount: json['_count']?['tenants'] as int?,
	$increasesCount: json['_count']?['increases'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Contract copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<String?>? leaseId,
		Value<String?>? bookingId,
		Value<ContractType?>? type,
		Value<ContractStatus?>? status,
		Value<String?>? title,
		Value<DateTime?>? effectiveFrom,
		Value<DateTime?>? effectiveTo,
		Value<DateTime?>? nextRenewalAt,
		Value<int?>? renewalNoticeDays,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Booking?>? booking,
		Value<Lease?>? lease,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<List<ContractVersion>?>? versions,
		Value<List<Document>?>? generalDocuments,
		Value<List<SignatureRequest>?>? signatureRequests,
		Value<List<Task>?>? tasks,
		Value<List<Agency>?>? agencies,
		Value<List<Tenant>?>? tenants,
		Value<List<Increase>?>? increases,
		int? $versionsCount,
		int? $generalDocumentsCount,
		int? $signatureRequestsCount,
		int? $tasksCount,
		int? $agenciesCount,
		int? $tenantsCount,
		int? $increasesCount,
        }) {
        return Contract(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		bookingId: bookingId != null ? bookingId.value : this.bookingId,
		type: type != null ? type.value : this.type,
		status: status != null ? status.value : this.status,
		title: title != null ? title.value : this.title,
		effectiveFrom: effectiveFrom != null ? effectiveFrom.value : this.effectiveFrom,
		effectiveTo: effectiveTo != null ? effectiveTo.value : this.effectiveTo,
		nextRenewalAt: nextRenewalAt != null ? nextRenewalAt.value : this.nextRenewalAt,
		renewalNoticeDays: renewalNoticeDays != null ? renewalNoticeDays.value : this.renewalNoticeDays,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		booking: booking != null ? booking.value : this.booking,
		lease: lease != null ? lease.value : this.lease,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		versions: versions != null ? versions.value : this.versions,
		generalDocuments: generalDocuments != null ? generalDocuments.value : this.generalDocuments,
		signatureRequests: signatureRequests != null ? signatureRequests.value : this.signatureRequests,
		tasks: tasks != null ? tasks.value : this.tasks,
		agencies: agencies != null ? agencies.value : this.agencies,
		tenants: tenants != null ? tenants.value : this.tenants,
		increases: increases != null ? increases.value : this.increases,
		$versionsCount: $versionsCount ?? this.$versionsCount,
		$generalDocumentsCount: $generalDocumentsCount ?? this.$generalDocumentsCount,
		$signatureRequestsCount: $signatureRequestsCount ?? this.$signatureRequestsCount,
		$tasksCount: $tasksCount ?? this.$tasksCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$tenantsCount: $tenantsCount ?? this.$tenantsCount,
		$increasesCount: $increasesCount ?? this.$increasesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Contract copyWithInstanceValues(Contract contract) {
        return Contract(
            id: contract.id ?? id,
		orgId: contract.orgId ?? orgId,
		propertyId: contract.propertyId ?? propertyId,
		listingId: contract.listingId ?? listingId,
		leaseId: contract.leaseId ?? leaseId,
		bookingId: contract.bookingId ?? bookingId,
		type: contract.type ?? type,
		status: contract.status ?? status,
		title: contract.title ?? title,
		effectiveFrom: contract.effectiveFrom ?? effectiveFrom,
		effectiveTo: contract.effectiveTo ?? effectiveTo,
		nextRenewalAt: contract.nextRenewalAt ?? nextRenewalAt,
		renewalNoticeDays: contract.renewalNoticeDays ?? renewalNoticeDays,
		createdBy: contract.createdBy ?? createdBy,
		createdAt: contract.createdAt ?? createdAt,
		updatedAt: contract.updatedAt ?? updatedAt,
		deletedAt: contract.deletedAt ?? deletedAt,
		booking: contract.booking ?? booking,
		lease: contract.lease ?? lease,
		listing: contract.listing ?? listing,
		org: contract.org ?? org,
		property: contract.property ?? property,
		versions: contract.versions ?? versions,
		generalDocuments: contract.generalDocuments ?? generalDocuments,
		signatureRequests: contract.signatureRequests ?? signatureRequests,
		tasks: contract.tasks ?? tasks,
		agencies: contract.agencies ?? agencies,
		tenants: contract.tenants ?? tenants,
		increases: contract.increases ?? increases,
		$versionsCount: contract.$versionsCount ?? $versionsCount,
		$generalDocumentsCount: contract.$generalDocumentsCount ?? $generalDocumentsCount,
		$signatureRequestsCount: contract.$signatureRequestsCount ?? $signatureRequestsCount,
		$tasksCount: contract.$tasksCount ?? $tasksCount,
		$agenciesCount: contract.$agenciesCount ?? $agenciesCount,
		$tenantsCount: contract.$tenantsCount ?? $tenantsCount,
		$increasesCount: contract.$increasesCount ?? $increasesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Contract mergeWithInstanceValues(Contract contract) {
        return Contract(
            id: contract.$assignedFields.contains('id') ? contract.id : id,
		orgId: contract.$assignedFields.contains('orgId') ? contract.orgId : orgId,
		propertyId: contract.$assignedFields.contains('propertyId') ? contract.propertyId : propertyId,
		listingId: contract.$assignedFields.contains('listingId') ? contract.listingId : listingId,
		leaseId: contract.$assignedFields.contains('leaseId') ? contract.leaseId : leaseId,
		bookingId: contract.$assignedFields.contains('bookingId') ? contract.bookingId : bookingId,
		type: contract.$assignedFields.contains('type') ? contract.type : type,
		status: contract.$assignedFields.contains('status') ? contract.status : status,
		title: contract.$assignedFields.contains('title') ? contract.title : title,
		effectiveFrom: contract.$assignedFields.contains('effectiveFrom') ? contract.effectiveFrom : effectiveFrom,
		effectiveTo: contract.$assignedFields.contains('effectiveTo') ? contract.effectiveTo : effectiveTo,
		nextRenewalAt: contract.$assignedFields.contains('nextRenewalAt') ? contract.nextRenewalAt : nextRenewalAt,
		renewalNoticeDays: contract.$assignedFields.contains('renewalNoticeDays') ? contract.renewalNoticeDays : renewalNoticeDays,
		createdBy: contract.$assignedFields.contains('createdBy') ? contract.createdBy : createdBy,
		createdAt: contract.$assignedFields.contains('createdAt') ? contract.createdAt : createdAt,
		updatedAt: contract.$assignedFields.contains('updatedAt') ? contract.updatedAt : updatedAt,
		deletedAt: contract.$assignedFields.contains('deletedAt') ? contract.deletedAt : deletedAt,
		booking: contract.$assignedFields.contains('booking') ? contract.booking : booking,
		lease: contract.$assignedFields.contains('lease') ? contract.lease : lease,
		listing: contract.$assignedFields.contains('listing') ? contract.listing : listing,
		org: contract.$assignedFields.contains('org') ? contract.org : org,
		property: contract.$assignedFields.contains('property') ? contract.property : property,
		versions: (contract.$assignedFields.contains('versions') && contract.versions != null) ? mergeModelLists(versions, contract.versions) : versions,
		generalDocuments: (contract.$assignedFields.contains('generalDocuments') && contract.generalDocuments != null) ? mergeModelLists(generalDocuments, contract.generalDocuments) : generalDocuments,
		signatureRequests: (contract.$assignedFields.contains('signatureRequests') && contract.signatureRequests != null) ? mergeModelLists(signatureRequests, contract.signatureRequests) : signatureRequests,
		tasks: (contract.$assignedFields.contains('tasks') && contract.tasks != null) ? mergeModelLists(tasks, contract.tasks) : tasks,
		agencies: (contract.$assignedFields.contains('agencies') && contract.agencies != null) ? mergeModelLists(agencies, contract.agencies) : agencies,
		tenants: (contract.$assignedFields.contains('tenants') && contract.tenants != null) ? mergeModelLists(tenants, contract.tenants) : tenants,
		increases: (contract.$assignedFields.contains('increases') && contract.increases != null) ? mergeModelLists(increases, contract.increases) : increases,
		$versionsCount: contract.$versionsCount ?? $versionsCount,
		$generalDocumentsCount: contract.$generalDocumentsCount ?? $generalDocumentsCount,
		$signatureRequestsCount: contract.$signatureRequestsCount ?? $signatureRequestsCount,
		$tasksCount: contract.$tasksCount ?? $tasksCount,
		$agenciesCount: contract.$agenciesCount ?? $agenciesCount,
		$tenantsCount: contract.$tenantsCount ?? $tenantsCount,
		$increasesCount: contract.$increasesCount ?? $increasesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Contract updateWithInstanceValues(Contract contract) {
        if (contract.$assignedFields.contains('id')) { id = contract.id; }
		if (contract.$assignedFields.contains('orgId')) { orgId = contract.orgId; }
		if (contract.$assignedFields.contains('propertyId')) { propertyId = contract.propertyId; }
		if (contract.$assignedFields.contains('listingId')) { listingId = contract.listingId; }
		if (contract.$assignedFields.contains('leaseId')) { leaseId = contract.leaseId; }
		if (contract.$assignedFields.contains('bookingId')) { bookingId = contract.bookingId; }
		if (contract.$assignedFields.contains('type')) { type = contract.type; }
		if (contract.$assignedFields.contains('status')) { status = contract.status; }
		if (contract.$assignedFields.contains('title')) { title = contract.title; }
		if (contract.$assignedFields.contains('effectiveFrom')) { effectiveFrom = contract.effectiveFrom; }
		if (contract.$assignedFields.contains('effectiveTo')) { effectiveTo = contract.effectiveTo; }
		if (contract.$assignedFields.contains('nextRenewalAt')) { nextRenewalAt = contract.nextRenewalAt; }
		if (contract.$assignedFields.contains('renewalNoticeDays')) { renewalNoticeDays = contract.renewalNoticeDays; }
		if (contract.$assignedFields.contains('createdBy')) { createdBy = contract.createdBy; }
		if (contract.$assignedFields.contains('createdAt')) { createdAt = contract.createdAt; }
		if (contract.$assignedFields.contains('updatedAt')) { updatedAt = contract.updatedAt; }
		if (contract.$assignedFields.contains('deletedAt')) { deletedAt = contract.deletedAt; }
		if (contract.$assignedFields.contains('booking')) { booking = contract.booking; }
		if (contract.$assignedFields.contains('lease')) { lease = contract.lease; }
		if (contract.$assignedFields.contains('listing')) { listing = contract.listing; }
		if (contract.$assignedFields.contains('org')) { org = contract.org; }
		if (contract.$assignedFields.contains('property')) { property = contract.property; }
		if (contract.$assignedFields.contains('versions') && contract.versions != null) { versions = mergeModelLists(versions, contract.versions); }
		if (contract.$assignedFields.contains('generalDocuments') && contract.generalDocuments != null) { generalDocuments = mergeModelLists(generalDocuments, contract.generalDocuments); }
		if (contract.$assignedFields.contains('signatureRequests') && contract.signatureRequests != null) { signatureRequests = mergeModelLists(signatureRequests, contract.signatureRequests); }
		if (contract.$assignedFields.contains('tasks') && contract.tasks != null) { tasks = mergeModelLists(tasks, contract.tasks); }
		if (contract.$assignedFields.contains('agencies') && contract.agencies != null) { agencies = mergeModelLists(agencies, contract.agencies); }
		if (contract.$assignedFields.contains('tenants') && contract.tenants != null) { tenants = mergeModelLists(tenants, contract.tenants); }
		if (contract.$assignedFields.contains('increases') && contract.increases != null) { increases = mergeModelLists(increases, contract.increases); }
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
          ? {...?serializedTypes, 'Contract'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(leaseId != null) 'leaseId': leaseId,
	if(bookingId != null) 'bookingId': bookingId,
	if(type != null) 'type': type?.toJson(),
	if(status != null) 'status': status?.toJson(),
	if(title != null) 'title': title,
	if(effectiveFrom != null) 'effectiveFrom': effectiveFrom?.toIso8601String(),
	if(effectiveTo != null) 'effectiveTo': effectiveTo?.toIso8601String(),
	if(nextRenewalAt != null) 'nextRenewalAt': nextRenewalAt?.toIso8601String(),
	if(renewalNoticeDays != null) 'renewalNoticeDays': renewalNoticeDays,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(booking != null && (!preventCircularSerialization || !serializedModels.contains('Booking'))) 'booking': booking?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'lease': lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(versions != null && (!preventCircularSerialization || !serializedModels.contains('ContractVersion'))) 'versions': versions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(generalDocuments != null && (!preventCircularSerialization || !serializedModels.contains('Document'))) 'generalDocuments': generalDocuments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(signatureRequests != null && (!preventCircularSerialization || !serializedModels.contains('SignatureRequest'))) 'signatureRequests': signatureRequests?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tenants != null && (!preventCircularSerialization || !serializedModels.contains('Tenant'))) 'tenants': tenants?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(increases != null && (!preventCircularSerialization || !serializedModels.contains('Increase'))) 'increases': increases?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($versionsCount != null || $generalDocumentsCount != null || $signatureRequestsCount != null || $tasksCount != null || $agenciesCount != null || $tenantsCount != null || $increasesCount != null) '_count': { 
		if ($versionsCount != null) 'versions': $versionsCount, 
		if ($generalDocumentsCount != null) 'generalDocuments': $generalDocumentsCount, 
		if ($signatureRequestsCount != null) 'signatureRequests': $signatureRequestsCount, 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($tenantsCount != null) 'tenants': $tenantsCount, 
		if ($increasesCount != null) 'increases': $increasesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Contract &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    