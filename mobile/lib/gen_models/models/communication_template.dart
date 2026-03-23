
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class CommunicationTemplate implements PrismaModel<String, CommunicationTemplate> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	String? type;
	String? templateType;
	String? subject;
	String? htmlContent;
	String? textContent;
	String? title;
	String? message;
	List<String>? channels;
	String? category;
	dynamic variables;
	bool? isActive;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	int? $channelsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    CommunicationTemplate({ this.id,
	 this.orgId,
	 this.name,
	 this.type,
	 this.templateType,
	 this.subject,
	 this.htmlContent,
	 this.textContent,
	 this.title,
	 this.message,
	 this.channels,
	 this.category,
	required this.variables,
	 this.isActive = true,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	this.$channelsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<CommunicationTemplate, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"templateType": (m) => m.templateType,

	"subject": (m) => m.subject,

	"htmlContent": (m) => m.htmlContent,

	"textContent": (m) => m.textContent,

	"title": (m) => m.title,

	"message": (m) => m.message,

	"channels": (m) => m.channels,

	"category": (m) => m.category,

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
  V? Function(CommunicationTemplate) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in CommunicationTemplate');
    }
    return propFunction as V? Function(CommunicationTemplate);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory CommunicationTemplate.fromJson(JsonMap json) =>
      CommunicationTemplate(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	type: json['type'] as String?,
	templateType: json['templateType'] as String?,
	subject: json['subject'] as String?,
	htmlContent: json['htmlContent'] as String?,
	textContent: json['textContent'] as String?,
	title: json['title'] as String?,
	message: json['message'] as String?,
	channels: json['channels'] != null ? (json['channels'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	category: json['category'] as String?,
	variables: json['variables'] as dynamic,
	isActive: json['isActive'] as bool?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	$channelsCount: json['_count']?['channels'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    CommunicationTemplate copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<String?>? type,
		Value<String?>? templateType,
		Value<String?>? subject,
		Value<String?>? htmlContent,
		Value<String?>? textContent,
		Value<String?>? title,
		Value<String?>? message,
		Value<List<String>?>? channels,
		Value<String?>? category,
		Value<dynamic>? variables,
		Value<bool?>? isActive,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		int? $channelsCount,
        }) {
        return CommunicationTemplate(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		templateType: templateType != null ? templateType.value : this.templateType,
		subject: subject != null ? subject.value : this.subject,
		htmlContent: htmlContent != null ? htmlContent.value : this.htmlContent,
		textContent: textContent != null ? textContent.value : this.textContent,
		title: title != null ? title.value : this.title,
		message: message != null ? message.value : this.message,
		channels: channels != null ? channels.value : this.channels,
		category: category != null ? category.value : this.category,
		variables: variables != null ? variables.value : this.variables,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		$channelsCount: $channelsCount ?? this.$channelsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    CommunicationTemplate copyWithInstanceValues(CommunicationTemplate communicationTemplate) {
        return CommunicationTemplate(
            id: communicationTemplate.id ?? id,
		orgId: communicationTemplate.orgId ?? orgId,
		name: communicationTemplate.name ?? name,
		type: communicationTemplate.type ?? type,
		templateType: communicationTemplate.templateType ?? templateType,
		subject: communicationTemplate.subject ?? subject,
		htmlContent: communicationTemplate.htmlContent ?? htmlContent,
		textContent: communicationTemplate.textContent ?? textContent,
		title: communicationTemplate.title ?? title,
		message: communicationTemplate.message ?? message,
		channels: communicationTemplate.channels ?? channels,
		category: communicationTemplate.category ?? category,
		variables: communicationTemplate.variables ?? variables,
		isActive: communicationTemplate.isActive ?? isActive,
		createdBy: communicationTemplate.createdBy ?? createdBy,
		createdAt: communicationTemplate.createdAt ?? createdAt,
		updatedAt: communicationTemplate.updatedAt ?? updatedAt,
		deletedAt: communicationTemplate.deletedAt ?? deletedAt,
		org: communicationTemplate.org ?? org,
		$channelsCount: communicationTemplate.$channelsCount ?? $channelsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    CommunicationTemplate mergeWithInstanceValues(CommunicationTemplate communicationTemplate) {
        return CommunicationTemplate(
            id: communicationTemplate.$assignedFields.contains('id') ? communicationTemplate.id : id,
		orgId: communicationTemplate.$assignedFields.contains('orgId') ? communicationTemplate.orgId : orgId,
		name: communicationTemplate.$assignedFields.contains('name') ? communicationTemplate.name : name,
		type: communicationTemplate.$assignedFields.contains('type') ? communicationTemplate.type : type,
		templateType: communicationTemplate.$assignedFields.contains('templateType') ? communicationTemplate.templateType : templateType,
		subject: communicationTemplate.$assignedFields.contains('subject') ? communicationTemplate.subject : subject,
		htmlContent: communicationTemplate.$assignedFields.contains('htmlContent') ? communicationTemplate.htmlContent : htmlContent,
		textContent: communicationTemplate.$assignedFields.contains('textContent') ? communicationTemplate.textContent : textContent,
		title: communicationTemplate.$assignedFields.contains('title') ? communicationTemplate.title : title,
		message: communicationTemplate.$assignedFields.contains('message') ? communicationTemplate.message : message,
		channels: communicationTemplate.$assignedFields.contains('channels') ? communicationTemplate.channels : channels,
		category: communicationTemplate.$assignedFields.contains('category') ? communicationTemplate.category : category,
		variables: communicationTemplate.$assignedFields.contains('variables') ? communicationTemplate.variables : variables,
		isActive: communicationTemplate.$assignedFields.contains('isActive') ? communicationTemplate.isActive : isActive,
		createdBy: communicationTemplate.$assignedFields.contains('createdBy') ? communicationTemplate.createdBy : createdBy,
		createdAt: communicationTemplate.$assignedFields.contains('createdAt') ? communicationTemplate.createdAt : createdAt,
		updatedAt: communicationTemplate.$assignedFields.contains('updatedAt') ? communicationTemplate.updatedAt : updatedAt,
		deletedAt: communicationTemplate.$assignedFields.contains('deletedAt') ? communicationTemplate.deletedAt : deletedAt,
		org: communicationTemplate.$assignedFields.contains('org') ? communicationTemplate.org : org,
		$channelsCount: communicationTemplate.$channelsCount ?? $channelsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    CommunicationTemplate updateWithInstanceValues(CommunicationTemplate communicationTemplate) {
        if (communicationTemplate.$assignedFields.contains('id')) { id = communicationTemplate.id; }
		if (communicationTemplate.$assignedFields.contains('orgId')) { orgId = communicationTemplate.orgId; }
		if (communicationTemplate.$assignedFields.contains('name')) { name = communicationTemplate.name; }
		if (communicationTemplate.$assignedFields.contains('type')) { type = communicationTemplate.type; }
		if (communicationTemplate.$assignedFields.contains('templateType')) { templateType = communicationTemplate.templateType; }
		if (communicationTemplate.$assignedFields.contains('subject')) { subject = communicationTemplate.subject; }
		if (communicationTemplate.$assignedFields.contains('htmlContent')) { htmlContent = communicationTemplate.htmlContent; }
		if (communicationTemplate.$assignedFields.contains('textContent')) { textContent = communicationTemplate.textContent; }
		if (communicationTemplate.$assignedFields.contains('title')) { title = communicationTemplate.title; }
		if (communicationTemplate.$assignedFields.contains('message')) { message = communicationTemplate.message; }
		if (communicationTemplate.$assignedFields.contains('channels')) { channels = communicationTemplate.channels; }
		if (communicationTemplate.$assignedFields.contains('category')) { category = communicationTemplate.category; }
		if (communicationTemplate.$assignedFields.contains('variables')) { variables = communicationTemplate.variables; }
		if (communicationTemplate.$assignedFields.contains('isActive')) { isActive = communicationTemplate.isActive; }
		if (communicationTemplate.$assignedFields.contains('createdBy')) { createdBy = communicationTemplate.createdBy; }
		if (communicationTemplate.$assignedFields.contains('createdAt')) { createdAt = communicationTemplate.createdAt; }
		if (communicationTemplate.$assignedFields.contains('updatedAt')) { updatedAt = communicationTemplate.updatedAt; }
		if (communicationTemplate.$assignedFields.contains('deletedAt')) { deletedAt = communicationTemplate.deletedAt; }
		if (communicationTemplate.$assignedFields.contains('org')) { org = communicationTemplate.org; }
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
          ? {...?serializedTypes, 'CommunicationTemplate'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(type != null) 'type': type,
	if(templateType != null) 'templateType': templateType,
	if(subject != null) 'subject': subject,
	if(htmlContent != null) 'htmlContent': htmlContent,
	if(textContent != null) 'textContent': textContent,
	if(title != null) 'title': title,
	if(message != null) 'message': message,
	if(channels != null) 'channels': channels,
	if(category != null) 'category': category,
	if(variables != null) 'variables': variables,
	if(isActive != null) 'isActive': isActive,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($channelsCount != null) '_count': { 
		if ($channelsCount != null) 'channels': $channelsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is CommunicationTemplate &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    