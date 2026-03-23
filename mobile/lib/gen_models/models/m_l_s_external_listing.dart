
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'm_l_s_connection.dart';
import 'organization.dart';


class MLSExternalListing implements PrismaModel<String, MLSExternalListing> , Id<String> {
    @override
String? id;
	String? orgId;
	String? connectionId;
	String? externalId;
	String? externalUrl;
	dynamic raw;
	String? mappedListingId;
	String? status;
	DateTime? lastSeenAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	MLSConnection? connection;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MLSExternalListing({ this.id,
	 this.orgId,
	 this.connectionId,
	 this.externalId,
	 this.externalUrl,
	required this.raw,
	 this.mappedListingId,
	 this.status,
	 this.lastSeenAt,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.connection,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MLSExternalListing, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"connectionId": (m) => m.connectionId,

	"externalId": (m) => m.externalId,

	"externalUrl": (m) => m.externalUrl,

	"raw": (m) => m.raw,

	"mappedListingId": (m) => m.mappedListingId,

	"status": (m) => m.status,

	"lastSeenAt": (m) => m.lastSeenAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"connection": (m) => m.connection,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MLSExternalListing) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MLSExternalListing');
    }
    return propFunction as V? Function(MLSExternalListing);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MLSExternalListing.fromJson(JsonMap json) =>
      MLSExternalListing(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	connectionId: json['connectionId'] as String?,
	externalId: json['externalId'] as String?,
	externalUrl: json['externalUrl'] as String?,
	raw: json['raw'] as dynamic,
	mappedListingId: json['mappedListingId'] as String?,
	status: json['status'] as String?,
	lastSeenAt: json['lastSeenAt'] != null ? DateTime.parse(json['lastSeenAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	connection: json['connection'] != null ? MLSConnection.fromJson(json['connection'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MLSExternalListing copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? connectionId,
		Value<String?>? externalId,
		Value<String?>? externalUrl,
		Value<dynamic>? raw,
		Value<String?>? mappedListingId,
		Value<String?>? status,
		Value<DateTime?>? lastSeenAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<MLSConnection?>? connection,
		Value<Organization?>? org,
        }) {
        return MLSExternalListing(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		connectionId: connectionId != null ? connectionId.value : this.connectionId,
		externalId: externalId != null ? externalId.value : this.externalId,
		externalUrl: externalUrl != null ? externalUrl.value : this.externalUrl,
		raw: raw != null ? raw.value : this.raw,
		mappedListingId: mappedListingId != null ? mappedListingId.value : this.mappedListingId,
		status: status != null ? status.value : this.status,
		lastSeenAt: lastSeenAt != null ? lastSeenAt.value : this.lastSeenAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		connection: connection != null ? connection.value : this.connection,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MLSExternalListing copyWithInstanceValues(MLSExternalListing mLSExternalListing) {
        return MLSExternalListing(
            id: mLSExternalListing.id ?? id,
		orgId: mLSExternalListing.orgId ?? orgId,
		connectionId: mLSExternalListing.connectionId ?? connectionId,
		externalId: mLSExternalListing.externalId ?? externalId,
		externalUrl: mLSExternalListing.externalUrl ?? externalUrl,
		raw: mLSExternalListing.raw ?? raw,
		mappedListingId: mLSExternalListing.mappedListingId ?? mappedListingId,
		status: mLSExternalListing.status ?? status,
		lastSeenAt: mLSExternalListing.lastSeenAt ?? lastSeenAt,
		createdAt: mLSExternalListing.createdAt ?? createdAt,
		updatedAt: mLSExternalListing.updatedAt ?? updatedAt,
		deletedAt: mLSExternalListing.deletedAt ?? deletedAt,
		connection: mLSExternalListing.connection ?? connection,
		org: mLSExternalListing.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MLSExternalListing mergeWithInstanceValues(MLSExternalListing mLSExternalListing) {
        return MLSExternalListing(
            id: mLSExternalListing.$assignedFields.contains('id') ? mLSExternalListing.id : id,
		orgId: mLSExternalListing.$assignedFields.contains('orgId') ? mLSExternalListing.orgId : orgId,
		connectionId: mLSExternalListing.$assignedFields.contains('connectionId') ? mLSExternalListing.connectionId : connectionId,
		externalId: mLSExternalListing.$assignedFields.contains('externalId') ? mLSExternalListing.externalId : externalId,
		externalUrl: mLSExternalListing.$assignedFields.contains('externalUrl') ? mLSExternalListing.externalUrl : externalUrl,
		raw: mLSExternalListing.$assignedFields.contains('raw') ? mLSExternalListing.raw : raw,
		mappedListingId: mLSExternalListing.$assignedFields.contains('mappedListingId') ? mLSExternalListing.mappedListingId : mappedListingId,
		status: mLSExternalListing.$assignedFields.contains('status') ? mLSExternalListing.status : status,
		lastSeenAt: mLSExternalListing.$assignedFields.contains('lastSeenAt') ? mLSExternalListing.lastSeenAt : lastSeenAt,
		createdAt: mLSExternalListing.$assignedFields.contains('createdAt') ? mLSExternalListing.createdAt : createdAt,
		updatedAt: mLSExternalListing.$assignedFields.contains('updatedAt') ? mLSExternalListing.updatedAt : updatedAt,
		deletedAt: mLSExternalListing.$assignedFields.contains('deletedAt') ? mLSExternalListing.deletedAt : deletedAt,
		connection: mLSExternalListing.$assignedFields.contains('connection') ? mLSExternalListing.connection : connection,
		org: mLSExternalListing.$assignedFields.contains('org') ? mLSExternalListing.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MLSExternalListing updateWithInstanceValues(MLSExternalListing mLSExternalListing) {
        if (mLSExternalListing.$assignedFields.contains('id')) { id = mLSExternalListing.id; }
		if (mLSExternalListing.$assignedFields.contains('orgId')) { orgId = mLSExternalListing.orgId; }
		if (mLSExternalListing.$assignedFields.contains('connectionId')) { connectionId = mLSExternalListing.connectionId; }
		if (mLSExternalListing.$assignedFields.contains('externalId')) { externalId = mLSExternalListing.externalId; }
		if (mLSExternalListing.$assignedFields.contains('externalUrl')) { externalUrl = mLSExternalListing.externalUrl; }
		if (mLSExternalListing.$assignedFields.contains('raw')) { raw = mLSExternalListing.raw; }
		if (mLSExternalListing.$assignedFields.contains('mappedListingId')) { mappedListingId = mLSExternalListing.mappedListingId; }
		if (mLSExternalListing.$assignedFields.contains('status')) { status = mLSExternalListing.status; }
		if (mLSExternalListing.$assignedFields.contains('lastSeenAt')) { lastSeenAt = mLSExternalListing.lastSeenAt; }
		if (mLSExternalListing.$assignedFields.contains('createdAt')) { createdAt = mLSExternalListing.createdAt; }
		if (mLSExternalListing.$assignedFields.contains('updatedAt')) { updatedAt = mLSExternalListing.updatedAt; }
		if (mLSExternalListing.$assignedFields.contains('deletedAt')) { deletedAt = mLSExternalListing.deletedAt; }
		if (mLSExternalListing.$assignedFields.contains('connection')) { connection = mLSExternalListing.connection; }
		if (mLSExternalListing.$assignedFields.contains('org')) { org = mLSExternalListing.org; }
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
          ? {...?serializedTypes, 'MLSExternalListing'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(connectionId != null) 'connectionId': connectionId,
	if(externalId != null) 'externalId': externalId,
	if(externalUrl != null) 'externalUrl': externalUrl,
	if(raw != null) 'raw': raw,
	if(mappedListingId != null) 'mappedListingId': mappedListingId,
	if(status != null) 'status': status,
	if(lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(connection != null && (!preventCircularSerialization || !serializedModels.contains('MLSConnection'))) 'connection': connection?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MLSExternalListing &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    