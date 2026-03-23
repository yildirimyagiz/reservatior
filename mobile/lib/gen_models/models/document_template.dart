
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class DocumentTemplate implements PrismaModel<String, DocumentTemplate> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	String? type;
	String? category;
	String? templateContent;
	dynamic variables;
	bool? isActive;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    DocumentTemplate({ this.id,
	 this.orgId,
	 this.name,
	 this.type,
	 this.category,
	 this.templateContent,
	required this.variables,
	 this.isActive = true,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<DocumentTemplate, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"category": (m) => m.category,

	"templateContent": (m) => m.templateContent,

	"variables": (m) => m.variables,

	"isActive": (m) => m.isActive,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(DocumentTemplate) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in DocumentTemplate');
    }
    return propFunction as V? Function(DocumentTemplate);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory DocumentTemplate.fromJson(JsonMap json) =>
      DocumentTemplate(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	type: json['type'] as String?,
	category: json['category'] as String?,
	templateContent: json['templateContent'] as String?,
	variables: json['variables'] as dynamic,
	isActive: json['isActive'] as bool?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    DocumentTemplate copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<String?>? type,
		Value<String?>? category,
		Value<String?>? templateContent,
		Value<dynamic>? variables,
		Value<bool?>? isActive,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
        }) {
        return DocumentTemplate(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		category: category != null ? category.value : this.category,
		templateContent: templateContent != null ? templateContent.value : this.templateContent,
		variables: variables != null ? variables.value : this.variables,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    DocumentTemplate copyWithInstanceValues(DocumentTemplate documentTemplate) {
        return DocumentTemplate(
            id: documentTemplate.id ?? id,
		orgId: documentTemplate.orgId ?? orgId,
		name: documentTemplate.name ?? name,
		type: documentTemplate.type ?? type,
		category: documentTemplate.category ?? category,
		templateContent: documentTemplate.templateContent ?? templateContent,
		variables: documentTemplate.variables ?? variables,
		isActive: documentTemplate.isActive ?? isActive,
		createdBy: documentTemplate.createdBy ?? createdBy,
		createdAt: documentTemplate.createdAt ?? createdAt,
		updatedAt: documentTemplate.updatedAt ?? updatedAt,
		deletedAt: documentTemplate.deletedAt ?? deletedAt,
		org: documentTemplate.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    DocumentTemplate mergeWithInstanceValues(DocumentTemplate documentTemplate) {
        return DocumentTemplate(
            id: documentTemplate.$assignedFields.contains('id') ? documentTemplate.id : id,
		orgId: documentTemplate.$assignedFields.contains('orgId') ? documentTemplate.orgId : orgId,
		name: documentTemplate.$assignedFields.contains('name') ? documentTemplate.name : name,
		type: documentTemplate.$assignedFields.contains('type') ? documentTemplate.type : type,
		category: documentTemplate.$assignedFields.contains('category') ? documentTemplate.category : category,
		templateContent: documentTemplate.$assignedFields.contains('templateContent') ? documentTemplate.templateContent : templateContent,
		variables: documentTemplate.$assignedFields.contains('variables') ? documentTemplate.variables : variables,
		isActive: documentTemplate.$assignedFields.contains('isActive') ? documentTemplate.isActive : isActive,
		createdBy: documentTemplate.$assignedFields.contains('createdBy') ? documentTemplate.createdBy : createdBy,
		createdAt: documentTemplate.$assignedFields.contains('createdAt') ? documentTemplate.createdAt : createdAt,
		updatedAt: documentTemplate.$assignedFields.contains('updatedAt') ? documentTemplate.updatedAt : updatedAt,
		deletedAt: documentTemplate.$assignedFields.contains('deletedAt') ? documentTemplate.deletedAt : deletedAt,
		org: documentTemplate.$assignedFields.contains('org') ? documentTemplate.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    DocumentTemplate updateWithInstanceValues(DocumentTemplate documentTemplate) {
        if (documentTemplate.$assignedFields.contains('id')) { id = documentTemplate.id; }
		if (documentTemplate.$assignedFields.contains('orgId')) { orgId = documentTemplate.orgId; }
		if (documentTemplate.$assignedFields.contains('name')) { name = documentTemplate.name; }
		if (documentTemplate.$assignedFields.contains('type')) { type = documentTemplate.type; }
		if (documentTemplate.$assignedFields.contains('category')) { category = documentTemplate.category; }
		if (documentTemplate.$assignedFields.contains('templateContent')) { templateContent = documentTemplate.templateContent; }
		if (documentTemplate.$assignedFields.contains('variables')) { variables = documentTemplate.variables; }
		if (documentTemplate.$assignedFields.contains('isActive')) { isActive = documentTemplate.isActive; }
		if (documentTemplate.$assignedFields.contains('createdBy')) { createdBy = documentTemplate.createdBy; }
		if (documentTemplate.$assignedFields.contains('createdAt')) { createdAt = documentTemplate.createdAt; }
		if (documentTemplate.$assignedFields.contains('updatedAt')) { updatedAt = documentTemplate.updatedAt; }
		if (documentTemplate.$assignedFields.contains('deletedAt')) { deletedAt = documentTemplate.deletedAt; }
		if (documentTemplate.$assignedFields.contains('org')) { org = documentTemplate.org; }
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
          ? {...?serializedTypes, 'DocumentTemplate'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(type != null) 'type': type,
	if(category != null) 'category': category,
	if(templateContent != null) 'templateContent': templateContent,
	if(variables != null) 'variables': variables,
	if(isActive != null) 'isActive': isActive,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is DocumentTemplate &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    