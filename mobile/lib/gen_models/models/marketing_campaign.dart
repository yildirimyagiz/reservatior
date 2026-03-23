
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'campaign_type.dart';
import 'campaign_status.dart';
import 'lead.dart';
import 'organization.dart';


class MarketingCampaign implements PrismaModel<String, MarketingCampaign> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	CampaignType? type;
	CampaignStatus? status;
	String? targetType;
	List<String>? targetIds;
	String? subject;
	String? content;
	String? templateId;
	DateTime? scheduledAt;
	DateTime? sentAt;
	DateTime? completedAt;
	int? sentCount;
	int? openCount;
	int? clickCount;
	int? conversionCount;
	double? budget;
	double? actualSpend;
	String? objective;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Lead>? leads;
	Organization? org;
	int? $targetIdsCount;
	int? $leadsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MarketingCampaign({ this.id,
	 this.orgId,
	 this.name,
	 this.type = CampaignType.EMAIL,
	 this.status = CampaignStatus.DRAFT,
	 this.targetType,
	 this.targetIds,
	 this.subject,
	 this.content,
	 this.templateId,
	 this.scheduledAt,
	 this.sentAt,
	 this.completedAt,
	 this.sentCount = 0,
	 this.openCount = 0,
	 this.clickCount = 0,
	 this.conversionCount = 0,
	 this.budget,
	 this.actualSpend,
	 this.objective,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.leads,
	 this.org,
	this.$targetIdsCount,
	this.$leadsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MarketingCampaign, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"status": (m) => m.status,

	"targetType": (m) => m.targetType,

	"targetIds": (m) => m.targetIds,

	"subject": (m) => m.subject,

	"content": (m) => m.content,

	"templateId": (m) => m.templateId,

	"scheduledAt": (m) => m.scheduledAt,

	"sentAt": (m) => m.sentAt,

	"completedAt": (m) => m.completedAt,

	"sentCount": (m) => m.sentCount,

	"openCount": (m) => m.openCount,

	"clickCount": (m) => m.clickCount,

	"conversionCount": (m) => m.conversionCount,

	"budget": (m) => m.budget,

	"actualSpend": (m) => m.actualSpend,

	"objective": (m) => m.objective,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"leads": (m) => m.leads,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MarketingCampaign) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MarketingCampaign');
    }
    return propFunction as V? Function(MarketingCampaign);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MarketingCampaign.fromJson(JsonMap json) =>
      MarketingCampaign(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	type: json['type'] != null ? CampaignType.fromJson(json['type']) : null,
	status: json['status'] != null ? CampaignStatus.fromJson(json['status']) : null,
	targetType: json['targetType'] as String?,
	targetIds: json['targetIds'] != null ? (json['targetIds'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	subject: json['subject'] as String?,
	content: json['content'] as String?,
	templateId: json['templateId'] as String?,
	scheduledAt: json['scheduledAt'] != null ? DateTime.parse(json['scheduledAt']) : null,
	sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt']) : null,
	completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
	sentCount: int.tryParse(json['sentCount'].toString()),
	openCount: int.tryParse(json['openCount'].toString()),
	clickCount: int.tryParse(json['clickCount'].toString()),
	conversionCount: int.tryParse(json['conversionCount'].toString()),
	budget: json['budget'] as double?,
	actualSpend: json['actualSpend'] as double?,
	objective: json['objective'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	leads: json['leads'] != null ? createModels<Lead>((json['leads'] as List).cast<JsonMap>(), Lead.fromJson) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	$targetIdsCount: json['_count']?['targetIds'] as int?,
	$leadsCount: json['_count']?['leads'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MarketingCampaign copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<CampaignType?>? type,
		Value<CampaignStatus?>? status,
		Value<String?>? targetType,
		Value<List<String>?>? targetIds,
		Value<String?>? subject,
		Value<String?>? content,
		Value<String?>? templateId,
		Value<DateTime?>? scheduledAt,
		Value<DateTime?>? sentAt,
		Value<DateTime?>? completedAt,
		Value<int?>? sentCount,
		Value<int?>? openCount,
		Value<int?>? clickCount,
		Value<int?>? conversionCount,
		Value<double?>? budget,
		Value<double?>? actualSpend,
		Value<String?>? objective,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Lead>?>? leads,
		Value<Organization?>? org,
		int? $targetIdsCount,
		int? $leadsCount,
        }) {
        return MarketingCampaign(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		status: status != null ? status.value : this.status,
		targetType: targetType != null ? targetType.value : this.targetType,
		targetIds: targetIds != null ? targetIds.value : this.targetIds,
		subject: subject != null ? subject.value : this.subject,
		content: content != null ? content.value : this.content,
		templateId: templateId != null ? templateId.value : this.templateId,
		scheduledAt: scheduledAt != null ? scheduledAt.value : this.scheduledAt,
		sentAt: sentAt != null ? sentAt.value : this.sentAt,
		completedAt: completedAt != null ? completedAt.value : this.completedAt,
		sentCount: sentCount != null ? sentCount.value : this.sentCount,
		openCount: openCount != null ? openCount.value : this.openCount,
		clickCount: clickCount != null ? clickCount.value : this.clickCount,
		conversionCount: conversionCount != null ? conversionCount.value : this.conversionCount,
		budget: budget != null ? budget.value : this.budget,
		actualSpend: actualSpend != null ? actualSpend.value : this.actualSpend,
		objective: objective != null ? objective.value : this.objective,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		leads: leads != null ? leads.value : this.leads,
		org: org != null ? org.value : this.org,
		$targetIdsCount: $targetIdsCount ?? this.$targetIdsCount,
		$leadsCount: $leadsCount ?? this.$leadsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MarketingCampaign copyWithInstanceValues(MarketingCampaign marketingCampaign) {
        return MarketingCampaign(
            id: marketingCampaign.id ?? id,
		orgId: marketingCampaign.orgId ?? orgId,
		name: marketingCampaign.name ?? name,
		type: marketingCampaign.type ?? type,
		status: marketingCampaign.status ?? status,
		targetType: marketingCampaign.targetType ?? targetType,
		targetIds: marketingCampaign.targetIds ?? targetIds,
		subject: marketingCampaign.subject ?? subject,
		content: marketingCampaign.content ?? content,
		templateId: marketingCampaign.templateId ?? templateId,
		scheduledAt: marketingCampaign.scheduledAt ?? scheduledAt,
		sentAt: marketingCampaign.sentAt ?? sentAt,
		completedAt: marketingCampaign.completedAt ?? completedAt,
		sentCount: marketingCampaign.sentCount ?? sentCount,
		openCount: marketingCampaign.openCount ?? openCount,
		clickCount: marketingCampaign.clickCount ?? clickCount,
		conversionCount: marketingCampaign.conversionCount ?? conversionCount,
		budget: marketingCampaign.budget ?? budget,
		actualSpend: marketingCampaign.actualSpend ?? actualSpend,
		objective: marketingCampaign.objective ?? objective,
		createdAt: marketingCampaign.createdAt ?? createdAt,
		updatedAt: marketingCampaign.updatedAt ?? updatedAt,
		deletedAt: marketingCampaign.deletedAt ?? deletedAt,
		leads: marketingCampaign.leads ?? leads,
		org: marketingCampaign.org ?? org,
		$targetIdsCount: marketingCampaign.$targetIdsCount ?? $targetIdsCount,
		$leadsCount: marketingCampaign.$leadsCount ?? $leadsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MarketingCampaign mergeWithInstanceValues(MarketingCampaign marketingCampaign) {
        return MarketingCampaign(
            id: marketingCampaign.$assignedFields.contains('id') ? marketingCampaign.id : id,
		orgId: marketingCampaign.$assignedFields.contains('orgId') ? marketingCampaign.orgId : orgId,
		name: marketingCampaign.$assignedFields.contains('name') ? marketingCampaign.name : name,
		type: marketingCampaign.$assignedFields.contains('type') ? marketingCampaign.type : type,
		status: marketingCampaign.$assignedFields.contains('status') ? marketingCampaign.status : status,
		targetType: marketingCampaign.$assignedFields.contains('targetType') ? marketingCampaign.targetType : targetType,
		targetIds: marketingCampaign.$assignedFields.contains('targetIds') ? marketingCampaign.targetIds : targetIds,
		subject: marketingCampaign.$assignedFields.contains('subject') ? marketingCampaign.subject : subject,
		content: marketingCampaign.$assignedFields.contains('content') ? marketingCampaign.content : content,
		templateId: marketingCampaign.$assignedFields.contains('templateId') ? marketingCampaign.templateId : templateId,
		scheduledAt: marketingCampaign.$assignedFields.contains('scheduledAt') ? marketingCampaign.scheduledAt : scheduledAt,
		sentAt: marketingCampaign.$assignedFields.contains('sentAt') ? marketingCampaign.sentAt : sentAt,
		completedAt: marketingCampaign.$assignedFields.contains('completedAt') ? marketingCampaign.completedAt : completedAt,
		sentCount: marketingCampaign.$assignedFields.contains('sentCount') ? marketingCampaign.sentCount : sentCount,
		openCount: marketingCampaign.$assignedFields.contains('openCount') ? marketingCampaign.openCount : openCount,
		clickCount: marketingCampaign.$assignedFields.contains('clickCount') ? marketingCampaign.clickCount : clickCount,
		conversionCount: marketingCampaign.$assignedFields.contains('conversionCount') ? marketingCampaign.conversionCount : conversionCount,
		budget: marketingCampaign.$assignedFields.contains('budget') ? marketingCampaign.budget : budget,
		actualSpend: marketingCampaign.$assignedFields.contains('actualSpend') ? marketingCampaign.actualSpend : actualSpend,
		objective: marketingCampaign.$assignedFields.contains('objective') ? marketingCampaign.objective : objective,
		createdAt: marketingCampaign.$assignedFields.contains('createdAt') ? marketingCampaign.createdAt : createdAt,
		updatedAt: marketingCampaign.$assignedFields.contains('updatedAt') ? marketingCampaign.updatedAt : updatedAt,
		deletedAt: marketingCampaign.$assignedFields.contains('deletedAt') ? marketingCampaign.deletedAt : deletedAt,
		leads: (marketingCampaign.$assignedFields.contains('leads') && marketingCampaign.leads != null) ? mergeModelLists(leads, marketingCampaign.leads) : leads,
		org: marketingCampaign.$assignedFields.contains('org') ? marketingCampaign.org : org,
		$targetIdsCount: marketingCampaign.$targetIdsCount ?? $targetIdsCount,
		$leadsCount: marketingCampaign.$leadsCount ?? $leadsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MarketingCampaign updateWithInstanceValues(MarketingCampaign marketingCampaign) {
        if (marketingCampaign.$assignedFields.contains('id')) { id = marketingCampaign.id; }
		if (marketingCampaign.$assignedFields.contains('orgId')) { orgId = marketingCampaign.orgId; }
		if (marketingCampaign.$assignedFields.contains('name')) { name = marketingCampaign.name; }
		if (marketingCampaign.$assignedFields.contains('type')) { type = marketingCampaign.type; }
		if (marketingCampaign.$assignedFields.contains('status')) { status = marketingCampaign.status; }
		if (marketingCampaign.$assignedFields.contains('targetType')) { targetType = marketingCampaign.targetType; }
		if (marketingCampaign.$assignedFields.contains('targetIds')) { targetIds = marketingCampaign.targetIds; }
		if (marketingCampaign.$assignedFields.contains('subject')) { subject = marketingCampaign.subject; }
		if (marketingCampaign.$assignedFields.contains('content')) { content = marketingCampaign.content; }
		if (marketingCampaign.$assignedFields.contains('templateId')) { templateId = marketingCampaign.templateId; }
		if (marketingCampaign.$assignedFields.contains('scheduledAt')) { scheduledAt = marketingCampaign.scheduledAt; }
		if (marketingCampaign.$assignedFields.contains('sentAt')) { sentAt = marketingCampaign.sentAt; }
		if (marketingCampaign.$assignedFields.contains('completedAt')) { completedAt = marketingCampaign.completedAt; }
		if (marketingCampaign.$assignedFields.contains('sentCount')) { sentCount = marketingCampaign.sentCount; }
		if (marketingCampaign.$assignedFields.contains('openCount')) { openCount = marketingCampaign.openCount; }
		if (marketingCampaign.$assignedFields.contains('clickCount')) { clickCount = marketingCampaign.clickCount; }
		if (marketingCampaign.$assignedFields.contains('conversionCount')) { conversionCount = marketingCampaign.conversionCount; }
		if (marketingCampaign.$assignedFields.contains('budget')) { budget = marketingCampaign.budget; }
		if (marketingCampaign.$assignedFields.contains('actualSpend')) { actualSpend = marketingCampaign.actualSpend; }
		if (marketingCampaign.$assignedFields.contains('objective')) { objective = marketingCampaign.objective; }
		if (marketingCampaign.$assignedFields.contains('createdAt')) { createdAt = marketingCampaign.createdAt; }
		if (marketingCampaign.$assignedFields.contains('updatedAt')) { updatedAt = marketingCampaign.updatedAt; }
		if (marketingCampaign.$assignedFields.contains('deletedAt')) { deletedAt = marketingCampaign.deletedAt; }
		if (marketingCampaign.$assignedFields.contains('leads') && marketingCampaign.leads != null) { leads = mergeModelLists(leads, marketingCampaign.leads); }
		if (marketingCampaign.$assignedFields.contains('org')) { org = marketingCampaign.org; }
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
          ? {...?serializedTypes, 'MarketingCampaign'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(type != null) 'type': type?.toJson(),
	if(status != null) 'status': status?.toJson(),
	if(targetType != null) 'targetType': targetType,
	if(targetIds != null) 'targetIds': targetIds,
	if(subject != null) 'subject': subject,
	if(content != null) 'content': content,
	if(templateId != null) 'templateId': templateId,
	if(scheduledAt != null) 'scheduledAt': scheduledAt?.toIso8601String(),
	if(sentAt != null) 'sentAt': sentAt?.toIso8601String(),
	if(completedAt != null) 'completedAt': completedAt?.toIso8601String(),
	if(sentCount != null) 'sentCount': sentCount,
	if(openCount != null) 'openCount': openCount,
	if(clickCount != null) 'clickCount': clickCount,
	if(conversionCount != null) 'conversionCount': conversionCount,
	if(budget != null) 'budget': budget,
	if(actualSpend != null) 'actualSpend': actualSpend,
	if(objective != null) 'objective': objective,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(leads != null && (!preventCircularSerialization || !serializedModels.contains('Lead'))) 'leads': leads?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($targetIdsCount != null || $leadsCount != null) '_count': { 
		if ($targetIdsCount != null) 'targetIds': $targetIdsCount, 
		if ($leadsCount != null) 'leads': $leadsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MarketingCampaign &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    