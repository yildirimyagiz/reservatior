
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';


class PropertyOffer implements PrismaModel<String, PropertyOffer> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	String? contactId;
	String? originalOfferId;
	double? offerPrice;
	String? currency;
	DateTime? closingDate;
	String? financingType;
	double? earnestMoneyDeposit;
	int? dueDiligencePeriod;
	bool? inspectionContingency;
	bool? appraisalContingency;
	String? specialConditions;
	String? status;
	DateTime? validUntil;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contact? contact;
	Listing? listing;
	Organization? org;
	PropertyOffer? originalOffer;
	List<PropertyOffer>? counterOffers;
	Property? property;
	int? $counterOffersCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PropertyOffer({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.contactId,
	 this.originalOfferId,
	 this.offerPrice,
	 this.currency = "USD",
	 this.closingDate,
	 this.financingType,
	 this.earnestMoneyDeposit,
	 this.dueDiligencePeriod,
	 this.inspectionContingency = true,
	 this.appraisalContingency = true,
	 this.specialConditions,
	 this.status = "PENDING",
	 this.validUntil,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contact,
	 this.listing,
	 this.org,
	 this.originalOffer,
	 this.counterOffers,
	 this.property,
	this.$counterOffersCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PropertyOffer, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"contactId": (m) => m.contactId,

	"originalOfferId": (m) => m.originalOfferId,

	"offerPrice": (m) => m.offerPrice,

	"currency": (m) => m.currency,

	"closingDate": (m) => m.closingDate,

	"financingType": (m) => m.financingType,

	"earnestMoneyDeposit": (m) => m.earnestMoneyDeposit,

	"dueDiligencePeriod": (m) => m.dueDiligencePeriod,

	"inspectionContingency": (m) => m.inspectionContingency,

	"appraisalContingency": (m) => m.appraisalContingency,

	"specialConditions": (m) => m.specialConditions,

	"status": (m) => m.status,

	"validUntil": (m) => m.validUntil,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contact": (m) => m.contact,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"originalOffer": (m) => m.originalOffer,

	"counterOffers": (m) => m.counterOffers,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PropertyOffer) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PropertyOffer');
    }
    return propFunction as V? Function(PropertyOffer);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PropertyOffer.fromJson(JsonMap json) =>
      PropertyOffer(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	contactId: json['contactId'] as String?,
	originalOfferId: json['originalOfferId'] as String?,
	offerPrice: json['offerPrice'] as double?,
	currency: json['currency'] as String?,
	closingDate: json['closingDate'] != null ? DateTime.parse(json['closingDate']) : null,
	financingType: json['financingType'] as String?,
	earnestMoneyDeposit: json['earnestMoneyDeposit'] as double?,
	dueDiligencePeriod: int.tryParse(json['dueDiligencePeriod'].toString()),
	inspectionContingency: json['inspectionContingency'] as bool?,
	appraisalContingency: json['appraisalContingency'] as bool?,
	specialConditions: json['specialConditions'] as String?,
	status: json['status'] as String?,
	validUntil: json['validUntil'] != null ? DateTime.parse(json['validUntil']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	originalOffer: json['originalOffer'] != null ? PropertyOffer.fromJson(json['originalOffer'] as JsonMap) : null,
	counterOffers: json['counterOffers'] != null ? createModels<PropertyOffer>((json['counterOffers'] as List).cast<JsonMap>(), PropertyOffer.fromJson) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	$counterOffersCount: json['_count']?['counterOffers'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PropertyOffer copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<String?>? contactId,
		Value<String?>? originalOfferId,
		Value<double?>? offerPrice,
		Value<String?>? currency,
		Value<DateTime?>? closingDate,
		Value<String?>? financingType,
		Value<double?>? earnestMoneyDeposit,
		Value<int?>? dueDiligencePeriod,
		Value<bool?>? inspectionContingency,
		Value<bool?>? appraisalContingency,
		Value<String?>? specialConditions,
		Value<String?>? status,
		Value<DateTime?>? validUntil,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contact?>? contact,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<PropertyOffer?>? originalOffer,
		Value<List<PropertyOffer>?>? counterOffers,
		Value<Property?>? property,
		int? $counterOffersCount,
        }) {
        return PropertyOffer(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		contactId: contactId != null ? contactId.value : this.contactId,
		originalOfferId: originalOfferId != null ? originalOfferId.value : this.originalOfferId,
		offerPrice: offerPrice != null ? offerPrice.value : this.offerPrice,
		currency: currency != null ? currency.value : this.currency,
		closingDate: closingDate != null ? closingDate.value : this.closingDate,
		financingType: financingType != null ? financingType.value : this.financingType,
		earnestMoneyDeposit: earnestMoneyDeposit != null ? earnestMoneyDeposit.value : this.earnestMoneyDeposit,
		dueDiligencePeriod: dueDiligencePeriod != null ? dueDiligencePeriod.value : this.dueDiligencePeriod,
		inspectionContingency: inspectionContingency != null ? inspectionContingency.value : this.inspectionContingency,
		appraisalContingency: appraisalContingency != null ? appraisalContingency.value : this.appraisalContingency,
		specialConditions: specialConditions != null ? specialConditions.value : this.specialConditions,
		status: status != null ? status.value : this.status,
		validUntil: validUntil != null ? validUntil.value : this.validUntil,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contact: contact != null ? contact.value : this.contact,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		originalOffer: originalOffer != null ? originalOffer.value : this.originalOffer,
		counterOffers: counterOffers != null ? counterOffers.value : this.counterOffers,
		property: property != null ? property.value : this.property,
		$counterOffersCount: $counterOffersCount ?? this.$counterOffersCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PropertyOffer copyWithInstanceValues(PropertyOffer propertyOffer) {
        return PropertyOffer(
            id: propertyOffer.id ?? id,
		orgId: propertyOffer.orgId ?? orgId,
		propertyId: propertyOffer.propertyId ?? propertyId,
		listingId: propertyOffer.listingId ?? listingId,
		contactId: propertyOffer.contactId ?? contactId,
		originalOfferId: propertyOffer.originalOfferId ?? originalOfferId,
		offerPrice: propertyOffer.offerPrice ?? offerPrice,
		currency: propertyOffer.currency ?? currency,
		closingDate: propertyOffer.closingDate ?? closingDate,
		financingType: propertyOffer.financingType ?? financingType,
		earnestMoneyDeposit: propertyOffer.earnestMoneyDeposit ?? earnestMoneyDeposit,
		dueDiligencePeriod: propertyOffer.dueDiligencePeriod ?? dueDiligencePeriod,
		inspectionContingency: propertyOffer.inspectionContingency ?? inspectionContingency,
		appraisalContingency: propertyOffer.appraisalContingency ?? appraisalContingency,
		specialConditions: propertyOffer.specialConditions ?? specialConditions,
		status: propertyOffer.status ?? status,
		validUntil: propertyOffer.validUntil ?? validUntil,
		createdAt: propertyOffer.createdAt ?? createdAt,
		updatedAt: propertyOffer.updatedAt ?? updatedAt,
		deletedAt: propertyOffer.deletedAt ?? deletedAt,
		contact: propertyOffer.contact ?? contact,
		listing: propertyOffer.listing ?? listing,
		org: propertyOffer.org ?? org,
		originalOffer: propertyOffer.originalOffer ?? originalOffer,
		counterOffers: propertyOffer.counterOffers ?? counterOffers,
		property: propertyOffer.property ?? property,
		$counterOffersCount: propertyOffer.$counterOffersCount ?? $counterOffersCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PropertyOffer mergeWithInstanceValues(PropertyOffer propertyOffer) {
        return PropertyOffer(
            id: propertyOffer.$assignedFields.contains('id') ? propertyOffer.id : id,
		orgId: propertyOffer.$assignedFields.contains('orgId') ? propertyOffer.orgId : orgId,
		propertyId: propertyOffer.$assignedFields.contains('propertyId') ? propertyOffer.propertyId : propertyId,
		listingId: propertyOffer.$assignedFields.contains('listingId') ? propertyOffer.listingId : listingId,
		contactId: propertyOffer.$assignedFields.contains('contactId') ? propertyOffer.contactId : contactId,
		originalOfferId: propertyOffer.$assignedFields.contains('originalOfferId') ? propertyOffer.originalOfferId : originalOfferId,
		offerPrice: propertyOffer.$assignedFields.contains('offerPrice') ? propertyOffer.offerPrice : offerPrice,
		currency: propertyOffer.$assignedFields.contains('currency') ? propertyOffer.currency : currency,
		closingDate: propertyOffer.$assignedFields.contains('closingDate') ? propertyOffer.closingDate : closingDate,
		financingType: propertyOffer.$assignedFields.contains('financingType') ? propertyOffer.financingType : financingType,
		earnestMoneyDeposit: propertyOffer.$assignedFields.contains('earnestMoneyDeposit') ? propertyOffer.earnestMoneyDeposit : earnestMoneyDeposit,
		dueDiligencePeriod: propertyOffer.$assignedFields.contains('dueDiligencePeriod') ? propertyOffer.dueDiligencePeriod : dueDiligencePeriod,
		inspectionContingency: propertyOffer.$assignedFields.contains('inspectionContingency') ? propertyOffer.inspectionContingency : inspectionContingency,
		appraisalContingency: propertyOffer.$assignedFields.contains('appraisalContingency') ? propertyOffer.appraisalContingency : appraisalContingency,
		specialConditions: propertyOffer.$assignedFields.contains('specialConditions') ? propertyOffer.specialConditions : specialConditions,
		status: propertyOffer.$assignedFields.contains('status') ? propertyOffer.status : status,
		validUntil: propertyOffer.$assignedFields.contains('validUntil') ? propertyOffer.validUntil : validUntil,
		createdAt: propertyOffer.$assignedFields.contains('createdAt') ? propertyOffer.createdAt : createdAt,
		updatedAt: propertyOffer.$assignedFields.contains('updatedAt') ? propertyOffer.updatedAt : updatedAt,
		deletedAt: propertyOffer.$assignedFields.contains('deletedAt') ? propertyOffer.deletedAt : deletedAt,
		contact: propertyOffer.$assignedFields.contains('contact') ? propertyOffer.contact : contact,
		listing: propertyOffer.$assignedFields.contains('listing') ? propertyOffer.listing : listing,
		org: propertyOffer.$assignedFields.contains('org') ? propertyOffer.org : org,
		originalOffer: propertyOffer.$assignedFields.contains('originalOffer') ? propertyOffer.originalOffer : originalOffer,
		counterOffers: (propertyOffer.$assignedFields.contains('counterOffers') && propertyOffer.counterOffers != null) ? mergeModelLists(counterOffers, propertyOffer.counterOffers) : counterOffers,
		property: propertyOffer.$assignedFields.contains('property') ? propertyOffer.property : property,
		$counterOffersCount: propertyOffer.$counterOffersCount ?? $counterOffersCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PropertyOffer updateWithInstanceValues(PropertyOffer propertyOffer) {
        if (propertyOffer.$assignedFields.contains('id')) { id = propertyOffer.id; }
		if (propertyOffer.$assignedFields.contains('orgId')) { orgId = propertyOffer.orgId; }
		if (propertyOffer.$assignedFields.contains('propertyId')) { propertyId = propertyOffer.propertyId; }
		if (propertyOffer.$assignedFields.contains('listingId')) { listingId = propertyOffer.listingId; }
		if (propertyOffer.$assignedFields.contains('contactId')) { contactId = propertyOffer.contactId; }
		if (propertyOffer.$assignedFields.contains('originalOfferId')) { originalOfferId = propertyOffer.originalOfferId; }
		if (propertyOffer.$assignedFields.contains('offerPrice')) { offerPrice = propertyOffer.offerPrice; }
		if (propertyOffer.$assignedFields.contains('currency')) { currency = propertyOffer.currency; }
		if (propertyOffer.$assignedFields.contains('closingDate')) { closingDate = propertyOffer.closingDate; }
		if (propertyOffer.$assignedFields.contains('financingType')) { financingType = propertyOffer.financingType; }
		if (propertyOffer.$assignedFields.contains('earnestMoneyDeposit')) { earnestMoneyDeposit = propertyOffer.earnestMoneyDeposit; }
		if (propertyOffer.$assignedFields.contains('dueDiligencePeriod')) { dueDiligencePeriod = propertyOffer.dueDiligencePeriod; }
		if (propertyOffer.$assignedFields.contains('inspectionContingency')) { inspectionContingency = propertyOffer.inspectionContingency; }
		if (propertyOffer.$assignedFields.contains('appraisalContingency')) { appraisalContingency = propertyOffer.appraisalContingency; }
		if (propertyOffer.$assignedFields.contains('specialConditions')) { specialConditions = propertyOffer.specialConditions; }
		if (propertyOffer.$assignedFields.contains('status')) { status = propertyOffer.status; }
		if (propertyOffer.$assignedFields.contains('validUntil')) { validUntil = propertyOffer.validUntil; }
		if (propertyOffer.$assignedFields.contains('createdAt')) { createdAt = propertyOffer.createdAt; }
		if (propertyOffer.$assignedFields.contains('updatedAt')) { updatedAt = propertyOffer.updatedAt; }
		if (propertyOffer.$assignedFields.contains('deletedAt')) { deletedAt = propertyOffer.deletedAt; }
		if (propertyOffer.$assignedFields.contains('contact')) { contact = propertyOffer.contact; }
		if (propertyOffer.$assignedFields.contains('listing')) { listing = propertyOffer.listing; }
		if (propertyOffer.$assignedFields.contains('org')) { org = propertyOffer.org; }
		if (propertyOffer.$assignedFields.contains('originalOffer')) { originalOffer = propertyOffer.originalOffer; }
		if (propertyOffer.$assignedFields.contains('counterOffers') && propertyOffer.counterOffers != null) { counterOffers = mergeModelLists(counterOffers, propertyOffer.counterOffers); }
		if (propertyOffer.$assignedFields.contains('property')) { property = propertyOffer.property; }
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
          ? {...?serializedTypes, 'PropertyOffer'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(contactId != null) 'contactId': contactId,
	if(originalOfferId != null) 'originalOfferId': originalOfferId,
	if(offerPrice != null) 'offerPrice': offerPrice,
	if(currency != null) 'currency': currency,
	if(closingDate != null) 'closingDate': closingDate?.toIso8601String(),
	if(financingType != null) 'financingType': financingType,
	if(earnestMoneyDeposit != null) 'earnestMoneyDeposit': earnestMoneyDeposit,
	if(dueDiligencePeriod != null) 'dueDiligencePeriod': dueDiligencePeriod,
	if(inspectionContingency != null) 'inspectionContingency': inspectionContingency,
	if(appraisalContingency != null) 'appraisalContingency': appraisalContingency,
	if(specialConditions != null) 'specialConditions': specialConditions,
	if(status != null) 'status': status,
	if(validUntil != null) 'validUntil': validUntil?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(originalOffer != null && (!preventCircularSerialization || !serializedModels.contains('PropertyOffer'))) 'originalOffer': originalOffer?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(counterOffers != null && (!preventCircularSerialization || !serializedModels.contains('PropertyOffer'))) 'counterOffers': counterOffers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($counterOffersCount != null) '_count': { 
		if ($counterOffersCount != null) 'counterOffers': $counterOffersCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PropertyOffer &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    