
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';


class Quote implements PrismaModel<String, Quote> , Id<String> {
    @override
String? id;
	String? orgId;
	String? contactId;
	String? quoteNumber;
	String? title;
	String? description;
	String? propertyId;
	String? listingId;
	dynamic items;
	double? subtotal;
	double? taxAmount;
	double? totalAmount;
	String? currency;
	DateTime? validUntil;
	String? status;
	String? notes;
	String? terms;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contact? contact;
	Listing? listing;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Quote({ this.id,
	 this.orgId,
	 this.contactId,
	 this.quoteNumber,
	 this.title,
	 this.description,
	 this.propertyId,
	 this.listingId,
	required this.items,
	 this.subtotal,
	 this.taxAmount = 0,
	 this.totalAmount,
	 this.currency = "USD",
	 this.validUntil,
	 this.status = "DRAFT",
	 this.notes,
	 this.terms,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contact,
	 this.listing,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Quote, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"contactId": (m) => m.contactId,

	"quoteNumber": (m) => m.quoteNumber,

	"title": (m) => m.title,

	"description": (m) => m.description,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"items": (m) => m.items,

	"subtotal": (m) => m.subtotal,

	"taxAmount": (m) => m.taxAmount,

	"totalAmount": (m) => m.totalAmount,

	"currency": (m) => m.currency,

	"validUntil": (m) => m.validUntil,

	"status": (m) => m.status,

	"notes": (m) => m.notes,

	"terms": (m) => m.terms,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contact": (m) => m.contact,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Quote) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Quote');
    }
    return propFunction as V? Function(Quote);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Quote.fromJson(JsonMap json) =>
      Quote(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	contactId: json['contactId'] as String?,
	quoteNumber: json['quoteNumber'] as String?,
	title: json['title'] as String?,
	description: json['description'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	items: json['items'] as dynamic,
	subtotal: json['subtotal'] as double?,
	taxAmount: json['taxAmount'] as double?,
	totalAmount: json['totalAmount'] as double?,
	currency: json['currency'] as String?,
	validUntil: json['validUntil'] != null ? DateTime.parse(json['validUntil']) : null,
	status: json['status'] as String?,
	notes: json['notes'] as String?,
	terms: json['terms'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Quote copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? contactId,
		Value<String?>? quoteNumber,
		Value<String?>? title,
		Value<String?>? description,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<dynamic>? items,
		Value<double?>? subtotal,
		Value<double?>? taxAmount,
		Value<double?>? totalAmount,
		Value<String?>? currency,
		Value<DateTime?>? validUntil,
		Value<String?>? status,
		Value<String?>? notes,
		Value<String?>? terms,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contact?>? contact,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return Quote(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		contactId: contactId != null ? contactId.value : this.contactId,
		quoteNumber: quoteNumber != null ? quoteNumber.value : this.quoteNumber,
		title: title != null ? title.value : this.title,
		description: description != null ? description.value : this.description,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		items: items != null ? items.value : this.items,
		subtotal: subtotal != null ? subtotal.value : this.subtotal,
		taxAmount: taxAmount != null ? taxAmount.value : this.taxAmount,
		totalAmount: totalAmount != null ? totalAmount.value : this.totalAmount,
		currency: currency != null ? currency.value : this.currency,
		validUntil: validUntil != null ? validUntil.value : this.validUntil,
		status: status != null ? status.value : this.status,
		notes: notes != null ? notes.value : this.notes,
		terms: terms != null ? terms.value : this.terms,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contact: contact != null ? contact.value : this.contact,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Quote copyWithInstanceValues(Quote quote) {
        return Quote(
            id: quote.id ?? id,
		orgId: quote.orgId ?? orgId,
		contactId: quote.contactId ?? contactId,
		quoteNumber: quote.quoteNumber ?? quoteNumber,
		title: quote.title ?? title,
		description: quote.description ?? description,
		propertyId: quote.propertyId ?? propertyId,
		listingId: quote.listingId ?? listingId,
		items: quote.items ?? items,
		subtotal: quote.subtotal ?? subtotal,
		taxAmount: quote.taxAmount ?? taxAmount,
		totalAmount: quote.totalAmount ?? totalAmount,
		currency: quote.currency ?? currency,
		validUntil: quote.validUntil ?? validUntil,
		status: quote.status ?? status,
		notes: quote.notes ?? notes,
		terms: quote.terms ?? terms,
		createdBy: quote.createdBy ?? createdBy,
		createdAt: quote.createdAt ?? createdAt,
		updatedAt: quote.updatedAt ?? updatedAt,
		deletedAt: quote.deletedAt ?? deletedAt,
		contact: quote.contact ?? contact,
		listing: quote.listing ?? listing,
		org: quote.org ?? org,
		property: quote.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Quote mergeWithInstanceValues(Quote quote) {
        return Quote(
            id: quote.$assignedFields.contains('id') ? quote.id : id,
		orgId: quote.$assignedFields.contains('orgId') ? quote.orgId : orgId,
		contactId: quote.$assignedFields.contains('contactId') ? quote.contactId : contactId,
		quoteNumber: quote.$assignedFields.contains('quoteNumber') ? quote.quoteNumber : quoteNumber,
		title: quote.$assignedFields.contains('title') ? quote.title : title,
		description: quote.$assignedFields.contains('description') ? quote.description : description,
		propertyId: quote.$assignedFields.contains('propertyId') ? quote.propertyId : propertyId,
		listingId: quote.$assignedFields.contains('listingId') ? quote.listingId : listingId,
		items: quote.$assignedFields.contains('items') ? quote.items : items,
		subtotal: quote.$assignedFields.contains('subtotal') ? quote.subtotal : subtotal,
		taxAmount: quote.$assignedFields.contains('taxAmount') ? quote.taxAmount : taxAmount,
		totalAmount: quote.$assignedFields.contains('totalAmount') ? quote.totalAmount : totalAmount,
		currency: quote.$assignedFields.contains('currency') ? quote.currency : currency,
		validUntil: quote.$assignedFields.contains('validUntil') ? quote.validUntil : validUntil,
		status: quote.$assignedFields.contains('status') ? quote.status : status,
		notes: quote.$assignedFields.contains('notes') ? quote.notes : notes,
		terms: quote.$assignedFields.contains('terms') ? quote.terms : terms,
		createdBy: quote.$assignedFields.contains('createdBy') ? quote.createdBy : createdBy,
		createdAt: quote.$assignedFields.contains('createdAt') ? quote.createdAt : createdAt,
		updatedAt: quote.$assignedFields.contains('updatedAt') ? quote.updatedAt : updatedAt,
		deletedAt: quote.$assignedFields.contains('deletedAt') ? quote.deletedAt : deletedAt,
		contact: quote.$assignedFields.contains('contact') ? quote.contact : contact,
		listing: quote.$assignedFields.contains('listing') ? quote.listing : listing,
		org: quote.$assignedFields.contains('org') ? quote.org : org,
		property: quote.$assignedFields.contains('property') ? quote.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Quote updateWithInstanceValues(Quote quote) {
        if (quote.$assignedFields.contains('id')) { id = quote.id; }
		if (quote.$assignedFields.contains('orgId')) { orgId = quote.orgId; }
		if (quote.$assignedFields.contains('contactId')) { contactId = quote.contactId; }
		if (quote.$assignedFields.contains('quoteNumber')) { quoteNumber = quote.quoteNumber; }
		if (quote.$assignedFields.contains('title')) { title = quote.title; }
		if (quote.$assignedFields.contains('description')) { description = quote.description; }
		if (quote.$assignedFields.contains('propertyId')) { propertyId = quote.propertyId; }
		if (quote.$assignedFields.contains('listingId')) { listingId = quote.listingId; }
		if (quote.$assignedFields.contains('items')) { items = quote.items; }
		if (quote.$assignedFields.contains('subtotal')) { subtotal = quote.subtotal; }
		if (quote.$assignedFields.contains('taxAmount')) { taxAmount = quote.taxAmount; }
		if (quote.$assignedFields.contains('totalAmount')) { totalAmount = quote.totalAmount; }
		if (quote.$assignedFields.contains('currency')) { currency = quote.currency; }
		if (quote.$assignedFields.contains('validUntil')) { validUntil = quote.validUntil; }
		if (quote.$assignedFields.contains('status')) { status = quote.status; }
		if (quote.$assignedFields.contains('notes')) { notes = quote.notes; }
		if (quote.$assignedFields.contains('terms')) { terms = quote.terms; }
		if (quote.$assignedFields.contains('createdBy')) { createdBy = quote.createdBy; }
		if (quote.$assignedFields.contains('createdAt')) { createdAt = quote.createdAt; }
		if (quote.$assignedFields.contains('updatedAt')) { updatedAt = quote.updatedAt; }
		if (quote.$assignedFields.contains('deletedAt')) { deletedAt = quote.deletedAt; }
		if (quote.$assignedFields.contains('contact')) { contact = quote.contact; }
		if (quote.$assignedFields.contains('listing')) { listing = quote.listing; }
		if (quote.$assignedFields.contains('org')) { org = quote.org; }
		if (quote.$assignedFields.contains('property')) { property = quote.property; }
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
          ? {...?serializedTypes, 'Quote'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(contactId != null) 'contactId': contactId,
	if(quoteNumber != null) 'quoteNumber': quoteNumber,
	if(title != null) 'title': title,
	if(description != null) 'description': description,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(items != null) 'items': items,
	if(subtotal != null) 'subtotal': subtotal,
	if(taxAmount != null) 'taxAmount': taxAmount,
	if(totalAmount != null) 'totalAmount': totalAmount,
	if(currency != null) 'currency': currency,
	if(validUntil != null) 'validUntil': validUntil?.toIso8601String(),
	if(status != null) 'status': status,
	if(notes != null) 'notes': notes,
	if(terms != null) 'terms': terms,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Quote &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    