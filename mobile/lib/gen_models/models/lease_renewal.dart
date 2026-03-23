
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'renewal_status.dart';
import 'lease.dart';
import 'listing.dart';
import 'organization.dart';


class LeaseRenewal implements PrismaModel<String, LeaseRenewal> , Id<String> {
    @override
String? id;
	String? leaseId;
	RenewalStatus? status;
	double? proposedRent;
	dynamic proposedTerms;
	DateTime? renewalDate;
	DateTime? responseDeadline;
	String? organizationId;
	String? listingId;
	Lease? lease;
	Listing? listing;
	Organization? organization;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    LeaseRenewal({ this.id,
	 this.leaseId,
	 this.status = RenewalStatus.PENDING,
	 this.proposedRent,
	required this.proposedTerms,
	 this.renewalDate,
	 this.responseDeadline,
	 this.organizationId,
	 this.listingId,
	 this.lease,
	 this.listing,
	 this.organization,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<LeaseRenewal, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"leaseId": (m) => m.leaseId,

	"status": (m) => m.status,

	"proposedRent": (m) => m.proposedRent,

	"proposedTerms": (m) => m.proposedTerms,

	"renewalDate": (m) => m.renewalDate,

	"responseDeadline": (m) => m.responseDeadline,

	"organizationId": (m) => m.organizationId,

	"listingId": (m) => m.listingId,

	"lease": (m) => m.lease,

	"listing": (m) => m.listing,

	"organization": (m) => m.organization,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(LeaseRenewal) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in LeaseRenewal');
    }
    return propFunction as V? Function(LeaseRenewal);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory LeaseRenewal.fromJson(JsonMap json) =>
      LeaseRenewal(
        id: json['id'] as String?,
	leaseId: json['leaseId'] as String?,
	status: json['status'] != null ? RenewalStatus.fromJson(json['status']) : null,
	proposedRent: json['proposedRent'] as double?,
	proposedTerms: json['proposedTerms'] as dynamic,
	renewalDate: json['renewalDate'] != null ? DateTime.parse(json['renewalDate']) : null,
	responseDeadline: json['responseDeadline'] != null ? DateTime.parse(json['responseDeadline']) : null,
	organizationId: json['organizationId'] as String?,
	listingId: json['listingId'] as String?,
	lease: json['lease'] != null ? Lease.fromJson(json['lease'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	organization: json['organization'] != null ? Organization.fromJson(json['organization'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    LeaseRenewal copyWith({
        Value<String?>? id,
		Value<String?>? leaseId,
		Value<RenewalStatus?>? status,
		Value<double?>? proposedRent,
		Value<dynamic>? proposedTerms,
		Value<DateTime?>? renewalDate,
		Value<DateTime?>? responseDeadline,
		Value<String?>? organizationId,
		Value<String?>? listingId,
		Value<Lease?>? lease,
		Value<Listing?>? listing,
		Value<Organization?>? organization,
        }) {
        return LeaseRenewal(
            id: id != null ? id.value : this.id,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		status: status != null ? status.value : this.status,
		proposedRent: proposedRent != null ? proposedRent.value : this.proposedRent,
		proposedTerms: proposedTerms != null ? proposedTerms.value : this.proposedTerms,
		renewalDate: renewalDate != null ? renewalDate.value : this.renewalDate,
		responseDeadline: responseDeadline != null ? responseDeadline.value : this.responseDeadline,
		organizationId: organizationId != null ? organizationId.value : this.organizationId,
		listingId: listingId != null ? listingId.value : this.listingId,
		lease: lease != null ? lease.value : this.lease,
		listing: listing != null ? listing.value : this.listing,
		organization: organization != null ? organization.value : this.organization
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    LeaseRenewal copyWithInstanceValues(LeaseRenewal leaseRenewal) {
        return LeaseRenewal(
            id: leaseRenewal.id ?? id,
		leaseId: leaseRenewal.leaseId ?? leaseId,
		status: leaseRenewal.status ?? status,
		proposedRent: leaseRenewal.proposedRent ?? proposedRent,
		proposedTerms: leaseRenewal.proposedTerms ?? proposedTerms,
		renewalDate: leaseRenewal.renewalDate ?? renewalDate,
		responseDeadline: leaseRenewal.responseDeadline ?? responseDeadline,
		organizationId: leaseRenewal.organizationId ?? organizationId,
		listingId: leaseRenewal.listingId ?? listingId,
		lease: leaseRenewal.lease ?? lease,
		listing: leaseRenewal.listing ?? listing,
		organization: leaseRenewal.organization ?? organization
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    LeaseRenewal mergeWithInstanceValues(LeaseRenewal leaseRenewal) {
        return LeaseRenewal(
            id: leaseRenewal.$assignedFields.contains('id') ? leaseRenewal.id : id,
		leaseId: leaseRenewal.$assignedFields.contains('leaseId') ? leaseRenewal.leaseId : leaseId,
		status: leaseRenewal.$assignedFields.contains('status') ? leaseRenewal.status : status,
		proposedRent: leaseRenewal.$assignedFields.contains('proposedRent') ? leaseRenewal.proposedRent : proposedRent,
		proposedTerms: leaseRenewal.$assignedFields.contains('proposedTerms') ? leaseRenewal.proposedTerms : proposedTerms,
		renewalDate: leaseRenewal.$assignedFields.contains('renewalDate') ? leaseRenewal.renewalDate : renewalDate,
		responseDeadline: leaseRenewal.$assignedFields.contains('responseDeadline') ? leaseRenewal.responseDeadline : responseDeadline,
		organizationId: leaseRenewal.$assignedFields.contains('organizationId') ? leaseRenewal.organizationId : organizationId,
		listingId: leaseRenewal.$assignedFields.contains('listingId') ? leaseRenewal.listingId : listingId,
		lease: leaseRenewal.$assignedFields.contains('lease') ? leaseRenewal.lease : lease,
		listing: leaseRenewal.$assignedFields.contains('listing') ? leaseRenewal.listing : listing,
		organization: leaseRenewal.$assignedFields.contains('organization') ? leaseRenewal.organization : organization
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    LeaseRenewal updateWithInstanceValues(LeaseRenewal leaseRenewal) {
        if (leaseRenewal.$assignedFields.contains('id')) { id = leaseRenewal.id; }
		if (leaseRenewal.$assignedFields.contains('leaseId')) { leaseId = leaseRenewal.leaseId; }
		if (leaseRenewal.$assignedFields.contains('status')) { status = leaseRenewal.status; }
		if (leaseRenewal.$assignedFields.contains('proposedRent')) { proposedRent = leaseRenewal.proposedRent; }
		if (leaseRenewal.$assignedFields.contains('proposedTerms')) { proposedTerms = leaseRenewal.proposedTerms; }
		if (leaseRenewal.$assignedFields.contains('renewalDate')) { renewalDate = leaseRenewal.renewalDate; }
		if (leaseRenewal.$assignedFields.contains('responseDeadline')) { responseDeadline = leaseRenewal.responseDeadline; }
		if (leaseRenewal.$assignedFields.contains('organizationId')) { organizationId = leaseRenewal.organizationId; }
		if (leaseRenewal.$assignedFields.contains('listingId')) { listingId = leaseRenewal.listingId; }
		if (leaseRenewal.$assignedFields.contains('lease')) { lease = leaseRenewal.lease; }
		if (leaseRenewal.$assignedFields.contains('listing')) { listing = leaseRenewal.listing; }
		if (leaseRenewal.$assignedFields.contains('organization')) { organization = leaseRenewal.organization; }
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
          ? {...?serializedTypes, 'LeaseRenewal'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(leaseId != null) 'leaseId': leaseId,
	if(status != null) 'status': status?.toJson(),
	if(proposedRent != null) 'proposedRent': proposedRent,
	if(proposedTerms != null) 'proposedTerms': proposedTerms,
	if(renewalDate != null) 'renewalDate': renewalDate?.toIso8601String(),
	if(responseDeadline != null) 'responseDeadline': responseDeadline?.toIso8601String(),
	if(organizationId != null) 'organizationId': organizationId,
	if(listingId != null) 'listingId': listingId,
	if(lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'lease': lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(organization != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'organization': organization?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is LeaseRenewal &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    