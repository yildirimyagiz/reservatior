
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'listing.dart';
import 'organization.dart';


class MlsListingEnhancement implements PrismaModel<String, MlsListingEnhancement> , Id<String> {
    @override
String? id;
	String? orgId;
	String? listingId;
	String? mlsNumber;
	String? mlsStatus;
	dynamic mlsPhotos;
	dynamic mlsDocuments;
	dynamic mlsHistory;
	DateTime? lastMlsUpdate;
	DateTime? createdAt;
	DateTime? updatedAt;
	Listing? listing;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MlsListingEnhancement({ this.id,
	 this.orgId,
	 this.listingId,
	 this.mlsNumber,
	 this.mlsStatus,
	required this.mlsPhotos,
	required this.mlsDocuments,
	required this.mlsHistory,
	 this.lastMlsUpdate,
	 this.createdAt,
	 this.updatedAt,
	 this.listing,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MlsListingEnhancement, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"listingId": (m) => m.listingId,

	"mlsNumber": (m) => m.mlsNumber,

	"mlsStatus": (m) => m.mlsStatus,

	"mlsPhotos": (m) => m.mlsPhotos,

	"mlsDocuments": (m) => m.mlsDocuments,

	"mlsHistory": (m) => m.mlsHistory,

	"lastMlsUpdate": (m) => m.lastMlsUpdate,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"listing": (m) => m.listing,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MlsListingEnhancement) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MlsListingEnhancement');
    }
    return propFunction as V? Function(MlsListingEnhancement);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MlsListingEnhancement.fromJson(JsonMap json) =>
      MlsListingEnhancement(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	listingId: json['listingId'] as String?,
	mlsNumber: json['mlsNumber'] as String?,
	mlsStatus: json['mlsStatus'] as String?,
	mlsPhotos: json['mlsPhotos'] as dynamic,
	mlsDocuments: json['mlsDocuments'] as dynamic,
	mlsHistory: json['mlsHistory'] as dynamic,
	lastMlsUpdate: json['lastMlsUpdate'] != null ? DateTime.parse(json['lastMlsUpdate']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MlsListingEnhancement copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? listingId,
		Value<String?>? mlsNumber,
		Value<String?>? mlsStatus,
		Value<dynamic>? mlsPhotos,
		Value<dynamic>? mlsDocuments,
		Value<dynamic>? mlsHistory,
		Value<DateTime?>? lastMlsUpdate,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Listing?>? listing,
		Value<Organization?>? org,
        }) {
        return MlsListingEnhancement(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		listingId: listingId != null ? listingId.value : this.listingId,
		mlsNumber: mlsNumber != null ? mlsNumber.value : this.mlsNumber,
		mlsStatus: mlsStatus != null ? mlsStatus.value : this.mlsStatus,
		mlsPhotos: mlsPhotos != null ? mlsPhotos.value : this.mlsPhotos,
		mlsDocuments: mlsDocuments != null ? mlsDocuments.value : this.mlsDocuments,
		mlsHistory: mlsHistory != null ? mlsHistory.value : this.mlsHistory,
		lastMlsUpdate: lastMlsUpdate != null ? lastMlsUpdate.value : this.lastMlsUpdate,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MlsListingEnhancement copyWithInstanceValues(MlsListingEnhancement mlsListingEnhancement) {
        return MlsListingEnhancement(
            id: mlsListingEnhancement.id ?? id,
		orgId: mlsListingEnhancement.orgId ?? orgId,
		listingId: mlsListingEnhancement.listingId ?? listingId,
		mlsNumber: mlsListingEnhancement.mlsNumber ?? mlsNumber,
		mlsStatus: mlsListingEnhancement.mlsStatus ?? mlsStatus,
		mlsPhotos: mlsListingEnhancement.mlsPhotos ?? mlsPhotos,
		mlsDocuments: mlsListingEnhancement.mlsDocuments ?? mlsDocuments,
		mlsHistory: mlsListingEnhancement.mlsHistory ?? mlsHistory,
		lastMlsUpdate: mlsListingEnhancement.lastMlsUpdate ?? lastMlsUpdate,
		createdAt: mlsListingEnhancement.createdAt ?? createdAt,
		updatedAt: mlsListingEnhancement.updatedAt ?? updatedAt,
		listing: mlsListingEnhancement.listing ?? listing,
		org: mlsListingEnhancement.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MlsListingEnhancement mergeWithInstanceValues(MlsListingEnhancement mlsListingEnhancement) {
        return MlsListingEnhancement(
            id: mlsListingEnhancement.$assignedFields.contains('id') ? mlsListingEnhancement.id : id,
		orgId: mlsListingEnhancement.$assignedFields.contains('orgId') ? mlsListingEnhancement.orgId : orgId,
		listingId: mlsListingEnhancement.$assignedFields.contains('listingId') ? mlsListingEnhancement.listingId : listingId,
		mlsNumber: mlsListingEnhancement.$assignedFields.contains('mlsNumber') ? mlsListingEnhancement.mlsNumber : mlsNumber,
		mlsStatus: mlsListingEnhancement.$assignedFields.contains('mlsStatus') ? mlsListingEnhancement.mlsStatus : mlsStatus,
		mlsPhotos: mlsListingEnhancement.$assignedFields.contains('mlsPhotos') ? mlsListingEnhancement.mlsPhotos : mlsPhotos,
		mlsDocuments: mlsListingEnhancement.$assignedFields.contains('mlsDocuments') ? mlsListingEnhancement.mlsDocuments : mlsDocuments,
		mlsHistory: mlsListingEnhancement.$assignedFields.contains('mlsHistory') ? mlsListingEnhancement.mlsHistory : mlsHistory,
		lastMlsUpdate: mlsListingEnhancement.$assignedFields.contains('lastMlsUpdate') ? mlsListingEnhancement.lastMlsUpdate : lastMlsUpdate,
		createdAt: mlsListingEnhancement.$assignedFields.contains('createdAt') ? mlsListingEnhancement.createdAt : createdAt,
		updatedAt: mlsListingEnhancement.$assignedFields.contains('updatedAt') ? mlsListingEnhancement.updatedAt : updatedAt,
		listing: mlsListingEnhancement.$assignedFields.contains('listing') ? mlsListingEnhancement.listing : listing,
		org: mlsListingEnhancement.$assignedFields.contains('org') ? mlsListingEnhancement.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MlsListingEnhancement updateWithInstanceValues(MlsListingEnhancement mlsListingEnhancement) {
        if (mlsListingEnhancement.$assignedFields.contains('id')) { id = mlsListingEnhancement.id; }
		if (mlsListingEnhancement.$assignedFields.contains('orgId')) { orgId = mlsListingEnhancement.orgId; }
		if (mlsListingEnhancement.$assignedFields.contains('listingId')) { listingId = mlsListingEnhancement.listingId; }
		if (mlsListingEnhancement.$assignedFields.contains('mlsNumber')) { mlsNumber = mlsListingEnhancement.mlsNumber; }
		if (mlsListingEnhancement.$assignedFields.contains('mlsStatus')) { mlsStatus = mlsListingEnhancement.mlsStatus; }
		if (mlsListingEnhancement.$assignedFields.contains('mlsPhotos')) { mlsPhotos = mlsListingEnhancement.mlsPhotos; }
		if (mlsListingEnhancement.$assignedFields.contains('mlsDocuments')) { mlsDocuments = mlsListingEnhancement.mlsDocuments; }
		if (mlsListingEnhancement.$assignedFields.contains('mlsHistory')) { mlsHistory = mlsListingEnhancement.mlsHistory; }
		if (mlsListingEnhancement.$assignedFields.contains('lastMlsUpdate')) { lastMlsUpdate = mlsListingEnhancement.lastMlsUpdate; }
		if (mlsListingEnhancement.$assignedFields.contains('createdAt')) { createdAt = mlsListingEnhancement.createdAt; }
		if (mlsListingEnhancement.$assignedFields.contains('updatedAt')) { updatedAt = mlsListingEnhancement.updatedAt; }
		if (mlsListingEnhancement.$assignedFields.contains('listing')) { listing = mlsListingEnhancement.listing; }
		if (mlsListingEnhancement.$assignedFields.contains('org')) { org = mlsListingEnhancement.org; }
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
          ? {...?serializedTypes, 'MlsListingEnhancement'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(listingId != null) 'listingId': listingId,
	if(mlsNumber != null) 'mlsNumber': mlsNumber,
	if(mlsStatus != null) 'mlsStatus': mlsStatus,
	if(mlsPhotos != null) 'mlsPhotos': mlsPhotos,
	if(mlsDocuments != null) 'mlsDocuments': mlsDocuments,
	if(mlsHistory != null) 'mlsHistory': mlsHistory,
	if(lastMlsUpdate != null) 'lastMlsUpdate': lastMlsUpdate?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MlsListingEnhancement &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    