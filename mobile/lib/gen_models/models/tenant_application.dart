
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'application_status.dart';
import 'contact.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';


class TenantApplication implements PrismaModel<String, TenantApplication> , Id<String> {
    @override
String? id;
	String? propertyId;
	String? listingId;
	String? applicantId;
	ApplicationStatus? status;
	DateTime? submittedAt;
	DateTime? reviewedAt;
	String? reviewedBy;
	dynamic applicationData;
	int? creditScore;
	bool? incomeVerified;
	bool? backgroundCheck;
	String? organizationId;
	Contact? applicant;
	Listing? listing;
	Organization? organization;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    TenantApplication({ this.id,
	 this.propertyId,
	 this.listingId,
	 this.applicantId,
	 this.status = ApplicationStatus.PENDING,
	 this.submittedAt,
	 this.reviewedAt,
	 this.reviewedBy,
	required this.applicationData,
	 this.creditScore,
	 this.incomeVerified = false,
	 this.backgroundCheck = false,
	 this.organizationId,
	 this.applicant,
	 this.listing,
	 this.organization,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<TenantApplication, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"applicantId": (m) => m.applicantId,

	"status": (m) => m.status,

	"submittedAt": (m) => m.submittedAt,

	"reviewedAt": (m) => m.reviewedAt,

	"reviewedBy": (m) => m.reviewedBy,

	"applicationData": (m) => m.applicationData,

	"creditScore": (m) => m.creditScore,

	"incomeVerified": (m) => m.incomeVerified,

	"backgroundCheck": (m) => m.backgroundCheck,

	"organizationId": (m) => m.organizationId,

	"applicant": (m) => m.applicant,

	"listing": (m) => m.listing,

	"organization": (m) => m.organization,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(TenantApplication) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in TenantApplication');
    }
    return propFunction as V? Function(TenantApplication);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory TenantApplication.fromJson(JsonMap json) =>
      TenantApplication(
        id: json['id'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	applicantId: json['applicantId'] as String?,
	status: json['status'] != null ? ApplicationStatus.fromJson(json['status']) : null,
	submittedAt: json['submittedAt'] != null ? DateTime.parse(json['submittedAt']) : null,
	reviewedAt: json['reviewedAt'] != null ? DateTime.parse(json['reviewedAt']) : null,
	reviewedBy: json['reviewedBy'] as String?,
	applicationData: json['applicationData'] as dynamic,
	creditScore: int.tryParse(json['creditScore'].toString()),
	incomeVerified: json['incomeVerified'] as bool?,
	backgroundCheck: json['backgroundCheck'] as bool?,
	organizationId: json['organizationId'] as String?,
	applicant: json['applicant'] != null ? Contact.fromJson(json['applicant'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	organization: json['organization'] != null ? Organization.fromJson(json['organization'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    TenantApplication copyWith({
        Value<String?>? id,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<String?>? applicantId,
		Value<ApplicationStatus?>? status,
		Value<DateTime?>? submittedAt,
		Value<DateTime?>? reviewedAt,
		Value<String?>? reviewedBy,
		Value<dynamic>? applicationData,
		Value<int?>? creditScore,
		Value<bool?>? incomeVerified,
		Value<bool?>? backgroundCheck,
		Value<String?>? organizationId,
		Value<Contact?>? applicant,
		Value<Listing?>? listing,
		Value<Organization?>? organization,
		Value<Property?>? property,
        }) {
        return TenantApplication(
            id: id != null ? id.value : this.id,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		applicantId: applicantId != null ? applicantId.value : this.applicantId,
		status: status != null ? status.value : this.status,
		submittedAt: submittedAt != null ? submittedAt.value : this.submittedAt,
		reviewedAt: reviewedAt != null ? reviewedAt.value : this.reviewedAt,
		reviewedBy: reviewedBy != null ? reviewedBy.value : this.reviewedBy,
		applicationData: applicationData != null ? applicationData.value : this.applicationData,
		creditScore: creditScore != null ? creditScore.value : this.creditScore,
		incomeVerified: incomeVerified != null ? incomeVerified.value : this.incomeVerified,
		backgroundCheck: backgroundCheck != null ? backgroundCheck.value : this.backgroundCheck,
		organizationId: organizationId != null ? organizationId.value : this.organizationId,
		applicant: applicant != null ? applicant.value : this.applicant,
		listing: listing != null ? listing.value : this.listing,
		organization: organization != null ? organization.value : this.organization,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    TenantApplication copyWithInstanceValues(TenantApplication tenantApplication) {
        return TenantApplication(
            id: tenantApplication.id ?? id,
		propertyId: tenantApplication.propertyId ?? propertyId,
		listingId: tenantApplication.listingId ?? listingId,
		applicantId: tenantApplication.applicantId ?? applicantId,
		status: tenantApplication.status ?? status,
		submittedAt: tenantApplication.submittedAt ?? submittedAt,
		reviewedAt: tenantApplication.reviewedAt ?? reviewedAt,
		reviewedBy: tenantApplication.reviewedBy ?? reviewedBy,
		applicationData: tenantApplication.applicationData ?? applicationData,
		creditScore: tenantApplication.creditScore ?? creditScore,
		incomeVerified: tenantApplication.incomeVerified ?? incomeVerified,
		backgroundCheck: tenantApplication.backgroundCheck ?? backgroundCheck,
		organizationId: tenantApplication.organizationId ?? organizationId,
		applicant: tenantApplication.applicant ?? applicant,
		listing: tenantApplication.listing ?? listing,
		organization: tenantApplication.organization ?? organization,
		property: tenantApplication.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    TenantApplication mergeWithInstanceValues(TenantApplication tenantApplication) {
        return TenantApplication(
            id: tenantApplication.$assignedFields.contains('id') ? tenantApplication.id : id,
		propertyId: tenantApplication.$assignedFields.contains('propertyId') ? tenantApplication.propertyId : propertyId,
		listingId: tenantApplication.$assignedFields.contains('listingId') ? tenantApplication.listingId : listingId,
		applicantId: tenantApplication.$assignedFields.contains('applicantId') ? tenantApplication.applicantId : applicantId,
		status: tenantApplication.$assignedFields.contains('status') ? tenantApplication.status : status,
		submittedAt: tenantApplication.$assignedFields.contains('submittedAt') ? tenantApplication.submittedAt : submittedAt,
		reviewedAt: tenantApplication.$assignedFields.contains('reviewedAt') ? tenantApplication.reviewedAt : reviewedAt,
		reviewedBy: tenantApplication.$assignedFields.contains('reviewedBy') ? tenantApplication.reviewedBy : reviewedBy,
		applicationData: tenantApplication.$assignedFields.contains('applicationData') ? tenantApplication.applicationData : applicationData,
		creditScore: tenantApplication.$assignedFields.contains('creditScore') ? tenantApplication.creditScore : creditScore,
		incomeVerified: tenantApplication.$assignedFields.contains('incomeVerified') ? tenantApplication.incomeVerified : incomeVerified,
		backgroundCheck: tenantApplication.$assignedFields.contains('backgroundCheck') ? tenantApplication.backgroundCheck : backgroundCheck,
		organizationId: tenantApplication.$assignedFields.contains('organizationId') ? tenantApplication.organizationId : organizationId,
		applicant: tenantApplication.$assignedFields.contains('applicant') ? tenantApplication.applicant : applicant,
		listing: tenantApplication.$assignedFields.contains('listing') ? tenantApplication.listing : listing,
		organization: tenantApplication.$assignedFields.contains('organization') ? tenantApplication.organization : organization,
		property: tenantApplication.$assignedFields.contains('property') ? tenantApplication.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    TenantApplication updateWithInstanceValues(TenantApplication tenantApplication) {
        if (tenantApplication.$assignedFields.contains('id')) { id = tenantApplication.id; }
		if (tenantApplication.$assignedFields.contains('propertyId')) { propertyId = tenantApplication.propertyId; }
		if (tenantApplication.$assignedFields.contains('listingId')) { listingId = tenantApplication.listingId; }
		if (tenantApplication.$assignedFields.contains('applicantId')) { applicantId = tenantApplication.applicantId; }
		if (tenantApplication.$assignedFields.contains('status')) { status = tenantApplication.status; }
		if (tenantApplication.$assignedFields.contains('submittedAt')) { submittedAt = tenantApplication.submittedAt; }
		if (tenantApplication.$assignedFields.contains('reviewedAt')) { reviewedAt = tenantApplication.reviewedAt; }
		if (tenantApplication.$assignedFields.contains('reviewedBy')) { reviewedBy = tenantApplication.reviewedBy; }
		if (tenantApplication.$assignedFields.contains('applicationData')) { applicationData = tenantApplication.applicationData; }
		if (tenantApplication.$assignedFields.contains('creditScore')) { creditScore = tenantApplication.creditScore; }
		if (tenantApplication.$assignedFields.contains('incomeVerified')) { incomeVerified = tenantApplication.incomeVerified; }
		if (tenantApplication.$assignedFields.contains('backgroundCheck')) { backgroundCheck = tenantApplication.backgroundCheck; }
		if (tenantApplication.$assignedFields.contains('organizationId')) { organizationId = tenantApplication.organizationId; }
		if (tenantApplication.$assignedFields.contains('applicant')) { applicant = tenantApplication.applicant; }
		if (tenantApplication.$assignedFields.contains('listing')) { listing = tenantApplication.listing; }
		if (tenantApplication.$assignedFields.contains('organization')) { organization = tenantApplication.organization; }
		if (tenantApplication.$assignedFields.contains('property')) { property = tenantApplication.property; }
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
          ? {...?serializedTypes, 'TenantApplication'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(applicantId != null) 'applicantId': applicantId,
	if(status != null) 'status': status?.toJson(),
	if(submittedAt != null) 'submittedAt': submittedAt?.toIso8601String(),
	if(reviewedAt != null) 'reviewedAt': reviewedAt?.toIso8601String(),
	if(reviewedBy != null) 'reviewedBy': reviewedBy,
	if(applicationData != null) 'applicationData': applicationData,
	if(creditScore != null) 'creditScore': creditScore,
	if(incomeVerified != null) 'incomeVerified': incomeVerified,
	if(backgroundCheck != null) 'backgroundCheck': backgroundCheck,
	if(organizationId != null) 'organizationId': organizationId,
	if(applicant != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'applicant': applicant?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(organization != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'organization': organization?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is TenantApplication &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    