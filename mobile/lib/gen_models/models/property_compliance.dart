
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'attachment.dart';
import 'contact.dart';
import 'user.dart';
import 'organization.dart';
import 'property.dart';


class PropertyCompliance implements PrismaModel<String, PropertyCompliance> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? type;
	String? status;
	dynamic data;
	String? inspectorId;
	String? inspectorContactId;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Attachment>? attachments;
	Contact? inspectorContact;
	User? inspector;
	Organization? org;
	Property? property;
	int? $attachmentsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PropertyCompliance({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.type,
	 this.status = "pending",
	required this.data,
	 this.inspectorId,
	 this.inspectorContactId,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.attachments,
	 this.inspectorContact,
	 this.inspector,
	 this.org,
	 this.property,
	this.$attachmentsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PropertyCompliance, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"type": (m) => m.type,

	"status": (m) => m.status,

	"data": (m) => m.data,

	"inspectorId": (m) => m.inspectorId,

	"inspectorContactId": (m) => m.inspectorContactId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"attachments": (m) => m.attachments,

	"inspectorContact": (m) => m.inspectorContact,

	"inspector": (m) => m.inspector,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PropertyCompliance) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PropertyCompliance');
    }
    return propFunction as V? Function(PropertyCompliance);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PropertyCompliance.fromJson(JsonMap json) =>
      PropertyCompliance(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	type: json['type'] as String?,
	status: json['status'] as String?,
	data: json['data'] as dynamic,
	inspectorId: json['inspectorId'] as String?,
	inspectorContactId: json['inspectorContactId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	attachments: json['attachments'] != null ? createModels<Attachment>((json['attachments'] as List).cast<JsonMap>(), Attachment.fromJson) : null,
	inspectorContact: json['inspectorContact'] != null ? Contact.fromJson(json['inspectorContact'] as JsonMap) : null,
	inspector: json['inspector'] != null ? User.fromJson(json['inspector'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	$attachmentsCount: json['_count']?['attachments'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PropertyCompliance copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? type,
		Value<String?>? status,
		Value<dynamic>? data,
		Value<String?>? inspectorId,
		Value<String?>? inspectorContactId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Attachment>?>? attachments,
		Value<Contact?>? inspectorContact,
		Value<User?>? inspector,
		Value<Organization?>? org,
		Value<Property?>? property,
		int? $attachmentsCount,
        }) {
        return PropertyCompliance(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		type: type != null ? type.value : this.type,
		status: status != null ? status.value : this.status,
		data: data != null ? data.value : this.data,
		inspectorId: inspectorId != null ? inspectorId.value : this.inspectorId,
		inspectorContactId: inspectorContactId != null ? inspectorContactId.value : this.inspectorContactId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		attachments: attachments != null ? attachments.value : this.attachments,
		inspectorContact: inspectorContact != null ? inspectorContact.value : this.inspectorContact,
		inspector: inspector != null ? inspector.value : this.inspector,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		$attachmentsCount: $attachmentsCount ?? this.$attachmentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PropertyCompliance copyWithInstanceValues(PropertyCompliance propertyCompliance) {
        return PropertyCompliance(
            id: propertyCompliance.id ?? id,
		orgId: propertyCompliance.orgId ?? orgId,
		propertyId: propertyCompliance.propertyId ?? propertyId,
		type: propertyCompliance.type ?? type,
		status: propertyCompliance.status ?? status,
		data: propertyCompliance.data ?? data,
		inspectorId: propertyCompliance.inspectorId ?? inspectorId,
		inspectorContactId: propertyCompliance.inspectorContactId ?? inspectorContactId,
		createdAt: propertyCompliance.createdAt ?? createdAt,
		updatedAt: propertyCompliance.updatedAt ?? updatedAt,
		deletedAt: propertyCompliance.deletedAt ?? deletedAt,
		attachments: propertyCompliance.attachments ?? attachments,
		inspectorContact: propertyCompliance.inspectorContact ?? inspectorContact,
		inspector: propertyCompliance.inspector ?? inspector,
		org: propertyCompliance.org ?? org,
		property: propertyCompliance.property ?? property,
		$attachmentsCount: propertyCompliance.$attachmentsCount ?? $attachmentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PropertyCompliance mergeWithInstanceValues(PropertyCompliance propertyCompliance) {
        return PropertyCompliance(
            id: propertyCompliance.$assignedFields.contains('id') ? propertyCompliance.id : id,
		orgId: propertyCompliance.$assignedFields.contains('orgId') ? propertyCompliance.orgId : orgId,
		propertyId: propertyCompliance.$assignedFields.contains('propertyId') ? propertyCompliance.propertyId : propertyId,
		type: propertyCompliance.$assignedFields.contains('type') ? propertyCompliance.type : type,
		status: propertyCompliance.$assignedFields.contains('status') ? propertyCompliance.status : status,
		data: propertyCompliance.$assignedFields.contains('data') ? propertyCompliance.data : data,
		inspectorId: propertyCompliance.$assignedFields.contains('inspectorId') ? propertyCompliance.inspectorId : inspectorId,
		inspectorContactId: propertyCompliance.$assignedFields.contains('inspectorContactId') ? propertyCompliance.inspectorContactId : inspectorContactId,
		createdAt: propertyCompliance.$assignedFields.contains('createdAt') ? propertyCompliance.createdAt : createdAt,
		updatedAt: propertyCompliance.$assignedFields.contains('updatedAt') ? propertyCompliance.updatedAt : updatedAt,
		deletedAt: propertyCompliance.$assignedFields.contains('deletedAt') ? propertyCompliance.deletedAt : deletedAt,
		attachments: (propertyCompliance.$assignedFields.contains('attachments') && propertyCompliance.attachments != null) ? mergeModelLists(attachments, propertyCompliance.attachments) : attachments,
		inspectorContact: propertyCompliance.$assignedFields.contains('inspectorContact') ? propertyCompliance.inspectorContact : inspectorContact,
		inspector: propertyCompliance.$assignedFields.contains('inspector') ? propertyCompliance.inspector : inspector,
		org: propertyCompliance.$assignedFields.contains('org') ? propertyCompliance.org : org,
		property: propertyCompliance.$assignedFields.contains('property') ? propertyCompliance.property : property,
		$attachmentsCount: propertyCompliance.$attachmentsCount ?? $attachmentsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PropertyCompliance updateWithInstanceValues(PropertyCompliance propertyCompliance) {
        if (propertyCompliance.$assignedFields.contains('id')) { id = propertyCompliance.id; }
		if (propertyCompliance.$assignedFields.contains('orgId')) { orgId = propertyCompliance.orgId; }
		if (propertyCompliance.$assignedFields.contains('propertyId')) { propertyId = propertyCompliance.propertyId; }
		if (propertyCompliance.$assignedFields.contains('type')) { type = propertyCompliance.type; }
		if (propertyCompliance.$assignedFields.contains('status')) { status = propertyCompliance.status; }
		if (propertyCompliance.$assignedFields.contains('data')) { data = propertyCompliance.data; }
		if (propertyCompliance.$assignedFields.contains('inspectorId')) { inspectorId = propertyCompliance.inspectorId; }
		if (propertyCompliance.$assignedFields.contains('inspectorContactId')) { inspectorContactId = propertyCompliance.inspectorContactId; }
		if (propertyCompliance.$assignedFields.contains('createdAt')) { createdAt = propertyCompliance.createdAt; }
		if (propertyCompliance.$assignedFields.contains('updatedAt')) { updatedAt = propertyCompliance.updatedAt; }
		if (propertyCompliance.$assignedFields.contains('deletedAt')) { deletedAt = propertyCompliance.deletedAt; }
		if (propertyCompliance.$assignedFields.contains('attachments') && propertyCompliance.attachments != null) { attachments = mergeModelLists(attachments, propertyCompliance.attachments); }
		if (propertyCompliance.$assignedFields.contains('inspectorContact')) { inspectorContact = propertyCompliance.inspectorContact; }
		if (propertyCompliance.$assignedFields.contains('inspector')) { inspector = propertyCompliance.inspector; }
		if (propertyCompliance.$assignedFields.contains('org')) { org = propertyCompliance.org; }
		if (propertyCompliance.$assignedFields.contains('property')) { property = propertyCompliance.property; }
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
          ? {...?serializedTypes, 'PropertyCompliance'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(type != null) 'type': type,
	if(status != null) 'status': status,
	if(data != null) 'data': data,
	if(inspectorId != null) 'inspectorId': inspectorId,
	if(inspectorContactId != null) 'inspectorContactId': inspectorContactId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(attachments != null && (!preventCircularSerialization || !serializedModels.contains('Attachment'))) 'attachments': attachments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(inspectorContact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'inspectorContact': inspectorContact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(inspector != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'inspector': inspector?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($attachmentsCount != null) '_count': { 
		if ($attachmentsCount != null) 'attachments': $attachmentsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PropertyCompliance &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    